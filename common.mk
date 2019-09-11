.PHONY: validate publish

validate: orb.yml
	circleci orb validate $<

publish: orb.yml validate
	circleci orb publish $< $(ORB)@$(VERSION)
