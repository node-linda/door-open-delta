door-open-delta
===============
Open [DeltaS112](http://gyazz.com/masuilab/慶應SFC 増井研究会) door with [linda-socket.io](https://github.com/node-linda/linda-socket.io)

- https://github.com/node-linda/door-open-delta


1. watch {type: "door", cmd: "open"}
2. open door
3. then, write {type: "door", cmd: "open", response: "success"}


Video
-----
http://www.youtube.com/watch?v=mHJhTMvtmPQ

Dependencies
------------
- [Servo Motor](http://akizukidenshi.com/catalog/g/gM-01794/)
- [Arduino Firmata](https://github.com/shokai/arduino_firmata)


## Install Dependencies

    % npm install


## Setup Arduino

Install Arduino Firmata v2.2

    Arduino IDE -> [File] -> [Examples] -> [Firmata] -> [StandardFirmata]

servo motor -> digital pin 9


## Run

    % npm start

=> http://linda-server.herokuapp.com/test?type=door


## Run with your [linda-server](https://github.com/node-linda/linda)

    % export LINDA_BASE=http://linda-server.herokuapp.com
    % export LINDA_SPACE=test
    % export ARDUINO=/dev/cu.usbserial-device
    % npm start


## Install as Service

    % gem install foreman

for launchd (Mac OSX)

    % sudo foreman export launchd /Library/LaunchDaemons/ --app node-linda-door-open-delta -u `whoami`
    % sudo launchctl load -w /Library/LaunchDaemons/node-linda-door-open-delta-main-1.plist


for upstart (Ubuntu)

    % sudo foreman export upstart /etc/init/ --app node-linda-door-open-delta -d `pwd` -u `whoami`
    % sudo service node-linda-door-open-delta start
