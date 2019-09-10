---
title: Jenkins 部署
type: Jenkins 部署
---

## 注意事项

1. 一定在本机测试功能正常
2. 确认本机代码已提交至 Gitlab
3. 确认提交的分支与 Jenkins 部署的分支相同
  
  ![确认提交的分支与 Jenkins 部署的分支相同](/images/jenkins-deploy/jenkins-deploy-gitlab-branch01.png)
  ![确认提交的分支与 Jenkins 部署的分支相同](/images/jenkins-deploy/jenkins-deploy-gitlab-branch02.png)

4. 确认**数据库运维脚本**已在相关数据库中部署
5. 部署前通知相关业务人员暂时业务操作
6. 部署完成后，确认新功能服务正常运行
7. 通知相关业务人员恢复业务操作

## 部署流程

1. 选择要部署的项目

  ![选择要部署的项目](/images/jenkins-deploy/jenkins-deploy-step01.png)

2. 选择【立即构建】

  ![选择【立即构建】](/images/jenkins-deploy/jenkins-deploy-step02.png)
  
3. 进入正在构建的 **Build History**

  ![进入正在构建的 Build History](/images/jenkins-deploy/jenkins-deploy-step03.png)
  
4. 查看部署日志 **Console Output**

  ![查看部署日志 Console Output](/images/jenkins-deploy/jenkins-deploy-step04.png)
  
5. 观察日志，若有异常则人工部署，避免 Java 服务中断！

  ![观察日志，若有异常则人工部署，避免 Java 服务中断](/images/jenkins-deploy/jenkins-deploy-step05.png)
  