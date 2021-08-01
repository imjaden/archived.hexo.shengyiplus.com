---
title: Jenkins 部署
type: Jenkins 部署
---

## 项目列表

环境名称 | 说明 | 编号
----|----|----
胜因学院 | 正式环境 | SypPro
胜因研发室 | 开发环境 | SypDev

项目名称 | 项目编号
----|----
Java 运营平台 | JavaAdmin
Java API 服务 | JavaApiServer
报表运营平台 | ReportPortal
数据字典平台 | DataDictionaryPortal
胜因在线文档 | Documents

![项目列表](/images/jenkins-deploy/jenkins-projects.png)
![项目列表](/images/jenkins-deploy/jenkins-deploy-view.png)

## 部署流程

1. 选择要部署的项目

  ![选择要部署的项目](/images/jenkins-deploy/jenkins-deploy-step01.png)

2. 选择【立即构建】

  ![选择【立即构建】](/images/jenkins-deploy/jenkins-deploy-step02.png)
  
3. 进入正在构建的 **Build History**

  ![进入正在构建的 Build History](/images/jenkins-deploy/jenkins-deploy-step03.png)

  或在首页左下区域查看正在构建的任务

  ![项目列表](/images/jenkins-deploy/jenkins-deploy-index.png)
  
4. 查看部署日志 **Console Output**

  ![查看部署日志 Console Output](/images/jenkins-deploy/jenkins-deploy-step04.png)
  
5. **观察日志，若有异常则人工介入，避免应用服务中断！**

  ![观察日志，若有异常则人工部署，避免 Java 服务中断](/images/jenkins-deploy/jenkins-deploy-step05.png)
  
## 注意事项

1. 代码一定要在本机测试正常
2. 确认本机代码已提交至 Gitlab
3. 确认提交的分支与 Jenkins 部署的分支相同
  
  ![确认提交的分支与 Jenkins 部署的分支相同](/images/jenkins-deploy/jenkins-deploy-gitlab-branch01.png)
  ![确认提交的分支与 Jenkins 部署的分支相同](/images/jenkins-deploy/jenkins-deploy-gitlab-branch02.png)

4. 确认**数据库运维脚本**已在相关数据库中部署
5. 部署前通知相关业务人员暂时业务操作
6. 部署完成后，确认新功能服务正常运行
7. 通知相关业务人员恢复业务操作

## 异常处理思路

无论本地调试还是 Jenkins 部署异常，都要耐心查看 **报错信息**，这是定位问题的源头。

### 项目语法错误

此类问题，本地运行代码即可重现同样的问题，属于低级错误。

![jenkins-部署异常-代码语法错误.png](/images/jenkins-exception/jenkins-部署异常-代码语法错误.png)

### 服务启动失败

部署成功只是代码包部署完成，但服务进程不一定正常启动；若遇到此类问题需要手工重启、调试。

![jenkins-部署异常-服务启动失败.png](/images/jenkins-exception/jenkins-部署异常-服务启动失败.png)