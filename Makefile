.PHONY: install
install:
	@ansible-galaxy install -r requirements.yml

.PHONY: dry-run
dry-run: install
	@ansible-playbook -i hosts.yml --ask-become-pass --check main.yml

.PHONY: run
run: install
	@ansible-playbook -i hosts.yml --ask-become-pass main.yml

.PHONY: lint
lint:
	@ansible-lint

.PHONY: test
test:
	@ansible-galaxy collection install -r roles/dev/molecule/default/collections.yml -p ~/.ansible/collections
	@cd roles/dev && molecule test
