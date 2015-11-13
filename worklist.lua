




local monitor = peripheral.wrap("left")
local running = true
local str = ""

function keyToChar(key)
  if key == keys.enter then
    return "\n"
   else if key == keys.space then
     return " "
   else
     return keys.getName(key)
   end
end

while running do
  local event, key, isHeld = os.pullEvent("key")
  str = str .. keyToChar( key )
  monitor.clear()
  monitor.setCursorPos(1,1)
  monitor.write(str)
end


-- PRINT FUNCTION
-- INPUT FUNCTION
-- INPUT TO CHAR CONVERTER
-- MAIN LOOP WITH MENU
-- SAVE/LOAD FILE; WORKLIST TABLE
-- BUTTON HANDLER FUNCTION





















