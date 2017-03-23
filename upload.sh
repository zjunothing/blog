#!/bin/bash
hexo generate
scp -r ./public/* root@45.79.111.218:/srv/www/zjunothing.com/
