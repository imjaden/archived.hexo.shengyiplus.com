---
title: 环境规范
type: 环境规范
---

## 公司设备规范

出发点：
- 公司设备开发环境不受员工流动影响
- 工具、配置路径统一规范方便内部协作
- 在线文档: 职场协作

公司设备：
- 工作事务仅允许使用公司设备
- 禁止串用公司电脑及公开设备账号密码
- 公司设备使用统一账号规范
    - SYMac01
    - SYMac02
    - SYMac0N
    - SYWin01
    - SYWin02
    - SYWin0N

仅公司设备不足时允许使用个人设备：
- 根据已知依赖的工具列表，快速、全面的安装软件

## 软件部署规范

- 项目目录: `~/WorkSpace`
- 依赖包目录: `~/SourceSpace`
- [工具包下载](https://pan.baidu.com/s/1P4yx7eHwJp29nfbnQ4qFEQ&shfl=shareset), 提取码: js5q

软件安装规范(所有设备统一安装目录、配置档位置): 开发工具列表

- iterm2/homebrew/sypctl
- Maven, `~/SourceSpace/Maven3.6.2`
- Zookeeper, `~/SourceSpace/Zookeeper3.4.10`
- ActiveMQ, `~/SourceSpace/ActiveMQ5.15.5`
- Kettle, `~/SourceSpace/Kettle`
- MacDown, Markdown 文件: `~/SourceSpace/Markdown`
- NaviCat, 操作SQL 存储: `~/SourceSpace/NaviCat`
- Java
- Redis/RDM
- MySQL
- IDEA
- Chrome
- Evernote
- Xmind
- Sublime Text

## 线上环境规范

关于线上资源事项：
- 本地环境开发、调试时必须连接本地资源(MySQL/Redis/Mongo/Zookeeper等资源)
- 临时调试线上问题时，允许连接云上数据资源(MySQL/Redis/Mongo/Zookeeper等资源), 

关于项目部署规范:
- 目录规范:
  - FTP: `/data/ftp`
  - 备份: `/data/backup`
  - Web: `/data/work/www`
      - Java 运营平台
      - JAVA API
      - JAVA API Service
      - 前端资源
  - 脚本: `/data/work/scripts`
      - 定时任务脚本
      - Kettle ETL/Jobs 脚本
  - 配置项: `/data/work/config`
  - 工具: `/data/work/tools`

    ```
    /bin/java -> /data/work/tools/jdk-1.8.0_192/jre/bin/java
    /bin/kitchen -> /data/work/tools/kettle-8.2.0.0_342/kitchen.sh
    /bin/kettle -> /data/work/tools/kettle-8.2.0.0_342/spoon.sh
    /bin/spoon -> /data/work/tools/kettle-8.2.0.0_342/spoon.sh
    /bin/ruby -> /root/.rbenv/shims/ruby
    ```

  - 日志项: `/data/work/logs`

  ```
  $ mkdir -p /data/{ftp,backup,work/{www,tools,scripts,config,logs}}
  ```
  
- Linux 系统运维账号
   - Root: `sy-user`
   - FTP: `sy-ftp-user`
   - Web: `sy-www-user`
   - 其他: `sy-devops-user`
- MySQL 运维账号(DDL/DDM权限)
   - 线上账号: `sy-user`
   - 线下开发: `sy-dev-user`
   - 客户账号: `sy-guest-user`
- Redis 运维账号: `sy-user`
