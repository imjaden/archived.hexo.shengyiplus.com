---
title: 业务菜单规范
type: 业务菜单规范
---

## 结构示意图

![业务菜单结构图](/images/业务菜单结构图.png)

*注: attachments/xmind/业务菜单结构图.xmind*

## 菜单字段

列名 | 属性 | 备注
:----|:----|:----
**id** | `int` | 
**uuid** | `varchar` | 菜单uuid
**category_name** | `varchar` | 分类名称
**category_icon** | `varchar` | 分类图标
**category_order** | `int` | 分类排序
**group_name** | `varchar` | 分组名称
**group_icon** | `varchar` | 分组图标
**group_order** | `int` | 分组排序
**name** | `varchar` | 菜单标题
**icon** | `varchar` | 菜单图标
**order** | `int` | 菜单排序
**publicly** | `tinyint` | 是否通用
**delete_status** | `varchar` | 删除状态字段 0未删除 1已删除
**description** | `varchar` | 描述
**platform** | `varchar` | 平台: pc/app/wxmp/tv
**menu_type** | `varchar` | 菜单类型：工具箱/报表项/设置项
**menu_object** | `varchar` | 菜单对象：wxmp/wxmp#config/report/link
**menu_object_id** | `varchar` | 菜单关联的对象 当menu_object为report时，menu_object_id为report.id
**menu_object_type** | `varchar` | 菜单关联的对象类型
**menu_object_title** | `varchar` | 菜单关联的对象标题
**menu_object_url** | `varchar` | 菜单关联的对象链接，menu_object为link时，menu_object_url为link，当menu_object为wxmp#config时，menu_object_url为home_path
**menu_object_extension** | `varchar` | 菜单关联对象的扩展参数
**menu_object_cdn** | `tinyint` | 是否为 CDN 状态
**menu_object_version** | `varchar` | cdn版本号，menu_object_url为cdn链接
**menu_extension** | `varchar` | 
**create_user** | `int` | 
**update_user** | `int` | 
**created_time** | `datetime` | 
**updated_time** | `datetime` | 

## 业务菜单层级

三级菜单 + 四维属性:
- 一级菜单 `category_name`
- 二级菜单 `group_name`
- 三级菜单 `name`
- 一维属性，平台 `platform`
- 二维属性，板块 `menu_type`
- 三维属性，对象 `menu_object`
- 四维属性，类型 `menu_object_type`

仅一级菜单时只使用 `name` 字段；仅二级菜单时只使用 `group_name` `category_name` 字段。

## 四个平台

支持四个平台(`platform`), 每个接口独立 API 域:
- 小程序端，编号: **wxmp**
- PC浏览器，编号:**pc**
- 电视大屏，编号: **tv**
- 手机应用，编号: **app**

### 1. 小程序端(wxmp)

结论: 使用了两级菜单 `group_name` `name`，板块(`menu_type`)有三种场景：报表项、工具箱、设置项，菜单对象(`menu_object`)支持三种类型: 内嵌模块、配置模块、外部链接。

菜单对象(`menu_object`)：
- 内嵌模块，编号: **wxmp**，依赖字段: 
    - 模块名称(`menu_object_id`)，手工维护
- 配置模块，编号: **wxmp#config**, 依赖字段: 
    - 模块名称(`menu_object_id`) 下拉框选择服务端模块列表
    - 模块根路径(`menu_object_url`)，对应模块表中的 `home_path`
- 外部链接，编号: **webview**，依赖字段: 
    - Web链接(`menu_object_url`)
    - 追加参数(`menu_extension`)

### 2. PC浏览器(PC)

结论: 使用了两级菜单 `group_name` `name`，板块(`menu_type`)有一场景：工具箱，菜单对象(`menu_object`): 大屏报表(big-screen-render)、外链大屏报表(big-screen-outer-render)、数据字典(data-dictionary-list)等。

菜单对象(`menu_object`) 依赖字段: 
  - 唯一标识(`menu_object_id`), 数据字典时为模块UUID, 其他情况为随机UUID
  - Web链接(`menu_object_url`)，大屏报表时为报表链接
  - 注：业务模块为前端代码路由中的 `name` 字段(该字段在路由配置档中需要唯一)

### 3. 电视大屏

结论: 使用了两级菜单 `group_name` `name`，板块(`menu_type`)有一场景：工具箱，菜单对象(`menu_object`)支持一种类型: 外部链接。

菜单对象(`menu_object`) 依赖字段: 
  - Web链接(`menu_object_url`)
  - 追加参数(`menu_extension`)

### 4. 手机应用

暂未上线