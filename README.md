# Spring Cloud Services for PCFDev

The goal of this project is to allow developers to run Spring Cloud Services on PCFDev.

This project assumes that you're running PCFDev at 192.168.11.11.

Currently, this project requires you to manually download the SCS Tile from network.pivotal.io and place that file alongside the deploy-local.sh file. Once you do that, you should be able to simply run ./deploy-local.sh and the SCS applications and Service Broker will deploy to PCFDev.

## Usage

Clone this project: `git clone https://github.com/dave-malone/pcfdev-spring-cloud-services`

Download the [SCS Tile](https://network.pivotal.io/products/p-spring-cloud-services)

Copy the downloaded p-spring-cloud-services-&#42;.zip file into this project directory

Make sure that you're already running PCFDev

`./deploy-local.sh`

## SSL certificates

Spring Cloud Services depends on wildcard certificates for &#42;.uaa and &#42;.login domains. By default, PCFDev only comes configured with a wildcard cert for the &#42;.local.pcfdev.io domain. In order to deploy SCS on PCFDev, we need to update the SSL cert, including the wildcard domains required:
&#42;.local.pcfdev.io,&#42;.uaa.local.pcfdev.io,&#42;.login.local.pcfdev.io

SSH into vagrant vm
  ```sudo su -
  cd /var/vcap/jobs/gorouter/config
  mkdir bak
  mv &#42;.pem ./bak
  openssl genrsa -out key.pem 2048
  openssl req -new -key key.pem -out csr.pem
  openssl req -x509 -days 365 -key key.pem -in csr.pem -out certificate.pem
  monit restart gorouter
  ```

## DNS

PCFDev uses xip.io in order to redirect all &#42;.local.pcfdev.io requests back to 192.168.11.11. You can either configure a local DNS server to map all &#42;.uaa.local.pcfdev.io and &#42;.login.local.pcfdev.io requests to 192.168.11.11.

Alternatively, you can modify your /etc/hosts file using a few well-known domain names. The scripts in this project deploy the SCS Service Broker as an app running on Cloud Foundry with a given hostname: scsbroker.local.pcfdev.io. The project also sets up a new Zone in UAA: spring-cloud-services.uaa.local.pcfdev.io and spring-cloud-services.login.local.pcfdev.io. All of this is configurable via the setup.sh script.


## TODO

* Currently, this project fails to deploy the SCS Service Broker.
* Utilize the network.pivotal.io download API to download the SCS Tile zip file
* Automate the generation of the SSL certificates and update to the PCFDev vagrant vm
* Automate creation of DNS entries required
