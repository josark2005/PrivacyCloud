# Privacy Cloud

## 设置方法

- [下载](https://github.com/jokin1999/PrivacyCloud/releases)源码
- 解压文件
- 打开`index.php`进行修改

## index.php 设置项

define(<设置名称>,<设置内容>)

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

---

## 举个栗子

```
// 必填设置
define("AK", "J7YjcNPAKo4HC5Q6szrX6EGcL8eBT06mqDQRVNqJ");   // accesskey
define("SK", "4woy6xkY9y5GZtW_WGG74fSzx8qNBxjIRpPwKEBp");   // secretkey
define("BUK", "exmple-bukname");  // bucket name
// 域名绑定
define("DM", "ospxxxxfu.bkt.clouddn.com");  // 如果你绑定了自己的域名，把false换成自己域名就可以了如左侧,没有绑定域名的填写方式请参考下方`图1`

// 可选设置，一般保持默认即可
// ACCOUNT AUTHENTICATED
define("AA", false);  // 如果您的账户实名了，请将false换为true
// FLUX CALCULATION(Query Doamin)
define("QD", DM); // 如果你希望查询多个域名下的流量使用情况，请将DM换成你的域名，可以是多个，使用英语逗号隔开
```

---

**图1**

![图1](./imgs/m_1_x_x_p1.png)
