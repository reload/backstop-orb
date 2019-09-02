.PHONY: backstop-validate backstop-publish dais-validate dais-publish

BACKSTOP_VERSION=dev:16
DAIS_VERSION=dev:20

backstop-validate: backstop-orb.yml
	circleci orb validate $<

backstop-publish: backstop-validate
	circleci orb publish backstop-orb.yml reload/backstop@$(BACKSTOP_VERSION)

dais-validate: dais-orb.yml
	circleci orb validate $<

dais-publish: dais-validate
	circleci orb publish dais-orb.yml reload/dais@$(DAIS_VERSION)
