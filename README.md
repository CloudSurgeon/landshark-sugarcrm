## How to use this image

### Running with Docker Run

This container is designed for use in the Delphix Landshark SugarCRM use case. This container relies on an external MySQL database. It also relies on SugarCRM application data residing in a directory on the host. To set up SugarCRM using this approach, please do the following:

1. Install [Docker](http://docs.docker.com/installation/)
2. Run `docker run --name some-sugarcrm -v /host/foo/bar:/var/www/html -e DB_HOST_NAME=yourhostname -e DATABASE_NAME=yourdatabasename -e DB_USER_NAME=yourusername -e DB_PASSWORD=yourpassword -e DB_TYPE=mysql -e DB_TCP_PORT=3306 -e DB_MANAGER=MysqlManager -p 2080:80 -d cloudsurgeon/landshark-sugarcrm`
3. Access `http://{docker_host}:2080` from your web browser to access SugarCRM.