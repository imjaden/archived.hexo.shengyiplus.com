---
title: 数据库运维
type: 数据库运维
---

## 思维导图

![数据库运维规范.png](/images/数据库运维规范.png)

*注: attachments/xmind/数据库运维规范.xmind*

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

## ETL 流规范

### 数据库分层

![ETL流规范](/images/ETL流规范.png)

*注: attachments/xmind/ETL流规范.xmind*

由于当前业务简单（与数据量多少无关），ETL 流程分三段:（其实需要维护是两段）

- **客户数据源**。

  数据类型: **客户的数据库，或提供的 Excel/SQL 等数据。**  

  客户数据源信息、定时提供的Excel/SQL数据备份归档在印象笔记。

- **ODS 层**(操作数据存储 Operational Data Store)。

  数据类型: 1. 业务需要的客户业务表；2. 非RDS层的计算数数据TDS中间表(转换数据存储 Transform Data Store)。

- **RDS 层**(报表数据存储 Report/Result Data Store)。

  报表加载直接使用的数据表；最佳实现方案是单层查询，若无法做到的话则考虑添加TDS数据中间表。

### 表命名规范

- [MySQL 编程规范](/developer/style-guide/mysql.html)
- 库名/表名/字段名统一小写。
- 库名/表名/字段名禁止使用 mysql 保留字。
- ODS 层业务表命名: `ods_业务表名`。若客户数据表名有大写(Oracle/SQLServer), 则按驼峰转下划线规则，比如 `salesA` 对应 `ods_sales_a`。
- ODS 层中间表命名: `tds_功能描述`。比如聚合汇总后的粉丝用户画像中间表 `tds_fans_personas`，若基于中间表多次计算的中间表在保持原表名后继续追加功能描述，比如基于粉丝用户画像聚合出区域分布表 `tds_fans_personas_regional_distributions`
- RDS 层数据表命名: `rds_数据表`。原则上 1. RDS 表数据量应该很小；2. RDS 数据只能源自 TDS 中间表。

### 备份/其他规范

- ODS/RDS 层所有的数据表设计、存储过程、触发器、视图、事件都需要维护在 [SypModelScripts](http://gitlab.ibi.ren/shengyiplus/syp-model-scripts)
- ODS 层的 ODS 业务表数据需要每日备份，并做人工检查。
- 存储过程按功能需求设计，禁止不同功能的需求使用同一个存储过程。
- 定时事件(event) 按功能需求设计，禁止不同功能的需求使用同一个定时事件。

### PERSON 概念

「PERSONA」是 Allen Cooper 提出来的一种通过调研和问卷获得的典型用户模型，用于产品需求挖掘与交互设计的方法。

- **P, 基本性(Primary)**: 指该用户角色是否基于对真实用户的情景访谈;
- **E, 同理性(Empathy)**: 指用户角色中包含姓名、照片和产品相关的描述，该用户角色是否引同理心;
- **R, 真实性(Realistic)**: 指对那些每天与顾客打交道的人来说，用户角色是否看起来像真实人物;
- **S, 独特性(Singular)**: 每个用户是否是独特的，彼此很少有相似性;
- **O, 目标性(Objectives)**: 该用户角色是否包含与产品相关的高层次目标，是否包含关键词来描述该目标;
- **N, 数量性(Number)**: 用户角色的数量是否足够少，以便设计团队能记住每个用户角色的姓名，以及其中的一个主要用户角色;
- **A, 应用性(Applicable)**: 设计团队是否能使用用户角色作为一种实用工具进行设计决策。

## 报表开发流程

### 思维导图

![报表开发流程.png](/images/报表开发流程.png)

*注: attachments/xmind/报表开发流程.xmind*

### 开发流程

1. 交流客户报表需求
2. 定向低保真原型图
3. 设计报表依赖的数据结构(RDS)
4. 填充伪业务数据
5. 报表开发，还原原型图
6. 与客户确认报表需求
7. 交流客户 ODS 层业务数据
8. 设计 ODS 层数据转换至 RDS 的 TDS 中间表
9. 实现存储过程/事件，同步 ODS -> TDS -> RDS
10. 维护表结构、存储过程、事件等代码至运维脚本项目

