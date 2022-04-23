ENTRYPOINT = main.py

.PHONY: all
all: setup ;

############################################
# Install development dependencies.
############################################

# Install pre-commit hooks, if not done already.
.git/hooks/pre-commit:
	pre-commit install

# Locked dependencies.
poetry.lock: pyproject.toml
	$(info Installing development dependencies.)
	poetry install

# Export requirements.txt dependencies.
requirements.txt: poetry.lock
	@poetry export -f requirements.txt --output requirements.txt

.PHONY: activate
activate:
	$(info Activating poetry shell...)
	@poetry shell

# Install development dependencies.
.PHONY: setup
setup: activate .git/hooks/pre-commit pyproject.toml poetry.lock requirements.txt ;

############################################
# Clean
############################################

# Clean cache.
.PHONY: clean
clean:
	$(info Removing __pycache__ directory...)
	rm -rf "git_clone/__pycache__"

############################################
# Entrypoint.
############################################

# Run against all files.
.PHONY:
pre-commit: .git/hooks/pre-commit
	pre-commit run --all-files

# Entrypoint.
.PHONY: run
run: pre-commit
	$(info Starting project.)
	poetry run git-pyclone
