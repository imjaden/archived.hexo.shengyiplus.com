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

  - 参数判断（mobile 和 password 进行判空）
  - 获取数据源 portalDataSource
  - 判断密码
    - 调用 `portalV2Service.queryUserInfo(mobile)` 方法查询用户密码

    ```sql
    select password 
    from sup_user 
    where mobile = #{mobile} and delete_status = 0 limit 1
    ```

    - 判断userPassword和参数password是否相等，或者根据手机号后六位数(内部排序)经过MD5加密后的字符串是否相等，有一个相等就继续，如果都不相同，返回信息中返回“密码错误”

  - 获取企业列表
    - 调用 `apiPortalV2Service的queryEnterpriseListWithMobile(mobile, password)` 获取企业列表 result

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

  - 查询用户角色
    - 循环遍历企业列表 result ，每次遍历的单体对象是 map ，调用 `apiPortalV2Service.queryUserRoleUuidList(userUuid,portalDataSource)` 查询用户角色uuid得到 roleList

    ```sql
    SELECT
      aur.uuid AS roleUuid ,
      aur.role_name AS roleName
    FROM
      sup_user_roles AS sur
    LEFT JOIN app_user_roles AS aur ON aur.uuid = sur.role_uuid
    AND sur.data_enterprise_uuid = aur.data_enterprise_uuid
    WHERE
      user_uuid = #{userUuid}
    GROUP BY
      aur.uuid
    ```

    - 追加 roleList 给map中的 userUuidList
    - 遍历 roleList，将每一个 roleUuid 用“，”拼接起来赋值给 roleUuids 字符串，然后追加到map中的 roleUuids 中

  - 封装结果到返回信息实体中并返回信息实体，用户选择企业进行登录

2. 获取微信用户 openid

  ```
  post /saas-api/api/portal/wx/query-user-openid 
  {
    code: 用户凭证(wx.login获取),
    enterpriseUuid: 企业uuid,
    mobile: 手机号
  }
  ```

  业务流程：

  - 参数判断（code 和 mobile 进行判空）
  - 如果 code 不为空，从数据库中重新获取 openid
    - 获取微信小程序配置信息
      - appId："weChat.appId"
      - secret："weChat.secret"
      - openIdUrl："weChat.openIdUrl"

    - 替换 openIdUrl 中的参数值
      - 用appId、secret、code 分别替换原openIdUrl中的 APP_ID、APP_SECRET、JS_CODE ，得到新的 openIdUrl

    - 获取openId返回值
      - 调用微信官方接口返回值 `HttpMethodUtil.getGetResult(openIdUrl, null)` 得到openIdResult
      - 判断openIdResult是否是JSON格式，不是则返回 获取用户 openId 接口返回值非JSON格式错误信息
      - 是JSON格式，则转为JSON对象 json

    - 创建一个字段 isBinding=0，向 json 中put
    - 如果 json 对象不为空，先获取数据源 portalDataSource
    - 调用 `apiWeChatService的portalQueryUserOpenId(mobilev, enterpriseUuid, portalDataSource)` 方法查询用户openId 得到结果集 result（Map集合）

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

    - 将结果 result 的 is_binding 字段追加给 json 中
    - 在返回实体对象中封装结果 json 对象，并返回

  - 如果 code 为空，则从数据源中取
    - 获得数据源对象 portalDataSource
    - 调用 `apiWeChatService.portalQueryUserOpenId(mobile,enterpriseUuid,portalDataSource)` 方法查询用户openId得到结果 result
    - 在返回实体对象中封装结果 result

3. 推送信息

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

  - 参数判断（param，data，toUsers，template_id 进行判空）
  - 获取企业信息：根据参数 enterpriseUuid 去查询企业信息得到 portalEnterprise
  - 获取用户openId：根据参数 toUsers 获取，得到openId数组 toUserArray
  - 封装查询参数 query，向其中追加参数 enterpriseUuid、toUsers、dataEnterpriseUuid和dataEnterpriseCode
  - 获取数据源得到 portalDataSource
  - 调用 `apiWeChatService的queryUserOpenIdWithUuid(query, portalDataSource)` 方法得到openId集合 openIdList

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

  - 向参数集合 newParam 中追加 appId、secret、fromUrl、ip、templateId、page、data、empahsis_keyword
  - 循环发送模板信息
    - 通过 openId 异步获取 formId
    - 向 newParam 中追加 openId 和 formId 给 toUser 和 formId 两个字段
    - 调用自身API去得到结果 sendResult
    - 向结果集合 resultMap 中追加 sendResult
  - 向返回实体信息中封装 resultMap 并返回

4. 提交用户偏好

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
  - 将 mobile、enterpriseUuid、platform 拼接成一个 hashkey
  - 大key为 “user：perference”，hashkey为拼接成的 hashkey 去redis中取值 preference
  - 如果 preference 是空的
    - 将 mobile、enterpriseUuid、platform 依次放进参数 params 中，params是一个map集合
    - 获取数据源 portalDataSource
    - 根据参数 params 和数据源去数据库取 preference

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

    - 以 “user：perference” 为大key，拼接的hashkey为 hashksy，preference 为值追加到redis中
    - 返回实体信息中封装 preference 并返回

  - 如果 preference 非空，返回实体信息中封装 preference 并返回

### 企业号登录

1. 获取企业

  ```
  get user/v1/enterprise-info
  {
    request： 请求
    enterpriseCode:  企业号
  }
  ```

  业务流程：

  - 参数判断（对enterpriseCode进行判空）
  - 获取数据源portalDataSource
  - 获取企业信息结果集 result
    - 调用 `apiUserLoginService.weChatAppletWithEnterpriseInfo(enterpriseCode, portalDataSource)` 方法获取企业信息 result

    ```sql
    SELECT
      id AS enterpriseId ,
      uuid AS enterpriseUuid ,
      CODE AS enterpriseCode ,
      `language` ,
      `name` AS enterpriseName ,
      role_id AS enterpriseRoleId ,
      group_id AS enterpriseGroupId ,
      data_source_id AS enterpriseDataSourceId
    FROM
      sup_enterprises
    WHERE
      CODE = #{enterpriseCode}
    LIMIT 1
    ```

  - result 不为空则向返回信息实体中封装 result 并返回

2. 获取登录用户信息

  ```
  get user/v1/wx-applet-login
  {
    request：请求
    mobile：手机号码
    password：MD5机密后的密码
    enterpriseUuid：企业UUID
  }
  ```

  业务流程：

  - 获取请求头中的enterpriseUuid
    - 调用 `request.getHeader("enterpriseUuid")` 得到企业UUID字符串 enterprise

  - 参数判断（对 mobile、password、enterpriseUuid 进行判空）
  - 验证 enterprise 和 参数 enterpriseUuid 是否想等，如果不相等则返回请求头与请求参数的企业UUID不一致
  - 获取企业信息
    - 异步调用 `asyncUtils.QUERY_ENTERPRISE_INFO(enterprise)` 方法得到企业信息 portalEnterprise

  - 拼接参数集合 param （Map集合）
    - 向 param 中追加键值对 {"mobile":mobile,"password":password,"dataEnterpriseUuid":portalEnterprise.getEnterpriseUuid();"dataEnterpriseCode":portalEnterprise.getEnterpriseCode()}

  - 获取数据源portalDataSource
  - 查询企业用户信息
    - 调用 `apiUserLoginService.weChatAppletWithLogin(param,portalDataSource)` 方法得到结果集 result

    ```sql
    SELECT
      sue.uuid AS userUuid ,
      su.user_name AS userName ,
      su.mobile AS userMobile ,
      su.email AS userEmail ,
      su.user_num AS userNumber ,
      sue. STATUS AS userStatus ,
      su. PASSWORD ,
      sue.token AS userToken ,
      'todo' AS userGravatar ,
      sen.group_id AS groupId ,
      'todo' AS groupName ,
      sen.role_id AS roleId ,
      'todo' AS roleName ,
      su.is_delete AS userIsDelete
    FROM
      sup_user_enterprises AS sue
    LEFT JOIN sup_user AS su ON sue.mobile = su.mobile
    LEFT JOIN sup_enterprises AS sen ON sen.uuid = sue.data_enterprise_uuid
    WHERE
      sue.mobile = '${mobile}'
    AND su. PASSWORD IS NOT NULL
    AND sue.data_enterprise_uuid = '${dataEnterpriseUuid}'
    AND sue.data_enterprise_code = '${dataEnterpriseCode}'
    AND sue.delete_status = '0'
    GROUP BY
      sue.uuid
    LIMIT 1
    ```

  - 用户信息核对
    - 判断用户信息结果集 result 中的USER_STATUS是否等于1，不等则返回该账号已被停用
    - 判断 result 中的PASSWORD 是否等于参数中的 password，不等则返回密码错误

  - 获取用户角色列表
    - 调用 `apiUserLoginService.queryUserRoleUuidList(result.get("userUuid").toString(), portalDataSource)` 得到 roleList

    ```sql
    SELECT
      aur.uuid AS roleUuid ,
      aur.role_name AS roleName
    FROM
      sup_user_roles AS sur
    LEFT JOIN app_user_roles AS aur ON aur.uuid = sur.role_uuid
    AND sur.data_enterprise_uuid = aur.data_enterprise_uuid
    WHERE
      user_uuid = #{userUuid}
    GROUP BY
      aur.uuid
    ```

    - 向 result 中追加{"roleUuidList":roleList,"roleUuids":""}

  - 获取角色UUID
    - 循环遍历 roleList ，将角色列表中的每一个角色的 roleUuid 拼接给 roleUuids ，中间用”，”隔开
    - 向 result 中追加 roleUuids 

  - 返回实体中封装结果集 result 并返回

3. 获取微信用户 openid 、推送消息 、提交用户偏好 三个步骤同 手机号登录 中的3、4、5介绍

### 微信登录

1. 获取企业列表

   ```
   get api/portal/v2/wx-login/enterprise-list-v2
   {
    request: 请求，
    code: 微信小程序中的code值
   }
   ```

  业务流程：

  - 参数判断
    - 对 code 进行判空

  - 获取 openId
    - 获取微信小程序配置信息
      - appId："weChat.appId"
      - secret："weChat.secret"
      - openIdUrl："weChat.openIdUrl"

    - 替换 openIdUrl 中的参数值
      - 用appId、secret、code 分别替换原openIdUrl中的 APP_ID、APP_SECRET、JS_CODE ，得到新的 openIdUrl

    - 获取openId返回值
      - 调用微信官方接口返回值 `HttpMethodUtil.getGetResult(openIdUrl, null)` 得到openIdResult

    - 判断openIdResult是否是JSON格式
      - 不是则返回 获取用户 openId 接口返回值非JSON格式错误信息
      - 是JSON格式，则转为JSON对象 json

    - 从 json 中去字段 OPEN_ID 的值，得到openId

  - 获取企业列表
    - 获取数据源portalDataSource
    - 获取企业用户信息结果集
      - 调用 `apiPortalV2Service.queryEnterpriseListWithWeChatOpenIdV2(openId,portalDataSource)` 方法得到结果集 result （Map集合）

      ```sql
      SELECT
        se.uuid AS enterpriseUuid ,
        se. CODE AS enterpriseCode ,
        se. NAME AS enterpriseName ,
        se.data_source_id AS dataSourceCode ,
        se.role_id AS enterpriseRoleId ,
        se.group_id AS enterpriseGroupId ,
        se. LANGUAGE AS enterpriseLanguage ,
        swu.wx_avatar AS wxAvatar ,
        swu.wx_name AS wxName ,
        swu.wx_nick_name AS wxNickName ,
        sue.uuid AS userUuid ,
        sue.mobile AS userMobile ,
        su.user_name AS userName ,
        su.email AS userEmail ,
        sue.delete_status AS userIsDelete ,
        swu.wx_unique_token AS wxUniqueoken ,
        sue. STATUS AS userStatus ,
        sue.token AS userToken ,
        se.group_id AS groupId ,
        se.role_id AS roleId ,
        'todo' AS userGravatar ,
        'todo' AS groupName ,
        'todo' AS roleName ,
        su. PASSWORD AS userIdToken
      FROM
        sup_wx_users AS swu
      INNER JOIN sup_user_enterprises AS sue ON sue.mobile = swu.mobile
      INNER JOIN sup_enterprises AS se ON sue.data_enterprise_uuid = se.uuid
      INNER JOIN sup_user AS su ON su.mobile = swu.mobile
      WHERE
        swu.wx_unique_token = #{openId}
      AND sue.delete_status = '0'
      AND swu.is_binding = 1
      AND swu.delete_status = 0
      ```

    - 验证结果集数据是否有效
      - 拿出 result 中 USER_STATUS 字段值， 不等于1则返回该账号已被停用错误信息

    - 获取用户角色UUID
      - 遍历结果集 result ，每一次遍历的单体是 map 
      - 调用 `apiUserLoginService.queryUserRoleUuidList(map.get("userUuid").toString(), portalDataSource)` 得到 roleList

      ```sql
      SELECT
        aur.uuid AS roleUuid ,
        aur.role_name AS roleName
      FROM
        sup_user_roles AS sur
      LEFT JOIN app_user_roles AS aur ON aur.uuid = sur.role_uuid
      AND sur.data_enterprise_uuid = aur.data_enterprise_uuid
      WHERE
        user_uuid = #{userUuid}
      GROUP BY
        aur.uuid
      ```

      - 向 map 中追加{"roleUuidList":roleList,"roleUuids":""}
      - 循环遍历 roleList ，将角色列表中的每一个角色的 roleUuid 拼接给 roleUuids ，中间用”，”隔开
      - 向 map 中追加 roleUuids 

  - 返回信息实体中封装结果集 result 并返回

## 注册页

### 业务流程图

[注册模块业务流程](/application/syp-wxmp.html)

1. 获取企业信息

  ```
  get user/v1/enterprise-info
  {
    enterpriseCode: 企业编码
  }
  ```

  业务流程：

  - 参数判断
    - 对 enterpriseCode  进行判空

  - 获取数据源portalDataSource
  - 获取企业信息
    - 调用 `apiUserLoginService.weChatAppletWithEnterpriseInfo` 方法获得企业信息结果集合 result

    ```sql
    SELECT
      id AS enterpriseId ,
      uuid AS enterpriseUuid ,
      CODE AS enterpriseCode ,
      `language` ,
      `name` AS enterpriseName ,
      role_id AS enterpriseRoleId ,
      group_id AS enterpriseGroupId ,
      data_source_id AS enterpriseDataSourceId
    FROM
      sup_enterprises
    WHERE
      CODE = #{enterpriseCode}
    LIMIT 1
    ```

  - 返回信息实体中封装结果集 result 并返回

2. 扫码查询追踪码明细

  ```
  get api/portal/wx/tracking-code/select-info
  {
    qrCodeUuid: 追踪码uuid
  }
  ```

  业务流程：

  - 参数判断
    - 对 qrCodeUuid 进行判空
    - 判断 qrCodeUuid 的长度是否是32位，不是则返回追踪码UUID长度不符合规则

  - 从redis获取数据
    - key为 "portal:qr:code" ，hashkey为  "qrCodeUuid" ，得到字符串值 str

  - 如果 str 不是空的则转为DataQrCode对象 dataQrCodeSelect ，如果是空的则将null赋值给 dataQrCodeSelect
  - 如果 dataQrCodeSelect 为null
    - 获取数据源 portalDataSource
    - 调用 `apiWeChatService.queryDataQrCodeInfoWithUuid(qrCodeUuid, portalDataSource)` 获取结果赋值给 dataQrCodeSelect

    ```sql
    SELECT
      id ,
      uuid ,
      enterprise_name ,
      enterprise_code ,
      enterprise_uuid ,
      business_uuid ,
      business_type ,
      business_name ,
      target_url ,
      data_json ,
      remark ,
      create_user ,
      update_user ,
      created_time ,
      updated_time
    FROM
      sup_qr_code_business_data
    WHERE
      uuid = #{uuid}
    ```

    - 如果 dataQrCodeSelect 不为空，则向redis中追加
      - key为 "portal:qr:code" ，hashkey为 qrCodeUuid，值为 JSONObject.toJSONString(dataQrCodeSelect)

  - 如果 dataQrCodeSelect 不为null
    - 调用 `dataQrCodeSelect.setDataJson(StringUtils.replace(dataQrCodeSelect.getDataJson(), "\\", ""))` 方法调整dataQrCodeSelect中dataJson数据格式

  - 返回信息实体中封装结果 dataQrCodeSelect 并返回

3. 发送验证码

  ```
  get user/v1/register-verification-code-v1
  {
    mobile: 手机号
  }
  ```

  业务流程：

  - 参数判断
    - 对 mobile 进行判空

  - 生成四位验证码
    - 调用 `RandomNumberGenerator.generateNumber()` 方法获得 code
    - 向结果集合 result 中追加 code

  - 发送短信
    - 调用 `asyncUtils.SEND_SMS_WITH_REGISTER(mobile, SUCCESS_MSG, SUCCESS)` 

  - 保存到redis中
    - key为 ("portal:user:verificationCode:register:%s",mobile)，值为 code

  - 返回信息实体中封装结果集 result 并返回
