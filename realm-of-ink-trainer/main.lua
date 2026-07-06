local hook = require("src.hook")
local gui = require("src.gui")

print("Realm of Ink Trainer v1.0")
print("Press F1 to toggle menu")
print("Press F2 to attach/detach")

local running = true

while running do
  -- Simulate game loop
  hook.process_frame()
  
  -- Simple input simulation (in real app, would use keyboard hooks)
  local input = io.read()
  if input == "F1" then
    hook.toggle_menu()
  elseif input == "F2" then
    if hook.is_hooked() then
      hook.detach()
    else
      hook.attach()
    end
  elseif input == "quit" or input == "exit" then
    running = false
  elseif gui.is_open() then
    gui.handle_input(input)
  end
  
  -- Small delay to prevent CPU hogging
  os.execute("sleep 0.1")
end

print("Trainer shutting down...")
if hook.is_hooked() then
  hook.detach()
end