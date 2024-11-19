setup:
	@pip install -U pip poetry

dependencies:
	@make setup
	@poetry install --no-root

update:
	@poetry update
