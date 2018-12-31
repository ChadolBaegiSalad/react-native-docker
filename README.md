# react-native-docker
Run react-native-cli on the docker

## How to set up
#### In osx

 1. install [docker](https://www.docker.com/products/docker-desktop)
 2. install [virtualbox](https://www.virtualbox.org/wiki/Downloads) (you must install both VirtualBox and VirtualBox Extension Pack)
 3. set up a virtual image that can access the USB port (because the default image does not have access to the port)
    > ***1. create and stop the virtual image*** 
    >> docker-machine create --driver virtualbox default
    >> docker-machine stop
    >
    > ***2. add a usb controller to the image***
    > ![2018-12-31 11 43 53](https://user-images.githubusercontent.com/24406920/50555011-0c13c600-0d09-11e9-8685-3b26c9edb1d5.png)
    >
    > ***3. start the virtual image***
    >> docker-machine start
    >
    > ***4. active docker-machine***
    >> eval $(docker-machine env)
    >
    > ***5. validate (if the output is the "default", it is success)***
    >> docker-machine active

 4. pull "react-native-docker" docker image
    > docker pull polaris707/react-native-docker:latest

if you're done, go to the "How to run a project" section.

#### In windows (to be added)


## How to run a project

#### In osx

 1. edit run.sh and get_bash.sh scripts attached to this repo. *PROJECT_NAME,* *PROJECT_ROOT_DIR*  is a variable, edit it to suit your environment

 2. run docker container
    > source run.sh (must be use the source command, don't use implicit execution)

 3. get the bash shell
    > ./get_bash.sh  (or docker exec -it [YOUR_PROJECT_NAME] bash)

 4. do your project
    * if you check all list of connected usb port, use lsusb command
    * if the device is not connected, try various connection methods such as MTP, PTP, and USB Mass Storage or try connecting again.

#### In windows (to be added)

