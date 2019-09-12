---
title: 团队协作
type: 团队协作
---

## Mac 推荐

### KeyCastr

功能亮点: 实时显示键盘的点击按钮，在外连 Window布局键盘时 预防混淆 `Command` `Ctl` 等按键

下载链接: [github: keycastr/keycastr](https://github.com/keycastr/keycastr/releases)

### CheatSheet

功能亮点: 使用任何工具时，忘记了快捷键**常按 `Command` 键**即可展示该工具的快捷命令图谱

下载链接: [CheatSheet](https://cheatsheet-mac.en.softonic.com/mac)

### Dash

功能亮点: 集成了几乎所有开发语言或工具的说明文档(也支持自主补充说明文档)

下载链接: [Dash for Mac](https://kapeli.com/dash)

## Markdown 

### 语法

[Markdown](http://www.markdown.cn/) 是一个 Web 上使用的文本到HTML的转换工具，可以通过简单、易读易写的文本格式生成结构化的HTML文档。目前 github、Stackoverflow 等网站均支持这种格式。

Markdown 的目标是实现**「易读易写」**。

| 效果                 | Markdown 语法
| ------------------- | ---------------------   
| H1                  | # 一级标题            
| H2                  | ## 二级标题             
| H3                  | ### 三级标题           
| [Link](https://doc.idata.mobi/)           | \[Link\](https://doc.idata.mobi)    
| `Inline Code`       | \`Inline Code\`              
| code block          | \`\`\`
| ![alt](/images/logo-100x50.png)     | \!\[alt](/images/logo-100x50.png) 
| **Bold**            | \*\*text\*\*          
| *Emphasize*         | \*text\*              
| ~~Strike-through~~  | ~~ text ~~        
| List without order  | * item               
| List with order     | 1. item              
| Blockquote          | > quote               
| HR                  | -----                 


### 规范

Markdown 语法是对错问题，Markdown 规范是内部协作整理文字时的默认的文字规范。

1. 不同标签间使用空行隔开（空一行即可）。
2. 代码块独立占一行
3. 多级列表时，子级结束时使用空行隔开

### 示例

#### 示例四级标题

下面是一段代码块:

```
puts "markdown style guide!"
```


下面是一段列表:

- 列表1
  - 列表1.1
  - 列表1.2

- 列表2
- 列表3

### 源码

```
#### 示例四级标题
 
下面是一段代码块:

\`\`\`
puts "markdown style guide!"
\`\`\`


下面是一段列表:

- 列表1
  - 列表1.1
  - 列表1.2

- 列表2
- 列表3
```


## 工作日志

### 格式

```
### 2017年3月23日 13 星期四 下午4:45

- DOING
    - 正做事项二

- TODO
    - 待做事项三
        \`\`\`
        question code block
        \`\`\`
- DONE
    - 完成事项一
        <完成事项一> 解释说明...
```

小建议：**日期与时间可以使用快捷键快速插入**

### 规范

- 工作日志按**时间逆序**。
- Markdown 标签之间**间隔一行**。。
- 工作日志尽量简洁的**详细描述**。
- 提交工作日志前，使用 Markdown 编辑器预览，确保语法使用正确。
- 拷贝内容时使用 `command/ctl + shift + v` 不要带样式。
- 每天 09:45 晨会、17:45 复盘会，在此之前更新工作日志。
- 历史工作日志中只应有 `DONE`, 长期 `TODO` 的事项放入近期任务。

## 交流规范

1. 家庭作业的交付是 md/pdf 两个文档，具体见[培训交付规范](/corporate-culture/workplace-cognition.html#培训交付规范)
2. 业务相关的协作交流使用[印象笔记](https://www.yinxiang.com/)
3. 印象笔记的使用最佳配置:
     - 文件夹列表使用[侧列表视图]视野开阔
     - 文档标题保留[标题][已更新时间]；右键标题栏即可配置；拖动标题栏可调整顺序

    ![印象笔记-工作日志-布局规范](/images/印象笔记-工作日志-布局规范.png)
    ![印象笔记-工作日志-标题栏规范](/images/印象笔记-工作日志-标题栏规范.png)

## 功能文档

![功能说明文档规范.png](/images/功能说明文档规范.png)

*注: attachments/xmind/功能说明文档规范.xmind*

## 交付规范

![培训交付规范](/images/培训交付规范.png)

## Gitlab 协作

### 思维导图

![Gitlab协作规范](/images/Gitlab协作规范.png)

### 提交格式

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

### 项目应用

项目根目录下会版本记录文件：`version.js` 或 `version.json`。

- 开发人员每次提交时修改 `提交版本` +1
- 项目助理每次发布时修改 `发布版本` +1

### `gap` 命令


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

## 开发工具

- [印象笔记](https://www.yinxiang.com/)
- [WonderPen](https://www.atominn.com/wonderpen)
- [微信](https://weixin.qq.com)
- [微信小程序开发工具](https://developers.weixin.qq.com/miniprogram/dev/devtools/download.html)
- [Google Chrome](https://www.google.cn/chrome/index.html)
- [RDM - RedisDesktopManager](https://github.com/uglide/RedisDesktopManager/releases)
- Navicat
- Sublime Text
- [XMind](https://www.xmind.cn/)
- [Axure](https://www.axure.com/download)
- Iterm2/OhMyZsh
- IntelliJ IDEA
- Android Studio
- Kettle
- [PowerBI](http://app.powerbi.com)
