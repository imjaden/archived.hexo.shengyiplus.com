---
title: SypCtl 工具
type: SypCtl 工具
---

## 兼容性

当前版本仅兼容适配 **Darwin/CentOS7.\***

## 一键部署

```
# Linux
$ curl -sS http://gitlab.idata.mobi/syp-apps/sypctl/raw/dev-0.1-master/env.sh | bash
# Darwin
$ curl -sS http://gitlab.idata.mobi/syp-apps/sypctl/raw/dev-0.1-master/darwin-env.sh | bash
```

## 使用手册

```
$ sypctl help
Usage: sypctl <command> [args]

常规操作:
sypctl help              帮助说明
sypctl upgrade           更新源码
sypctl deploy            部署服务引导（删除会自动部署）
sypctl deployed          查看已部署服务
sypctl report            设备/MySQL状态
sypctl sync:device       更新重新提交设备信息

sypctl agent   help      #代理# 配置
sypctl toolkit help      #工具# 箱
sypctl service help      #服务# 管理
sypctl backup:file  help #备份文件# 工具
sypctl backup:mysql help #备份MySQL# 工具
sypctl sync:mysql   help #迁移MySQL# 工具

命令缩写:
sypctl service -> syps
sypctl toolkit -> sypt


  mmmm m     m mmmmm    mmm mmmmmmm m
 #"   " "m m"  #   "# m"   "   #    #
 "#mmm   "#"   #mmm#" #        #    #
     "#   #    #      #        #    #
 "mmm#"   #    #       "mmm"   #    #mmmmm

Current version is 0.2.19
For full documentation, see: http://gitlab.idata.mobi/syp-apps/sypctl.git
```

## 备份方案

![SypCtl三级备份方案.png](/images/SypCtl三级备份方案.png)

*注: attachments/xmind/SypCtl三级备份方案.xmind*