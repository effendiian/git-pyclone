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

# Install explicitly.
.PHONY: install
install: .git/hooks/pre-commit
	@poetry install

# Install development dependencies.
.PHONY: setup
setup: activate .git/hooks/pre-commit pyproject.toml poetry.lock requirements.txt ;

############################################
# Deployment
############################################

# Clean cache.
.PHONY: clean
clean:
	$(info Removing __pycache__ directories...)
	rm -rf ".mypy_cache"
	rm -rf ".pytest_cache"
	rm -rf "git_pyclone/__pycache__"
	rm -rf "tests/__pycache__"

# Build the poetry package.
.PHONY: build
build: pre-commit test
	@poetry build

############################################
# Entrypoint.
############################################

# Run against all files.
.PHONY:
pre-commit: .git/hooks/pre-commit
	pre-commit run --all-files

# Run pytest suite.
.PHONY:
test:
	pytest tests/

# Entrypoint.
.PHONY: run
run: pre-commit
	$(info Starting project.)
	poetry run git-pyclone
