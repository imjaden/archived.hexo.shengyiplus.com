#!/usr/bin/env bash
scriptFolder=$(dirname $0)
test -f /root/.bash_profile && source /root/.bash_profile

cd ${scriptFolder}
case "$1" in
    git:auto:push|gap)
        shift
        java -cp dependencies -jar gap.jar $@
    ;;
    start)
        npm run start
    ;;
    build)
        npm run build
    ;;
    deploy)
        npm run deploy
    ;;
    build:deploy|bd)
        npm run build
        npm run deploy
    ;;
    *)
        echo "Error - 未知参数:"
        echo "$@"
    ;;
esac