lint: check

check:
	pre-commit run --all-files

configure:
	brew bundle
	tfenv install
	tflint --init
	pre-commit install

init:
	cd ./environments/prod && terraform init

plan:
	cd ./environments/prod && terraform plan

apply:
	cd ./environments/prod && terraform apply
