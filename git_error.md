## 1. git merge fatal: Needed a single revision invalid upstream feat/release   

```shell
The error is telling that git-rebase expects only one referente, not two. And origin is not a reference.

You forgot the slash between origin and master.

git rebase -i origin/master
origin is the name of the repository.
master is the branch of the repository.
You can have several branches. Then the slash is telling git which branch of the repository is the one you want to rebase.

When you want to do a rebase of your own repository you only need to write the branch or reference without telling any repository.
```  

> http://stackoverflow.com/questions/31897929/git-rebase-i-origin-master-fatal-needed-a-single-revision-invalid-upstream-or  
