.PHONY: validate publish

VERSION=1.0.1

validate: orb.yml
	circleci orb validate orb.yml

publish: validate
	circleci orb publish orb.yml reload/backstop-status@$(VERSION)
