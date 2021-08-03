# 胜因学院-在线文档平台

该站点基于 [Hexo](https://hexo.io) 构建而成。网站内容在 `src` 文件夹内，格式为 Markdown。欢迎 issue 或 pull request。

在线地址：[https://docs.idata.mobi](https://docs.idata.mobi)

## 贡献内容

- 3、 部署项目：cnpm run build
- 3、 提交代码：使用 git 提交，等待管理员审核合并

``` bash
# 1、 安装本地编辑器 推荐 sublime 或者 vscode

# 2、 git 下载项目文件
$ git clone https://gitlab.idata.mobi/shengyiplus/syp-documents.git

# 3、 安装 npm，切换源到淘宝源，依次执行命令即可
$ cd syp-documents
$ npm install cnpm -g --registry=https://r.npm.taobao.org
$ cnpm install

# 4、 启动本地项目，本地预览，启动成功后，点击网址可以访问，即搭建成功
$ cnpm run start # 本地浏览: http://localhost:4000

# 5、 使用编辑器打开项目，进入 src 目录下，选中或添加待变更的文件，并点击保存

# 6、 编译文章（可以在编译器终端中执行，也可以去电脑终端中执行，需要先进入到项目目录下）
$ cnpm run build

# 7、 部署文章
$ cnpm run deploy

# 8、 提交代码 其中 type 代表提交类型， module 代表您所修改的模块， message 代表您所调整的内容描述
$ cnpm run gap <type> <module> <message>

# 9、 如果需要合并代码，提交成功后，登录 gitlab 发起合并请求，并截图给管理员，请求管理员合并


# 提交 pull-request
# 访问 https://docs.idata.mobi/
```
