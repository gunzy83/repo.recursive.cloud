.PHONY: add-aur-package add-local-package s3-upload upgrade-aur-packages build-package remove-package upgrade-and-push

RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
$(eval $(RUN_ARGS):;@:)

export AWS_PROFILE=gunzy

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build-package: ## build a PKGBUILD in a folder
	@cd $(RUN_ARGS) && \
	 makepkg -csf && \
	 cd ..

add-local-package: build-package ## build a PKGBUILD in a folder and add it to the local-repo
	@mv $(RUN_ARGS)/$(RUN_ARGS)-*.pkg.tar.zst local-repo/ && \
	 cd local-repo && \
	 repo-add -n recursive-cloud.db.tar.xz $(RUN_ARGS)-*.pkg.tar.zst

add-aur-package: ## add an AUR package to the local repo
	@aur sync --repo recursive-cloud --root $(shell pwd)/local-repo --no-view $(RUN_ARGS)

upgrade-aur-packages: ## upgrade all AUR packages in the local repo
	@aur sync --repo recursive-cloud --root $(shell pwd)/local-repo --no-view --upgrades

s3-upload: ## upload all changed filed to S3 hosting
	@aws s3 sync --follow-symlinks local-repo/ s3://repo.recursive.cloud/arch/repo/x86_64/ && \
	  aws --profile gunzy cloudfront create-invalidation --distribution-id E2Z8EZMWIP4QG1 --paths '/arch/repo/x86_64/*'

upgrade-and-push: upgrade-aur-packages s3-upload ## upgrade all AUR packages in local repo and push to S3

remove-package:
	@echo "Not implemented"
