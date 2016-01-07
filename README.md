# Command 
Note all commands in Linux and Mac.  

#URL  
GDB document : http://www.sourceware.org/gdb/current/onlinedocs/gdb.html   
autoconf & automake :   
> http://www.cnblogs.com/itech/archive/2010/11/28/1890220.html    
  http://www.laruence.com/2009/11/18/1154.html --for GNU    

#GNU nano 
**^G表示Ctrl+G，就是按住Ctrl键不放然后按G**  

#VIM  
光标到行首： shift+^    
光标到行未： shift+$   or  shift+a（edit mode）    

#Git
**git config --global core.editor vim**  
* global修改的是~/.gitconfig，对当前用户有效

**push到github时，每次都要输入用户名和密码的问题**   
* step1 配置ssh key : https://help.github.com/articles/generating-ssh-keys/   
* step2 git remote set-url origin git@github.com:USERNAME/REPOSITORY2.git     
    http://blog.csdn.net/yuquan0821/article/details/8210944  

**git 分支合并与冲突**  
* git branch branch_name           -- 创建分支  
* git checkout branch_name         -- 切换分支  
* git pull origin master:slave     -- 用远端origin主机的master分支更新本地slave分支  
* git diff                         -- 如果有文件冲突,diff出冲突处，手动修改/删除`>>>>head  code  <<<<< `中的代码    
* git commit -a -M "Update with master"  --本地slave分支提交到origin主机的slave分支即可    

**git process on Working:**   
```
gc master  
git pull origin master   
gc rogerluo410-dev  
git merge master  -- 合并master到当前分支
```  

**fork了开源项目后，如何持续跟进项目的开发:**     
```
$ git clone https://github.com/youname/ruby-china.git
$ git remote add ruby-china https://github.com/ruby-china/ruby-china.git
$ git remote
origin # 你的
ruby-china # 官方的
$ git fetch ruby-china
$ git checkout master
$ git rebase ruby-china/master -i

git rebase有点类似git merge，但是两者又有不同，打个比方，你有两个抽屉A和B，里面都装了衣服，现在想把B中的衣服放到A中，git merge是那种横冲直撞型的，拿起B就倒入A里面，如果满了（冲突）再一并整理；
而git rebase就很持家了，它会一件一件的从B往A中加，会根据一开始放入的时间顺序的来加，如果满了你可以处理这一件，你可以继续加，或者跳过这一件，又 或者不加了，把A还原。所以merge适合那种比较琐碎的，简单的合并，系统级的合并还是用rebase吧。

# 合并b
git rebase b

# 处理完冲突继续合并
git rebase –continue

# 跳过
git rebase –skip

# 取消合并
git rebase –abort

git stach  --隐藏某个commit    
```
   
 
#Thread
**top -H -p pid命令查看进程内各个线程占用的CPU百分比**  
```
PID USER      PR  NI  VIRT  RES  SHR S %CPU MEM    TIME+  COMMAND                         

14086 root      25   0  922m 914m 538m R  101 10.0  21:35.46 gateway                          

14087 root      25   0  922m 914m 538m R  101 10.0  10:50.22 gateway                           

14081 root      25   0  922m 914m 538m S   99 10.0   8:57.36 gateway                            

14082 root      25   0  922m 914m 538m R   99 10.0  11:51.92 gateway                              

14089 root      25   0  922m 914m 538m R   99 10.0  21:21.77 gateway                             

14092 root      25   0  922m 914m 538m R   99 10.0  19:55.47 gateway                               

14094 root      25   0  922m 914m 538m R   99 10.0  21:02.21 gateway                                

14083 root      25   0  922m 914m 538m R   97 10.0  21:32.39 gateway                                 

14088 root     25   0  922m 914m  538m R  97 10.0   11:23.12  gateway
```  

**使用gcore命令转存进程映像及内存上下文**  
```
gcore 14094
该命令生成core文件core.14094
```

**用gdb调试core文件，并线程切换到37号线程.gcore和实际的core dump时产生的core文件几乎一样，只是不能用gdb进行某些动态调试**  
```
(gdb) gdb gateway core.14094 
(gdb) thread 37
[Switching to thread 37 (Thread 0x4696ab90 (LWP 14086))]#0  0x40000410 in __kernel_vsyscall ()
(gdb) where
#0  0x40000410 in __kernel_vsyscall ()
#1  0x40241f33 in poll () from /lib/i686/nosegneg/libc.so.6

可以根据详细的函数栈进行gdb调试，打印一些变量值，并结合源代码分析为何会poll调用占用很高的CPU。
```  

#curl  
`Get request with parameters IN URL:`  
* curl http://localhost:3000/api/backend/taxonomies?params1=1&params2=2   

`POST request with JSON data:`       
*  curl -X POST localhost:3000/api/v1/team/63/products -F 'token=123' -F 'type=stone_material' -F 'surface_id=3' -F 'file_ids[]=1' -F 'file_ids[]=2' -F 'prices[0][type]=1' -F 'prices[0][level]=3' -F 'prices[1][type]=2' -F 'prices[1][deliver_address]=sadafsfs' -F 'prices[1][level]=5' -F 'taxonomy_id=10' -F 'archive_ids[]=3' -F 'archive_ids[]=1' -F 'prices[0][length]=15' -F 'prices[0][amount]=5' -F 'prices[0][money]=5.55' -F 'prices[1][amount]=7' -F 'prices[1][money]=15.64'  -F 'name=lu105'    

`PUT`   
* curl -X PUT localhost:3000/api/v1/team/63/products/111 -d 'token=123' -d 'file_ids[]=8' -d 'file_ids[]=6' -d 'taxonomy_id=15' -d 'surface_id=7' -d 'archive_ids[]=12' -d 'prices[0][price_id]=230' -d 'prices[0][money]=1255.55' -d 'prices[0][amount]=100' -d 'prices[0][length]=101' -d 'prices[0][type]=2' -d 'prices[0][height]=134' -d 'prices[1][height]=50' -d 'prices[1][money]=500' -d 'prices[1][amount]=200'    


#scp  
一.作用： 
远程拷贝文件/目录 SCP 

二.命令基本格式： 
scp source dest  

三.具体应用例子： 
本地->远端（复制文件）：   
scp LocalFile  UserName@RemoteIP:RemoteFile    

本地->远端（复制目录）：   
scp -r LocalFolder UserName@RemoteIP:RemoteFolder   

远端->本地（复制文件）：  
scp UserName@RemoteIP:RemoteFile LocalFile    

远端->本地（复制目录）：  
scp -r UserName@RemoteIP:RemoteFolder LocalFolder   

远端->远端（复制文件，从1复制到2） ：     
scp UserName1@RemoteIP1:RemoteFile1 UserName2@RemoteIP2:RemoteFile2   

远端->远端（复制目录，从1复制到2）:    
scp -r UserName1@RemoteIP1:RemoteFolder1 UserName2@RemoteIP2:RemoteFolder2   

注：执行以上命令后，系统会提示输入UserName的密码。     

#Tips for configure Linux   
###Creating a user and adding it to the sudoers list    
   Creating               : http://www.cyberciti.biz/faq/howto-add-new-linux-user-account/   
   Adding in sudoers list : http://www.pendrivelinux.com/how-to-add-a-user-to-the-sudoers-list/    
   
   a.Editing "NOPASSWD" for a user account :     
     Enter `"sudo vim /etc/sudoers"`     
     and then edit with `"devops ALL=(ALL:ALL) NOPASSWD :ALL"`   
     
   b.Adding bash for a user account so that it can be operated by bash when access to the os with SSH,otherwise,it can't use shell command with SSH   
     Enter "sudo vim /etc/passwd"   
     and then edit with `"devops:x:1001:1001::/home/devops:/bin/bash" `  
     
     
###.bashrc and .profile 
* 要搞清bashrc与profile的区别，首先要弄明白什么是交互式shell和非交互式shell，什么是login shell 和non-login shell。   

* 交互式模式就是shell等待你的输入，并且执行你提交的命令。这种模式被称作交互式是因为shell与用户进行交互。这种模式也是大多数用户非常熟悉的：登录、执行一些命令、签退。当你签退后，shell也终止了。     shell也可以运行在另外一种模式：非交互式模式。在这种模式下，shell不与你进行交互，而是读取存放在文件中的命令,并且执行它们。当它读到文件的结尾，shell也就终止了。   

* bashrc与profile都用于保存用户的环境信息，bashrc用于交互式non-loginshell，而profile用于交互式login shell。   

/etc/profile，/etc/bashrc 是系统全局环境变量设定   
~/.profile，~/.bashrc用户家目录下的私有环境变量设定  

当登入系统时候获得一个shell进程时，其读取环境设定档有三步  
1. 首先读入的是全局环境变量设定档/etc/profile，然后根据其内容读取额外的设定的文档，如
/etc/profile.d和/etc/inputrc   
2. 然后根据不同使用者帐号，去其家目录读取~/.bash_profile，如果这读取不了就读取~/.bash_login，这个也读取不了才会读取
~/.profile，这三个文档设定基本上是一样的，读取有优先关系   
3. 然后在根据用户帐号读取~/.bashrc  

至于~/.profile与~/.bashrc的不同区别，都具有个性化定制功能    
~/.profile可以设定本用户专有的路径，环境变量，等，它只能登入的时候执行一次   
~/.bashrc也是某用户专有设定文档，可以设定路径，命令别名，每次shell script的执行都会使用它一次  

   
###set colorful prompt   
`export PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '    `  

* shell提示符显示git当前分支  
```
## Parses out the branch name from .git/HEAD:
find_git_branch () {
    local dir=. head
    until [ "$dir" -ef / ]; do
        if [ -f "$dir/.git/HEAD" ]; then
            head=$(< "$dir/.git/HEAD")
            if [[ $head = ref:\ refs/heads/* ]]; then
                git_branch=" → ${head#*/*/}"
            elif [[ $head != '' ]]; then
                git_branch=" → (detached)"
            else
                git_branch=" → (unknow)"
            fi
            return
        fi
        dir="../$dir"
    done
    git_branch=''
}
PROMPT_COMMAND="find_git_branch; $PROMPT_COMMAND"

# Here is bash color codes you can use
  black=$'\[\e[1;30m\]'
    red=$'\[\e[1;31m\]'
  green=$'\[\e[1;32m\]'
 yellow=$'\[\e[1;33m\]'
   blue=$'\[\e[1;34m\]'
magenta=$'\[\e[1;35m\]'
   cyan=$'\[\e[1;36m\]'
  white=$'\[\e[1;37m\]'
 normal=$'\[\e[m\]'
 
PS1="$white[$magenta\u$white@$green\h$white:$cyan\w$yellow\$git_branch$white]\$ $normal"

以上的代码可以放在 ~/.profile 或者 ~/.bash_profile 等文件中即可，我的系统是 Snow Leopard，
PS1 定义在/etc/bashrc 中，所以直接修改这个文件。
```
