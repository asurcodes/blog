all: update_theme clone_site compile optimize deploy

.PHONY: all

NOW = $(shell date)
GITHUB_ACTOR = Asur
GITHUB_EMAIL = asur@asurbernardo.com
GITHUB_PAGES_REPO = git@github.com:asurbernardo/asurbernardo.github.io.git

update_theme:
	@printf "\033[0;32mUpdating theme submodule...\033[0m\n"
	git submodule foreach git pull origin master

clone_site:
	@printf "\033[0;32mCloning site from remote...\033[0m\n"
	rm -rf public
	git clone $(GITHUB_PAGES_REPO) public

compile:
	@printf "\033[0;32mCompiling content...\033[0m\n"
	hugo -t amperage --minify --gc

compile:
	@printf "\033[0;32mOptimizing files...\033[0m\n"
	./optimize.sh

deploy:
	@printf "\033[0;32mDeploying content to Github...\033[0m\n"
	cd public && \
		git add --all && \
		git commit -m "Rebuilding site - $(NOW)" && \
		git push origin master