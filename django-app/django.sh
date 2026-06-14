#!/bin/bash

set -e

: << TASK
Deploy Django Notes App using Docker Compose
TASK

REPO_URL="https://github.com/LondheShubham153/django-notes-app"
PROJECT_DIR="django-notes-app"

create_clone() {
    if [ ! -d "django-notes-app" ]; then
        git clone https://github.com/LondheShubham153/django-notes-app
    fi

    cd django-notes-app || exit 1
}

installation() {
    echo "===== Installing Dependencies ====="

    sudo apt-get update

    sudo apt-get install -y \
        docker.io \
        nginx \
        curl

    sudo apt install docker-compose -y
}

restart_services() {
    echo "===== Starting Services ====="

    sudo systemctl enable docker
    sudo systemctl start docker

    sudo systemctl enable nginx
    sudo systemctl start nginx
}

check_env() {
    echo "===== Checking Environment File ====="

    if [ ! -f ".env" ]; then
        echo ".env file not found!"

        if [ -f ".env.example" ]; then
            echo "Found .env.example"
            echo "Create .env before deployment."
        fi

        exit 1
    fi
}

deploy() {
    echo "Deploying"
    docker-compose up -d --build
}

verify() {
    echo "===== Verifying Deployment ====="

    docker ps

    echo
    echo "Containers running successfully."
}

echo
echo "******** DEPLOYMENT STARTED ********"
echo

if ! create_clone; then
    echo "Repository setup failed."
    exit 1
fi

if ! installation; then
    echo "Dependency installation failed."
    exit 1
fi

if ! restart_services; then
    echo "Failed to start services."
    exit 1
fi

if ! check_env; then
    echo "Environment validation failed."
    exit 1
fi

if ! deploy; then
    echo "Deployment failed."
    exit 1
fi

verify

echo
echo "******** DEPLOYMENT COMPLETED ********"
echo
