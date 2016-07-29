# LWAN webserver Dockerfile

[LWAN Website](https://lwan.ws/)

LWAN is a very high-performance static-content webserver.  On my MacBookPro, I can get over 13000
requests per second with ApacheBench.  NGiNX by comparison gets about 300 per second when run with
a stock Docker image.

``` ab -k -n 50000 -c 25 http://localhost:8080 ```


##  How to build
```
docker build -t lwan .
```

##  How to use it on port 8080 and with content mounted on /lwan/wwwroot from the local directory
```
docker run -it -p 8080:8080 -v `pwd`:/lwan/wwwroot lwan
```

##  As a canned static asset webserver

You could easily ADD your static content under /lwan/wwwroot in a derivative Dockerfile based on
this image.

##  Features
*  It serves static content and handles HAProxy.
*  Not much else, as built in this image.  Support for other things have been turned off.

