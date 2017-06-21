# Capistrano::UnicornNginx

Capistrano tasks for automatic and sensible WAL-E configuration

Goals of this plugin:

* automatic configuration for setting up WAL-E for continuous backups of
  PostgreSQL.

Specifics:

* generates environment variables for WAL-e
* sets up cronjobs for base backups and deleting old ones

Almost all the setup has been done by capistrano. There is just one manual step 
that needs to be done.

* Uncomment and modify these lines in your postgresql.conf file under /etc/postgresql/9.3/main/

```
wal_level = archive
archive_mode = on
archive_command = 'envdir /etc/wal-e.d/env /usr/local/bin/wal-e wal-push %p'
archive_timeout = 60
```

Then restart postgres: `service postgresql restart`.

* Test by making the first snapshot backup:
```
/usr/bin/envdir /etc/wal-e.d/env /usr/local/bin/wal-e backup-push /var/lib/postgresql/9.3/main

```

`capistrano-wal-e` works only with Capistrano 3!

### Installation

Add this to `Gemfile`:

    group :development do
      gem 'capistrano', '~> 3.2.1'
      gem 'capistrano-wal-e', '~> 0.1.1'
    end

And then:

    $ bundle install

