#!/usr/bin/env bash
scriptFolder=$(dirname $0)
test -f ~/.bash_profile && source ~/.bash_profile

cd ${scriptFolder}
case "$1" in
    git:auto:push|gap)
        shift
        java -jar GitAutoPush@0.1.2.jar $@
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