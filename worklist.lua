




local monitor = peripheral.wrap("left")
local running = true
local str = ""

while running do
  local event, s = os.pullEvent( "char" ) -- limit os.pullEvent to the 'key' event
  str = str .. s
  monitor.clear()
  monitor.setCursorPos(1,1)
  monitor.write(str)
end


-- PRINT FUNCTION
-- INPUT FUNCTION
-- MAIN LOOP WITH MENU
-- SAVE/LOAD FILE; WORKLIST TABLE
-- BUTTON HANDLER FUNCTION





















