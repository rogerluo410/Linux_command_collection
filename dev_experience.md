#HASH加密  
http://linux.cn/article-2722-1.html  -- 加盐密码哈希：如何正确使用   

**需要提到的是，用于保护密码的哈希函数和你在数据结构中学到的哈希函数是不同的。  
比如用于实现哈希表这之类数据结构的哈希函数，它们的目标是快速查找，而不是高安全性。   
只有加密哈希函数才能用于保护密码，例如SHA256，SHA512，RipeMD和WHIRLPOOL。**   

###1.序列化
**序列化**就是一种用来处理对象流的机制，所谓对象流也就是将对象的内容进行流化。可以对流化后的对象进行读写操作，也可将流化后的对象传输 于网络之间。序列化是为了解决在对对象流进行读写操作时所引发的问题。 
   序列化的实现：将需要被序列化的类实现Serializable接口，该接口没有需要实现的方法，implements Serializable只是为了标注该对象是可被序列化的，然后使用一个输出流(如：FileOutputStream)来构造一个ObjectOutputStream(对象流)对象，接着，使用ObjectOutputStream对象的writeObject(Object obj)方法就可以将参数为obj的对象写出(即保存其状态)，要恢复的话则用输入流.

**当两个进程在进行远程通信时，彼此可以发送各种类型的数据。无论是何种类型的数据，都会以二进制序列的形式在网络上传送。发送方需要把这个对象转换为字节序列，才能在网络上传送；接收方则需要把字节序列再恢复为对象。
把对象转换为字节序列的过程称为对象的序列化。
把字节序列恢复为对象的过程称为对象的反序列化。
说的再直接点，序列化的目的就是为了跨进程传递格式化数据.

**Base64** 也是一种序列化的算法。

###2. MD5
- MD5即Message-Digest Algorithm 5（信息-摘要算法 5），用于确保信息传输完整一致。是计算机广泛使用的散列算法之一（又译摘要算法、哈希算法），主流编程语言普遍已有MD5实现。 将数据（如汉字）运算为另一固定长度值，是散列算法的基础原理，MD5的前身有MD2、MD3和MD4。
- MD5一度被广泛应用于安全领域。但是由于MD5的弱点被不断发现以及计算机能力不断的提升，现在已经可以构造两个具有相同MD5的信息[2]，使本  算法不再适合当前的安全环境。目前，MD5计算广泛应用于错误检查。例如在一些BitTorrent下载中，软件通过计算MD5和检验下载到的碎片的完整性。
- MD5是输入不定长度信息，输出固定长度128-bits的算法。经过程序流程，生成四个32位数据，最后联合起来成为一个128-bits散列。基本方式为，求余、取余、调整长度、与链接变量进行循环运算。得出结果。

**Some specifical questions:**
- 为什么说 MD5 是不可逆的？  
  **A:** (1)1+6=7，但是给你个7你能知道这是几跟几加得的吗？
如果有人坚持认为MD5算法是可逆的，请不妨设想一下将MD5算法应用到文件压缩方面，那岂不是又出现了一种超级压缩技术了。。好几个G大小的文件都能压缩成一串MD5，反正"可以求逆"也就是解压缩(如果应用于压缩技术，算法就是公开的了，也不用费劲去破解了)。可惜这个显然是不可能的，哈哈哈哈
     (2)对呀，这个解释很易懂嘛，我一般说x%8=5，你能知道这个x是多少吗。。

> http://www.zhihu.com/question/22651987

- md5会有重复的可能吗？  
  **A:**   
一般认为任何一个字符串都有一个对应的md5加密串
的确这样. md5算法对输入串的形式没有要求.
如果将26个英文字母组合成32位字符串
显然不是只有32位串才能被md5加密. 所以这么比较无意义.
事实上有可数无穷多个字符串可以被md5加密, 所以自然会有重复, 但这不叫"不够用". 因为大多数使用情形下, 有重复不会带来很大问题, md5不是用完就没了的。。。

> http://www.zhihu.com/question/23189202

- 为什么现在网上有很多软件可以破解MD5，但MD5还是很流行？  
  **A:**    
         1、算法的公开并不意味着不安全；RSA 的算法也是公开的，AES 也是公开的。现代密码学的安全性从不是靠算法的保密来保证的。

         2、目前没有软件能有效地破解 MD5。大多数时候只是把常见字符串的 MD5 存了起来为彩虹表，然后直接反查。

         3、再次强调 MD5 只是哈希，而不是加密。MD5 是没有可能解密的，因为一个 MD5 可能对应无数种可能的明文。

         4、MD5 目前来说还是可以用的，尤其是考虑到合适的加盐以后可以解决大多数彩虹表带来的危险。当然现在已经很多人提倡用 SHA 系列的哈希算法取代 MD5。
         
         5.通过哈希，以达到加密的效果。
         
> http://www.zhihu.com/question/22311285

###3.哈希加密算法
**MD5,SHA-1,SHA-2,SHA-256,SHA-512,SHA-3,RIPEMD-160**

> http://www.atool.org/hash.php

- MD5,sha1,sha256(sha2)分别输出多少位啊？
  MD5输出128bit,32bytes.
  SHA1输出160bit,40bytes.
  SHA256输出256bit,64bytes.
  另外还有SHA244,SHA512
  分别输出244bit，512bit

**Some specifical questions:**
- SHA1 vs md5 vs SHA256: which to use for a PHP login?  
  **A:**   

Neither. You should use bcrypt. The hashes you mention are all optimized to be quick and easy on hardware, and so cracking them share the same qualities. If you have no other choice, at least be sure to use a long salt and re-hash multiple times.
      	 	
a. can you elaborate? what is bcrypt? i don't see any good online examples of it... –  NMoney Feb 10 '10 at 7:50
	 	
b. Yes. I'm referring to SHA1, SHA256 and MD5 and a series of other hashes that are optimized for speed. You don't want to use a hash optimized for speed to secure a password. There are many good articles discussing why, and I like this one in particular: chargen.matasano.com/chargen/2007/9/7/… –  Johannes Gorset Feb 10 '10 at 7:51 
	
It's included in the "crypt" function since PHP 5.3. If you have an earlier version, I'd look into the "phpass" framework for the next best thing. –  Johannes Gorset Feb 10 '10 at 8:03

@Stanislav Palatnik SHA512 is a good alternative. Don't get me wrong; I'm not saying a stretched and salted SHA512 hash is insecure. It's secure. Even so, the fact remains that bcrypt is more secure, and so I see no reason not to use it. –  Johannes Gorset Feb 15 '10 at 6:41 
	
@Cypher: bcrypt is designed to be slow in the interest of being equally slow to **crack**. –  Johannes Gorset Mar 16 '13 at 11:42

> http://stackoverflow.com/questions/2235158/sha1-vs-md5-vs-sha256-which-to-use-for-a-php-login

#字符编码：ASCII，Unicode和UTF-8  
* ASCII码  一个字符占一个字节
因此八个二进制位就可以组合出256种状态，这被称为一个字节（byte）。也就是说，一个字节一共可以用来表示256种不同的状态，每一个状态对应一个符号，就是256个符号，从0000000到11111111。  

* Unicode  
正如上一节所说，世界上存在着多种编码方式，同一个二进制数字可以被解释成不同的符号。因此，要想打开一个文本文件，就必须知道它的编码方式，否则用错误的编码方式解读，就会出现乱码。为什么电子邮件常常出现乱码？就是因为发信人和收信人使用的编码方式不一样。   

Unicode只是一个符号集，它只规定了符号的二进制代码，却没有规定这个二进制代码应该如何存储。  

* UTF-8   
互联网的普及，强烈要求出现一种统一的编码方式。UTF-8就是在互联网上使用最广的一种Unicode的实现方式。其他实现方式还包括UTF-16（字符用两个字节或四个字节表示）和UTF-32（字符用四个字节表示），不过在互联网上基本不用。重复一遍，这里的关系是，UTF-8是Unicode的实现方式之一。
UTF-8最大的一个特点，就是它是一种变长的编码方式。它可以使用1~4个字节表示一个符号，根据不同的符号而变化字节长度。   

> http://www.ruanyifeng.com/blog/2007/10/ascii_unicode_and_utf-8.html   

#分布式文件系统  
分布式文件系统（Distributed File System）是指文件系统管理的物理存储资源不一定直接连接在本地节点上，而是通过计算机网络与节点相连。  

特点：  
```
文件系统最初设计时，仅仅是为局域网内的本地数据服务的。而分布式文件系统将服务范围扩展到了整个网络。不仅改变了数据的存储和管理方式，也拥有了本地文件系统所无法具备的数据备份、数据安全等优点。判断一个分布式文件系统是否优秀，取决于以下三个因素：

l 数据的存储方式，例如有1000万个数据文件，可以在一个节点存储全部数据文件，在其他N个节点上每个节点存储1000/N万个数据文件作为备份；或者平均分配到N个节点上存储，每个节点上存储1000/N万个数据文件。无论采取何种存储方式，目的都是为了保证数据的存储安全和方便获取。

2 数据的读取速率，包括响应用户读取数据文件的请求、定位数据文件所在的节点、读取实际硬盘中数据文件的时间、不同节点间的数据传输时间以及一部分处理器的处理时间等。各种因素决定了分布式文件系统的用户体验。即分布式文件系统中数据的读取速率不能与本地文件系统中数据的读取速率相差太大，否则在本地文件系统中打开一个文件需要2秒，而在分布式文件系统中各种因素的影响下用时超过10秒，就会严重影响用户的使用体验。

3 数据的安全机制，由于数据分散在各个节点中，必须要采取冗余、备份、镜像等方式保证节点出现故障的情况下，能够进行数据的恢复，确保数据安全。
```

#Website 
> http://tech.meituan.com/   --美团技术
