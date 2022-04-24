env ?= dev
stack_dir := ./environments/${env}/${stack}
var_file := ../config.sh

lint: check

check:
	pre-commit run --all-files

configure:
	brew bundle
	tfenv install
	pre-commit install
	tflint --init

init: check-args
	cd ${stack_dir} && source ${var_file} && AWS_PROFILE=copotrzebne-${env} terraform init

plan: check-args
	cd ${stack_dir} && source ${var_file} && AWS_PROFILE=copotrzebne-${env} terraform plan

apply: check-args
	cd ${stack_dir} && source ${var_file} && AWS_PROFILE=copotrzebne-${env} terraform apply

output: check-args
	cd ${stack_dir} && source ${var_file} && AWS_PROFILE=copotrzebne-${env} terraform output

output-raw: check-args
  ifndef name
	  $(error name is undefined)
  endif
	cd ${stack_dir} && source ${var_file} && AWS_PROFILE=copotrzebne-${env} terraform output -raw ${name}

destroy: check-args
	cd ${stack_dir} && source ${var_file} && AWS_PROFILE=copotrzebne-${env} terraform apply -destroy

check-args:
ifndef stack
	$(error stack is undefined)
endif
