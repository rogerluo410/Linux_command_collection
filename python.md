**Python has indent for coding, and is a dynamical language.**
- its docs : 
  > https://docs.python.org/2/library/stdtypes.html?highlight=dict#dict

- pip(module manager) :
  > https://pip.pypa.io/en/latest/installing.html  

  PyPI is the Python Package index — repository of python modules.  

  pip is used to download and install packages directly from PyPI. PyPI is hosted by Python Software Foundation. It is a   specialized package manager that only deals with python packages.  
  
  apt-get is used to download and install packages from Ubuntu repositories which are hosted by Canonical.  as follow:    
  > http://askubuntu.com/questions/431780/apt-get-install-vs-pip-install
  
- Access Postgresql tutorial:  
  > http://zetcode.com/db/postgresqlpythontutorial/  

- Most elegant way to check if the string is empty in Python?
  ```  
   if not myString:
      print "String is empty"
  ```
- Best way to check if a list is empty? :
  ```
    if not myList: 
      print "List is empty"
  ```

- How to test if every item in a list of type 'int'?  
  ```
     my_list = [1, 2, 3.25]
     all(isinstance(item, int) for item in my_list)
     output : False
  ```

### 数据结构 ###
 - 元组
   pyzoo = ('wolf', 'elephant', 'penguin')
 - 字典
   dict = { key : value }
   multi values ：
       ```
         key = 0
         Dict.setdefault(key,[]
         Dict[key].append('value1')
         Dict[key].append('value2')
           
         print Dict : { 0 : ['value1',value2] }  
       ```
    multi keys :  
       ```
         Dict[(key1,key2,key3)] = 1
         must be a () 元组 ， not a [] list or called array in the keys. 
       ```
    Traversal Dict:
       ```
         for key , value in Dict.iteritems():
             print key , value
         
         -----------------------------------    
         keys = mydictionary.keys()
         keys.sort()
         for each in keys:
             print "%s: %s" % (each, mydictionary.get(each))    
       ```
    Searching by key:
       ```
        value = Dict.get(key) # return the value for key.  
       ```
       
  - 序列
    list = []

### 运算符 和 表达式 ###

  - in，not in
    ```
      for i in range(0,10):
    ```
  - x[index:index] 寻址段
    ```
     str = '12345'
     str1 = str[0:3]
     print str1 ===> '1234'  
    ```
    
### String ###

 - format print 
  ```
   str = "dbname={0} user={1}".format(dbname,username)
  ```
  
 - erase '\n' ,'\r\n' 
  ```
    str.strip().split(',')
  ```

###  控制流\Function ###

 - if,elif,else 
   ```
     if expression :
     
     elif expression :
     
     else:
     
   ```
   
 - while, for
   ```
     while expression:
     
     for i in range(0,5):
   ```

  - Function
   ```
      def funcion_name() : 
      
      --------------------
      key parameters:
         def func(a, b=5, c=10): 
           print 'a is', a, 'and b is', b, 'and c is', c
           
         func(3, 7)
         func(25, c=24)
         func(c=50, a=100)
         
         output :
         $ python func_key.py
         a is 3 and b is 7 and c is 10
         a is 25 and b is 5 and c is 24
         a is 100 and b is 5 and c is 50
   ```
   
### Module ###

 - from x import y
 

