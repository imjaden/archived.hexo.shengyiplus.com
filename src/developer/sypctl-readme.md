---
title: SypCtl 工具
type: SypCtl 工具
---

`SypCtl` 是为了实现对八爪鱼项目及团队其他依赖的技术框架进行环境部署、版本管理、快捷调度、服务守护、日志监控、异常通知、数据备份等一系列围绕提升团队开发效率、加固运维能力、提升服务稳定能力而定制的运维工具。

## 一键部署

- 兼容性：当前版本仅兼容适配 Darwin/CentOS7
- 编程语言: `ruby`, `Bash Shell`

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
sypctl upgrade:force     强制更新
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

Current version is 0.2.26/48
For full documentation, see: https://gitlab.idata.mobi/syp-apps/sypctl.git
```

## 备份方案

![SypCtl三级备份方案.png](/images/SypCtl三级备份方案.png)

*注: attachments/xmind/SypCtl三级备份方案.xmind*

## 功能结构

![SypCtl功能结构.png](/images/SypCtl功能结构.png)

*注: attachments/xmind/SypCtl功能结构.xmind*

## SypCtl 体系:

- [sypctl](https://gitlab.idata.mobi/syp-apps/sypctl)
- [sypctl server](https://gitlab.idata.mobi/syp-apps/sypctl-server)
- [sypctl sync](https://gitlab.idata.mobi/syp-apps/sypctl/tree/dev-backup-script)

### SypCtl 服务器

配置档备份列表及下载入口：
![SypCtlServer-BackupFile.png](/images/SypCtlServer-BackupFile.png)

数据库备份列表及下载入口：
![SypCtlServer-BackupMySQL.png](/images/SypCtlServer-BackupMySQL.png)

服务/进程查看界面：
![SypCtlServer-ServiceStatus.png](/images/SypCtlServer-ServiceStatus.png)

命令行查看服务状态：
![SypCtl-ServiceStatus.png](/images/SypCtl-ServiceStatus.png)

代理端日志查看界面：
![SypCtlServer-AgentLog.png](/images/SypCtlServer-AgentLog.png)

### SypCtl 恢复 GitLab

![SypCtlSync演示.png](/images/SypCtlSync演示.png)

### SypEtl 监控/日志

![SypEtl-MonitorLog.png](/images/SypEtl-MonitorLog.png)




