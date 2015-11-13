

-- I'M KORWIN A RETARTED WORKSHOP LIST!!


local monitor = peripheral.wrap("left")
local running = true
local str = ""

function keyToChar(key)
  if key == keys.enter then
    return "\n"
  elseif key == keys.space then
    return " "
  else
    return keys.getName(key)
  end
end

function printClearStr(str)
  monitor.clear()
  monitor.setCursorPos(1,1)
  printStr(str)
end

function printStr(str)
  for c in str:gmatch"." do
    if c == "\n" then
      local x, y = monitor.getCursorPos()
      monitor.setCursorPos(1,y+1)
    else
      monitor.write(c)
    end
  end
end

while running do
  local event, key, isHeld = os.pullEvent("key")
  str = str .. keyToChar( key )
  printClearStr(str)
end


-- PRINT FUNCTION
-- INPUT FUNCTION
-- INPUT TO CHAR CONVERTER
-- MAIN LOOP WITH MENU
-- SAVE/LOAD FILE; WORKLIST TABLE
-- BUTTON HANDLER FUNCTION





















