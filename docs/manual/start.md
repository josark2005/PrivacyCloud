# Privacy Cloud

## 首次使用设置方法

- [下载](https://github.com/jokin1999/PrivacyCloud/releases)源码
- 解压文件
- 打开`index.php`进行修改

## index.php 设置项

*define(<设置名称>,<设置内容>)*

eg.

```
// 将"SP"设置项的值设置为"qiniu"
// 这个设置项是设置服务提供商
define("SP","qiniu");
// 所有的设置都是这样修改的
```

**设置项一览**

*加粗为必填项*

|设置项|意义|例子/解释|
|:-:|:-:|:-:|
|**SP**|服务提供商|qiniu|
|**AK**|Access Key|账户控制台个人中心密钥管理中提供的AK|
|**SK**|Secret Key|账户控制台个人中心密钥管理中提供的SK|
|**BUK**|Bucket|需要连接的对象存储Bucket名称|
|**DM**|Domain|Bucket提供的域名或自行绑定的域名，一般为`xxx.com`|
|AA|Account AUTHENTICATED|账户是否实名，实名填写`true`,否则填写`false`（此项设置不需要使用双引号）|
|QD|Query Doamin|查询已使用的流量时需要查询的域名，多个域名时使用英文逗号隔开|
