

-- I'M KORWIN A RETARTED WORKSHOP LIST!!

-- VARIABELS --

local monitor = peripheral.wrap("left")

local running = true
local input = ""
local answer = ""

local screennr = 0

-- screens
-- 0. main menu

-- 1. tasks

-- 11. add task
-- 12. remove task
-- 13. update task

-- 2. workers

-- 21. add worker
-- 22. remove worker
-- 23. update worker

-- 3. status

-- 31. add status
-- 32. remove status
-- 33. update status

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
  printinput(repeats("=", tableWidth))
  for i=1, tableHeight-1, 1 do
    monitor.setCursorPos(x,y+i)
    printinput("||")
    monitor.setCursorPos(x+tableWidth-2,y+i)
    printinput("||")
  end
  monitor.setCursorPos(x,y+tableHeight)
  printinput(repeats("=", tableWidth))
  monitor.setCursorPos(x+(tableWidth-#self.status)/2,y+(tableHeight/2)-1)
  printinput(self.status)
  monitor.setCursorPos(x+(tableWidth-#self.task)/2,y+(tableHeight/2))
  printinput(self.task)
  monitor.setCursorPos(x+(tableWidth-#self.worker)/2,y+(tableHeight/2)+1)
  printinput(self.worker)
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
  elseif key == keys.backspace and input ~= "" then
    input = inputing.sub(input,1,#input-1)
    return ""
  else
    return ""
  end
end

function printClearinput(input)
  monitor.clear()
  monitor.setCursorPos(1,1)
  printinput(input)
end

function moveDown()
  local x, y = monitor.getCursorPos()
  monitor.setCursorPos(1,y+1)
end

function printinput(input)
  for c in input:gmatch"." do
    if c == "\n" then
      moveDown()
    else
      monitor.write(c)
    end
  end
end

function handleKey(key, isHeld)
  local c = keyToChar(key)
  input = input .. c
end

function handleChar(c)
  input = input .. c
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

function printCenterCon(txt)
  local x, y = term.getCursorPos()
  local w, h = term.getSize()
  term.setCursorPos(math.floor(w - #txt)/2, y)
  print(txt)
end

function screenHandler()
  if screennr == 0 then -- MAIN MENU
    printCenterCon(" === MENU === ")
    printCenterCon("1. Tasks")
    printCenterCon("2. Workers")
    printCenterCon("3. Status")
    printCenterCon("4. Exit")
    printCenterCon("Answer: " .. answer)
    printCenterCon("- Choose menu -")
    printCenterCon(input)
  elseif screennr == 1 then -- TASKS
    printCenterCon(" === TASKS === ")
    printCenterCon("1. Add")
    printCenterCon("2. Remove")
    printCenterCon("3. Update")
    printCenterCon("4. Back")
    printCenterCon("Answer: " .. answer)
    printCenterCon("- Choose menu -")
    printCenterCon(input)
  elseif screennr == 2 then -- WORKERS
  printCenterCon(" === WORKERS === ")
    printCenterCon("1. Add")
    printCenterCon("2. Remove")
    printCenterCon("3. Update")
    printCenterCon("4. Back")
    printCenterCon("Answer: " .. answer)
    printCenterCon("- Choose menu -")
    printCenterCon(input)
  elseif screennr == 3 then -- STATUS
    printCenterCon(" === STATUS === ")
    printCenterCon("1. Add")
    printCenterCon("2. Remove")
    printCenterCon("3. Update")
    printCenterCon("4. Back")
    printCenterCon("Answer: " .. answer)
    printCenterCon("- Choose menu -")
    printCenterCon(input)
  end
end

function screenEnterHandler(key)
  if screennr == 0 then -- MAIN MENU
    if "1" == input then -- Tasks
      screennr = 1
      answer = ""
    elseif "2" == input then -- Workers
      screennr = 2
      answer = ""
    elseif "3" == input then -- Status
      screennr = 3
      answer = ""
    elseif "4" == input then -- Exit
      running = false
      answer = ""
    else
      answer = "Error on input (" .. input .. ")"
    end
    input = ""
    return ""
  elseif screennr == 1 then -- TASKS
    if "1" == input then -- Add
      
      answer = ""
    elseif "2" == input then -- Remove
      
      answer = ""
    elseif "3" == input then -- Update
      
      answer = ""
    elseif "4" == input then -- Back
      screennr = 0
      answer = ""
    else
      answer = "Error on input (" .. input .. ")"
    end
    input = ""
    return ""
  elseif screennr == 2 then -- WORKERS
    if "1" == input then -- Add
      
      answer = ""
    elseif "2" == input then -- Remove
      
      answer = ""
    elseif "3" == input then -- Update
      
      answer = ""
    elseif "4" == input then -- Back
      screennr = 0
      answer = ""
    else
      answer = "Error on input (" .. input .. ")"
    end
    input = ""
    return ""
  elseif screennr == 3 then -- STATUS
    if "1" == input then -- Add
      
      answer = ""
    elseif "2" == input then -- Remove
      
      answer = ""
    elseif "3" == input then -- Update
      
      answer = ""
    elseif "4" == input then -- Back
      screennr = 0
      answer = ""
    else
      answer = "Error on input (" .. input .. ")"
    end
    input = ""
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
  term.setCursorPos(1, 1)
  screenHandler()
end


-- PRINT FUNCTION
-- INPUT FUNCTION
-- INPUT TO CHAR CONVERTER
-- MAIN LOOP WITH MENU
-- SAVE/LOAD FILE; WORKLIST TABLE
-- BUTTON HANDLER FUNCTION





















