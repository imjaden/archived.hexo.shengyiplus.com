---
title: Gitlab提交规范
type: Gitlab提交规范
---

## 思维导图

![Gitlab协作规范](/images/Gitlab协作规范.png)

## 提交格式

> type@version(scope): subject

示例：`style@0.1.1/1(commit): 声明团队提交规范`
字段解释：
- type: 必写，可用下述标签: 
    - feat：新功能（feature） 
    - fix：修补 bug 
    - docs：文档（documentation） 
    - style： 格式（不影响代码运行的变动） 
    - refactor：重构（即不是新增功能，也不是修改 bug 的代码变动） 
    - perf：性能改善（A code change that improves performance）
    - test：增加测试 
    - chore：构建过程或辅助工具的变动 

- version: 版本号，例 0.1.2/3
    - 0: 产品版本，默认 0
    - 1: 阶段版本，默认 1
    - 2: 发布版本，默认 1，每次发布 +1
    - 3: 提交版本，默认1，每次提交 +1

- scope: 模块，本次提交代码关联的模块名称
- subject: 日志，本次提交的业务说明，多条日志时使用分号 `;` 分隔

## 项目应用

项目根目录下会版本记录文件：`version.js` 或 `version.json`。

- 开发人员每次提交时修改 `提交版本` +1
- 项目助理每次发布时修改 `发布版本` +1

## `gap` 命令


1. 所有项目源码根目录下都有版本配置档 `version.json`

```
{
    "name": "胜因学院在线文档",
    "major:description": "产品版本",
    "minor:description": "业务版本",
    "tiny:description": "线上版本，每次发布上线时 +1",
    "commit:description": "开发版本，每次 commit 时 +1",
    "major": 0,
    "minor": 1,
    "tiny": 1,
    "commit": 3,
    "pro_mini_version": "0.1.1",
    "pro_version": "0.1.1/3",
    "dev_version": "0.1.3"
}
```

2. 使用 `gap` 操作的 commit 行为都会修改 `version.json` 中 `commit` +1
3. 所有项目都支持 `gap` 命令
    - Node.js 项目 `npm run gap <type> <module> <message>`
    - Ruby 项目 `bash tool.sh gap <type> <module> <message>`
    - Bash 项目 `bash tool.sh gap <type> <module> <message>`

