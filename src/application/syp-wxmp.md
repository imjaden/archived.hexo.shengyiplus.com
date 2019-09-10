---
title: 胜因学院(小程序)
type: 胜因学院(小程序)
---

## 业务流程图

![胜因学院-业务流程图](/images/胜因学院-业务流程图.png)

*注: attachments/xmind/胜因学院-业务流程图.xmind*

## 业务效果图

![胜因学院小程序-业务效果图](/images/胜因学院-小程序业务效果图.png)

*注: TODO-待补充 axure 原型*

## 业务模块框架

![胜因学院小程序-业务流程](/images/胜因学院-小程序模块框架图.png)

*注: attachments/xmind/胜因学院-小程序功能框架图.xmind*

接口文档: [登录模块](/developer/api-guide/syp-wxmp.html)

## 积分流程图

![小程序积分说明](/images/小程序积分说明.png)

*注: attachments/xmind/胜因学院-小程序用户与微信账户的关联.xmind*

[模板消息-微信小程序官方](https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/template-message.html):
> 步骤一：获取模板 ID
> 步骤二：页面的 form 组件，属性 report-submit 为 true 时，可以声明为需要发送模板消息，此时点击按钮提交表单可以获取 formId，用于发送模板消息。或者当用户完成 支付行为，可以获取 prepay_id 用于发送模板消息。
> 步骤三：调用接口下发模板消息

## 积分5W1H

### WHERE

- 胜因学院-我的-积分

![胜因学院-我的-积分](/images/胜因学院-我的-积分.png)

### WHAT

- 这里的积分，其实就是formID,每一个积分代表一个formID
- formID用于给用户推送模板消息，每一个formID可推送一条模板消息
- 模板消息就是小程序的服务通知，只有在业务有需要的时候才会给用户推送

![推送消息](/images/推送消息.png)

### WHEN

- 每一位微信用户有其唯一识别的openID，每一个openID可对应多个formID
- 根据业务需要，我们会在某些特定的表单处埋点，当用户提交这些表单，即可获取该用户的formID，一次提交行为对应一个formID
- 用户通过提交表单向服务器提交数据，这是真正意义上的表单；但是在胜因学院小程序中，用户点击这些button（如下图所示），向服务器提交的数据为空值，也可算作一次提交表单行为，也可获取一个formID
- 只有在业务有需要的时候才会消耗用户的formID推送模板消息，所以formID可能会有富余，而且formID的有效期是7天，只可使用7天内的formID，多余或过期的 formID 作废

![提交表单](/images/提交表单.jpeg)

### WHY

- 这里的积分数量主要是为了提示客户当前能推送多少条模板消息，避免相互追责

### HOW

> 步骤一：获取模板 ID
> 步骤二：页面的 form 组件，属性 report-submit 为 true 时，可以声明为需要发送模板消息，此时点击按钮提交表单可以获取 formId，用于发送模板消息。或者当用户完成 支付行为，可以获取 prepay_id 用于发送模板消息。
> 步骤三：调用接口下发模板消息
