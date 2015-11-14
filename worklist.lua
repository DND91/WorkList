

-- I'M KORWIN A RETARTED WORKSHOP LIST!!

-- VARIABELS --

local monitor = peripheral.wrap("left")
local running = true
local str = ""

local tableWidth = 40
local tableHeight = 4

local cells = {}

Cell = {}
Cell.__index = Cell

function Cell.create()          -- our new object
   local self = setmetatable({},Cell)  -- make Account handle lookup
   self.status = "Nonactive"      -- initialize our object
   self.task = "X"
   self.worker = "none"
   return self
end

function Cell:printCell()
  local x, y = monitor.getCursorPos()
  local w,h = monitor.getSize()
  printStr(repeats("=", tableWidth))
  for i=1, tableHeight-1, 1 do
    monitor.setCursorPos(x,y+i)
    printStr("||")
    monitor.setCursorPos(x+tableWidth-2,y+i)
    printStr("||")
  end
  monitor.setCursorPos(x,y+tableHeight)
  printStr(repeats("=", tableWidth))
  monitor.setCursorPos(x+(tableWidth-#self.status)/2,y+(tableHeight/2)-1)
  printStr(self.status)
  monitor.setCursorPos(x+(tableWidth-#self.task)/2,y+(tableHeight/2))
  printStr(self.task)
  monitor.setCursorPos(x+(tableWidth-#self.worker)/2,y+(tableHeight/2)+1)
  printStr(self.worker)
end

for i=0,20,1 do
  table.insert(cells, Cell.create())
end

-- FUNCTIONS --
 
function repeats(s, n) return n > 0 and s .. repeats(s, n-1) or "" end

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

function moveDown()
  local x, y = monitor.getCursorPos()
  monitor.setCursorPos(1,y+1)
end

function printStr(str)
  for c in str:gmatch"." do
    if c == "\n" then
      moveDown()
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

function printTableMonitor()
  local w,h = monitor.getSize()
  local x, y = monitor.getCursorPos()
  
  for key,cell in pairs(cells) do
    monitor.setCursorPos(x,y)
    cell:printCell()
    x = x + tableWidth
    if w <= (x+tableWidth) then
      y = y + tableHeight
      x = 1
      if h <= (y + 2*tableHeight) then
        return
      end
    end
  end
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
  monitor.clear()
  monitor.setCursorPos(2,2)
  printTableMonitor()
end


-- PRINT FUNCTION
-- INPUT FUNCTION
-- INPUT TO CHAR CONVERTER
-- MAIN LOOP WITH MENU
-- SAVE/LOAD FILE; WORKLIST TABLE
-- BUTTON HANDLER FUNCTION





















