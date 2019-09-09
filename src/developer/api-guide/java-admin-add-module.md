---
title: 运营平台添加模块
type: 运营平台添加模块
---

## 企业朔源码

1. 溯源码是一个独立的模块（后面会详讲），该码会绑定企业信息
2. 用户注册流程中，就是通过扫描溯源码（与码绑定的业务信息无关，仅需要企业信息）绑定企业信息
3. 并非所有企业都有溯源码的模块需求，但所有企业的新用户注册流程中都需要扫码
4. 在运营平台企业管理列表中添加展示溯源码（没有则创建一个）
5. 业务同事根据用户需求，打印或邮件发该企业的溯源码

## 企业管理菜单

### 添加溯源码列

- 修改 SaasEnterpriseMapper.xml 文件中id为 queryList 的SQL语句，添加查询结果字段 qrCodeUuid 以及添加对应的关联表 

  ```sql
  SELECT  ae.*, ar.role_name ,
    ag.group_name ,
    sqced.uuid AS qrCodeUuid
  FROM sup_enterprises AS ae
  LEFT JOIN app_roles AS ar ON ar.id = ae.role_id
  LEFT JOIN app_groups AS ag ON ag.group_id = ae.group_id
  LEFT JOIN(
    SELECT
      max(uuid) AS uuid ,
      enterprise_uuid
    FROM
      sup_qr_code_business_data
    GROUP BY
      enterprise_uuid
  ) AS sqced ON sqced.enterprise_uuid = ae.uuid
  WHERE ae.is_delete = 0
  .....
  ```

- 在saasenterprise.js中添企业朔源码列

  ```javascript
  {
    label: '企业朔源码', name: 'qrCodeUuid', index: 'qrCodeUuid', width: 60,
  }
  ```

### 检查朔源码按钮

- 在 SaasEnterpriseMapper.xml 中添加 id 为queryListByNoParams 的SQL，实现无参数获取企业信息

  ```sql
  SELECT  ae.*, ar.role_name ,
    ag.group_name ,
    sqced.uuid AS qrCodeUuid
  FROM sup_enterprises AS ae
  LEFT JOIN app_roles AS ar ON ar.id = ae.role_id
  LEFT JOIN app_groups AS ag ON ag.group_id = ae.group_id
  LEFT JOIN(
    SELECT
      max(uuid) AS uuid ,
      enterprise_uuid
    FROM
      sup_qr_code_business_data
    GROUP BY
      enterprise_uuid
  ) AS sqced ON sqced.enterprise_uuid = ae.uuid
  WHERE ae.is_delete = 0
  ```

- 在 SaasEnterpriseMapper.xml 中添加 id 为 insertQrCodeUuid 的SQL，向朔源码信息表 sup_qr_code_business_data 中添加 qrCodeUuid 以及对应的企业信息

  ```sql
  INSERT INTO sup_qr_code_business_data(
              uuid ,
              enterprise_name ,
              enterprise_code ,
              enterprise_uuid ,
              target_url ,
              data_json ,
              remark ,
              create_user ,
              update_user
          )
  VALUES (
              #{param1} ,
              #{param2} ,
              #{param3} ,
              #{param4} ,
              null ,
              #{param5} ,
              null ,
              #{param6} ,
              null
          )
  ```

- 在 SaasEnterpriseService、SaasEnterpriseServiceImpl和SaasEnterpriseMapper.java 中添加对应的 queryEnterpriseService 和 insertQrCodeuuid 方法

- 在 SaasEnterpriseController 中添加 createEnterpriseTackingCode(String createUser) 方法

  - 调用 `saasEnterpriseService.queryListByNoParams()` 获得企业信息列表 saasEnterpriseList
  - 遍历 saasEnterpriseList ，每次遍历单体对象是 saasEnterprise
  - 判断 saasEnterprise.getQrCodeUuid() 是否为空，为空则生成qrCodeUuid
    - 调用 `RandomNumString.getCheckUuid(System.currentTimeMillis()) + RandomNumString.randomStringCheck32Uuid(10) + RandomNumString.getRandomNumber(100000)` 生成32位字符串 dataUuid
    - 将企业信息 saasEnterprise 转为JSON字符串 dataJson
    - 调用 `saasEnterpriseService.insertQrCodeUuid(dataUuid, saasEnterprise.getName(),saasEnterprise.getCode(), saasEnterprise.getUuid(), dataJson, createUser)` 向朔源码信息表中插入新添加的数据

- saasenterprise.js 中添加 createEnterpriseTackingCode 方法，需要传入参数 createUser ，通过弹窗输入值，方法调用 `../saas-enterprise/tracking-code/createEnterpriseTackingCode` 接口，补全所有企业朔源码，成功后刷新页面列表

  ```javascript
  methods{
      createEnterpriseTackingCode: function () {
              var htmlStr = '<span style="color: red; text-align: center;display:block;">生成企业朔源码，请耐心等待</span>';
              htmlStr = htmlStr + '<input type="text" id="createUser" style="text-align: center; width: 280px;" placeholder="请输入创建人：小明（15200000000）"/>';
  
              var indexConfirm = layer.confirm(htmlStr, {
                  btn: [
                      '确认', '取消'
                  ],
                  btnAlign: 'c',
                  title: "批量添加企业朔源码"
              }, function () {
                  var createUser = $("#createUser").val();
                      $.ajax({
                          type: "GET",
                          url: "../saas-enterprise/tracking-code/createEnterpriseTackingCode",
                          data: {
                              createUser: createUser
                          },
                          success: function (r) {
                              if (r.code == 0) {
                                  alert('操作成功', function () {   $("#jqGrid").trigger("reloadGrid");
                                  });
                                  vm.reload();
                              } else {
                                  alert(r.msg);
                              }
                          }
                      });
                  layer.close(indexConfirm);
              }, function () {
                  layer.close(indexConfirm);
              });
          },
  }
  ```

- 在 saasenterprise.html 中添加一个点击事件

  ```html
  <a class="btn btn-primary" @click="createEnterpriseTackingCode">补全朔源码</a>
  ```


### 查看朔源码按钮 

- 在 SaasEnterpriseController 中添加 show 方法，需要参数 id ，这个 id 是页面展示的行id

  - 调用 `saasEnterpriseService.queryListByNoParams()` 方法获得企业信息列表 saasEnterpriseList
  - 遍历 saasEnterpriseList ，每一次遍历单体对象是 saasEnterprise
  - 判断 saasEnterprise.getId() 是否和参数 id 相等，相等则通过 saasEnterprise.getQrCodeUuid() 获得 qrCodeUuid 
  - 如果 qrCodeUuid 为空
    - 调用 `RandomNumString.getCheckUuid(System.currentTimeMillis()) + RandomNumString.randomStringCheck32Uuid(10) + RandomNumString.getRandomNumber(100000)` 生成 dataUuid 
    - 将企业信息 saasEnterprise 转为JSON字符串 dataJson
    - 调用 `saasEnterpriseService.insertQrCodeUuid(dataUuid, saasEnterprise.getName(),saasEnterprise.getCode(), saasEnterprise.getUuid(), dataJson, createUser)` 向朔源码信息表中插入新添加的数据
    - 将 dataUuid 赋值给 qrCodeUuid
  - 返回实体信息中封装 qrCodeUuid 并返回

- 在 saasenterprise.js 中添加 showTackingCode 方法，在 data 下 添加参数 qrCodeuuid:""

  ```javascript
  <!--添加参数变量-->
  data:{
    showList: true,
    show: 1,
    title: null,
    saasEnterprise: {},
    qrCodeUuid: ""
  }
  
  <!--添加方法-->
  methods:{showTackingCode: function () {
              var id = getSelectedRow();
              $.get("../saas-enterprise/show/" + id, function (r) {
                  vm.qrCodeUuid = r.qrCodeUuid;
                  if (vm.qrCodeUuid == null || ""==vm.qrCodeUuid) {
                      return null;
                  } else {
                      alert("<img src='http://qr.topscan.com/api.php?&w=300&text=" + vm.qrCodeUuid + "'/>");
                  }
              });
          },
          }
  ```

- 在 saasenterprise.html 中添加单击事件

  ```html
  <a class="btn btn-primary" @click="showTackingCode">查看朔源码</a>
  ```

  