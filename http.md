#HTTP


##REST / JSON / XML-RPC / SOAP
REST mandates the general semantics and concepts. The transport and encodings are up to you. They were originally formulated on XML, but JSON is totally applicable.

XML-RPC / SOAP are different mechanisms, but mostly the same ideas: how to map OO APIs on top of XML and HTTP. IMHO, they're disgusting from a design view. I was so relieved when found about REST. In your case, i'm sure that the lots of layers would mean a lot more CPU demand.

I'd say go REST, using JSON for encoding; but if your requirements are really that simple as just uploading, then you can use simply HTTP (which might be RESTful in design even without adding any specific library)

> http://stackoverflow.com/questions/1371312/rest-json-xml-rpc-soap   


##HTTP status  
| Response Class	| HTTP Status Code	| Symbol |   
| Informational   | 100 |	:continue            |     
|  | 101	| :switching_protocols |   
|  | 102	| :processing          |

