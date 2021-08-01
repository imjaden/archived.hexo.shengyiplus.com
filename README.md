# 胜因学院-在线文档平台

该站点基于 [Hexo](https://hexo.io) 构建而成。网站内容在 `src` 文件夹内，格式为 Markdown。欢迎 issue 或 pull request。

在线地址：[https://docs.idata.mobi](https://docs.idata.mobi)

## 贡献内容

``` bash
$ git clone git@gitlab.ibi.ren:shengyiplus/syp-documents.git

$ cd syp-documents
$ npm install cnpm -g --registry=https://r.npm.taobao.org
$ cnpm install
$ cnpm run start # 本地浏览: http://localhost:4000

# 编译文章
$ cnpm run build
# 部署文章
$ cnpm run deploy

# 提交代码
$ cnpm run gap <type> <module> <message>

# 提交 pull-request
```
