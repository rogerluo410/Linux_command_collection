###RVM  
* Installing in OSX with homebrew :  
   1. Install Homebrew :  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"    --`brew doctor` check tool installed successfully.   
   2. Install and configure RVM : 
   ```
   curl -L https://get.rvm.io | bash -s stable    
   source ~/.rvm/scripts/rvm
   ```
   3. Check :  rvm -v   
   4. Install Ruby :  rvm install 2.0.0
   5. Other command : 
            * rvm known   
            * rvm use 2.0.0  
            * rvm list   
            * rvm 2.0.0 --default   
