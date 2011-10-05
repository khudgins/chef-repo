#!/usr/bin/env ruby

require 'rubygems'
require 'aws/s3'
require 'socket'
require 'tempfile'
require 'date'
require '/etc/aws/s3.rb'

# Databases to backup are just args, default to all databases if no args:
if ARGV.size() < 3
  puts "Usage: \"backup_mysql.sh hostname username dbpassword [databases]\""
  puts "First three arguments are required!"
  exit
end

host, user, pass = ARGV.slice!(0..2)
databases = ARGV.join(" ")
backup_string = ""
if databases.nil? || databases.empty?
  backup_string = "--all-databases"
  backup_tag = "all-databases"
else
  backup_string = "--databases #{databases}"
  backup_tag = ARGV.join("_")
end

# Handle empty db password
unless pass.empty?
  pass = "-p #{pass}"  
end
TMPDIR   = '/tmp'

AWS::S3::Base.establish_connection!(
  :access_key_id     => ACCESS_KEY_ID,
  :secret_access_key => SECRET_ACCESS_KEY
)

Tempfile.open('db-backup', TMPDIR) do |backup|
  system <<-BACKUP
    nice mysqldump -h #{host} -u #{user} #{pass} -C -q #{backup_string} | \
      nice gzip -c -9 > #{backup.path}
  BACKUP

  bucket   = BACKUP_BUCKET.split('/').first
  hostname = Socket.gethostname.split('.').first

  subdir   = BACKUP_BUCKET.split('/').last
  now      = Time.now.strftime("%Y%m%d-%H%M%S")
  filename = "#{subdir}/#{backup_tag}-#{now}.tar.gz"
  AWS::S3::S3Object.store(filename, open(backup), bucket)
  
end