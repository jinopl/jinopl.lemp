CUR_DIR = $(shell echo "${PWD}")
tag ?= jinopl.lemp
version ?=latest

.PHONY: build run

common:
	@echo 'To setup machine use : make setup'
	@echo 'For building docker image again use : make build'
	@echo 'For running docker container : make run'

build:
	@docker build . -t $(tag):$(version)
run:
	@docker run --rm -it --name $(tag) -p 8080:80 --volume=mysqldata:/var/lib/mysql --mount type=bind,source=$(CUR_DIR)/src,target=/var/www/html/ $(tag):$(version)
setup:
	@docker volume create --name mysqldata$(tag)
firstrun:
	@make build
	@make setup
	@make run
clean:
	@docker volume rm mysqldata$(tag)
	@docker image rm $(tag):$(version)

deepclean:
	@docker system prune
