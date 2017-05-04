# kannel dockerized

[![Docker Build Status](https://img.shields.io/docker/build/onlinecity/kannel.svg)]()
[Kannel](http://www.kannel.org/) on docker, using alpine linux. Built from the latest code in the kannel svn repo.

### Usage

This repo contains the kannel dockerfile and a docker compose stack which includes smsbox and a fakesmsc for testing purposes.

To test it run `docker-compose up`

After everything is running you can inject a message by using the provided sms box. 

`curl -v "http://localhost:13013/cgi-bin/sendsms?username=tester&password=foobar&message=Test&to=1234"`

It should be "delivered" using the fakesmsc problem so you will see it on the output from docker.