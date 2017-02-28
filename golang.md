
# Go Foundation

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


＊ 内建类型 
  － bool   true / false   
 
  － 数字类型： 
    int （32位系统是  32位字长， 64位系统是 64位字长， 硬件决定长度）， 
    还可以显示指定类型长度： int32/uint32, byte/int8/int16/int64, byte是 uint8 的别名。 

    浮点类型： float32 / float64, 没有float。
    64位的整型 和 64位的浮点型总是64位的， 即便是在32位架构上。  

    注意： 混用这些类型向变量赋值，会引起编译器错误。  
 
  － 常量： 
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

  -  字符串 
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
  s := `xxxx   
        yyyy`    //使用反引号， 但是包含换行符， 原始字符串在反引号内是不转义的    

 － 集合结构 
  array, slice (切片)， map    
  
   定义： 

   array ：  ［n]type,     
   a := [3]int{1,2,3}   //{1,2,3} 为赋的初值     
   a := [...]int{1,2,3} //Go会自动统计元素个数      
   
   多维数组：   
   a := [2][2]int { [2]int{1,3}, [2]int{2, 4}}    
   a := [][2]int { {1,2}, {3,4} }    
   
