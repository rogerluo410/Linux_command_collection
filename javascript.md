**JS中获取HTML标签对象**  
在JS中使用 $('#images-mask')， 取得标签id    = images-mask 的对象  
在JS中使用 $('.images-mask')， 取得标签class = images-mask 的对象  

**在JS中动态添加标签**  
obj = '<div>...</div>'
$(obj) 表示使用这个标签对象  
```
var sData =  JSON.stringify(data);
            var jData =  JSON.parse(sData);
            //alert(jData["photos"])
            var images = ""
            for (var i in jData["photos"]) {
                //alert (i)
                 images += '<a href="#" class="preview"><img class="img" src="'+ jData["photos"][i]["photo_addr"] +'" alt="" /></a>';

            }
            $('#images-mask').html($(images));
```
