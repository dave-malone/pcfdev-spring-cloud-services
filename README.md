# Spring Cloud Services for PCFDev

The goal of this project is to allow developers to run Spring Cloud Services on PCFDev.

This project assumes that you're running PCFDev at 192.168.11.11.

Currently, this project requires you to manually download the SCS Tile from network.pivotal.io and place that file alongside the deploy-local.sh file. Once you do that, you should be able to simply run ./deploy-local.sh and the SCS applications and Service Broker will deploy to PCFDev.

## Prerequisites

Openssl client on OSX needs to be updated. These scripts have been tested with openssl 1.0.2h. Instructions on updating can be found here: http://apple.stackexchange.com/questions/126830/how-to-upgrade-openssl-in-os-x


## SSL certificates

Spring Cloud Services depends on wildcard certificates for &#42;.uaa and &#42;.login domains. By default, PCFDev only comes configured with a wildcard cert for the &#42;.local.pcfdev.io domain. In order to deploy SCS on PCFDev, we need to update the SSL cert, including the wildcard domains required:
&#42;.local.pcfdev.io,&#42;.uaa.local.pcfdev.io,&#42;.login.local.pcfdev.io

SSH into vagrant vm
  ```
  sudo su -
  cd /var/vcap/jobs/gorouter/config
  mkdir bak
  mv *.pem ./bak
  wget https://gist.githubusercontent.com/dave-malone/c4eb740c96b425098dd3c5f82117b7c4/raw/2d50094c9b502c8b580cf24ab49d9a4ef0e44312/temp.cnf
  openssl ecparam -genkey -out key.pem -name prime256v1
  openssl req -x509 -new -key key.pem -out cert.pem -extensions server_req_extensions -config temp.cnf
  monit restart gorouter
  ```

## DNS

PCFDev uses xip.io in order to redirect all &#42;.local.pcfdev.io requests back to 192.168.11.11. You can either configure a local DNS server to map all &#42;.uaa.local.pcfdev.io and &#42;.login.local.pcfdev.io requests to 192.168.11.11.

Alternatively, you can modify your /etc/hosts file using a few well-known domain names. The scripts in this project deploy the SCS Service Broker as an app running on Cloud Foundry with a given hostname: scsbroker.local.pcfdev.io. The project also sets up a new Zone in UAA: spring-cloud-services.uaa.local.pcfdev.io and spring-cloud-services.login.local.pcfdev.io. All of this is configurable via the setup.sh script.

For my setup, I added the following entry to my /etc/hosts file:

192.168.11.11   spring-cloud-services.uaa.local.pcfdev.io,spring-cloud-services.login.local.pcfdev.io,login.local.pcfdev.io,uaa.local.pcfdev.io,api.local.pcfdev.io,scsbroker.local.pcfdev.io,doppler.local.pcfdev.io


## Usage

Clone this project: `git clone https://github.com/dave-malone/pcfdev-spring-cloud-services`

Download the [SCS Tile](https://network.pivotal.io/products/p-spring-cloud-services)

Copy the downloaded p-spring-cloud-services-&#42;.zip file into this project directory

Make sure that you're already running PCFDev

`./deploy-local.sh`


## Spring Cloud Services

Once SCS Has been deployed, you can access the dashboards via scsbroker.local.pcfdev.io. The default admin user credentials can be used to authenticate.

## TODO

* Utilize the network.pivotal.io download API to download the SCS Tile zip file
* Automate the generation of the SSL certificates and update to the PCFDev vagrant vm
* Automate creation of DNS entries required
