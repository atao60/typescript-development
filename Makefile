SHELL = /bin/sh

OWNER = $(shell grep "^\s*OWNER\s*=" ./hub.config.env | sed 's/^.*=\s*//' | sed 's/\s*$$//')
NAME = $(shell grep "^\s*NAME\s*=" ./hub.config.env | sed 's/^.*=\s*//' | sed 's/\s*$$//')
VERSIONS = $(shell grep "VERSIONS=" ./hub.config.env | sed 's/^.*=\s*//' | sed 's/\s*$$//' | sed -E 's/\s+/ /g')
TARGETS = $(shell echo ${VERSIONS} | sed -E "s|[^[:space:]]+|-t $(OWNER)/$(NAME):&|g")


build:
	docker build --pull --squash $(TARGETS) .

publish:
	@for tag in $(VERSIONS); do \
	# create a branch 'releases/<tag>' to trigger a release \
	git checkout -b releases/$$tag; \
	# push the tag on Github repository, forcing replacement \
	git tag -f $$tag; \
	git push -f origin $$tag; \
	git push -u origin releases/$$tag; \
	# push the tag on docker repository \
	docker push $(OWNER)/$(NAME):$$tag; \
	# git tags survives branch deletion \
	git checkout main; \
	git branch -D releases/$$tag; \
	git push origin --delete releases/$$tag; \
	done
	
	git push
