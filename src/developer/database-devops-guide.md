---
title: 数据库运维规范
type: 数据库运维规范
---

## 思维导图

![数据库运维规范.png](/images/数据库运维规范.png)

## 运维流程

- 确认功能需求
- **本地**开发测试
- 维护运维 SQL 脚本至[SypModelScript](http://gitlab.ibi.ren/shengyiplus/syp-model-scripts)
- 提交代码合并审核(*参考[Gitlab 协作](/corporate-culture/teamwork.html#Gitlab-协作)*)
- 向管理员申请部署至**开发/正式**环境

*注意:*
- 确认提交的SQL运维脚本语法正确
- 确认SQL运维脚本可重复执行(不报错)

## 运维范围

包含但不限于以下内容:(*参考[表设计规范](/developer/style-guide/mysql.html#表设计规范)*)

- 数据库: DDL 语句、存储过程、函数、视图、事件
- 数据表: DDL 语句、触发器、字段更新语句
- 业务数据: 数据插入语句
