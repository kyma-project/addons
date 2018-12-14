GIT_REF=$(shell git rev-parse --abbrev-ref HEAD)
GIT_TAG=$(shell echo $(GIT_REF) | cut -d/ -f2)
GIT_REPO=$(REPO_OWNER)/$(REPO_NAME)
export GITHUB_TOKEN=$(BOT_GITHUB_TOKEN)

.PHONY: check
check:
	@echo "dupa"
	@echo $(GIT_REF)
	@echo $(GIT_TAG)
	@echo $(PULL_REFS)
	@echo $(PULL_BASE_REF)
	@echo "dupa"
	./scripts/checker.sh --helm-lint --directories ./bundles --helm-version v2.10.0

.PHONY: prepare-assets
prepare-assets:
	./scripts/prepare-release-assets.sh

.PHONY: generate-changelog
generate-changelog:
	./scripts/generate_changelog.sh $(GIT_TAG) $(GIT_REPO)

.PHONY: latest-release
latest-release:
	./scripts/create_latest_tag_step.sh $(GIT_REPO)
	./scripts/remove_latest_release.sh $(GIT_REPO)
	./scripts/push_release.sh latest $(GIT_REPO)

.PHONY: release-branch
release-branch:
# release branch named `release-x.y` will be created if the GIT_TAG matches the `x.y.0` version pattern, in which `0` is revision.
ifeq ($(GIT_TAG),)
	@echo "Skipping creating release branch.."
else
	./scripts/create_release_branch_step.sh $(GIT_TAG) $(GIT_REPO)
endif

.PHONY: push-release
push-release:
ifeq ($(GIT_TAG),)
	@echo "Skipping creating release.."
else
	./scripts/push_release.sh $(GIT_TAG) $(GIT_REPO)
endif

.PHONY: ci-pr
ci-pr: check prepare-assets

.PHONY: ci-master
ci-master: check prepare-assets release-branch push-release latest-release

.PHONY: ci-release
ci-release: check prepare-assets generate-changelog push-release
