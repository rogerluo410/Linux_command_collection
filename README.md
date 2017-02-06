# Command 
Note all commands in Linux and Mac.  
> http://www.duyan.com.cn/edu-85.html  

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
> http://git-scm.com/book/zh/v2 --git 教程   
> https://services.github.com/kit/downloads/cn/github-git-cheat-sheet.html  --git 常用命令  
 
```
编辑用户名和邮箱, 编辑工具  
$ git config --global user.name "wirelessqa"  
$ git config --global user.email wirelessqa.me@gmail.com  
$ git config --global core.editor vim 
```
* global修改的是~/.gitconfig，对当前用户有效


**push到github时，每次都要输入用户名和密码的问题**   
* step1 配置ssh key : https://help.github.com/articles/generating-ssh-keys/   
* step2 git remote set-url origin git@github.com:USERNAME/REPOSITORY2.git     
    http://blog.csdn.net/yuquan0821/article/details/8210944  

**git 分支合并与冲突**  
* git branch branch_name           -- 创建分支  
* git branch -a                    -- 查看所有本地 和 远程分支  
* git checkout branch_name         -- 切换分支  
* git push --set-upstream origin branch_name  --提交到远程本分支上（在远端服务器上创建该分支）   
* git pull origin master:slave     -- 用远端origin主机的master分支更新本地slave分支  
* git diff                         -- 如果有文件冲突,diff出冲突处，手动修改/删除`>>>>head  code  <<<<< `中的代码    
* git commit -a -M "Update with master"  --本地slave分支提交到origin主机的slave分支即可    

**git 命令自动补全脚本**  
```
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash

No need to worry about what directory you're in when you run this as your home directory(~) is used with the target.

Then I added to my ~/.bash_profile file the following 'execute if it exists' code:

(solution one)
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

Update: I'm making these bits of code more concise to shrink down my .bashrc file, in this case I now use:

(solution two)
test -f ~/.git-completion.bash && . $_  

Note: $_ means the last argument to the previous command. so . $_ means run it - "it" being .git-completion.bash in this case

This still works on both Ubuntu and OSX and on machines without the script .git-completion.bash script.

Now git Tab (actually it's git TabTab ) works like a charm!

(PS: If this doesn't work off the bat, you may need to run chmod -X ~/.git-completion.bash to give the script permission to run.)
```

**git process on Working:**   
```
gc master  
git pull origin master   
gc rogerluo410-dev  
git merge master  -- 合并master到当前分支

OR 

git fetch origin staging
git merge origin staging  

OR  

git fetch -p 
git checkout staging
git merge
git checkout [branch_name]
git rebase staging 
git push -f origin [branch_name]  
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

# git stach的作用: 
git stash: 备份当前的工作区的内容，从最近的一次提交中读取相关内容，让工作区保证和上次提交的内容一致。同时，将当前的工作区内容保存到Git栈中。
git stash pop: 从Git栈中读取最近一次保存的内容，恢复工作区的相关内容。由于可能存在多个Stash的内容，所以用栈来管理，pop会从最近的一个stash中读取内容并恢复。
git stash list: 显示Git栈内的所有备份，可以利用这个列表来决定从那个地方恢复。
git stash clear: 清空Git栈。此时使用gitg等图形化工具会发现，原来stash的哪些节点都消失了。

[roger@rogers-MacBook-Air:~/Repos/giant → roger-dev → ruby-2.1.4]$ git stash list
stash@{0}: WIP on roger-dev: 8701131 :dog: 优化代码逻辑。
stash@{1}: WIP on roger-dev: 733cf60 :cat: 修复逻辑错误。
[roger@rogers-MacBook-Air:~/Repos/giant → roger-dev → ruby-2.1.4]$ git stash pop stash@{1}  --恢复 stash@{1}

# git reset --hard <commit_id>  --删除某次提交
http://blog.csdn.net/hudashi/article/details/7664464

# git rm 把一个文件删除，并把它从git的仓库管理系统中移除
git rm 1.txt  

git rm -r --cached .    ---移除git add的文件。
```

**怎么忽略不想上传的文件**   
```
git中提供两种过滤机制，一种是全局过滤机制，即对所有的git都适用；另一种是针对某个项目使用的过滤规则。个人倾向于第二种。

以我的一个项目为例，该项目用.net开发，.config文件、包括生成的bin/Debug, bin/Release文件等，我希望不加入git管理。

在代码目录下建立.gitignore文件：vim .gitignore ,内容如下：

[plain] view plaincopy

#过滤数据库文件、sln解决方案文件、配置文件  
*.mdb  
*.ldb  
*.sln  
*.config  
  
  
#过滤文件夹Debug,Release,obj  
Debug/  
Release/  
obj/  
然后调用git add. ，执行 git commit即可。

问题：.gitignore只适用于尚未添加到git库的文件。如果已经添加了，则需用git rm移除后再重新commit。
```

- Generally speaking, a commit has a type which must be one of the following:

Commit starts with lowercase.

* feat: A new feature
* fix: A bug fix
* docs: Documentation only changes
* style: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
* refactor: A code change that neither fixes a bug or adds a feature
* perf: A code change that improves performance
* test: Adding missing tests
* chore: Changes to the build process or auxiliary tools and libraries such as documentation generation  

A git commit example:

```
feat: auth with JWT

- add gem JWT
- add service LoginUser
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
```
linux启动是自动加载的几个文件说明bashrc等
（1）/etc/profile
全局（公有）配置，不管是哪个用户，登录时都会读取该文件。

（2）/ect/bashrc
Ubuntu没有此文件，与之对应的是/ect/bash.bashrc
它也是全局（公有）的
bash执行时，不管是何种方式，都会读取此文件。

（3）~/.profile
若bash是以login方式执行时，读取~/.bash_profile，若它不存在，则读取~/.bash_login，若前两者不存在，读取~/.profile。
另外，图形模式登录时，此文件将被读取，即使存在~/.bash_profile和~/.bash_login。

（4）~/.bash_login
若bash是以login方式执行时，读取~/.bash_profile，若它不存在，则读取~/.bash_login，若前两者不存在，读取~/.profile。

（5）~/.bash_profile
Unbutu默认没有此文件，可新建。
只有bash是以login形式执行时，才会读取此文件。通常该配置文件还会配置成去读取~/.bashrc。

（6）~/.bashrc
当bash是以non-login形式执行时，读取此文件。若是以login形式执行，则不会读取此文件。

（7）~/.bash_logout
注销时，且是longin形式，此文件才会读取。也就是说，在文本模式注销时，此文件会被读取，图形模式注销时，此文件不会被读取。

下面是在本机的几个例子：
1. 图形模式登录时，顺序读取：/etc/profile和~/.profile
2. 图形模式登录后，打开终端时，顺序读取：/etc/bash.bashrc和~/.bashrc
3. 文本模式登录时，顺序读取：/etc/bash.bashrc，/etc/profile和~/.bash_profile
4. 从其它用户su到该用户，则分两种情况：
（1）如果带-l参数（或-参数，–login参数），如：su -l username，则bash是lonin的，它将顺序读取以下配置文件：/etc/bash.bashrc，/etc/profile和~/.bash_profile。
（2）如果没有带-l参数，则bash是non-login的，它将顺序读取：/etc/bash.bashrc和~/.bashrc
5. 注销时，或退出su登录的用户，如果是longin方式，那么bash会读取：~/.bash_logout
6. 执行自定义的shell文件时，若使用“bash -l a.sh”的方式，则bash会读取行：/etc/profile和~/.bash_profile，若使用其它方式，如：bash a.sh， ./a.sh，sh a.sh（这个不属于bash shell），则不会读取上面的任何文件。
7. 上面的例子凡是读取到~/.bash_profile的，若该文件不存在，则读取~/.bash_login，若前两者不存在，读取~/.profile。
```

   
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

#Mac  
* 8个不可不知的Mac OS X专用命令行工具:  mdfind ...   
> http://segmentfault.com/a/1190000000509514   


#Charles
http抓包工具   


#Sublime Text  
工具栏 Preferences – Settings-User 进入用户设置：  
```
{
 "trim_trailing_white_space_on_save": true,
  "ensure_newline_at_eof_on_save": true,
  "font_face": "Microsoft YaHei Mono",
  "font_size": 16.0,
  "disable_tab_abbreviations": true,
  "tab_size": 2,
  "draw_minimap_border": true,
  "save_on_focus_lost": true,
  "highlight_line": true,
  "word_wrap": "true",
  "fade_fold_buttons": false,
  "bold_folder_labels": true,
  "highlight_modified_tabs": true,
  "default_line_ending": "unix",
  "auto_find_in_selection": true
}
```  
> http://www.jianshu.com/p/b90fc7a0bd2d  

快捷键： 
```
On mac: 
 (Shift) + Alt + command + 1(2,3,4) 分屏
 command + N  新窗口  
 command + w  关闭当前窗口  
 command + shift + t  恢复关闭的窗口  
 Shift + command + [  ( ] ) 切换文件
 command + p 搜索文件
```

# Atom plugins recommended.

> http://blog.csdn.net/d780793370/article/details/52148297  
> http://www.jianshu.com/p/dd97cbb3c22d  


```
relative-numbers
ex-mode
vim-mode

advanced-open-file

ruby-block

docblockr 

file-icons

autocomplete-paths

platformio-ide-terminal

highlight-selected
```
