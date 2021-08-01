---
title: MySQL Insert 注意事项
type: MySQL Insert 注意事项
---

## Create Table

```
create table if not exists `tbl_insert_ignore_replace_duplicate` (
  `id` int(11) not null auto_increment comment '自增主键',
  `label` varchar(20) not null comment '唯一标识',
  `data_update_time` timestamp not null default current_timestamp comment '数据更新时间',
  primary key (`id`),
  unique index `inx_label` (`label`)
) engine=innodb default charset=utf8 row_format=dynamic comment='测试insert/ignore/replace/duplicate功能';
```

## Insert Into

```
mysql > insert into tbl_insert_ignore_replace_duplicate(label) value ('insert'), ('replace'), ('duplicate');

Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> select * from tbl_insert_ignore_replace_duplicate;
+----+-----------+---------------------+
| id | label     | data_update_time    |
+----+-----------+---------------------+
|  1 | insert    | 2019-10-16 23:22:21 |
|  2 | replace   | 2019-10-16 23:22:21 |
|  3 | duplicate | 2019-10-16 23:22:21 |
+----+-----------+---------------------+
```

普通 `insert into` 当主键或唯一索引冲突时，MySQL 会异常报错中断执行。

```
mysql> mysql > insert into tbl_insert_ignore_replace_duplicate(label) value ('insert');
ERROR 1062 (23000): Duplicate entry 'insert' for key 'inx_label'

mysql> show create table tbl_insert_ignore_replace_duplicate;

CREATE TABLE `tbl_insert_ignore_replace_duplicate` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `label` varchar(20) NOT NULL COMMENT '唯一标识',
  `data_update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `inx_label` (`label`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='测试insert/ignore/replace/duplicate功能'
```

虽然插入失败，但占用了一次 id+1 机会，即把 id=4 使用了，下次 id 从 5 开始。

*TODO: 待确认 master-slave 集群时，slave 库中表的 `AUTO_INCREMENT` 值与 master 相同*

## Replace Into (禁用)

`replace into` 操作时，当主键或唯一索引冲突时就是普通的 `insert into` 效果。

**但是**，当有主键或唯一索引冲突时，会删除冲突行，重新插入，从而 `id` 自动 `+1`.

```
mysql> select version();
+-----------+
| version() |
+-----------+
| 5.7.25    |
+-----------+
1 row in set (0.01 sec)

mysql> select * from tbl_insert_ignore_replace_duplicate;
+----+-----------+---------------------+
| id | label     | data_update_time    |
+----+-----------+---------------------+
|  1 | insert    | 2019-10-16 23:22:21 |
|  2 | replace   | 2019-10-16 23:22:21 |
|  3 | duplicate | 2019-10-16 23:22:21 |
+----+-----------+---------------------+
3 rows in set (0.00 sec)

mysql> replace into tbl_insert_ignore_replace_duplicate(label) value ('replace');
Query OK, 2 rows affected (0.00 sec)

# 上面 insert into 冲突时，造成了 id=(旧id最大值+1)=4
mysql> select * from tbl_insert_ignore_replace_duplicate;
+----+-----------+---------------------+
| id | label     | data_update_time    |
+----+-----------+---------------------+
|  1 | insert    | 2019-10-16 23:22:21 |
|  3 | duplicate | 2019-10-16 23:22:21 |
|  5 | replace   | 2019-10-16 23:27:50 |
+----+-----------+---------------------+
3 rows in set (0.00 sec)

mysql> replace into tbl_insert_ignore_replace_duplicate(label) value ('replace');
Query OK, 2 rows affected (0.00 sec)

mysql> select * from tbl_insert_ignore_replace_duplicate;
+----+-----------+---------------------+
| id | label     | data_update_time    |
+----+-----------+---------------------+
|  1 | insert    | 2019-10-16 23:22:21 |
|  3 | duplicate | 2019-10-16 23:22:21 |
|  6 | replace   | 2019-10-16 23:28:35 |
+----+-----------+---------------------+
3 rows in set (0.00 sec)

mysql> show create table tbl_insert_ignore_replace_duplicate;

CREATE TABLE `tbl_insert_ignore_replace_duplicate` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `label` varchar(20) NOT NULL COMMENT '唯一标识',
  `data_update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `inx_label` (`label`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='测试insert/ignore/replace/duplicate功能'
```

若配置了主从同步，则此时 slave 库中 tbl_insert_ignore_replace_duplicate 表的 AUTO_INCREMENT = 4。

当 master 库压力过大或其他情况，需要把 slave 库转为 master 库时，造成 id 在 4-6 区间的数据无法同步到旧 master 库(出现 duplicate key error)

*TODO: 待实践确认*

## Insert Ignore Into

```
mysql> insert ignore into tbl_insert_ignore_replace_duplicate(label) value ('insert');
Query OK, 0 rows affected, 1 warning (0.00 sec)

# 无任何
mysql> select * from tbl_insert_ignore_replace_duplicate;
+----+-----------+---------------------+
| id | label     | data_update_time    |
+----+-----------+---------------------+
|  1 | insert    | 2019-10-16 23:22:21 |
|  3 | duplicate | 2019-10-16 23:22:21 |
|  6 | replace   | 2019-10-16 23:28:35 |
+----+-----------+---------------------+
4 rows in set (0.00 sec)

# AUTO_INCREMENT 还是 +1 了！
mysql> show create table tbl_insert_ignore_replace_duplicate;

CREATE TABLE `tbl_insert_ignore_replace_duplicate` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `label` varchar(20) NOT NULL COMMENT '唯一标识',
  `data_update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `inx_label` (`label`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='测试insert/ignore/replace/duplicate功能'
```

## On Duplicate Key Update

```
mysql> insert into tbl_insert_ignore_replace_duplicate(label) value ('duplicate') on duplicate key update data_update_time = now();
Query OK, 2 rows affected (0.01 sec)

# label = duplicate 行更新了 data_update_time 列
mysql> select * from tbl_insert_ignore_replace_duplicate;
+----+-----------+---------------------+
| id | label     | data_update_time    |
+----+-----------+---------------------+
|  1 | insert    | 2019-10-16 23:22:21 |
|  3 | duplicate | 2019-10-16 23:38:33 |
|  6 | replace   | 2019-10-16 23:28:35 |
+----+-----------+---------------------+
4 rows in set (0.00 sec)
```
