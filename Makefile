GIT_TAG=$(PULL_BASE_REF)
GIT_REPO=$(REPO_OWNER)/$(REPO_NAME)
export GITHUB_TOKEN=$(BOT_GITHUB_TOKEN)

.PHONY: check
check:
	./scripts/checker.sh --helm-lint --directories ./addons --helm-version v2.10.0

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
# release branch named `release-x.y` will be created if the GIT_TAG matches the `x.y.0` version pattern.
	./scripts/create_release_branch_step.sh $(GIT_TAG) $(GIT_REPO)

.PHONY: push-release
push-release:
	./scripts/push_release.sh $(GIT_TAG) $(GIT_REPO)

.PHONY: ci-pr
ci-pr: check prepare-assets

.PHONY: ci-master
ci-master: check prepare-assets

.PHONY: ci-release
ci-release: check generate-changelog prepare-assets push-release release-branch

