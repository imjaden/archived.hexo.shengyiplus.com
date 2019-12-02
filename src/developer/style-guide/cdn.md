---
title: CDN 运维规范
type: CDN 运维规范
---

## 文档大纲

- 域名分配
- 通用资源-维护方式
- 非通用资源-维护方式

## 域名分配

- 胜因学院正式环境: https://cdn.idata.mobi
- 胜因学院开发环境: https://cdn-dev.idata.mobi

## 通用资源-维护方式

Webassets项目链接: https://gitlab.idata.mobi/shengyiplus/syp-webassets

1. 下载静态资源，合规命名(文件名称、版本号)
2. 维护静态资源至对应目录
3. 使用CDN链接访问在线资源

### 路由/文件命名规范

路径规范后的目标:
1. 统一管理、监控、同步、备份
2. 统一 CDN访问链接

路由/文件命名规范:
- 目录命名使用复数(数据库业务表命名同理)
- 路由或文件命名中空格使用横线, 比如 wxmp-icons
- 组合词不需要分割，比如 `webassets`/`datasource`

路由/路径分类：
1. 菜单图标统一维护(各平台中访问菜单图标的在线链接)
2. 小程序/TV/Pc/App应用内图标，分别维护(方便独立升级)
3. 头像

```
# 目录分配
/data/work/www/webassets/
├── javascripts // javascript 文件
├── stylesheets // css/fonts 文件
├── enterprises // 企业命名空间
├── gravatars // 头像
├── feedbacks // 问题反馈截图或视频
├── menu-icons // 菜单图标
├── app-icons // app 应用图标
├── pc-icons // pc 应用图标
├── tv-icons // tv 应用图标
└── wxmp-icons // 微信小程序图标
```

### CDN & HTTP/HTTPS

1. 所有服务默认支持 HTTPS, 即使用 HTTPS 线上测试
2. 禁止使用外部资源，统一维护在本项目内

- [胜因学院-静态资源](https://cdn.idata.mobi/webassets.html)
- [胜因研发室-静态资源](https://cdn-dev.idata.mobi/webassets.html)

### 代码提交规范

```
$ ./tool.sh gap -h
示例:
$ ./tool.sh gap <type> <module> <message>
```

## 非通用资源-维护方式

1. `https://cdn.idata.mobi` 对应的根目录: `/data/work/www`

    示例: /data/work/www/webassets/wxmp-icons/btn_inf.png 对应的访问链接: https://cdn.idata.mobi/webassets/wxmp-icons/btn_inf.png

2. 静态资源(图片/字段/javascript/stylesheets) 对应存储目录: `/data/work/www/webassets`

    与 `webassets` 并列的是其他 Web 项目：

    ```
    $tree -L 1 /data/work/www/
    /data/work/www/
    ├── webassets
    ├── frontend-apps
    ├── index.html
    ├── providerAPI
    ├── tomcatAPI
    ├── tomcatSuperAdmin
    ├── vapelab -> /data/work/www/frontend-apps/repository/vapelab@0.1.23
    └── web-portal -> /data/work/www/frontend-apps/repository/web-portal@0.2.10
    ````

## 运维规范(webassets)-上传操作

```
$ tree -L 1 /data/work/www/webassets
/data/work/www/webassets
├── enterprises
├── gravatars
├── menu-icons
├── vapelab // VapeLab 平台静态资源
└── wxmp-icons

$ tree -N -L 1 /data/work/www/webassets/vapelab/
/data/work/www/webassets/vapelab/
├── ALD
├── CERALL-CL6-CL7
├── DM
└── EXEEK-XK
```

1. VapeLab 平台静态资源上传至目录 /data/work/www/webassets/vapelab/
2. 目录、文件名称间不要有空格、`&|\` 等特殊符号
3. 上传命令

    ```
    # Mac 本机
    $ rsync --progress -ar CERALL-CL6-CL7 sy-devops-user@syp.idata.mobi:/data/work/www/webassets/vapelab
    # Syp-Pro
    $ find  /data/work/www/webassets/vapelab/CERALL-CL6-CL7/ -type f         
    /data/work/www/webassets/vapelab/CERALL-CL6-CL7/详情图/画板-1.png      
    /data/work/www/webassets/vapelab/CERALL-CL6-CL7/详情图/画板-2.png  
    /data/work/www/webassets/vapelab/CERALL-CL6-CL7/详情图/画板-3.png
    # 访问链接
    https://cdn.idata.mobi/webassets/vapelab/CERALL-CL6-CL7/详情图/画板-1.png     
    https://cdn.idata.mobi/webassets/vapelab/CERALL-CL6-CL7/详情图/画板-2.png    
    https://cdn.idata.mobi/webassets/vapelab/CERALL-CL6-CL7/详情图/画板-3.png  
    ```