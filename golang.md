
# Go Foundation  
Purpose:   
学习函数式编程     

> https://github.com/golang/go/tree/master/src  -- go 源码
> https://blog.golang.org/   --blog   
> https://golang.org/doc/effective_go.html  --effective go   
> https://golang.org/pkg/  -- go packages  
> https://github.com/golang/go/wiki/  --go wiki  
> http://awesome-go.com/  --go module  

`go env`  命令查看go环境  
`go run xx.go`  运行  go代码   
`go build xx.go` 编译 go代码  

1) 变量， 类型 和 保留字 
```go
  var a int   //声明 a 为整型, 声明之后 初值为0值， 字符串为“” 空字符串。
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
    or：      
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
    
  - 函数也是值  
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
   
# 包     
包是函数和数据的集合。   

> http://www.cnblogs.com/sevenyuan/p/4548748.html   --理解Golang包导入   

1) 创建包  
 ```go
   package pkg_name   //包名小写   

   func Func1() {     //首字母大写为导出函数，小写为私有函数；这个规则同样适用于定义在包中的其他名字(新类型，全局变量)
     ...  
   }
 ```  

2) 创建目录, 将包代码文件存入该目录下    

  ```go
    -src   //$GOPATH/src    
     -pkg_name    //目录名一般与包名相同         
      -文件名1        
      -文件名2    //多个文件中都可以处于pkg_name这个namespace下         
    -pkg   //$GOPATH/pkg, 存放包编译后的 .a 文件； golang是一个动态语言，实际链接的还是源码； 静态编译，动态运行。  
    
    src 
      github.com
        pkg_name    //目录名
          file1.go  //文件名
          file2.go
            .
            .
            .
  ```

 3) 使用该package  
 
  - 先要编译安装：         
   go install "github.com/pkgname"    //记住，指定的是目录名，而不是包名，包名本质上是代码层面的概念。      
   go get url  //取github上的包       

  - 在其他的包 或 main 中引入该包：   

    ```go
     import (
       "github.com/mylib"    //仅引入目录相对路径, 加载GOPATH/src/github.com/mylib 模块
     )
    ```

  - 其他引入包的方式     

    ```go
     import( 
      . “fmt”    //点操作，省略前缀的包名，适用于方法名唯一，不会与其它包中方法名冲突的系统内建包。 
      f "fmt"    //别名操作， f为fmt这个包 在该文件中的别名    
      “database/sql” _ “github.com/ziutek/mymysql/godrv”   //_操作, 只是引用该包，所以无法通过包名来调用包中的其他函数。  
     )
    ```
 
# 内存分配 与 自定义类型  
 
  ** Go只有指针， 没有指针运算， 不能用指针遍历字符串中的各个字符。     
  ** Go也有GC功能， 无须担心内存分配和回收。  
  
 1)  new 和 make  
   new:   
     分配初值为零值， 返回指针。 主要是结构类型的分配   
   
         ```go      
           type SyncedBuffer struct { 
             lock sync.Mutex 
             buffer bytes.Buffer
           }

           p := new(SyncedBuffer)  //p是一个指针  
         ```     

   make: 
     分配初值为非零值， 返回类型的引用， 而不是指针。 仅用于 slice， map， channel的初始化。   
   
        ```go   
          var p *[]int = new([]int)
          *p = make([]int, 100, 100)
        ```    
  
 2) 复合声明  
  
  1 有时候， 零值不能满足需求， 必须有一个用于初始化的构造函数。        
  2 &File{fd, name, nil, 0} 从复合声明中获取地址，意味着告诉编译器在堆中分配空间，而不是栈中。   
  3 在特定的情况下,如果复合声明不包含任何字段,它创建特定类型的零值。表达 式new(File) 和&File{} 是等价的。     
  4 复合声明同样可以用于创建array,slice 和map。    
  
    
    ```go   

      orig:  

      f :=new(File)
      f.fd = fd
      f.name = name 
      f.nepipe = 0

      updated: 

      func Newfile(fd int, name string) *File {
         ...
         if fd < 0 {
           return nil
         }

         f := File(fd, name, 0)
         return &f    //返回本地变量的地址没有问题， 在函数返回后，相关的存储区域仍然存在。  
      }
    ```  
    
 3) 自定义类型   
   Go 允许自定义新的类型， 通过保留字type实现。  
   
   ```go    
   
     type NameAge struct {     //首字母大写  
       name string     //不导出
       age int         //不导出
     }
   ```
   
 现在NewMutux 等同于Mutex,但是它没有任何Mutex的方法。      
 换句话说,它的方法是空的。    
 但是PrintableMutex 已经从Mutex 继承了方法集合。   
 *PrintableMutex 的方法集合包含了Lock 和Unlock 方法,被绑定到其匿名字段Mutex。   
   
  ```go     
    type Mutex struct {}

    func (m *Mutex) Lock() { fmt.Println("in lock") }
    func (m *Mutex) Unlock() { fmt.Println("in unlock") }

    type NewMutex Mutex
    type PrintableMutex struct {
       Mutex   //这种写法会创建匿名Mutex类型成员变量，也可以看成PrintableMutex继承了Mutex
    }

    func main() {
      var nm NewMutex
      (&nm).Lock()  //(&nm).Lock undefined (type *NewMutex has no field or method Lock)

      pm := new(PrintableMutex)
      pm.Lock()   // => in lock
    }
  ```
  
  假如某自定义类型2个匿名成员有同名的方法， 则该类型变量在调用同名方法时， 会出现编译错误 ambiguous selector pm.Lock  
    
    ```go  
      type Mutex struct {}
      func (m *Mutex) Lock() { fmt.Println("lock in Mutex") }
      func (m *Mutex) Unlock() { fmt.Println("unlock in Mutex") }

      type Mutex1 struct {}
      func (m *Mutex1) Lock() { fmt.Println("lock in Mutex1 ") }
      func (m *Mutex1) Unlock() { fmt.Println("unlock in Mutex1") }

      type NewMutex Mutex
      type PrintableMutex struct {
         Mutex   //这种写法会创建匿名Mutex类型成员变量，也可以看成PrintableMutex继承了Mutex
         Mutex1  
      }

      func main() {
        // var nm NewMutex
        // (&nm).Lock()  //(&nm).Lock undefined (type *NewMutex has no field or method Lock)
        defer func() {
          if x := recover(); x != nil {
            fmt.Println("recovered!")
          }
        }()  //匿名函数

        pm := new(PrintableMutex)
        pm.Lock()   // => 编译错误：  ambiguous selector pm.Lock
      } 
    ```     
    
  4) 转换  

   ```go
     // []int to string
       a := []int {1,2,3}
       b := string(a)
       fmt.Println(b) //cannot convert a (type []int) to type string


     //use rune or int32， int64 is error: cannot convert c (type []int64) to type string
     c := []int32 {1,2,3}
     d := string(c)
     t := reflect.TypeOf(d)
     fmt.Println(t)  // => string
     fmt.Println(d[2]) // => 3
   ```  

   如何在自定义类型之间进行转换?这里创建了两个类型Foo 和Bar,而Bar 是Foo 的一个 别名:     
   type foo struct { int } ← 匿名字段   
   type bar foo    
   
   然后:   
   
   var b bar = bar{1}  
   var f foo = b   
   
   最后一行会引起错误:  
   cannot use b (type bar) as type foo in assignment(不能使用b(类型bar)作为类型foo赋值)   
   
   这可以通过转换来修复:  
   var f foo = foo(b)  
   
   注意转换那些字段不一致的结构是相当困难的。同时注意,转换b到int 同样会出错;  
   整数与有整数字段的结构并不一样。    
   
   
# 接口   

Go 语言不是一种 “传统” 的面向对象编程语言：它里面没有类和继承的概念。  

 - 通过接口可以实现很多面向对象的特性。接口提供了一种方式来 说明 对象的行为：如果谁能搞定这件事，它就可以用在这儿。  
 
 - Go 中的接口跟 Java/C# 类似：都是必须提供一个指定方法集的实现。但是更加灵活通用：任何提供了接口方法实现代码的类型都隐式地实现了该接口，而不用显式地声明。  

 - 接口定义了一组方法（方法集），但是这些方法不包含（实现）代码：它们没有被实现（它们是抽象的）。接口里也不能包含变量。 
 
 - 一般用 结构体 实现接口方法集中的方法，每一个方法的实现说明了此方法是如何作用于该类型的：即实现接口
 
 - 实现某个接口的 结构体（除了实现接口方法外）还可以有其他的方法。
 
 - 即使接口在类型之后才定义，二者处于不同的包中，被单独编译：只要类型实现了接口中的方法，它就实现了此接口  
 
 - go 会做 静态类型检查（是否该类型实现了某个接口）， 如果该类型没有实现某个接口，则会报 “impossible type assertion”   
 
 - 鸭子编程， 实现运行时的动态转换    
 
   ```golang
        package main

	import "fmt"

	type IDuck interface {  
		Quack()
		Walk()
	}

	func DuckDance(duck IDuck) {  // 先使用接口， 后创建bird
		for i := 1; i <= 3; i++ {
			duck.Quack()
			duck.Walk()
		}
	}

	type Bird struct {
		// ...
	}

	func (b *Bird) Quack() {   // bird 实现 duck接口
		fmt.Println("I am quacking!")
	}

	func (b *Bird) Walk()  {
		fmt.Println("I am walking!")
	}

	func main() {
		b := new(Bird)
		DuckDance(b)
	}
   ```   

  * 接口是Go 中的核心概念。 `*S` 在Go中表示， S类型的指针。  

  定义结构 和 结构的方法：     

  ```go
    type Sa struct { i int }
    
    func (p *Sa) Get() int { return p.i }
    func (p *Sa) Put(v int) { p.i = v } 
  ```
  
  也可以定义接口类型， 仅仅是方法的集合。 定义结构 I : 

  ```go
   type I interface {
    Get() int
    Put(int)
   } 
  ```  
  
  对于接口I， Sa是合法的实现， 因为它定义了I所需要的两个方法， 注意， 即使没有明确定义Sa实现了I， 这也是正确的。  

  Go可以利用这一特点来实现接口的另一含义， 就是接口类型做入参。   
  ```go
    func f(p I) {
      fmt.Println(p.Get())
      p.Put(1)
    }
  ```
 
 * 类型（struct）赋值给 接口， 接口才能做类型断言， 查看该接口指向哪一个类型。  
   ```golang
     var areaIntf IShaper
     sq1 := new(Square)
	    sq1.side = 5
	    areaIntf = sq1
     
     // Is Square the type of areaIntf?
     if t, ok := areaIntf.(*Square); ok {
      fmt.Printf("The type of areaIntf is: %T\n", t)
     }
     
     如果忽略 areaIntf.(*Square) 中的 * 号，会导致编译错误：impossible type assertion: Square does not implement Shaper (Area method has pointer receiver)。
     
     //动态方法调用  
     type xmlWriter interface {
	WriteXML(w io.Writer) error
     }
     
     // Exported XML streaming function.
	func StreamXML(v interface{}, w io.Writer) error {
		if xw, ok := v.(xmlWriter); ok {
			// It’s an  xmlWriter, use method of asserted type.
			return xw.WriteXML(w)
		}
		// No implementation, so we have to use our own function (with perhaps reflection):
		return encodeToXML(v, w)
	}

	// Internal XML encoding function.
	func encodeToXML(v interface{}, w io.Writer) error {
		// ...
	}
	
	现在我们可以实现适用于该流类型的任何变量的 StreamXML 函数，并用类型断言检查传入的变量是否实现了该接口；如果没有，我们就调用内建的 encodeToXML 来完成相应工作  
	
	因此 Go 提供了动态语言的优点，却没有其他动态语言在运行时可能发生错误的缺点。  
	
   ```
  
  * 类型判断：type-switch  
   接口变量的类型也可以使用一种特殊形式的 switch 来检测：type-switch  

	```golang
	  switch areaIntf.(type) {
		case *Square:
			// TODO
		case *Circle:
			// TODO
		...
		default:
			// TODO
		}

	  func classifier(items ...interface{}) {  //可变参数
		for i, x := range items {
			switch x.(type) {
			case bool:
				fmt.Printf("Param #%d is a bool\n", i)
			case float64:
				fmt.Printf("Param #%d is a float64\n", i)
			case int, int64:
				fmt.Printf("Param #%d is a int\n", i)
			case nil:
				fmt.Printf("Param #%d is a nil\n", i)
			case string:
				fmt.Printf("Param #%d is a string\n", i)
			default:
				fmt.Printf("Param #%d is unknown\n", i)
			}
		}
	  }
	```

  * 接口嵌套接口  
  比如接口 File 包含了 ReadWrite 和 Lock 的所有方法，它还额外有一个 Close() 方法  
```golang
	type ReadWrite interface {
	    Read(b Buffer) bool
	    Write(b Buffer) bool
	}

	type Lock interface {
	    Lock()
	    Unlock()
	}

	type File interface {
	    ReadWrite
	    Lock
	    Close()
	}
```

# go 多态特性  

当一个类型包含（内嵌）另一个类型（实现了一个或多个接口）的指针时，这个类型就可以使用（另一个类型）所有的接口方法。  

```golang
type Task struct {
	Command string
	*log.Logger
}
```

这个类型的工厂方法像这样：  
```golang
func NewTask(command string, logger *log.Logger) *Task {
	return &Task{command, logger}
}
```

当 log.Logger 实现了 Log() 方法后，Task 的实例 task 就可以调用该方法：  
```golang
  task.Log()  
```

类型可以通过继承多个接口来提供像 多重继承 一样的特性：  
```golang
type ReaderWriter struct {
	*io.Reader
	*io.Writer
}
```

上面概述的原理被应用于整个 Go 包，多态用得越多，代码就相对越少。这被认为是 Go 编程中的重要的最佳实践。   



# 自省和反射  
  
   了解一个对象中的标签， 需要用reflect包（在Go中没有其它方法）。 
   
   - 可以通过反射来分析一个结构体  
   
   - 反射是用程序检查其所拥有的结构，尤其是类型的一种能力；这是元编程的一种形式  
   
   - 反射可以在运行时检查类型和变量，例如它的大小、方法和 动态 的调用这些方法。这对于没有源代码的包尤其有用。这是一个强大的工具，除非真得有必要，否则应当避免使用或小心使用。  
   
   - 两个简单的函数，reflect.TypeOf 和 reflect.ValueOf，返回被检查对象的类型和值。例如，x 被定义为：var x float64 = 3.4，那么 reflect.TypeOf(x) 返回 float64，reflect.ValueOf(x) 返回 <float64 Value>  

   - 实际上，反射是通过检查一个接口的值，变量首先被转换成空接口。这从下面两个函数签名能够很明显的看出来： 
   
```golang
  func TypeOf(i interface{}) Type
  func ValueOf(i interface{}) Value
```
   
```golang
        package main

	import (
		"fmt"
		"reflect"
	)

	func main() {
		var x float64 = 3.4
		fmt.Println("type:", reflect.TypeOf(x))
		v := reflect.ValueOf(x)
		fmt.Println("value:", v)
		fmt.Println("type:", v.Type())
		fmt.Println("kind:", v.Kind())
		fmt.Println("value:", v.Float())
		fmt.Println(v.Interface())
		fmt.Printf("value is %5.2e\n", v.Interface())
		y := v.Interface().(float64)
		fmt.Println(y)
	}
```  



# 使用工厂方法创建结构体实例

- Go 语言不支持面向对象编程语言中那样的构造子方法，但是可以很容易的在 Go 中实现 “构造子工厂”方法。为了方便通常会为类型定义一个工厂，按惯例，工厂的名字以 new 或 New 开头。  

- 我们可以说是工厂实例化了类型的一个对象，就像在基于类的OO语言中那样。  

- 如果想知道结构体类型T的一个实例占用了多少内存，可以使用：size := unsafe.Sizeof(T{})  

```golang
  type matrix struct {    // 不曝光 matrix 结构体， 只能在本文件中使用matrix结构体
    ...
  }

  func NewMatrix(params) *matrix {
     m := new(matrix) // 初始化 m
     return m
  }
```
	
在其他包里使用工厂方法：  
```golang
  package main
  import "matrix"
  ...
  wrong := new(matrix.matrix)     // 编译失败（matrix 是私有的）
  right := matrix.NewMatrix(...)  // 实例化 matrix 的唯一方式
```
  
