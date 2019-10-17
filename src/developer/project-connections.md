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

## 业务项目

**注意:** 需要开发团队成员了解业务项目源码之间的关联、本地启动等操作，具备各项目基本的源码阅读能力。

- [JavaAdmin](http://gitlab.ibi.ren/shengyiplus/syp-java-admin)
- [JavaAPI](http://gitlab.ibi.ren/shengyiplus/syp-api-server)
- [ModelScript](http://gitlab.ibi.ren/shengyiplus/syp-model-scripts)
- [WXMP](http://gitlab.ibi.ren/shengyiplus/syp-wxmp)
- [ReportPortal](http://gitlab.ibi.ren/shengyiplus/syp-report-portal)
- [DataDictionaryPortal](http://gitlab.ibi.ren/shengyiplus/syp-data-dictionary-portal)
- [AndroidTv](http://gitlab.ibi.ren/shengyiplus/syp-android-tv)
- [allerganScripts](http://gitlab.ibi.ren/allergan/allerganScripts)

## 辅助项目

- [SypCtl](http://gitlab.ibi.ren/syp-apps/sypctl)
- [SypUtils](http://gitlab.ibi.ren/shengyiplus/syp-utils)
- [GitAutoPush](http://gitlab.ibi.ren/shengyiplus/GitAutoPush)
- [SypDocument](http://gitlab.ibi.ren/shengyiplus/syp-documents)
- [SypWebassets](http://gitlab.ibi.ren/shengyiplus/syp-webassets)
- [DdpScript](http://gitlab.ibi.ren/shengyiplus/DdpScript)