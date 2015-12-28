# NetWatch

NetWatch is a demonstration of a NodeJS webapp that is built into a Docker image, using Make as the build tool.

## Make tasks

* `build`: Build a Docker image for the app. The image includes NodeJS and nmap.
* `run`: Run a Docker container based on the built image. Exposes the webapp at port 3000.
* `debug`: Debug a Docker container based on the built image. Opens a bash shell for you to play with.