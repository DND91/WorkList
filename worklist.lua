

-- I'M KORWIN A RETARTED WORKSHOP LIST!!


local monitor = peripheral.wrap("left")
local running = true
local str = ""

function keyToChar(key)
  if key == keys.enter then
    return "\n"
  elseif key == keys.space then
    return " "
  elseif key == keys.backspace and str ~= "" then
    str = string.sub(str,1,#str-1)
    return ""
  else
    return ""
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

function handleKey(key, isHeld)
  local c = keyToChar(key)
  str = str .. c
end

function handleChar(c)
  str = str .. c
end

while running do -- MAIN LOOP
  local event, param1, param2, param3 = os.pullEvent()
  -- local event, key, isHeld = os.pullEvent("key")
  -- EVENT HANDLING
  if event == "char" then
    handleChar(param1)
  elseif event == "key" then
    handleKey(param1, param2)
  end
  -- BODY
  shell.run("clear")
  print(str)
  printClearStr(str)
end


-- PRINT FUNCTION
-- INPUT FUNCTION
-- INPUT TO CHAR CONVERTER
-- MAIN LOOP WITH MENU
-- SAVE/LOAD FILE; WORKLIST TABLE
-- BUTTON HANDLER FUNCTION





















