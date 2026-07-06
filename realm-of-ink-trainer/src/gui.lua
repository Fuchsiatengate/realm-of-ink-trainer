local gui = {}
local trainer = require("trainer")

local menu_open = false

function gui.toggle()
  menu_open = not menu_open
  if menu_open then
    print("[GUI] Trainer menu opened")
  else
    print("[GUI] Trainer menu closed")
  end
end

function gui.is_open()
  return menu_open
end

function gui.display()
  if not menu_open then return end
  
  print("=== Realm of Ink Trainer ===")
  local state = trainer.get_state()
  print("Health: " .. state.health)
  print("Mana: " .. state.mana)
  print("Stamina: " .. state.stamina)
  print("Ink Power: " .. state.ink_power)
  print("===========================")
  print("1) Set Health to 9999")
  print("2) Set Mana to 9999")
  print("3) Set Stamina to 9999")
  print("4) Freeze Ink Power")
  print("5) Toggle Menu")
end

function gui.handle_input(key)
  if key == "1" then
    trainer.set_health(9999)
    print("[GUI] Health set to 9999")
  elseif key == "2" then
    trainer.set_mana(9999)
    print("[GUI] Mana set to 9999")
  elseif key == "3" then
    trainer.set_stamina(9999)
    print("[GUI] Stamina set to 9999")
  elseif key == "4" then
    trainer.freeze_ink_power()
    print("[GUI] Ink Power frozen")
  elseif key == "5" then
    gui.toggle()
  end
end

return gui