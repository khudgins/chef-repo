#!/usr/bin/ruby

require 'rubygems'
require 'aws/s3'
require 'socket'
require 'tempfile'
require 'date'
require '/etc/aws/s3.rb'

# Files to backup are just args:
backup_tag = ARGV.shift
files_to_backup = ARGV.join(" ")

TMPDIR   = '/tmp'

AWS::S3::Base.establish_connection!(
  :access_key_id     => ACCESS_KEY_ID,
  :secret_access_key => SECRET_ACCESS_KEY
)

Tempfile.open('db-backup', TMPDIR) do |backup|
  system <<-BACKUP
    nice tar --ignore-failed-read -cf - #{files_to_backup} | \
      nice gzip -c -9 >                                           \
      #{backup.path}
  BACKUP

  bucket   = BACKUP_BUCKET.split('/').first
  hostname = Socket.gethostname.split('.').first

  subdir   = BACKUP_BUCKET.split('/').last
  now      = Time.now.strftime("%Y%m%d-%H%M%S")
  filename = "#{subdir}/#{backup_tag}-#{now}.tar.gz"
  AWS::S3::S3Object.store(filename, open(backup), bucket)
  
end