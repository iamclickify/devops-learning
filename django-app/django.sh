#!/bin/bash

: << task
deploy django app and handle code for errors
task

create_clone() {
	echo "Clone the repository"
	git clone https://github.com/LondheShubham153/django-notes-app
}

installation(){
	echo "Installing dependencies"
	sudo apt-get update
	sudo apt-get install docker.io nginx -y
}

restart(){
	sudo systemctl enable docker
	sudo systemctl enable nginx
	sudo systemctl restart docker
}

deploy(){
	echo "Deploying"
	docker build -t notes-app .
	docker run -d -p 8000:8000 notes-app:latest
}

echo " ***** Deployment Started ***** "

if ! create_clone; then
	echo "Code directory already exists"
	cd django-notes-app
fi

if ! installation; then
	echo "Installation failed"
	exit 1
fi

if ! restart; then
	echo "System fault identified"
	exit 1
fi

deploy

echo " ***** Deployment Ended ***** "
