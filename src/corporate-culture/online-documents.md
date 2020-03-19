---
title: 在线文档
type: 在线文档
---

## 文档说明

该站点基于 [Hexo](https://hexo.io) 构建而成。网站内容在 `src` 文件夹内，格式为 Markdown。欢迎 issue 或 pull request。

在线地址：[doc.idata.mobi](https://docs.idata.mobi)

## 贡献内容

- 步骤1: 注册 [团队gitlab](https://gitlab.idata.mobi)
- 步骤2: 向团队申请[项目 syp-documents](https://gitlab.idata.mobi/shengyiplus/syp-documents) 开发权限
- 步骤3: 本地生成 sshkey
- 步骤4: 在 gitlab 账号 ssh 设置项中添加本地 sshkey
- 步骤5: 拉取 syp-documents 项目源码
- 步骤6: 贡献内容
- 步骤7: 使用 [gap 规范](/developer/style-guide/gitlab.html) 提交
- 步骤8: 申请合并
- 步骤9: 管理员审核通过、并发布内容
- 步骤10: 在线文档[doc.idata.mobi](https://docs.idata.mobi) 中查看自己的贡献内容

``` bash
$ git clone git@gitlab.idata.mobi:shengyiplus/syp-documents.git

$ cd syp-documents
$ npm install
$ npm run start # 本地浏览: http://localhost:4000

# 编译文章
$ npm run build

# 提交代码
$ npm run gap <type> <module> <message>

# 提交 pull-request
```

## 图片说明

为了更直观的表述自己的想法、理念，往往一图胜千言，为了保持思维导图的沉淀式更新，需要注意以下几点:

1. 图片存放在本项目内 `src/images/`
2. 图片名称与业务描述相关，方便维护、清理
3. 图片原型(xmind/axure/或其他)维护在 `attachments/{xmind,axure}`

示意效果图:
![图片原型路径说明](/images/图片原型路径说明.png)

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
3. `gap` 命令符合[Gitlab提交规范](/developer/style-guide/gitlab.html), 减少冗余输入