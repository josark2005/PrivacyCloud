# Privacy Cloud

## 错误码解析

### 第一位

- `J`: 使用由Jokin定制开发的框架。
- `T`: 使用`Twocola-php`框架。

### 字母除第一位与最后两位

- `PC`: Privacy Cloud。

*表示项目*

### 字母倒数第二位

- `U`: `Update` 表示更新过程中出现的错误。

*表示出错时的任务状态*

### 字母最后一位

- `D`: `Danger` 表示高危错误。
- `F`: `Fatal` 表示底层异常错误。
- `E`: `Error` 表示常见错误。

## Privacy Cloud 错误码一览

**推荐方案代码请往下翻阅**

|错误码|起始版本|终止版本|解释|推荐方案|
|:-:|:-:|:-:|:-:|
|JPCD01|`1.3.2`|`up-to-date`|无法读取版本信息|重新安装程序|
|JPCD02|`1.3.2`|`up-to-date`|缺少升级所需参数|重新配置或重新安装程序|
|~~JPCD03~~|~~`1.3.2`~~|`1.3.2`|~~非升级对应版本~~|~~取消升级~~|
|JPCD04|`1.3.2`|`up-to-date`|无法还原|`PCS-1`|

## Privacy Cloud 解决方案一览

- `PCS-1`
  - 来源：`JPCD04`
  - 检查入口文件同级目录下是否存在`_pcbkup.zip`文件。
  - 若不存在，则重新安装。
  - 若存在，请检查其完整性（是否能正常解压）。
  - 若可解压，请解压至其所在目录（当前目录）。
  - 不可解压请重新安装。
  - 常见：非`1.3.1`版本升级`1.3.2`版本导致。