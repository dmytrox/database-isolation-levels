up:
	docker-compose up -d --build

down:
	docker-compose down -v

mysql:
	docker-compose exec mysql bash

postgres:
	docker-compose exec postgres bash
