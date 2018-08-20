Image States on Hub:

 - grav: [![](https://images.microbadger.com/badges/image/opsforge/grav-docker.svg)](https://hub.docker.com/r/opsforge/grav-docker/ "Grav Docker Image")

# Grav docker container

**Active versions:**

- Grav: 1.3.8+ with Admin 1.6.6+ (updates with each re-run of the build)

## Credits

This project makes use of the logic of the php7-apache image in the https://github.com/docker-library/wordpress project.

## Benefits

- 0-touch install - run the container and it will unpack the current grav on launch if you don't already have it
- persist content with a mount for the container
- horizontally scalable

## Description

GRAV is an open source CMS system, more on the project: https://getgrav.org/
They don't really have a supported way to run this on docker for the moment, hence this repo.

## How to use

There are two ways to use this stack:

1. Run with the docker cli
2. Run with docker-compose

### Using with docker-compose

Clone the repo to a docker host or get the docker-compose.yml file on the host. From a shell in the folder of the yaml file run:

    docker-compose up -d

Wait for the pulls to finish and afterwards 5-7 more minutes for the stack to come online. The grav container will be listening on port 80.

To get rid of the stack (again from the folder of the yaml):

    docker-compose down

Data from GRAV will persist in the current folder (of docker-compose) under a /data subdirectory.

*Make sure that if you don't want to keep the data you remove the data folders from the folder of the yaml.*

### Using with the docker cli

From a docker host, run:

    docker run -dt -p 80:80 -v $(pwd)/data:/var/www/html opsforge/grav-docker:latest

That's all.
