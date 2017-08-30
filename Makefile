# Normalise some things.
.POSIX:
.SUFFIXES:

.PHONY: test

# Define our suffixes for inference rules, see http://nullprogram.com/blog/2017/08/20/.
.SUFFIXES: .vcl .tf.json

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

build: ## Build the generated Terraform files.
build: $(TERRAFORM_VCL_OVERRIDES)

test: ## Run the tests!
	npm run test

clean: ## Clean up generated files.
	rm -rf node_modules/ \
		.terraform/ \
		terraform/deploy.ftplan \
		terraform/*.tfstate \
		terraform/*.tfstate.backup \
		terraform/*_vcl.tf

help: ## Show this help message.
	@echo "usage: make [target] ..."
	@echo ""
	@echo "targets:"
	@grep -Eh '^\S+:\ ##' ${MAKEFILE_LIST} | column -t -s ':#'
