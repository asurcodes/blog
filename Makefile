all: compile deploy update_submodule_pointers

.PHONY: all

NOW = $(shell date)

compile:
	@printf "\033[0;32mUpdating theme submodule...\033[0m\n"
	# Update theme
	git submodule foreach git pull origin master
	@printf "\033[0;32mCompiling content...\033[0m\n"
	# Compile content
	hugo -t amperage

deploy:
	@printf "\033[0;32mDeploying content to Github...\033[0m\n"
	# Go to Public folder
	cd public
	# Add changes to git.
	git add .
	# Commit changes.
	git commit -m "Rebuilding site - $(NOW)"
	# Push source
	git push origin master

update_submodule_pointers:
	@printf "\033[0;32mUpdating submodule pointers...\033[0m\n"
	# Update submodules to remote master
	git submodule foreach git pull origin master
	# Stage submodules
	git add public
	git add themes/amperage
	# Commit changes
	git commit -m "Updating submodule pointers - $(NOW)"
	# Push source
	git push origin master
