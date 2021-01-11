
## Building docker container

```
docker stop test
docker rmi -f test
docker build -t test:1.0 .
docker run --name test -p 8080:80 -d test:1.0
docker exec -it test /bin/bash
```

## Running tests

`su www-data -s /bin/bash -c "phpunit -c web/core web/core/modules/ban"`
