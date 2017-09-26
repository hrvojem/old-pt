#!/bin/bash
mysql -e "create database imdb;"
pv /vagrant/imdb-no-indexes.sql | mysql -D imdb

