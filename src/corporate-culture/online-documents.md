---
title: 在线文档
type: 在线文档
---

## 文档说明

该站点基于 [Hexo](https://hexo.io) 构建而成。网站内容在 `src` 文件夹内，格式为 Markdown。欢迎 issue 或 pull request。

在线地址：[http://doc.idata.mobi](http://doc.idata.mobi)

## 贡献内容

``` bash
$ git clone git@gitlab.ibi.ren:shengyiplus/syp-documents.git

$ cd syp-documents
$ npm install
$ npm run start # 本地浏览: http://localhost:4000

# 编译文章
$ npm run build

# 提交代码
$ npm run gap <type> <module> <message>

# 提交 pull-request
```

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