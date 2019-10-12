> http://www.slideshare.net/anildigital/design-patterns-inruby  

- Four points: 

1. 从事物(对象)中分离出保持不变的东西。  
   Separate out the things that change from those that stay the same.    
   
2. 编写接口， 而非实现。(抽象化事物)
   Program to an interface, not an implementation.    
   
3. 使用组合，胜过继承。  
   Prefer composition over inheritance.    
   
4. 代理， 代理， 代理。  
   Delegate, delegate, delegate.


- principles: 

1. 单一职责原则。 

2. 开放－封闭原则（一个软件实体应当对扩展开放,对修改关闭）。    
   例如， 构造一辆车，用横滨牌轮胎， 也可以用米其林。 不必在车模块写为横滨牌轮胎，如果要用米其林，则要修改代码。   
   只需初始化车对象时， 传入横滨牌轮胎或米其林。
   
3. 里氏代换原则       
   只有衍生类可以替换基类，软件单位的功能才能不受影响，基类才能真正被复用，而衍生类也能够在基类的基础上增加新功能。        
   应当尽量从抽象类继承,而不从具体类继承,一般而言,如果有两个具体类A,B有继承关系,那么一个最简单的修改方案是建立一个抽象类C,然后让类A和B成为抽象类C的子类.
   
4. 依赖倒置原则 (要求客户端依赖于抽象耦合)         
   例如， 构造一辆车, 只需初始化车对象时, 定义的入参变量是横滨牌轮胎， 那么如果想要传入米其林，则不得不修改代码或者重载初始化函数。    
   可以抽象化轮胎类，由于is-a的关系， 所以根据里氏代换原则，衍生类可以替换基类使用。  
   
5. 接口隔离原则（一个类对另外一个类的依赖是建立在最小的接口上）        
   胖接口会导致他们的客户程序之间产生不正常的并且有害的耦合关系.当一个客户程序要求该胖接口进行一个改动时,会影响到所有其他的客户程序.        
   使用多个专门的接口比使用单一的总接口要好.       
   
6. 合成/聚合复用原则 （has-a关系）       
   在一个新的对象里面使用一些已有的对象,使之成为新对象的一部分;新的对象通过这些向对象的委派达到复用已有功能的目的.这个设计原则有另一个简短的表述:`要尽量使用合成/聚合,尽量不要使用继承.`  与开闭原则有联系。 

   
-----------------------------------
工作流引擎设计思路

工作流引擎数据库设计
目标： 实现订单交易及其他工作流的状态流转。不考虑可视化的自定义工作流，所有流程设计时完成。暂不考虑节点多分支以及分支汇合的情况。

 1.  工作流总表， wf_list
     - id
     - name
     - klazz     // 英文别名
     - remark    // 备注
     - deleted

  2. 工作流节点表， wf_node
     - id
     - wf_list_id
     - name
     - prev_node_id      // 上一个节点id
     - next_node_id      // 下一个节点id
     - failed_transition_node_id  // 失败跳转节点id， 没有就返回上级节点
     - node_type          // 节点类型(1-开始节点,2-运行节点,3-结束节点)  
     - node_func_type // 节点功能类型(1-普通节点{自动处理} 2-业务节点{人为审批})
     - node_func_class_name  // 节点处理类的类全名称
     - order    // 序号
     - deleted

  3. 工作流申请表， wf_apply
     - id
     - user_id          // 申请人
     - wf_list_id       // 工作流id
     - cur_node_id  // 当前节点id
     - title
     - content
     - state     // 当前工作流状态(1-已提交,2-运行中,3-结束)
     - priority  // 优先级
     - deleted

  4. 工作流操作表， wf_process
     - id 
     - wf_apply_id  // 申请单id
     - wf_node_id   // 本次操作工作流节点id 
     - wf_node_name // 本次操作工作流节点名字
     - user_id         // 操作人
     - operation     // 0-提交，1-通过，2-驳回(返回给上一级 或 指定节点)
     - reason         // 理由
     - deleted

----------------------------
节点处理类设计思路

提供处理函数套件：

 - init_function  流程初始函数
 - run_function 流程运行函数
 - save_function 流程保存函数
 - transit_function  流程流转函数
 - execute_function  流程直接执行函数

