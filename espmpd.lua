
PIN_BUTTON = 3
TIME_ALARM =25
gpio.mode(PIN_BUTTON, gpio.INPUT, gpio.PULLUP)
button_state = 1
button_time = 0

PORT = 6600
host = '192.168.1.161'

socket=net.createConnection(net.TCP, 0)
socket:connect(PORT, host)

function mpdCommand(command)
    socket:send(command .. "\n")
end


function buttonHandler()
  button_state_new = gpio.read(PIN_BUTTON)
  if button_state == 1 and button_state_new == 0 then
    button_time = tmr.time()
    mpdCommand("pause")
  elseif button_state == 0 and button_state_new == 1 then
    button_time_new = tmr.time()
    if tmr.time() > (button_time + 2) then
      tmr.stop(1)
      print("BUTTON DISABLED")
    end
  end
  button_state = button_state_new
end

tmr.alarm(1, TIME_ALARM, 1, buttonHandler)

