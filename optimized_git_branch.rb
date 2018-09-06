require 'json'
require 'optparse'
options = {}
FILE_PATH = '/usr/local/etc/git_branch.conf'
OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"
  opts.on("-l", "--[no-]list", "list branchs") { |l| options[:list] = l }
  opts.on("-d", "--del_branch=DEL_BRANCH", "delete branch name") { |d| options[:del_branch] = d }
end.parse!

`echo {} >> /usr/local/etc/git_branch.conf` unless File.file? '/usr/local/etc/git_branch.conf'
conf_file = File.open(FILE_PATH)
$git_conf = JSON.parse(conf_file.read) || {}
REPO_NAME = `basename \`git rev-parse --show-toplevel\``.strip

def write_conf branch_name, message
  return if message.strip.empty?
  config = [Time.now.strftime("%Y.%m.%d"), message]
  $git_conf[REPO_NAME] = ($git_conf[REPO_NAME] || {}).merge!({ branch_name => config })
  write_file
end

def write_file
  File.open(FILE_PATH, 'w') { |file| file.write($git_conf.to_json) }
end

def list_branch
  puts "branch: message\n\n"
  config_with_time = {} # 后续加的分支时间，为了兼容
  ($git_conf[REPO_NAME] || {}).each do |k, v|
    next unless v
    if v.is_a? String
      puts "#{k}:  #{v}" 
    else
      config_with_time.merge! k => v
    end
  end
  puts "\ntime---branch: message\n\n"
  config_with_time.each do |k, v|
    puts "#{v[0]}---#{k}:  #{v[1]}"
  end
end

def delete_conf key
  `git branch -D #{key}`
  $git_conf[REPO_NAME].delete key
  write_file
end

def switch_branch branch_name, message = ''
  system("git checkout #{branch_name}") || system("git checkout -b #{branch_name}")
  write_conf branch_name, message
end

list_branch if options[:list]
delete_conf options[:del_branch] if options[:del_branch]
switch_branch ARGV[0], ARGV[1] if ARGV[0]