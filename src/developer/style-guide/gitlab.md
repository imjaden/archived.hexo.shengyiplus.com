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
3. 所有项目都支持 `gap` 命令 `./tool.sh gap <type> <module> <message>`
4. 若项目中未支持 `gap` 请联系管理员

## Gitlab 请求合并

1. 本地代码使用 `gap` 命令提交
2. 打开并登录 [gitlab.ibi.ren](http://gitlab.ibi.ren)
3. 点击页面 [Merge Request]，点击按钮 [New Merge Request]
4. 选择自己的分支及要提交的目标分支
    - 要提交的源码分支(Source Branch)，一般分支名称是自己名称
    - 要提交的目标分支(Target Branch), 一般以 master 作为后续

![gitlab-new-merge-request.png](/images/gitlab-new-merge-request.png)

5. 依然按照上述的**提交格式**整理提交描述，`type` 为 `merge`。
6. 选择该负责项目的代码审核人(Assignee)。

![gitlab-new-merge-request-submit.png](/images/gitlab-new-merge-request-submit.png)

7. 提交后(Submit merge request) 后，微信通知项目负责审核代码。