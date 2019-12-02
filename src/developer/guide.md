---
title: 规范指南
type: 规范指南
---

## 关于空格 & 空行

1. 禁止使用`制表符`缩进，配置编辑器自动替换`制表符`为`空格`(2或4个)。
2. 赋值符 `=` 两侧各1个 `空格`, 参数、哈希等`逗号`、`冒号` 后跟1个空格，例: `fun(one, two); let hsh = {one: 1, two: 2}`
3. 多个变量声明时可在一行；多变量赋值时换行，并左对齐。
4. 单行或多行注释符后跟1个 `空格`。
5. 所有代码或文本中禁止两个及两个以上的空行。
6. 业务功能代码段之间使用1个空行
7. 样式 `css` 类之间默认不需要空行；业务代码间空1行。

## 关于团队协作

1. 申请 [职场共识](/corporate-culture/workplace-ceremony.html) 培训
2. 申请 [团队协作](/corporate-culture/teamwork.html) 培训
    - 学习 [交流规范](/corporate-culture/teamwork.html#交流规范)
    - 学习 [交付规范](/corporate-culture/teamwork.html#交付规范)
    - 安装 [开发工具](/corporate-culture/teamwork.html#开发工具)
3. 申请工作日志权限
    - 学习 [Markdown 语法](/corporate-culture/teamwork.html#Markdown)
    - 学习 [工作日志规范](/corporate-culture/teamwork.html#工作日志)
2. 申请 [Gtilab](https://gitlab.idata.mobi/) 账号
    - 学习 [Gitlab 提交规范](/developer/style-guide/gitlab.html)
        1. (**禁止提交视频、音频甚至图片等大体积文件，请维护至 CDN**)
        2. 所有项目都需配置 `Readme.md`
        3. 项目代码交流前先阅读 `Readme.md`
    - 学习 [Java 编程规范](/developer/style-guide/java.html)
    - 学习 [MySQL 协作规范](/developer/style-guide/mysql.html)
    - 学习 [Javascript 协作规范](/developer/style-guide/javascript.html)
    - 学习 [CDN 运维规范](/developer/style-guide/cdn.html)
3. 申请 [Jenkins](https://jenkins.idata.mobi/) 账号
    - 学习 [Jenkins 部署](/developer/jenkins-deploy.html)
4. 申请印象笔记项目目录权限
5. 熟悉[团队源码体系](/developer/project-connections.html)

## 关于开发 & 运维

- [设备环境规范](/developer/environment-guide.html)
- [ETL 运维](/developer/etl-devops-guide.html)
- [API 规范](/developer/api-design-guide.html)
- [RDC 接口规范](/developer/rdc-guide.html)
- [业务菜单规范](/developer/menu-guide.html)

## 关于调试

1. 提交的代码禁止出现调试代码，例: `console.log`
2. 前端同事学习使用 `debugger` 的调试技巧
3. 前端同事学习 Chrome 控制台的基本使用

## 关于测试

1. Java/数据工程师交付接口的 PostMan 测试实例
2. 前端遇到接口问题时，确认 API 路由、请求头、参数信息



