local hook = {}
local trainer = require("trainer")
local gui = require("gui")

local hooked = false

function hook.attach()
  if hooked then
    print("[Hook] Already attached")
    return false
  end
  
  hooked = true
  print("[Hook] Attached to Realm of Ink process")
  
  local udp, err = trainer.connect("127.0.0.1", 8080)
  if udp then
    print("[Hook] Network connection established")
  else
    print("[Hook] Network unavailable: " .. (err or "unknown"))
  end
  
  return true
end

function hook.detach()
  if not hooked then
    print("[Hook] Not attached")
    return false
  end
  
  hooked = false
  print("[Hook] Detached from process")
  return true
end

function hook.is_hooked()
  return hooked
end

function hook.toggle_menu()
  gui.toggle()
end

function hook.process_frame()
  if not hooked then return end
  
  -- Simulate frame processing
  local state = trainer.get_state()
  if state.ink_power == 9999 then
    -- Keep ink power frozen each frame
    state.ink_power = 9999
  end
  
  if gui.is_open() then
    gui.display()
  end
end

return hook