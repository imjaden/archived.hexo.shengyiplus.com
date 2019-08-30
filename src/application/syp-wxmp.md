---
title: 胜因学院(小程序)
type: 胜因学院(小程序)
---

## 业务流程图

![胜因学院小程序-业务流程](/images/胜因学院小程序-业务流程.png)

[登录模块接口文档](/developer/api-guide/syp-wxmp.html)

## 我的-积分

![胜因学院小程序-业务流程](/images/小程序-我的-积分.png)

积分主要用于小程序消息的推送；简单来讲，微信为了避免小程序对用户滥发消息推送，通过引导用户创建积分(FormId)的方式，约束每推送用户一条消息需要消耗一积分；每个积分有效期七天，长期（大于七天）不使用小程序的用户也收不到推送消息。

## 积分说明

![小程序积分说明](/images/小程序积分说明.png)

[模板消息-微信小程序官方](https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/template-message.html):
> 步骤一：获取模板 ID
> 步骤二：页面的 form 组件，属性 report-submit 为 true 时，可以声明为需要发送模板消息，此时点击按钮提交表单可以获取 formId，用于发送模板消息。或者当用户完成 支付行为，可以获取 prepay_id 用于发送模板消息。
> 步骤三：调用接口下发模板消息
