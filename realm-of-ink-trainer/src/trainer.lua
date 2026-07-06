local trainer = {}
local socket = require("socket")
local cjson = require("cjson")

local ink_state = {
  health = 100,
  mana = 50,
  stamina = 80,
  ink_power = 0
}

function trainer.connect(host, port)
  local udp = socket.udp()
  udp:settimeout(1)
  local ok, err = udp:connect(host or "127.0.0.1", port or 8080)
  if not ok then
    return nil, "Connection failed: " .. (err or "unknown")
  end
  return udp
end

function trainer.send_command(udp, cmd, value)
  local packet = cjson.encode({ command = cmd, value = value })
  udp:send(packet)
  local response, err = udp:receive()
  if response then
    return cjson.decode(response)
  end
  return nil, err or "no response"
end

function trainer.get_state()
  return ink_state
end

function trainer.set_health(hp)
  ink_state.health = math.max(0, math.min(9999, hp))
end

function trainer.set_mana(mp)
  ink_state.mana = math.max(0, math.min(9999, mp))
end

function trainer.set_stamina(sp)
  ink_state.stamina = math.max(0, math.min(9999, sp))
end

function trainer.freeze_ink_power()
  ink_state.ink_power = 9999
  return true
end

return trainer