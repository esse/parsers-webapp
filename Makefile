.PHONY: run
run: parser web_app

.PHONY: build_parser
build_parser:
	docker build parser/ -t esse/parser:latest

.PHONY: build_web_app
build_web_app:
	docker build web_app/ -t esse/web_app:latest

.PHONY: web_app
web_app: build_web_app
	docker-compose run --service-ports web_app

.PHONY: parser
parser: build_parser
	docker-compose up -d --force-recreate parser
