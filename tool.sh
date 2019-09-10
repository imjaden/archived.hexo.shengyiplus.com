#!/usr/bin/env bash
scriptFolder=$(dirname $0)
test -f /root/.bash_profile && source /root/.bash_profile

cd ${scriptFolder}
case "$1" in
    build)
        bash $0 pam:jar
        cd allerganBaidu && npm install
    ;;
    git:auto:push|gap)
        shift
        java -cp dependencies -jar gap.jar $@
        # bundle exec ruby git-utils.rb $@
    ;;
    baidu:index)
        cd allerganBaidu && node index
    ;;
    baidu:index:daemon)
        cd allerganBaidu && bash daemon.sh index:start
    ;;
    baidu:news)
        cd allerganBaidu && node news
    ;;
    baidu:news:daemon)
        cd allerganBaidu && bash daemon.sh news:start
    ;;
    pam)
        jarPath=allerganPam/src/main/java/salesforceRestApi.jar
        if [[ ! -f "${jarPath}" ]]; then
            bash $0 pam:jar
        fi
        cd ${scriptFolder}
        java -jar ${jarPath}
    ;;
    pam:jar)
        cd allerganPam/src/main/java
        rm -f salesforceRestApi.jar
        rm -f com/salesforce/restapi/App.class
        javac -Djava.ext.dirs=library com/salesforce/restapi/App.java
        jar -cvfm salesforceRestApi.jar ../resources/META-INF/MANIFEST.MF -C ./ .
        cd -
    ;;
    pam:daemon)
        echo "TODO"
    ;;
    xiaoai)
        ruby allerganXiaoAi/allerganXiaoAiAutoLoad.rb
    ;;
    execute:raw)
        bash $0 xiaoai
        bash $0 pam
        bash $0 baidu:news
        bash $0 baidu:index
    ;;
    execute)
        mkdir -p ${scriptFolder}/logs
        bash $0 execute:raw > ${scriptFolder}/logs/$(date +%Y-%m-%d).log 2>&1
    ;;
    help)
        echo "艾尔建运维命令说明:"
        echo ""
        echo "\$ bash tool.sh build       # 编译依赖"
        echo "\$ bash tool.sh pam         # 获取最近三天的PAM活动数据"
        echo "\$ bash tool.sh baidu:news  # 获取百度新闻(配置百度账号, allerganBaidu/config.json)"
        echo "\$ bash tool.sh baidu:index # 获取百度指数(配置百度账号, allerganBaidu/config.json)"
        echo "\$ bash tool.sh execute     # 执行上述所有获取命令"
        echo ""
    ;;
    *)
        echo "Error - 未知参数:"
        echo "$@"
    ;;
esac