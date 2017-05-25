
# Typescript
  wiki: https://github.com/Microsoft/TypeScript-Handbook/blob/master/pages/Basic%20Types.md   
  
  1. boolean 
   let isDone: boolean = false;
  
  2. number
   let decimal: number = 6;
   
  3. string
   let color: string = "blue";
   
   backtick ｀｀:  `xxxx ${var}`  //格式化连接字符串     
   
  4. array
   let list: number[] = [1,2,3]    
   let list: Array<number> = [1,2,3] //必须赋初值？, 可以[]空数组

  5. Tuple (pair)   
    let x: [string, number] = ['base', 1]    
    
  6. Enum    
    enum Color {Red, Blue, Green}  //from 0 to last one      
    let c: Color = Color.Red    
  
  7. Any      
    let notSure: any = 4;  
    notSure = "xxxx";   
    notSure = false;   
    
    let list: any[] = [1, "213", true]    
    list[1] = 1000    
    
  8. void, null, undefined, never   
  
  9. Type assertions   
    let someValue: any = "assss";    
    let strLength: number = (someValue as string).length;       
    
  
