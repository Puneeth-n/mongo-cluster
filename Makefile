#!make

MONGO_VERSION:=mongo:3.2
DC:=docker-compose
DC_MONGO:= MONGO_VERSION=$(MONGO_VERSION) $(DC)
DC_CLUSTER:=$(DC_MONGO) -p test -f ./docker-compose.yml
DC_SINGLE_NODE:=$(DC_MONGO) -f ./docker-compose.node.yml
MONGO_INSTANCE?=db01

cluster-start:
	@$(DC_CLUSTER) up -d db01 db02 db03

cluster-logs:
	@$(DC_CLUSTER) logs -f

cluster-down:
	@$(DC_CLUSTER) down

cluster-init:
	@$(DC_CLUSTER) run --rm init

login:
	@MONGO_INSTANCE=${MONGO_INSTANCE} $(DC_CLUSTER) run --rm client mongo --host db
