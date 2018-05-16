# Docker based development environment
This Ubuntu 18.04 based image provides an SSH environment for developing
applications. This image enables quick deployment of a development environment
without the need to install the regular development tools.

Major languages pre-installed in the image include:
+ Javascript (Node JS)
+ Ruby
+ Golang
+ Python

Neovim is the programmer editor of choice with numerous plugins preinstalled to
support development.

## SSH access and authentication
Access to the container is provided by OpenSSH on port 22. When starting or
creating the container port 22 should be exposed to the host on an available port.

Ssh key authentication is preferred method of authentication with trusted keys
automatically added in the [.ssh/authorized_keys](home/.ssh/authorized_keys). Anyone
forking or using this image must change the authorized_keys file with their own keys.

## Build Arguments
+ *user*: The user ID to be created
+ *fullname*: The full name of the user
+ *email*: The email address of the user
+ *timezone*: The timezone of the user

## References
See related article [I hate building development environments](http://bit.ly/i-hate-building-development-environments)
