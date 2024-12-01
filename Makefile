# ↓↓↓当日いじる↓↓↓
# アプリケーション
WORK_DIR:=~/
REPO:=git@github.com:kackey0-1/isucon12-final.git
# ↑↑↑ここまで↑↑↑

# colors
ESC=$(shell printf '\033')
RESET="${ESC}[0m"
BOLD="${ESC}[1m"
RED="${ESC}[31m"
GREEN="${ESC}[32m"
BLUE="${ESC}[33m"

# commands
START_ECHO=echo "$(GREEN)$(BOLD)[INFO] start $@ $$s $(RESET)"

.PHONY: init
init:
	eval $$(ssh-agent) && \
	ssh-add ~/.ssh/id_ed25519 && \
	for s in s1 s2 s3; do \
		$(START_ECHO); \
		ssh -A $$s "sudo rm -rf isucon12-final"; \
		ssh -A $$s "sudo chmod 777 /var/lib/mysql-files/"; \
	done && \
	eval $$(ssh-agent -k)

.PHONY: deploy-app
deploy-app:
	@ for s in s1 s2 s3; do\
		$(START_ECHO);\
		ssh $$s "sudo rm -rf isucon12-final";\
		ssh $$s "git clone $(REPO)";\
	done
