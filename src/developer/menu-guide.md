---
title: 菜单规范
type: 菜单规范
---

## 四个平台

支持四个平台(sup_menus.platform), 每个接口独立 API 域:
- 小程序端，编号: **wxmp**
- PC浏览器，编号:**pc**
- 电视大屏，编号: **tv**
- 手机应用，编号: **app**

## 通用字段

- 分类名称(category_name)
- 分类排序(category_order), 隐藏字段
- 分组名称(group_name)
- 分组排序(group_order), 隐藏字段
- 菜单标题(obj_title)
- 菜单排序(item_order), 隐藏字段
- 菜单类型(menu_type)
- 菜单图标(icon)

## 1. 小程序端(wxmp)

小程序端有三个模块支持菜单：
- 报表项
- 工具箱
- 设置项

上述三个模块只是用来展示菜单的区域，支持的菜单属性是相同的。

小程序端支持的菜单类型(menu_type)：
- 小程序模块，编号: **wxmp**，依赖字段: 
    - 模块名称(obj_id)，手工输入
    - 根路径(home_path)
- 小程序配置，编号: **wxmp#config), 依赖字段: 
    - 模块名称(obj_id) 下拉列表选择模块
    - 根路径(home_path)
- 内部报表，编号: **report**，依赖字段: 
    - 内部报表(obj_id) 下拉列表选择报表 
    - 外部链接(obj_link)
    - 追加参数(option_user_num)
- 外部链接，编号: **webview**，依赖字段: 
    - 外部链接(obj_link)
    - 追加参数(option_user_num)

## 2. PC浏览器(PC)

PC 端不分模块，以左侧边栏的方式展示用户权限内的菜单。

菜单类型(menu_type) 编号: **wxmp**，依赖字段: 
  - 外部链接(obj_link)
  - 追加参数(option_user_num)

## 3. 电视大屏

大屏两模块，仅其中一个模块支持菜单：
- 工具箱
- 设置项(无菜单)

菜单类型(menu_type) 编号: **tv**，依赖字段: 
  - 外部链接(obj_link)
  - 追加参数(option_user_num)

## 4. 手机应用

iOS/Android 系统App 支持三个模块，仅两个模块支持菜单：
- 报表项
- 工具箱
- 设置项(无菜单)

菜单类型(menu_type) 编号: **app**，依赖字段: 
  - 外部链接(obj_link)
  - 追加参数(option_user_num)