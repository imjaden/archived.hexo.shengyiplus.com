```
#!/bin/bash
#
# 开发人员: Aaron
# 更新日期: 2019-10-29
# 客户名称: 艾尔建
# 业务模块: 用户行为数据同步
# 对接团队: 齐数ETOCRM
# 定时任务: 30 19 * * *
# 业务描述: 
# 代码步骤:
#   1. 通过邮件接收压缩文档的解压密钥
#   2. 解压压缩文档
#   3. 移动数据文档至ETL流读取目录
#   4. 执行 ETL 流
#   5. 备份归档数据压缩文档、密钥文档
#   6. 清理解压后的数据
#
set -e # 遇错即中止
function logger() { echo "$(date +'%y/%m/%d %H:%M:%S') - $1"; }

logger "1. 通过邮件接收压缩文档的解压密钥"
/bin/ruby /data/work/kettle/scripts/etocrm_encrypt_automator.rb

logger "2. 解压压缩文档"
datestr=$(date -d "0 day ago" "+%Y%m%d")
entrypt=$(cat ${allergan_members_path}/etocrmdata/encrypt.pw)
echo "unzip x -P${entrypt} -o ${allergan_members_path}/etocrmdata/${datestr}.zip"
unzip -P${entrypt} -o ${allergan_members_path}/etocrmdata/${datestr}.zip

logger "3. 移动数据文档至ETL流读取目录"
mv ${allergan_members_path}/etocrmdata/${datestr}.csv ${allergan_members_path}/etocrmdata/user_behaviors.csv

logger "4. 执行 ETL 流"
/bin/kitchen -file=/data/work/kettle/jobs/user_behavior.kjb

logger "4. 备份归档数据压缩文档、密钥文档"
cp -p ${allergan_members_path}/etocrmdata/encrypt.pw ${allergan_members_path}/executed_file/${datestr}.pw
mv ${allergan_members_path}/etocrmdata/${datestr}.zip ${allergan_members_path}/executed_file/${datestr}.zip

logger "6. 清理解压后的数据"
rm -rf ${allergan_members_path}/etocrmdata/user_behaviors.csv

exit 0 # 仪式感退出
```
