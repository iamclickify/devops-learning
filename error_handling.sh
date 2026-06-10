#!/bin/bash

create_directory() {
	mkdir demo
}

if ! create_directory; then
	echo "The code has been exited"
	exit 1
fi

echo "The code has been interrupted"
