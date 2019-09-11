---
title: MySQL 编程规范
type: MySQL 编程规范
---

## 审核规范

- [数据库运维脚本](http://gitlab.ibi.ren/shengyiplus/syp-model-scripts), 向 DBA 审核开发权限。
- 表结构变更 DBA 审核未通过的，不允许上线。
- 运维 SQL 脚本必须本地执行成功才能提交合并，由 DBA 部署运维脚本。

## 基础规范

- 库名/表名/字段名注释业务场景。
- 库名/表名/字段名禁止使用 `mysql` 保留字。 
- 库名/表名/字段名小写字母、见名知意、下划线命名。
- 数据对象/变量命名采用英文字符,禁止中文命名。
- 临时库/表名必须以 `tmp` 为前缀，并以日期为后缀。
- 备份库/表必须以 `bak` 为前缀，并以日期为后缀。
- 禁止明文存储密码。 
- 禁止跨库访问数据。

## 查询规范

- 拆分复杂 SQL 为多个小 SQL，或创建汇总中间表（利用 `query cache`和多核 `cpu`）。
- 用 `i`n 代替 `or`。`in` 的个数控制在 1000 以内。
- 不使用负向查询，如`not in`/`like`。
- 用`union all`代替`union`；`union all`不需要对结果集再进行排序。
- 禁止使用 `order by rand()`。 
- `select`、`insert`语句必须显式的指明字段名称。
- `where` 条件中的非等值条件（`in`/`between`/`<`/`<=`/`>`/`>=`）会导致后面的条件使用不了索引。
- 使用合理的分页方式以提高分页(`limit`)的效率。
- 减少与数据库交互次数，尽量采用批量sql语句。 
    - a) `insert on duplicate key update`
    - b) `replace into`
    - c) `insert ignore`
    - d) `insert into values() `

## 表设计规范

- 推荐 `utf8mb4`。`utf8mb4` 是真正意义上的 `utf-8`。
- 必须有主键，使用`unsigned`自增列作主键；再创建 `uuid` 字段，作为业务主键。
- 使用 `varbinary` 存储大小写敏感的变长字符串或二进制内容。 `varbinary`默认区分大小写，没有字符集概念，速度快。
- 区分使用 `datetime` 和 `timestamp`。  
- 状态或数量如无特殊字符时，类型使用 `int(11)`。
- 存储状态，性别等，用 `tinyint(1)`。
- 日期如无特殊字符时，类型使用 `date`，`xxx_date`命名。
- 时间如无特殊字符时，类型使用 `datetime` ，`xxx_datetime`命名。
- 备注等内容过长字段使用 `varchar(1000)`。
- 价格等小数类型使用 `decimal(10, 2)`。
- 同一意义的字段设计定义必须相同（便于联表查询）
- 表与表之间需要建立关联关系时尽量使用uuid关联。
- 禁止`default null`，建议`not null` 设置默认值。
- 不建议使用 `enum` 类型，使用 `tinyint` 来代替。

## 索引设计规范

- 唯一索引命名 `uniq_字段1_字段2`，非唯一索引命名 `idx_字段1_字段2`。
- 建立索引时，务必先 `explain`，查看索引使用情况；禁止冗余索引；禁止重复索引。
- 重要的 SQL 中 `where` 条件里的字段必须被索引。
- 不在低基数列上建立索引，例如“性别”。
- 不要在频繁更新的列上建立索引。
- 不在索引列进行数学运算和函数运算（参与了运算的列不会引用索引）
- 复合索引须符合最左前缀的特点建立索引（MySQL 使用复合索引时从左向右匹配）

## 存储过程规范

- 使用 `pro_存储过程名`。
- 接收参数使用 `var_字段名`。
- 接收参数将：`in var_data_enterprise_uuid varchar (100)`, `in var_data_enterprise_code varchar (100)`放置接收参数的末尾。
- 尽可能减少游标的使用。

## 业务场景规范

- 建表时必带字段：

  ```
  `id` int(11) not null auto_increment,
  `uuid` varchar(50) default null comment 'uuid',
  `creater_uuid` varchar(50) default null comment '创建人uuid',
  `created_time` datetime default current_timestamp comment '创建时间',
  `updater_uuid` varchar(50) default null comment '更新人 uuid',
  `updated_time` datetime default current_timestamp on update current_timestamp comment '更新时间',
  `data_enterprise_uuid` varchar(100) default null comment '数据所属企业uuid',
  `data_enterprise_code` varchar(100) default null comment '数据所属企业号',
  `delete_status` varchar(100) default '0' comment '删除状态, 0 未删除 1 已删除',
  ```

- 建表时必带索引：

  ```
  unique key `index_uuid` (`data_enterprise_uuid`,`uuid`)
  ```

- `uuid` 类型统一为 `varchar(50)`。
- 如数量等字段需要设置默认值。
- 尽可能减少主数据字段的变动，如有特定需求建立主数据关联表进行连接。
- 当表与表之间需要建立关联关系时尽量使用 `uuid` 关联。

### 命名规范

- 模糊查询统一使用字段 `fuzzy_search命名`。
- 表名称命名第一段使用统一项目名称命名。
- 当a表与b表为一对多的关系，b表为a表的明细内容时，表名称命名为：`a表名_detail`（a表明细表）。
- 当需要接受当前登录人的 `uuid` 时，使用 `emp_uuid`字段接收。
- 当需要接受分页时，使用`start_num`、`end_num`字段接收。

### SQL 编写规范

- 查询时`join`表时如无特殊情况需加上`data_enterprise_code`和`delete_status`的关联筛选。
- 编写 SQL 时 `where` 条件中养成带上`data_enterprise_data`、`data_enterprise_code`和`delete_status`字段的筛选。
- 传递给前端的参数使用驼峰形式别名。
- `count` 统一使用 `count(*)`。
- 列表页查询传递筛选时使用以下规范：

  ```
  and case
  when '#筛选字段名#' = 'all' or '#筛选字段名#' = '' then
      1 = 1
  else
      数据库字段名 like '%#筛选字段名#%'
  end
  ```

- 列表默认使用 `order by updated_time desc`。

### 应用场景规范

- **REP标题命名**规范：
    1.查询 - 获取xxx列表
    2.查询 - 获取xxx详情
    3.查询 - 获取xxx明细列表
    4.查询 - 统计xxx数量
    5.查询 - xxx校验
    6.修改 - 修改xxx
    7.新增 - 新增xxx

- 需访问数据库的表单校验尽量使用多个接口实现校验。
- 如需要查询加上增（删改）时，选择 `*/select` 权重类型。
- 当需要使用 `if` 判定等操作时使用存储过程完成。
- 当需要接受对象数组进行操作时走固定接口完成。
- 尽量保持一个项目一个分组。
- 所有接口需经过 PostMan 测试通过才算完成。
- 所有接口按模块使用印象笔记呈现，基本格式规范如下：

  ```
  标题：接口文档-xxx模块
  正文：

  ### 新增(修改、删除) - 新增(修改、删除)xxx
  #### 请求参数
  {
    repcode:'rep_0000xx',
    repgroup:'xxx',
    请求参数1字段名:'', // 请求参数1
    请求参数1字段名:'',  // 请求参数2
  }

  ### 查询 - xxxxx
  #### 请求参数
  {
    repcode：'rep_0000xx',
    repgroup:'xxx',
    请求参数1字段名:'默认值', // 请求参数1
  }

  #### 接收参数
  {
    接收参数1字段名:'', // 接收参数1
  }
  ```

## 说明文档规范

- 整理业务表创表语句，确认说明字段都有备注
- 梳理说明业务 SQL 并补充注释
- 整理业务表模型 E-R 图

  ![MySQL-ER图示例](/images/MySQL-ER图示例.png)

  *注: attachments/navicat-data-modeler-database-model/MySQL-ER图示例.ndm*
