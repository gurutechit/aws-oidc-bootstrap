POETRY_PROJECT_PATH := $(shell poetry env info --path | xargs -r dirname)
export ANSIBLE_HOME := $(POETRY_PROJECT_PATH)/.ansible
export ANSIBLE_COLLECTIONS_PATH := $(ANSIBLE_HOME)/collections
export ANSIBLE_NOCOWS := 1

$(ANSIBLE_COLLECTIONS_PATH):
	poetry run ansible-galaxy collection install -r requirements.yml
install: $(ANSIBLE_COLLECTIONS_PATH)
	poetry run ansible-playbook playbook.yml
destroy: $(ANSIBLE_COLLECTIONS_PATH)
	poetry run ansible-playbook playbook.yml --tags destroy
clean:
	rm -rf .ansible/collections
	rm -rf .venv
.PHONY: clean
