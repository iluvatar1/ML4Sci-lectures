
.PHONY: book clean actions repo2docker binder devcontainer lite reset-origin-master nbgrader

book:
	@echo "Building book with jupyter-book"
	jupyter-book build -v ./

# Check https://github.com/nektos/act/issues/1658
actions:
	@echo "Running local actions"
	@echo "Do not forget to have docker running and also : sudo ln -s ~/.docker/run/docker.sock /var/run/docker.sock"
	act # act --secret-file .secrets -v --container-architecture linux/amd64

binder:
	@echo "Building and running local image, for binder"
	docker build ./  -f ./Dockerfile  -t bindertest
    docker run -it --rm -p 8888:8888 bindertest jupyter notebook --NotebookApp.default_url=/lab/ --ip=0.0.0.0 --port=8888 --allow-root

repo2docker:
	@echo "Building docker image with repo2docker"
	repo2docker --user-id 1000 --user-name jovyan --debug --image-name r2d ./

devcontainer:
	@echo "Building and running  devcontainer image "
	devcontainer build --workspace-folder ./ --image-name devcontest
	docker run -it devcontest /bin/bash

lite:
	rm -rf _output _contents lite-build _build
	jupyter lite build --config jupyter_lite_config.json
	mkdir -p _build/html/lab
	cp -r lite-build/* _build/html/lab/
	cd lite-build && python3 -m http.server 8000

reset-origin-master:
	@echo "Resetting current branch to origin/master"
	git fetch origin master
	git reset --hard origin/master
	git clean -fd

nbgrader:
	@echo "Generating assingments to test ..."
	nbgrader generate_assignment --assignment="lectures/*" --notebook="*" --force

html:
	@echo "Building html book and serving it..."
	jupyter-book build --html --execute
	npx serve _build/html

clean:
	rm -f *~ #_build
