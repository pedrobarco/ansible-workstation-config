.PHONY: install
install:
	@ansible-galaxy install -r requirements.yml

.PHONY: dry-run
dry-run:
	@ansible-playbook --inventory-file=hosts --ask-become-pass --check main.yml

.PHONY: run
run:
	@ansible-playbook --inventory-file=hosts --ask-become-pass main.yml
