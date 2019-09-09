---
title: DataV报表流程
type: DataV报表流程md
---

## 背景

针对已经发布上线的DataV报表，梳理接口逻辑、对数，达成团队内部运维报表的共识。

## “微整”同比增长流程

### 报表展示

![nVHBB6.png](https://s2.ax1x.com/2019/09/04/nVHBB6.png)

### 点击数据

![nVHhut.png](https://s2.ax1x.com/2019/09/04/nVHhut.png)

### 配置数据源

![nVH4DP.png](https://s2.ax1x.com/2019/09/04/nVH4DP.png)

### 查到repCode 和keyword

![nVHbCQ.png](https://s2.ax1x.com/2019/09/04/nVHbCQ.png)

### 通过repCode找到对应的sql

![nVbSET.png](https://s2.ax1x.com/2019/09/04/nVbSET.png)
![nVbPC4.png](https://s2.ax1x.com/2019/09/04/nVbPC4.png)

### 将keyword的值填到语句中执行

得到的sql语句是：
```sql
SELECT round((t1.`value`-t2.`value`)/t2.`value`*100,2) as `value` FROM
  (SELECT average_year as `value` FROM kpi_baidu_index_month_summary
  WHERE search_year = year(now()) AND keyword = '微整' 
  GROUP BY keyword ) as t1
LEFT JOIN 
  (SELECT average_year as `value` FROM kpi_baidu_index_month_summary
  WHERE search_year = year(now())-1 AND keyword = '微整' 
  GROUP BY keyword) as t2
on 1=1
```

### 结果

得到-27.04与报表一致

## 与粉毒、衡力、Botox的竞品分析

### 报表展示

![nZSJqH.png](https://s2.ax1x.com/2019/09/04/nZSJqH.png)

### 与上个案例一样找到url

![nZSrQS.png](https://s2.ax1x.com/2019/09/04/nZSrQS.png)

### 根据repCode找到sql语句

![nZSfJ0.png](https://s2.ax1x.com/2019/09/04/nZSfJ0.png)

### 将keyword的值填入sql中执行
得到的sql语句：
```sql
SELECT concat(t1.`month`,'月') as x,ifnull(t2.average_month,0) as y,t1.month_en_short,t3.keyword as s
FROM (select * from dim_date WHERE time_type = 'month' and `year` = year(now())) AS t1
LEFT JOIN(SELECT keyword FROM dim_baidu_index_keyword WHERE LOCATE(keyword,'粉毒,衡力,botox') > 0) as t3
on 1=1
LEFT JOIN (SELECT * from kpi_baidu_index_month_summary WHERE LOCATE(keyword,'粉毒,衡力,botox') > 0) AS t2
  ON t1.`year` = t2.search_year AND t1.`month` = t2.search_month AND t2.keyword = t3.keyword
ORDER BY t1.`month`;
```

### 结果
月份|y轴|月份简写|竞品
-|:-:|:-:|-:
1月|121|Jan|衡力
1月|419|Jan|Botox
1月|0|Jan|粉毒
2月|355|Feb|Botox
2月|0|Feb|粉毒
2月|121|Feb|衡力
3月|361|Mar|Botox
3月|0|Mar|粉毒
3月|123|Mar|衡力
4月|0|Apr|Botox
4月|0|Apr|衡力
4月|0|Apr|粉毒
5月|0|May|Botox
5月|0|May|衡力
5月|0|May|粉毒
6月|0|June|Botox
6月|0|June|衡力
6月|0|June|粉毒
7月|0|July|Botox
7月|0|July|衡力
7月|0|July|粉毒
8月|13|Aug|粉毒
8月|129|Aug|衡力
8月|361|Aug|Botox
9月|0|Sept|粉毒
9月|0|Sept|Botox
9月|0|Sept|衡力
10月|0|Oct|粉毒
10月|0|Oct|Botox
10月|0|Oct|衡力
11月|0|Nov|粉毒
11月|0|Nov|Botox
11月|0|Nov|衡力
12月|0|Dec|粉毒
12月|0|Dec|Botox
12月|0|Dec|衡力

### 结论
与报表显示一致