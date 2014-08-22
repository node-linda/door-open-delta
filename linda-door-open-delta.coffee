process.env.LINDA_BASE  ||= 'http://linda-server.herokuapp.com'
process.env.LINDA_SPACE ||= 'test'

_ = require 'lodash'

## Linda
LindaClient = require('linda').Client
socket = require('socket.io-client').connect(process.env.LINDA_BASE)
linda = new LindaClient().connect(socket)
ts = linda.tuplespace(process.env.LINDA_SPACE)

linda.io.on 'connect', ->
  console.log "connect!! <#{process.env.LINDA_BASE}/#{ts.name}>"
  ts.watch {type: 'door', cmd: 'open'}, (err, tuple) ->
    return if err
    console.log tuple
    return if tuple.data.response?
    door_open_throttled ->
      res = tuple.data
      res.response = 'success'
      ts.write res

linda.io.on 'disconnect', ->
  console.log "socket.io disconnect.."


## Arduino
ArduinoFirmata = require('arduino-firmata')
arduino = new ArduinoFirmata().connect(process.env.ARDUINO)

arduino.once 'connect', ->
  console.log "connect!! #{arduino.serialport_name}"
  console.log "board version: #{arduino.boardVersion}"

door_open = (onComplete = ->) ->
  arduino.servoWrite 9, 0
  setTimeout ->
    arduino.servoWrite 9, 180
    onComplete()
  , 2000

door_open_throttled = _.throttle door_open, 5000, trailing: false
