all: compile deploy

.PHONY: all

NOW = $(shell date)
GITHUB_ACTOR = Asur
GITHUB_EMAIL = asur@asurbernardo.com
GITHUB_PAGES_REPO = git@github.com:asurbernardo/asurbernardo.github.io.git

compile:
	@printf "\033[0;32mUpdating theme submodule...\033[0m\n"
	# Update theme
	git submodule foreach git pull origin master
	@printf "\033[0;32mCompiling content...\033[0m\n"
	# Compile content
	hugo -t amperage --minify

deploy:
	@printf "\033[0;32mDeploying content to Github...\033[0m\n"
	# Go to Public folder
	cd public && \
		git config user.name "$(GITHUB_ACTOR)" && \
		git config user.email "$(GITHUB_EMAIL)" && \
		git remote set-url origin $(GITHUB_PAGES_REPO) && \
		git add --all && \
		git commit -m "Rebuilding site - $(NOW)" && \
		git push origin master