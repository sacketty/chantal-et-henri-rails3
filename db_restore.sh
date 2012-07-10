#!/bin/sh
heroku pgbackups:capture --expire
curl -o latest.dump `heroku pgbackups:url`   
rake db:drop
rake db:create
pg_restore --verbose --clean --no-acl --no-owner -h localhost -U tester -d wedding_r3 latest.dump
