GIT = $(shell which git)
GIT_BRANCH = $(shell git rev-parse --abbrev-ref HEAD)
GIT_COMMIT = $(shell git rev-parse --short HEAD)
GIT_COMMIT_TIME = $(shell git log -n 1 --pretty=format:"%ad" --date=iso)
PIP = $(shell which pip)

.PHONY: help
help: ## Show help messages
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-40s\033[0m %s\n", $$1, $$2}'

.PHONY: install-ci
install-ci: install-commit-message-template install-ci-pkgs install-hooks ## Install ci tools

.PHONY: install-ci-pkgs
install-ci-pkgs: ## Install ci packages
	# Install ci packages
	@$(PIP) install -qr ci/requirements.txt

.PHONY: install-hooks
install-hooks: .pre-commit-config.yaml install-ci-pkgs ## Install packages for git hooks
	# Install git hooks
	@pre-commit install -c $< -t pre-commit -t commit-msg -t pre-push

.PHONY: install-commit-message-template
install-commit-message-template: ci/COMMIT_MESSAGE_TEMPLATE ## Install commit-message template
	# Install commit-message template
	@$(GIT) config commit.template $<

.PHONY: uninstall-hooks
uninstall-hooks: ## Uninstall hooks
	# Remove all hooks
	@pre-commit uninstall -t pre-commit -t commit-msg -t pre-push

.PHONY: uninstall-commit-message-template
uninstall-commit-message-template: ## Uninstall commit-message template
	# Remove commit template
	@$(GIT) config --unset commit.template || true

.PHONY: uninstall-ci
uninstall-ci: uninstall-hooks uninstall-commit-message-template ## Uninstall ci tools
	# Uninstall all hooks

.PHONY: reinstall-ci
reinstall-ci: uninstall-ci install-ci ## Reinstall ci tools
	# Reinstall all hooks

.PHONY: bump
bump: install-ci-pkgs ## Bump
	@cz bump

.PHONY: push-version
push-version: install-ci-pkgs ## Push current version
	$(eval version := $(shell cz version --project))
	@git push
	@git push origin $(version)

.PHONY: show-version
show-version: install-ci-pkgs ## Show current version
	@cz version --project

.PHONY: bump-and-push-version
bump-and-push-version: bump push-version ## Bump and push current version
