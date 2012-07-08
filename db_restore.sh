#!/bin/sh
/usr/bin/heroku pgbackups:capture --expire
/usr/bin/curl -o latest.dump `heroku pgbackups:url`   
rake db:drop
rake db:create
/usr/local/bin/pg_restore --verbose --clean --no-acl --no-owner -h localhost -U tester -d wedding_r3 latest.dump