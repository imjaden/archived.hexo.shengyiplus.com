---
title: 源码体系
type: 源码体系
---

## 思维导图

![源码体系](/images/源码体系.png)

*注: attachments/xmind/源码体系.xmind*

## 数据库运维

运维流程:

0. 项目源码 [ModelScripts](https://gitlab.idata.mobi/shengyiplus/syp-model-scripts)
1. 定位模块对应的运维脚本，若没有请联系管理员
2. 在业务数据库测试确认功能运行正常
3. 运维到脚本中的**代码可重复被执行**，即运维脚本可重复执行
4. 运维脚本中**不允许出现业务数据库名称**，若有疑惑请联系管理员
5. 使用 [GAP 规范](/developer/style-guide/gitlab.html) 提交代码
6. 在 [Gitlab发起请求合并](/developer/style-guide/gitlab.html#Gitlab-请求合并)

## 业务项目

**注意:** 需要开发团队成员了解业务项目源码之间的关联、本地启动等操作，具备各项目基本的源码阅读能力。

- [JavaAdmin](https://gitlab.idata.mobi/shengyiplus/syp-java-admin)
- [JavaAPI](https://gitlab.idata.mobi/shengyiplus/syp-api-server)
- [ModelScript](https://gitlab.idata.mobi/shengyiplus/syp-model-scripts)
- [WXMP](https://gitlab.idata.mobi/shengyiplus/syp-wxmp)
- [WebPortal](https://gitlab.idata.mobi/shengyiplus/syp-web-portal)
- [ReportPortal](https://gitlab.idata.mobi/shengyiplus/syp-report-portal)(过期)
- [DataDictionaryPortal](https://gitlab.idata.mobi/shengyiplus/syp-data-dictionary-portal)(过期)
- [AndroidTv](https://gitlab.idata.mobi/shengyiplus/syp-android-tv)
- [allerganScripts](https://gitlab.idata.mobi/allergan/allerganScripts)

*项目`README.md`中会说明开发分支、访问域名等信息。*

![readme-domain-guides](/images/readme-domain-guides.png)

## 辅助项目

- [SypCtl](https://gitlab.idata.mobi/syp-apps/sypctl)
- [SypUtils](https://gitlab.idata.mobi/shengyiplus/syp-utils)
- [GitAutoPush](https://gitlab.idata.mobi/shengyiplus/GitAutoPush)
- [SypDocument](https://gitlab.idata.mobi/shengyiplus/syp-documents)
- [SypWebassets](https://gitlab.idata.mobi/shengyiplus/syp-webassets)
- [DdpScript](https://gitlab.idata.mobi/shengyiplus/DdpScript)