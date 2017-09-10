# README

## deployment

### requirements
- docker container

### instructions
```bash
docker-compose build
docker-compose run web rake db:create
docker-compose up
```

test using
```bash
docker-compose run web rails test
```
