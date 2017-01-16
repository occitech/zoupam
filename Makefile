install: ## Install web NPM dependencies
	docker-compose run --rm elm package install -y

docker_run: ## Launch docker instances for development
	docker-compose up -d elm

logs: ## Watch container logs (useful for development)
	docker-compose logs -f elm

refresh: ## Refresh docker containers
	docker-compose stop elm && docker-compose rm -vaf elm && docker-compose up -d elm

test: ## Launch tests
	@echo "TODO !"

build: ## Compile js
	docker-compose run --rm elm run build

lint: ## Make a lint pass
	# docker-compose run --rm npm run lint

deploy_prod: build ## Deploy prod
	@ echo "Deploying to " $$DEPLOYMENT_TARGET_PATH
	@rsync -avzL --delete dist/ $$DEPLOYMENT_TARGET_PATH

# Automatic documentation. See http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
