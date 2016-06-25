docker-ocs-inventory-ng
=======================

Out-of-the-box OCS-Inventory-NG Server image based on CentOS 6

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


Technical Detail
----------------

This approach is based on [official wiki server installation guide](http://wiki.ocsinventory-ng.org/index.php/Documentation:Server). In other word, it includes all LAMP module plus perl, mod_perl, and it's dependencies.

To mount your existing inventory database (MySQL), do this:

	docker run -d -p 80:80 -p 3306:3306 -v /path/to/your/mysql/directory:/var/lib/mysql -v  /path/to/your/mysql/setting/dbconfig.inc.php:/usr/share/ocsinventory-reports/ocsreports/dbconfig.inc.php yourname/ocs-inventory-ng
	
It also expose port 3306 for MySQL connection; just in case you need it.
