

-- I'M KORWIN A RETARTED WORKSHOP LIST!!

-- VARIABELS --

local monitor = peripheral.wrap("left")

local running = true
local str = ""
local screennr = 0

local tableWidth = 36
local tableHeight = 4
local tableSpace = 1

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
    return screenEnterHandler()
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
  local sx = x
  
  for key,cell in pairs(cells) do
    monitor.setCursorPos(x,y)
    cell:printCell()
    x = x + tableWidth + tableSpace
    if w <= (x+tableWidth + tableSpace) then
      y = y + tableHeight + tableSpace
      x = sx
      if h <= (y + 1*(tableHeight + tableSpace)) then
        return
      end
    end
  end
end

function screenHandler()
  if screennr == 0 then
    print(" === MENU === ")
    print("1. Tasks")
    print("2. Workers")
    print("3. Status")
    print("4. Exit")
    print("Choose menu: " + str)
  end
end

function screenEnterHandler(key)
  if screennr == 0 then
    if "1" == str then -- Tasks
    
    elseif "2" == str then -- Workers
    
    elseif "3" == str then -- Status
    
    elseif "4" == str then -- Exit
      running = false
    end
    str = ""
    return ""
  end
  
  return "\n"
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
  -- MONITOR
  monitor.clear()
  local w,h = monitor.getSize()
  local x = (w - math.floor(w/(tableWidth+tableSpace)) * (tableWidth+tableSpace)) / 2 + 1
  
  monitor.setCursorPos(x,tableSpace)
  printTableMonitor()
  -- CONSOLE
  shell.run("clear")
  screenHandler()
end


-- PRINT FUNCTION
-- INPUT FUNCTION
-- INPUT TO CHAR CONVERTER
-- MAIN LOOP WITH MENU
-- SAVE/LOAD FILE; WORKLIST TABLE
-- BUTTON HANDLER FUNCTION





















