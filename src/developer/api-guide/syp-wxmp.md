---
title: 接口文档(小程序)
type: 接口文档
---

## 登录页

### 业务流程图

[登录模块业务流程](/application/syp-wxmp.html)

### 手机号登录

1. 企业列表展示

  ```
  get /portal/v2/account-number-login/enterprise-list
  {
    mobile: 手机号,
    password: 密码(MD5加密)
  }
  ```

  业务流程：

  - 参数判断（mobile和password 进行判空）
  - 获取数据源 portalDataSource
  - 判断密码
    - 调用 `PortalV2Service的queryUserInfo(mobile)` 方法查询用户密码

      ```SQL
      select password 
      from sup_user 
      where mobile = #{mobile} and delete_status = 0 limit 1
      ```

    - 判断userPassword和参数password是否相等，或者根据手机号后六位数(内部排序)经过MD5加密后的字符串是否相等，有一个相等就继续，如果都不相同，返回信息中返回“密码错误”

2. 获取企业列表

  - 调用 `apiPortalV2Service的queryEnterpriseListWithMobile(mobile, password)` 获取企业列表result

    ```sql
    SELECT
      sue.uuid AS userUuid ,
      su.user_name AS userName ,
      sue.mobile AS userMobile ,
      su.email AS userEmail ,
      su.user_num AS userNumber ,
      sue. STATUS AS userStatus ,
      su. PASSWORD ,
      su. PASSWORD AS userIdToken ,
      sue.token AS userToken ,
      se.group_id AS groupId ,
      se.role_id AS roleId ,
      su.is_delete AS userIsDelete ,
      'todo' AS userGravatar ,
      'todo' AS groupName ,
      'todo' AS roleName ,
      se.uuid AS enterpriseUuid ,
      se. CODE AS enterpriseCode ,
      se. NAME AS enterpriseName ,
      se.data_source_id AS dataSourceCode ,
      se.role_id AS enterpriseRoleId ,
      se.group_id AS enterpriseGroupId ,
      se. LANGUAGE AS enterpriseLanguage
    FROM
      sup_user_enterprises AS sue
    LEFT JOIN sup_enterprises AS se ON se.uuid = sue.data_enterprise_uuid
    AND sue.data_enterprise_code = se. CODE
    LEFT JOIN sup_user AS su ON su.mobile = sue.mobile
    WHERE
      sue.mobile = #{mobile} and sue.delete_status = '0' and sue.status = 1
    
    GROUP BY
      sue.uuid
    ```

3. 查询用户角色

  - 循环遍历企业列表result，每次遍历的单体对象是map，根据map中的userUuid和数据源去调用 `apiPortalV2Service的queryUserRoleUuidList` 查询用户角色uuid得到 roleList
  - 追加roleList给map中的userUuidList
  - 遍历roleList，将每一个roleUuid用“，”拼接起来赋值给roleUuids字符串，然后追加到map中的roleUuids中

4. 封装结果到返回信息实体中并返回信息实体，用户选择企业进行登录

### 微信登录

获取微信用户 openid

```
post /saas-api/api/portal/wx/query-user-openid 
{
  code: 用户凭证(wx.login获取),
  enterpriseUuid: 企业uuid,
  mobile: 手机号
}
```

业务流程：

- 参数判断（code和mobile进行判空）
- 如果code不为空，从数据库中重新获取openid
  - 读取配置文件中的weChat.appId、weChat.secret、weChat.openIdUrl分别赋值给appId、secret、openIdUrl三个字符串，然后用appId、secret、参数code分别替换openIdUrl中的APP_ID、APP_SECRET、JS_CODE三个字段，得到一个新的openIdUrl，然后调用本地方法去查询到openId，得到openIdResult
  - 判断openIdResult是否是json格式，不是则返回信息显示格式错误，是则将它转为JSON对象json
  - 创建一个字段isBinging=0，向json中put
  - 如果json对象不为空，先获取数据源portalDataSource
  - 调用 `apiWeChatService的portalQueryUserOpenId(mobilev, enterpriseUuid, portalDataSource)`方法查询用户openId得到结果集 result（map集合）

    ```sql
    SELECT
      wx_unique_token AS openid ,
      is_binding
    FROM
      sup_wx_users
    WHERE
      mobile = #{mobile} and is_binding = 1 and delete_status = 0
    ORDER BY
      id DESC
    LIMIT 1
    ```

  - 将结果result的is_binding字段追加给json中
  - 在返回实体对象中封装结果json对象，并返回

- 如果code为空，则从数据源中取
  - 获得数据源对象portalDataSource
  - 根据参数mobile和request中的enterpriseUuid和数据源来调用apiWeChatService的portalQueryUserOpenId方法查询用户openId得到结果result
  - 在返回实体对象中封装结果result

### 推送信息

```
post /saas-api/api/portal/wx/send-template-message
{
  toUsers: 需要发送的用户的uuid,
  template_id: 模板id,
  page: 需要跳转的页面（选填）,
  data: 微信通知模板数据,
  enterpriseUuid: 企业uuid,
  emphasis_keyword： 模板需放大关键字可选填）
}
```

业务流程：

- 参数判断（param，data，toUsers，template_id进行判空）
- 获取企业信息：根据参数enterpriseUuid去查询企业信息得到portalEnterprise
- 获取用户openId：根据参数toUsers中获取，得到openId数组toUserArray
- 封装查询参数query，向其中追加参数enterpriseUuid、toUsers、dataEnterpriseUuid和dataEnterpriseCode
- 获取数据源得到portalDataSource
- 调用 `apiWeChatService的queryUserOpenIdWithUuid(query, portalDataSource)` 方法得到 openId 集合openIdList

  ```sql
  SELECT DISTINCT
    swu.wx_unique_token AS openId
  FROM
    sup_user_enterprises AS sue
  LEFT JOIN sup_wx_users AS swu ON sue.mobile = swu.mobile
  WHERE
    sue.delete_status = '0'
  AND swu.wx_unique_token IS NOT NULL
  AND swu.wx_unique_token != ''
  AND sue.data_enterprise_uuid = #{dataEnterpriseUuid} and sue.data_enterprise_code = #{dataEnterpriseCode}
  
  AND swu.is_binding = 1
  AND swu.delete_status = 0
  AND sue.uuid IN '遍历#{toUsers}'
  GROUP BY uuid
  ```

- 向参数集合newParam中追加appId、secret、fromUrl、ip、templateId、page、data、empahsis_keyword
- 循环发送模板信息
  - 通过openId异步获取formId
  - 向newParam中追加openId和formId给toUser和formId两个字段
  - 调用自身API去得到结果sendResult
  - 向结果集合resultMap中追加sendResult
- 向返回实体信息中封装resultMap并返回

### 提交用户偏好

```
get user/v1/preference
{
  enterpriseUuid: 企业UUID,
  cmobile: 手机号,
  platform: 平台
}
```

业务流程：

- 参数判断（对enterpriseUuid、mobile、platform进行判空）
- 将mobile、enterpriseUuid、platform拼接成一个hashkey
- 大key为“user：perference”，hashkey为拼接成的hashkey去redis中取值preference
- 如果preference是空的
  - 将mobile、enterpriseUuid、platform依次放进参数params中，params是一个map集合
  - 获取数据源portalDataSource
  - 根据参数params和数据源去数据库取preference

    ```sql
    SELECT
      preference
    FROM
      sup_user_preferences
    WHERE
      enterprise_uuid = '${enterpriseUuid}'
    AND mobile = '${mobile}'
    AND platform = '${platform}'
    LIMIT 1;
    ```

  - 以“user：perference”为大key，拼接的hashkey为hashksy，preference为值追加到redis中
  - 返回实体信息中封装preference并返回

- 如果preference非空，返回实体信息中封装preference并返回

## 工具箱

- 请求url：/saas-api/api/portal/wx/toolbox-menu?repGroup=&enterpriseUuid=a6ee40566a0844d485b360f6424251c4&roleId=none&roleUuids=55f666e2b1e911e99ca1506b4b26f73a&menu_uuid=
- 接口路径：api/portal/wx/toolbox-menu
- 请求方式：GET
- 关键参数：
  - 请求   request
  - 用户角色uuid   roleUuids
- 流程：
  - 参数判断（roleUuids进行判空）
  - 从redis中获取值menuListStr
    - key为"portal:role:wx:toolbox-menu"
    - hashkey为"role-" + roleUuids
  - 将menuListStr转为菜单menuList集合
  - 如果menuList是空的
    - 获取数据源portalDataSource
    - 根据roleUuids调用apiWeChatService的queryToolboxMenuByUserRoleUuids方法获取菜单值menuList
    - 解析渲染menuList数据
    - 以key为"portal:role:wx:toolbox-menu"，hashkey为"role-" + roleUuids，值为menuList向redis中追加
    - 返回实体信息中封装menuList并返回
  - 如果menuList非空，返回实体信息中封装menuListS并返回

### 企业号登陆

- 请求url：
- 接口路径：
- 请求方式：GET
- 关键参数：
- 流程：