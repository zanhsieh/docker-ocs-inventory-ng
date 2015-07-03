docker-ocs-inventory-ng
=======================

Out-of-the-box OCS-Inventory-NG Server image based on CentOS 6.6

Usage
-----

To create the image `yourname/ocs-inventory-ng`, execute the following command on the docker-ocs-inventory-ng folder:

	docker build -t yourname/ocs-inventory-ng .

You could push your new image to the registry

	docker push yourname/ocs-inventory-ng


Running your OCS-inventory-ng docker image
------------------------------------------

Start your image binding the external ports 80 and 3306 in all interfaces to your container:

	docker run -d -p 80:80 -p 3306:3306 yourname/ocs-inventory-ng

Test your deployment:

	curl http://localhost/ocsreports/


