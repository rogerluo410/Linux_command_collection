#System performance command  
* 抓包分析   

   `tcpdump -nn port 9090 -w /var/001.cap`  

   这意思是监听 9090 端口，将监听到的数据保存到 001.cap文件 

* lsof -i:25830 查看所指定端口运行的程序    

* lsof -i -p 646 查看指定进程所占用的端口   
  ps: MacOS X 的netstat等工具是BSD的，不如GNU的强大    
