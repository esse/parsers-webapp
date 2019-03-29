.PHONY: run
run: build_parser build_web_app parser web_app

.PHONY: build_parser
build_parser:
	docker build parser/ -t esse/dahlia-parser:latest

.PHONY: build_web_app
build_web_app:
	docker build web_app/ -t esse/dahlia-web_app:latest

.PHONY: web_app
web_app:
	docker-compose run --service-ports web_app

.PHONY: parser
parser:
	docker-compose run parser
