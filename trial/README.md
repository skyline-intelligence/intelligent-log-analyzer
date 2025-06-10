# Intelligent Log Analyzer - Trial
### Quick Start with Docker Compose
This method provides a complete integrated solution with MySQL, Analyzer Server, and Grafana all configured and ready to use.

 Prerequisites
- Docker and Docker Compose installed on your system
- At least 4GB of available RAM
- Ports 8086, 3000, and 3306 available

### Step 1: Prepare the Project
Enter the trial directory, ensure you have the following files in the trial directory:
- docker-compose.yml
- Dockerfile
- supervisord.conf
- startup.sh
- mysql-init.sql
- sql.zip / test data for analyzer_server

### Step 2: Build and Start Services

#### Build the Docker image
```
docker-compose build --no-cache
```

#### Start all services using Docker Compose
```
docker-compose up -d
``` 

**Important Note:**
During the first startup, the database will be initialized and a large amount of test data will be imported, which requires some waiting time.

Monitor data imported status with the following command:
```
docker-compose exec grafana-app tail -f /var/log/startup.log
```

The output should include the following message when the database is ready:
```
All SQL files imported successfully
Startup script completed
```
After MySQL initialization is complete, you need to restart all Docker containers once, otherwise Grafana will not be able to access the analyzer_server API.

First, stop all containers:
```
docker-compose down
```
Then, start all containers again:
```
docker-compose up -d
```
After restarting, Grafana should be able to access the analyzer_server API.

### Step 3: Verify Installation

#### Check service status
``` 
docker-compose ps
``` 
**Important Note:** After startup, you need to check the container status. There should be 3 Docker instances running:
- trial_grafana-app_1 (Grafana Dashboard)
- trial_analyzer-server_1 (Analyzer Server)
- trial_mysql_1 (MySQL Database)

If you don't see all 3 containers running, you need to:
1. Stop all containers: `docker-compose down`
2. Restart all services: `docker-compose up -d`

#### View logs
``` 
docker-compose logs -f
``` 

### Step 4: Access the Application
- Grafana Dashboard : http://localhost:3000
  - Default credentials: admin/admin
- Analyzer Server API : http://localhost:8086
- MySQL Database : localhost:3306
  - Username: mysql
  - Password: mysql
  - Database: analyzer_database<br>

### Step 5: Enable Intelligent Log Analyzer plugin  <br>
- Log in to Grafana with admin/admin, click on the Plugins option in the left sidebar menu.
- In the Plugins page, search for "analyzer", then click on the intelligent log analyzer plugin that appears in the search results.
- Click the Enable button in the upper right corner to activate the intelligent log analyzer plugin. After enabling the plugin, you can go to Intelligent-Log-Analyzer to view the monitoring.

### Step 5: Stop and Reset Services

#### Stop all services using Docker Compose
```
docker-compose down
```

You can also delete the MySQL data volume and restart the services to reinitialize the database.

#### Remove MySQL data volume
```
docker volume rm trial_mysql_data
```
**Note:** Removing the MySQL data volume will delete all existing data. After removing the volume, restart the services with `docker-compose up -d` to reinitialize the database with fresh data.

