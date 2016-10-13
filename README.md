## **oevelgone/teamspeak-sql**

  Docker image for Teamspeak 3 
  from [**mbentley/teamspeak**](https://hub.docker.com/r/mbentley/teamspeak/)
  with SQL (mysql/mariadb) plugin activated.

## Usage

  1.  Set up a SQL container (mysql/mariadb) with user (default : teamspeak) access on database (default : teamspeak)

  2. Run teamspeak container.

    ```shell
docker run -d --name teamspeak --link teamspeak-db:3306 \
-p 9987:9987/udp -p 30033:30033 -p 10011:10011 -p 41144:41144 \
-e TS_DB_HOST=teamspeak-db \
teamspeak_sql
```

## Manual
#### Environment
 - TS_DB_HOST 127.0.0.1
 - TS_DB_PORT 3306
 - TS_DB_NAME teamspeak
 - TS_DB_USER teamspeak
 - TS_DB_PASSWORD teamspeak

#### Exposed Ports
Port | Type | Function
--- | ---
9987 | UDP in | Default voice port
10011 | TCP in | Default serverquery port
30033 | TCP in | Default filetransfer port
41144 | TCP in | Default tsdns port

## Docker-compose

###### Docker-compose example file : 
```
version: '2'
services:
  db:
    image: mysql:latest
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: teamspeak
      MYSQL_DATABASE: teamspeak
      MYSQL_USER: teamspeak
      MYSQL_PASSWORD: teamspeak

  teamspeak:
    image: oevelgone/teamspeak-sql:lastest
    depends_on:
      - db
    links:
      - db
    ports:
      - "9987:9987/udp"
      - "30033:30033"
      - "10011:10011"
      - "41144:41144"
    restart: always
    environment:
      TS_DB_HOST: db
      TS_DB_PASSWORD: teamspeak
```
