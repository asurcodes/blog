all: compile deploy

.PHONY: all

NOW = $(shell date)

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
		git add . && \
		git commit -m "Rebuilding site - $(NOW)" && \
		git push origin master