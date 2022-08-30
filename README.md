# Library API with Go, Gorilla/Mux and Gorm

## Installation
```
docker compose up -d
```

## Request example:
```
curl --location --request GET 'http://localhost:5000/api/book?page=4&size=1'
```
```
curl --location --request GET 'http://localhost:5000/api/book/3'
```
```
curl --location --request GET 'http://localhost:5000/api/book/4/items'
```