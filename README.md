# mongo-dev

`docker-compose.yml` example 
```yaml
---
version: '3.4'
services:
  mongo-server-container:
    container_name: "mongo-server"
    build:
      context: ./mongo
    image: my/mongo-server
    restart: always
    ports:
    - "3099:27017"
    environment:
      AUTH: "yes"
      MONGO_ADMIN_USER: "admin"
      MONGO_ADMIN_PASSWORD: "adminpwd"
      MONGO_SERVICE1_USER: "user"
      MONGO_SERVICE1_PASSWORD: "userpwd"
      MONGO_SERVICE2_USER: "user"
      MONGO_SERVICE2_PASSWORD: "userpwd"
      MONGO_APPLICATION_DATABASE: service1,service2
    volumes:
    - ./mongo-server-data:/data/db
```

get image
```
docker push mityi/mongo-dev:tagname
```
