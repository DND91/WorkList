




local monitor = peripheral.wrap("left")
local running = true
local str = ""

while running do
  local event, key, isHeld = os.pullEvent("key")
  str = str .. keys.getName( key )
  monitor.clear()
  monitor.setCursorPos(1,1)
  monitor.write(str)
end


-- PRINT FUNCTION
-- INPUT FUNCTION
-- MAIN LOOP WITH MENU
-- SAVE/LOAD FILE; WORKLIST TABLE
-- BUTTON HANDLER FUNCTION





















