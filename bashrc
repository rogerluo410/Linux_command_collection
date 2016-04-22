
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

archey
alias rebash='source ~/.bashrc'

alias h='history'
alias k='kill -9'
#####ps#####
alias psx='ps auxw | grep'
alias psg='ps -ef | grep'

#####cd#####
alias cda='cd ~/Repos/giant'
alias cdg='cd ~/Repos/golem'
alias cdc='cd ~/Repos/golem/app/controllers/api/v1'


#####git#####
alias gs='git status'
alias gc='git checkout'
alias gb='git branch'
alias gcr='git checkout rogerluo410-dev'

#####show git branch in shell prompt
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

#rvm ruby version
ruby_version=" → `rvm-prompt i v g`"

PS1="$white[$magenta\u$white@$green\h$white:$cyan\w$yellow\$git_branch$red\$ruby_version$white]\$ $normal"
 
########end of git branch prompt#####








