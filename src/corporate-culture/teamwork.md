---
title: 团队协作
type: 团队协作
---

## Mac 工具推荐

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

### 印象笔记

1. 家庭作业的交付是 md/pdf 两个文档，具体见[培训交付规范](/corporate-culture/workplace-cognition.html#培训交付规范)
2. 业务相关的协作交流使用[印象笔记](https://www.yinxiang.com/)
3. 印象笔记的使用最佳配置:
     - 文件夹列表使用[侧列表视图]视野开阔
     - 文档标题保留[标题][已更新时间]；右键标题栏即可配置；拖动标题栏可调整顺序

    ![印象笔记-工作日志-布局规范](/images/印象笔记-工作日志-布局规范.png)
    ![印象笔记-工作日志-标题栏规范](/images/印象笔记-工作日志-标题栏规范.png)

### 微信交流

*注: 针对微信/企业微信/QQ等实时交流工具中的交流规范*。

参考: [职场共识 - 协作规范](/corporate-culture/workplace-ceremony.html#协作规范)

### 邮件交流

Dear All，

我们用邮件是正式的商务沟通，发送邮件注意基本礼仪规范：
1. 标题（点明主旨，方便收件人在列表中查看）
2. 收件人
  1. 主收件人
  2. 抄送人（只为通知到）
  3. 密件抄送（你需要通知的人，又不想让其他收件人知道）
3. 附件
4. 正文
  1. 称呼
  2. 事项描述，尽量用列表清单，有附件的，也要在正文中说明。
  3. 签名

Thanks.

**Albert Li 李昊**
[上海胜因软件技术有限公司](http://www.intfocus.com)
***让人和机器可以合作完成更酷的工作***
上海市闵行区顾戴路2337号B座6楼 201110
Tel: 86 21 51876038 | Mob: 135 8569 7734
Mail: albert_li@intfocus.com | www.intfocus.com


## 功能文档

![功能说明文档规范.png](/images/功能说明文档规范.png)

*注: attachments/xmind/功能说明文档规范.xmind*

## 交付规范

### 思维脑图

![培训交付规范](/images/培训总结交付规范-01.png)

*注: attachments/xmind/培训总结交付规范.xmind*

### 注意事项

1. 明确交付主题，创建**主题名称的目录**
2. 图片文件命名以**主题为前缀**，以**序号为后缀**
2. 创建 `images` 目录，并把相关图片放在该目录
3. `markdown` 原稿中使用**相对路径**引用图片
4. `markdown` 原稿与导出的 PDF 文档放在主题目录
5. 打包 `zip` 压缩文档作为交付文档

### 交付示例

1. *示例文档*目录结构

  ```
  $ tree Desktop/

  Desktop/
  ├── 交付文档示例
  │   ├── images
  │   │   ├── 交付文档示例-01.jpeg
  │   │   └── 交付文档示例-02.png
  │   ├── 交付文档示例.md
  │   └── 交付文档示例.pdf
  └── 交付文档示例.zip // 交付文档
  ```

2. 图片引用示例

```
## 交付文档示例

![交付文档示例-01](images/交付文档示例-01.jpeg)
![交付文档示例-02](images/交付文档示例-02.png)
```

2. 配置 `.md` 文档默认使用 MacDown 软件打开

  ![培训总结交付规范](/images/培训总结交付规范-02.png)

## Gitlab 协作

### 思维导图

![Gitlab协作规范](/images/Gitlab协作规范.png)

*注: attachments/xmind/Gitlab协作规范.xmind*

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

### 请求合并

- 进入团队Gitlab[项目页面](http://gitlab.ibi.ren/)
- 创建请求合并(New merge request)
- 源分支(Source Branch) 选择自己的开发分支
- 目标分支(Target Branch) 选择项目的主分支(dev-0.\*-master)
- 标题(Title) 格式为: `merge@version(scope): message`
- 描述(Description) 格式为:

  ```
  XYZ 申请合并:
  1. 本次提交涉及N份源码文件，M份其他文档，已测试运行成功
  2. 已检测代码编程规范符合要求
  3. 已查阅说明文档(readme.md)符合预期
  ```

- 审核人(Assignee) 选择项目管理员
- 提交合并审核(Submit merge request)

若提示提交的代码有冲突，则需要**取消合并申请**，在本地合并主分支代码、并测试无误后重新提交代码，再请求合并(merge request)。

**代码冲突**提示如下：*
![](/images/gitlab-merge-request-conflicts.png)

*本地合并主分支的代码命令:*

```bash
# 1. 合并主分支代码，根据具体主分支名称调整命令
$ git pull origin dev-0.1-master
# 2. 运行代码，测试确认合并后代码 运行正常
# 3. 本地提交代码
# 4. 线上提交合并申请
# 5. 若有代码冲突，说明在1-4步骤期间其他同事有提交代码，继续进入步骤1
```

## 开发工具

- [印象笔记](https://www.yinxiang.com/)
- [MacDown](https://macdown.uranusjr.com/)
- [微信](https://weixin.qq.com)
- [微信小程序开发工具](https://developers.weixin.qq.com/miniprogram/dev/devtools/download.html)
- [Google Chrome](https://www.google.cn/chrome/index.html)
- [RDM - RedisDesktopManager](https://github.com/uglide/RedisDesktopManager/releases)
- [Navicat](https://www.navicat.com.cn/products)
- Sublime Text
- [XMind](https://www.xmind.cn/)
- [Axure](https://www.axure.com/download)
- [Iterm2](https://www.iterm2.com/)/[OhMyZsh](https://ohmyz.sh/)
- [VNC Viewer](https://www.realvnc.com/en/connect/download/viewer/)
- [IntelliJ IDEA](http://www.jetbrains.com/idea/download/#section=mac)
- [Android Studio](http://www.android-studio.org/index.php/download)
- [Kettle/Data-Integration](http://mirror.bit.edu.cn/pentaho/Data%20Integration/7.1/)
- [PowerBI](http://app.powerbi.com)
