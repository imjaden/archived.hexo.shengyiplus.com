#!/usr/bin/env ruby
#
# 作者: Jaden
# 日期: 2019-10-30
# 功能模块: 调用ETL流脚本、归档日志、邮件通知
# 代码步骤:
#   1. 约定ETL流脚本目录，以脚本名称为作参数
#   2. 约定脚本目录 /data/work/scripts/, 调用脚本并重定向日志
#   3. 根据脚本退出码(0 表示成功，其他表示失败)判断运行是否成功
#   4. 发送邮件，附件日志文件
#

script_name = ARGV[0]
log_folder = "/data/work/logs"
log_path = "#{log_folder}/#{script_name}-#{Time.now.strftime('%y%m%d%H%M%S')}.log"
script_folder = "/data/work/scripts/"
script_path = "#{script_folder}/#{script_name}"

def logger(message = ''); puts Time.now.strftime("%y/%m/%d %H:%M:%S - #{message}") end

if File.exists?(script_path)
  `bash #{script_path} > #{log_path} 2>&1`
else
  File.open(log_path, "w:utf-8") { |file| file.puts("ETL 脚本不存在:\n#{script_path}") }
end

