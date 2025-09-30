.DEFAULT_GOAL := help

help: ## prints help for most of the make targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

update-ollama: ## update ollama models
	./scripts/ollama_update_models.sh

update-homebrew: ## update & upgrade homebrew
	brew update
	brew upgrade
	brew cleanup --prune=all -s
