---
title: 源码体系
type: 源码体系
---

## 思维导图

![源码体系](/images/源码体系.png)

*注: attachments/xmind/源码体系.xmind*

## 数据库运维

运维流程:

0. 项目源码 [syp-model-scripts](http://gitlab.ibi.ren/shengyiplus/syp-model-scripts)
1. 定位模块对应的运维脚本，若没有请联系管理员
2. 在业务数据库测试确认功能运行正常
3. 运维到脚本中的**代码可重复被执行**，即运维脚本可重复执行
4. 运维脚本中**不允许出现业务数据库名称**，若有疑惑请联系管理员
5. 使用 [gap 规范](/developer/style-guide/gitlab.html) 提交代码
6. 在 [Gitlab发起请求合并](/developer/style-guide/gitlab.html#Gitlab-请求合并)