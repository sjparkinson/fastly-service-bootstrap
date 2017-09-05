# Normalise some things.
.POSIX:
.SUFFIXES:

.PHONY: test

all: help

# Install npm dependencies.
node_modules: package.json
	npm install
	touch -m node_modules

# Install Terraform dependencies.
.terraform:
	terraform init terraform/

fmt: ## Format the code.
fmt: node_modules .terraform
	terraform fmt terraform/
	prettier --write 'test/**/*.js'

lint: ## Lint the code.
	[[ $$(terraform fmt -write=false terraform/) != *[^[:space:]]* ]] || terraform fmt -write=false -diff terraform/
	[[ $$(prettier --list-different 'test/**/*.js') != *[^[:space:]]* ]] || prettier --list-different 'test/**/*.js'

test: ## Run the tests!
	npm run test

clean: ## Clean up generated files.
	rm -rf node_modules/ \
		.terraform/ \
		terraform/*.tfstate \
		terraform/*.tfstate.backup

help: ## Show this help message.
	@echo "usage: make [target] ..."
	@echo ""
	@echo "targets:"
	@grep -Eh '^\S+:\ ##' ${MAKEFILE_LIST} | column -t -s ':#'
