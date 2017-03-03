
# Go Foundation  
Purpose:   
学习函数式编程     

> https://blog.golang.org/   --blog   
> https://golang.org/doc/effective_go.html  --effective go   
> https://golang.org/pkg/  -- go packages  
> https://github.com/golang/go/wiki/  --go wiki  
> http://awesome-go.com/  --go module     

1) 变量， 类型 和 保留字 
```go
  var a int   //声明 a 为整型
  var b bool
  a = 15      //赋值 a 为 15 
  b = true

  等价于 
  a := 15
  b := true  

  := 表达式符号相当于 初始化并赋值  
```

＊ var 声明可以成组， const 常量， import 导入包 也可以！  
```go
  var (    //左括号必须在同一行
    x bool
    y int 
  )

  const ( 
    x bool
    y int
  )
```

a, b := 20, 16  //平行赋值  
_, b := 31, 32  //特殊变量名 _  , 任何赋给它的值都被丢弃  


2) 内建类型    
  - bool   true / false     
 
  - 数字类型： 
    int （32位系统是  32位字长， 64位系统是 64位字长， 硬件决定长度）， 
    还可以显示指定类型长度： int32/uint32, byte/int8/int16/int64, byte是 uint8 的别名。 

    浮点类型： float32 / float64, 没有float。
    64位的整型 和 64位的浮点型总是64位的， 即便是在32位架构上。  

    注意： 混用这些类型向变量赋值，会引起编译器错误。  
 
  - 常量： 
  常量在编译时被创建， 只能是数字，字符串， bool。 
  可以使用 itoa 生成枚举值。 

  ```go
    const (
      a = itoa
      b = itoa 
    )

    a = 0 , b = 1 

    equal: 
    const ( 
      a = itoa
      b     //Implicitly b = itoa
    )
  ```

  - 字符串   
  var s string = "hello"
  
  与 C 语言一样， "" 表示字符串， '' 表示字符。 
  
  在 GO中 修改一个字符串的字符： 
  ```go
   s := "hello"
   c := []byte(s) 
   c[0] = 'c'
   s2 := string(c)
  ```

  多行字符串： 
    s := "xxxx" +    // + 必须在上面   
         "yyyy"    
    or    
    s := \`xxxx   
          yyyy\`    //使用反引号， 但是包含换行符， 原始字符串在反引号内是不转义的    

  - 集合结构 
  array, slice (切片)， map    
  
   - 数组定义： 

         array ：  ［n]type,     
         a := [3]int{1,2,3}   //{1,2,3} 为赋的初值     
         a := [...]int{1,2,3} //Go会自动统计元素个数      

         多维数组：   
         a := [2][2]int { [2]int{1,3}, [2]int{2, 4}}    
         a := [][2]int { {1,2}, {3,4} }    
   
   
    - 切片定义：      
       slice 与 array 类似， 但是在新的元素加入的时候可以增加长度。 slice 总是指向底层的一个array， slice是一个指向array的指针， 参考STL中的vector。     

       slice是引用类型，这意味着当赋值某个slice到另外一个变量，两个引用会指向同一个array。   

       slice 的定义方式：     
           1. sl := make([]int, 6)  //用make关键字 创建有6个元素的slice    
           2. var array [10]int; sl := array[0:6]  //用已存在的数组初始化一个slice       
              len(sl) == 6  //slice的长度为6   
              cap(sl) == 10 //slice的容量为10，与底层数组有多大的内存空间有关。     
      
       slice 的扩展： 
           append 和 copy  内建函数。  
           1. append   
            追加值，并且返回新的，与原slice有相同类型的slice， 如果原slice指向的底层array容量不够，会分配一个新的底层array，有更大的容量。    
            s1 := append(s0, 1,3,5,7)

           2. copy
             copy(dst, src)   返回复制的元素个数   

             ```go
             var a []int{0,1,2,3,4,5,6,7}  //cap(a) == 8
             s := make([]int, 6)  //cap(s) == 6

             n1 := copy(s, a[0:])   <- n1 = 6, s == []int{0,1,2,3,4,5}
             n2 := copy(s, s[2:])   <- n2 = 4, s == []int{2,3,4,5,4,5}  
             ```    
     
   - map:     
     键值对 ／ hash ／ 字典      
     
     定义：    
     map[key-type]value-type:  
     
       m := map[string]int {   // { 左花扩号 必须在同一行    
         "Jan": 31, "Feb": 28，  //结尾的逗号是必须的    
       }    

     遍历：     
     for k, v := range m {    //range 迭代器遍历集合， ｛｝中的为闭包   
       fmt.Println(k,v)
     }
     
     增加元素：   
       m["March"] = 31     
     
     检查元素是否存在：   
       v, ok := m["March"]     
     
     删除元素：  
       delete(m, "March")   
     
     
     
# 函数       

- 内建函数   
close  delete  len  cap  new  make  copy  append  panic  recover  print  println  complex  real  imag   


- 自定义函数  
 
 - 作用域  
 函数内的局部变量将覆盖全局同名变量  
 
 - 多值返回  
 go 函数和方法可以返回多值  
 
 ```go
  func name(a int) (b，c int) {   // { 左花括号必须在函数同一层   
                                  // a为入参， b，c为返回值
      return                      // 此为命名返回值， 直接return 就可以返回b，c
                                  // 如果 func name(a int) (int, int), 则必须在函数体内定义返回变量  
  }
 ```  
 
 - 延迟代码  
   defer 关键字， 相当于c++中的析构函数   
   defer 后指定的函数，会在函数退出前调用  
   例如，文件打开，结束操作后，需要关闭，可以使用defer  

   ```go
   func ReadWrite() bool {
     file.Open("file")
     defer file.Close()  //file.Close() 被添加到defer列表中   
   }
   ```   

   defer 列表是栈的结构， 后进先出：    
   ```go
   func Myfunc() {
     defer func(){
       fmt.Println("1")
     }()

     defer func(){
       fmt.Println("2")
     }()
                       //打印顺序： 2 1
   }
   ```   

   defer 可以访问命名返回参数：  
   ```go
   func f() (ret int) {
     defer func() {
       ret++   //初始化为零值  
     }()
     return   //返回 1， 而不是0
   }
   ```
 
  - 变参        
    接受变参的函数有不定数量的参数:   
    ```go
     func myfunc(arg ...int)
    ```  
    所有参数都为整型， 在函数体内， arg是一个slice。  

    如果不想指定类型，则可以一个万能类型 interface{} :      
    ```go
     func myfunc(arg ...interface{})
    ```   
    
    ```go
      package main

      import (
        "fmt"
      )


      func Get(arg ...int) {
        fmt.Println(arg)
        arg[0] = 9
        fmt.Println(arg)
      }

      func main() {
       //a := [...]int {1,2,3,4,5}
       //Get(a)   //可变参数为都是整型的参数，只是在函数体内是一个slice
       Get(1,2,3,4,5)
      }
    ```   
    
  -  函数也是值  
  函数也是值， 可以赋值给变量  
  
  ```go
    func main() {
      a := func() {
        ...
      }
      a()   //函数调用
    }  
    
    var xs = map[int]func() int {
      1: func() int { return 30 }，
      2: func() int { return 20 },  
    } 
    
    函数作为函数入参：  
    func myfunc(y int, f func(int) bool) {
      f(1)  //调用回调函数  
    }
  ```   
  
  回调函数例子：  
  ```go
    package main

    import (
      "fmt"
    )


    func callback(i int, f func(int) bool) {
       b := f(i)
       fmt.Println(b)
    }


    func main() {
      a := func(i int) bool {
        fmt.Println(i)
        return true
      }
      callback(10, a)
    }

  ```   
  

 - 函数的恐慌 和 恢复  
   Go 没有像Java那样的异常机制， 不能抛出一个异常。  
   一定要记得，这应当作为最后手段被使用， 代码中应该没有或很少恐慌的东西。   
   
   panic / recover  
   panic 可以直接由panic函数产生， 也可以由运行时错误产生， 如： 访问越界的数组。   
   panic的函数，如果不recover会终止运行， 有recover函数的会执行recover函数体内的代码。  
   
   ```go
     func Join(i []interface{}) string {
        // t := reflect.TypeOf(i)
        // v := reflect.ValueOf(i)
        //
        defer func() {
          if x := recover(); x != nil {  //短表达式， 整个成为一个完整的表达式并返回值。  
             fmt.Println("recovered!")
          }
        }()
        cnt := len(i)
        sl := make([]uint8, cnt)
        for k,v := range i {
          // fmt.Println(v)
          switch v.(type) {
          case byte:
            sl[k] = v.(byte)
          default:
            panic("error type")
          }
          // sl[k] = v.(int)  //赋值必须要 type assertion
        }
          //[]int to string
        return string(sl)
      }
   ```
   
  
  
  
 
