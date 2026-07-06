local trainer = require("src.trainer")

-- Test initial state
local state = trainer.get_state()
assert(state.health == 100, "Default health should be 100")
assert(state.mana == 50, "Default mana should be 50")
assert(state.stamina == 80, "Default stamina should be 80")
assert(state.ink_power == 0, "Default ink power should be 0")

-- Test set_health
trainer.set_health(500)
state = trainer.get_state()
assert(state.health == 500, "Health should be 500 after set")
trainer.set_health(-10)
state = trainer.get_state()
assert(state.health == 0, "Health should clamp to 0")
trainer.set_health(99999)
state = trainer.get_state()
assert(state.health == 9999, "Health should cap at 9999")

-- Test set_mana
trainer.set_mana(200)
state = trainer.get_state()
assert(state.mana == 200, "Mana should be 200")
trainer.set_mana(-5)
state = trainer.get_state()
assert(state.mana == 0, "Mana should clamp to 0")

-- Test set_stamina
trainer.set_stamina(150)
state = trainer.get_state()
assert(state.stamina == 150, "Stamina should be 150")

-- Test freeze_ink_power
local result = trainer.freeze_ink_power()
assert(result == true, "freeze_ink_power should return true")
state = trainer.get_state()
assert(state.ink_power == 9999, "Ink power should be 9999 after freeze")

-- Test network connection (optional, may fail if no server)
local udp, err = trainer.connect("127.0.0.1", 8080)
if udp then
  local resp, err2 = trainer.send_command(udp, "ping", 1)
  if resp then
    print("[TEST] Network communication successful")
  else
    print("[TEST] Network send failed: " .. (err2 or "unknown"))
  end
  udp:close()
else
  print("[TEST] Network connection unavailable: " .. (err or "unknown"))
end

print("[TEST] All trainer tests passed!")
os.exit(0)