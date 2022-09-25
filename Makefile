isort = isort src tests
black = black -l 120 --target-version py38 src tests

.PHONY: install
install:
	python -m pip install -U wheel pip
	pip install -r requirements.txt
	pip install -e .

.PHONY: install-dev
install-dev: install
	pip install -r requirements-dev.txt
	pre-commit install
	pre-commit install --hook-type pre-push
	nbdime config-git --enable

.PHONY: test
test:
	pytest --cov-report html --cov=src tests

.PHONY: format
format:
	$(isort)
	$(black)

.PHONY: lint
lint:
	mypy src/
	flake8 src/ tests/
	$(isort) --check-only --df
	$(black) --check

clean: clean-build clean-pyc clean-test ## remove all build, test, coverage and Python artifacts

clean-build: ## remove build artifacts
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	rm -fr *.egg-info

clean-pyc: ## remove Python file artifacts
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

clean-test: ## remove test and coverage artifacts
	rm -f .coverage
	rm -fr htmlcov/
	rm -fr .pytest_cache
	rm -fr tmp_dir_for_testting/

dist: clean ## builds source and wheel package
	#python setup.py sdist
	python setup.py sdist bdist_wheel
	ls -l dist
