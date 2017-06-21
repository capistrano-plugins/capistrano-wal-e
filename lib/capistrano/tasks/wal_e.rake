namespace :load do
  task :defaults do

  end
end

namespace :wal_e do
  task :setup_env do
    on roles :db do |role|
      sudo 'mkdir -p /etc/wal-e.d/env'
      sudo_upload! StringIO.new(fetch(:aws_access_key_id)), '/etc/wal-e.d/env/AWS_ACCESS_KEY_ID'
      sudo_upload! StringIO.new(fetch(:aws_secret_access_key)), '/etc/wal-e.d/env/AWS_SECRET_ACCESS_KEY'
      sudo_upload! StringIO.new(fetch(:aws_region)), '/etc/wal-e.d/env/AWS_REGION'
      sudo_upload! StringIO.new("#{fetch(:wale_s3_prefix)}_#{role}"), '/etc/wal-e.d/env/WALE_S3_PREFIX'
      sudo 'chown -R root:postgres /etc/wal-e.d'
    end
  end

  task :setup_cron do
    on roles :db do
      cron = <<-EOF.gsub(/^\s+/, '')
        0 3 * * * /usr/bin/envdir /etc/wal-e.d/env /usr/local/bin/wal-e backup-push /var/lib/postgresql/9.3/main
        0 5 * * * envdir /etc/wal-e.d/env /usr/local/bin/wal-e delete --confirm retain 5
      EOF
      sudo_upload! StringIO.new(cron), "#{shared_path}/postgres-cron"
      sudo "chown -R root:postgres #{shared_path}/postgres-cron"
      sudo "-u postgres crontab #{shared_path}/postgres-cron"
    end
  end

  task :setup do
    invoke 'wal_e:setup_env'
    invoke 'wal_e:setup_cron'
  end
end

task :setup do
  invoke 'wal_e:setup'
end
