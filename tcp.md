#TCP

**谈一谈网络编程学习经验**  
> http://blog.csdn.net/solstice/article/details/6527585   
> http://www.ideawu.net/blog/archives/880.html   -- 在Linux进行IO的正确姿势     

**TCP的keep-alive选项** 
> http://www.cnblogs.com/wainiwann/p/4024583.html   --tcp的keep-alive
> http://blog.csdn.net/lys86_1205/article/details/21234867  --http keep_alive 和 tcp keep_alive  

```
tcp自己的keepalive有这样的一个bug：

正常情况下，连接的另一端主动调用colse关闭连接，tcp会通知，我们知道了该连接已经关闭。
但是如果tcp连接的另一端突然掉线，或者重启断电，这个时候我们并不知道网络已经关闭。
而此时，如果有发送数据失败，tcp会自动进行重传。重传包的优先级高于keepalive，
那就意味着，我们的keepalive总是不能发送出去。
而此时，我们也并不知道该连接已经出错而中断。在较长时间的重传失败之后，我们才会知道。

为了避免这种情况发生，我们要在tcp上层，自行控制(在应用层实现一个心跳包)。
对于此消息，记录发送时间和收到回应的时间。如果长时间没有回应，就可能是网络中断。
如果长时间没有发送，就是说，长时间没有进行通信，可以自行发一个包，用于keepalive，以保持该连接的存在。

-------http keep-alive与tcp keep-alive----------------
http keep-alive与tcp keep-alive，不是同一回事，意图不一样。
http keep-alive是为了让tcp活得更久一点，以便在同一个连接上传送多个http，提高socket的效率。
而tcp keep-alive是TCP的一种检测TCP连接状况的保鲜机制。
```

#网络结构  
```
第一层:物理层       网线,集线器   
第二层:数据链路层   网卡,交换机; 重要协议: ARP 地址解析鞋业, RARP 逆向地址解析协议;  
第三层:网络层       路由器 (三层交换机, 也实现交换机的功能); 重要协议: IP协议, ICMP协议(Internet Control Message Protocol); 
第四层:传输层       重要协议: TCP 字节流/UDP 数据报
第五层:会话层
第六层:表示层 
第七层:应用层

ICMP: 
它是TCP/IP协议族的一个子协议，用于在IP主机、路由器之间传递控制消息。控制消息是指网络通不通、主机是否可达、路由是否可用等
网络本身的消息。这些控制消息虽然并不传输用户数据，但是对于用户数据的传递起着重要的作用。  

ARP:
是根据IP地址获取物理地址的一个TCP/IP协议。主机发送信息时将包含目标IP地址的ARP请求广播到网络上的所有主机，并接收返回消息，
以此确定目标的物理地址；收到返回消息后将该IP地址和物理地址存入本机ARP缓存中并保留一定时间，下次请求时直接查询ARP缓存以节
约资源。


网关： 

网关是一个非常广泛的概念，我们很难给出一个确切的定义。
从第一层到第七层都可以有网关设备出现。
我们通常所说的网关主要是指第三层的设备,即路由器。

关于网关是工作在某几层的观点是不正确的，过于教条主义，而缺少对事物本质的了解。譬如说应用网关，一个应用网关的具体设备确实
会包括ISO模型中的所有7层（我们不关注具体的协议实现）但是实现网关功能的具体进程并不会涉及到下面的层次，那是一个网络设备要
得以运作必须的实现。而与网关的实现相关的处理只在特定的层次上操作。因此我们完全是可以确定网关的应用层次的。

有些网关具体的实现可能即包含了多个层次，但这只能说是这个具体的实现是同时包含了多种的网关的实现的，是复合型的而已。
即是说，路由器就是工作在的三层的网关设备。而代理服务器（特定与一定的服务，譬如web服务。）就是应用层的网关。
```

# Socket 
> http://www.retran.com/beej/index.html  


**epoll**  
> http://blog.csdn.net/xiajun07061225/article/details/9250579  --epoll详解  

首先通过epoll_create(int maxfds)来创建一个epoll的句柄，其中maxfds为你epoll所支持的最大句柄数。这个函数会返回一个新的epoll句柄，之后的所有操作将通过这个句柄来进行操作。在用完之后，记得用close()来关闭这个创建出来的epoll句柄。  

nfds=epoll_wait(kdpfd,events,maxevents,-1);     
其中kdpfd为用epoll_create创建之后的句柄，events是一个epoll_event*的指针，当epoll_wait这个函数操作成功之后，epoll_events里面将储存所有的读写事件。maxevents是最大事件数量。最后一个timeout是epoll_wait的超时，为0的时候表示马上返回，为-1的时候表示一直等下去，直到有事件发生，为任意正整数的时候表示等这么长的时间，如果一直没有事件，则返回。一般如果网络主循环是单独的线程的话，可以用-1来等，这样可以保证一些效率，如果是和主逻辑在同一个线程的话，则可以用0来保证主循环的效率。   

struct epoll_event结构如下: 
```
/保存触发事件的某个文件描述符相关的数据（与具体使用方式有关）  
  
typedef union epoll_data {  
    void *ptr;  
    int fd;  
    __uint32_t u32;  
    __uint64_t u64;  
} epoll_data_t;  
 //感兴趣的事件和被触发的事件  
struct epoll_event {  
    __uint32_t events; /* Epoll events */  
    epoll_data_t data; /* User data variable */  
};  
```

事件注册函数：  
```
 int epoll_ctl(int epfd, int op, int fd, struct epoll_event *event);
epoll的事件注册函数，它不同于select()是在监听事件时告诉内核要监听什么类型的事件，而是在这里先注册要监听的事件类型。
第一个参数是epoll_create()的返回值。
第二个参数表示动作，用三个宏来表示：
EPOLL_CTL_ADD：注册新的fd到epfd中；
EPOLL_CTL_MOD：修改已经注册的fd的监听事件；
EPOLL_CTL_DEL：从epfd中删除一个fd；
```

事件类型： 
```
events可以是以下几个宏的集合：
EPOLLIN ：表示对应的文件描述符可以读（包括对端SOCKET正常关闭）；
EPOLLOUT：表示对应的文件描述符可以写；
EPOLLPRI：表示对应的文件描述符有紧急的数据可读（这里应该表示有带外数据到来）；
EPOLLERR：表示对应的文件描述符发生错误；
EPOLLHUP：表示对应的文件描述符被挂断；
EPOLLET： 将EPOLL设为边缘触发(Edge Triggered)模式，这是相对于水平触发(Level Triggered)来说的。
EPOLLONESHOT：只监听一次事件，当监听完这次事件之后，如果还需要继续监听这个socket的话，需要再次把这个socket加入到EPOLL队列里
```

实例：  
```C++  
epoll_wait范围之后应该是一个循环，遍历所有的事件：  

nfds = epoll_wait(epfd,events,20,500);  
{
  for(n=0;n<nfds;++n)
  {
    if(events[n].data.fd==listener)
    {
      //如果是主socket的事件的话，则表示
      //有新连接进入了，进行新连接的处理。
      client=accept(listener,(structsockaddr*)&local,&addrlen);
      if(client<0)
      {
        perror("accept");
        continue;
      }
      setnonblocking(client);//将新连接置于非阻塞模式
      ev.events=EPOLLIN|EPOLLET;//并且将新连接也加入EPOLL的监听队列。
      //注意，这里的参数EPOLLIN|EPOLLET并没有设置对写socket的监听，
      //如果有写操作的话，这个时候epoll是不会返回事件的，如果要对写操作
      //也监听的话，应该是EPOLLIN|EPOLLOUT|EPOLLET
      ev.data.fd=client;
      if(epoll_ctl(kdpfd,EPOLL_CTL_ADD,client,&ev)<0)
      {
        //设置好event之后，将这个新的event通过epoll_ctl加入到epoll的监听队列里面，
        //这里用EPOLL_CTL_ADD来加一个新的epoll事件，通过EPOLL_CTL_DEL来减少一个
        //epoll事件，通过EPOLL_CTL_MOD来改变一个事件的监听方式。
        fprintf(stderr,"epollsetinsertionerror:fd=%d",client);
        return -1;
      }
    }
    elseif(event[n].events&EPOLLIN)
    {
      //如果是已经连接的用户，并且收到数据，
      //那么进行读入
      intsockfd_r;
      if((sockfd_r=event[n].data.fd)<0)continue;
      read(sockfd_r,buffer,MAXSIZE);
      //修改sockfd_r上要处理的事件为EPOLLOUT
      ev.data.fd=sockfd_r;
      ev.events=EPOLLOUT|EPOLLET;
      epoll_ctl(epfd,EPOLL_CTL_MOD,sockfd_r,&ev);
    }
    elseif(event[n].events&EPOLLOUT)
    {
      //如果有数据发送
      intsockfd_w=events[n].data.fd;
      write(sockfd_w,buffer,sizeof(buffer));
      //修改sockfd_w上要处理的事件为EPOLLIN
      ev.data.fd=sockfd_w;
      ev.events=EPOLLIN|EPOLLET;
      epoll_ctl(epfd,EPOLL_CTL_MOD,sockfd_w,&ev);
    }
    do_use_fd(events[n].data.fd);
  }
}
```

linux socket文件描述符与地址端口怎么关联的？  

A: socket跟他绑定也是为了统一接口。所以网络相关的调用，如connect,bind等等，第一步基本上就是通过文件描述符找到对应的内核socket结构，然后在进行对应的操作。  



