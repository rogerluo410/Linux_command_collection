
# Typescript
  wiki: https://github.com/Microsoft/TypeScript-Handbook/blob/master/pages/Basic%20Types.md   
  
 ** Basic Types   
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
    

** Interface   
  
  如果对象中的某属性，某interface也有， 则该对象可以转换成该接口。   
  
  ```javascript
    function printLabel(labelledObj: { label: string }) {
    console.log(labelledObj.label);
    }

    let myObj = {size: 10, label: "Size 10 Object"};
    printLabel(myObj);  
    
    //or  
    interface LabelledValue {
    label: string;
    }

    function printLabel(labelledObj: LabelledValue) {
        console.log(labelledObj.label);
    }

    let myObj = {size: 10, label: "Size 10 Object"};
    printLabel(myObj);  
    
    //or 
    
    interface SquareConfig {
      color?: string;   //Optional Properties  
      width?: number;
    }
  ```
  
  
  readonly vs const :   
  Variables use const whereas properties use readonly.    

  ```
    interface Point {
      readonly x: number;
      readonly y: number;
    }
    
    let p1: Point = { x: 10, y: 20 };
    p1.x = 5; // error! 赋了初值就不能再赋值了   
    
  ```   
  
   接口中有函数原型声明：   
   
   ```
     interface SearchFunc {
        (source: string, subString: string): boolean;
      }

      //usage:  
      let mySearch: SearchFunc;
      mySearch = function(src: string, sub: string): boolean {
          let result = src.search(sub);
          return result > -1;
      }
    ```
  
 ** Class Types implementing an interface   
 
   ```
     interface ClockInterface {
          currentTime: Date;
          setTime(d: Date);
      }

      class Clock implements ClockInterface {
          currentTime: Date;
          setTime(d: Date) {
              this.currentTime = d;
          }
          constructor(h: number, m: number) { }
      }  

      Interfaces describe the public side of the class, rather than both the public and private side.   
   ```

** 类的继承  
 
   ```
     class Person {
          protected name: string;
          protected constructor(theName: string) { this.name = theName; }
      }

      // Employee can extend Person
      class Employee extends Person {
          private department: string;

          constructor(name: string, department: string) {
              super(name);
              this.department = department;
          }

          public getElevatorPitch() {
              return `Hello, my name is ${this.name} and I work in ${this.department}.`;
          }
      }

      let howard = new Employee("Howard", "Sales");
      let john = new Person("John"); // Error: The 'Person' constructor is protected
   ```


** Namespace and Module  
  
  ```
    shapes.ts: 
    
    export namespace Shapes {
        export class Triangle { /* ... */ }
        export class Square { /* ... */ }
    } 
    
    shapeConsumer.ts:  
    import * as shapes from "./shapes";
    let t = new shapes.Shapes.Triangle(); // shapes.Shapes?
  ```
