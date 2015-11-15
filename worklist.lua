

-- I'M KORWIN A RETARTED WORKSHOP LIST!!

-- VARIABELS --

local monitor = peripheral.wrap("left")

local running = true
local input = ""
local answer = ""

local screennr = 0

local temp = nil

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

local tableWidth = 36
local tableHeight = 4
local tableSpace = 1

local tasks = {}

Task = {}
Task.__index = Task

function Task.create()          -- our new object
   local self = setmetatable({},Task)  -- make Account handle lookup
   self.status = "Nonactive"      -- initialize our object
   self.task = "X"
   self.worker = "none"
   return self
end

function Task:printTask()
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

local workers = {}

Worker = {}
Worker.__index = Worker

function Worker.create()          -- our new object
   local self = setmetatable({},Worker)  -- make Account handle lookup
   self.name = "NAME"      -- initialize our object
   self.abre = "NAM"
   self.color = colors.green
   return self
end


-- DEBUG SETUP --

for i=0,20,1 do
  table.insert(tasks, Task.create())
end

-- FUNCTIONS --
 
function repeats(s, n) return n > 0 and s .. repeats(s, n-1) or "" end

function keyToChar(key)
  if key == keys.enter then
    return screenEnterHandler()
  elseif key == keys.space then
    return " "
  elseif key == keys.backspace then
    if input ~= "" then
      input = string.sub(input,1,#input-1)
    else
      if screennr == 21 then
        if input == "" and temp ~= nil then
          if temp.name == nil then
            screennr = 2
          if temp.abre == nil then
            input = temp.name
            temp.name = nil
          elseif temp.color == nil then
            input = temp.abre
            temp.abre = nil
          end
          if input == nil then
            input = ""
          end
        end
      end
    end
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
  
  for key,cell in pairs(tasks) do
    monitor.setCursorPos(x,y)
    cell:printTask()
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
    printCenterCon("3. Exit")
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
  elseif screennr == 21 then -- ADD WORKER
    if temp == nil then
      temp = Worker.create()
      temp.name = nil
      temp.abre = nil
      temp.color = nil
    end
    
    printCenterCon(" === ADD WORKER === ")
    printCenterCon("Answer: " .. answer)
    
    if temp.name == nil then
      printCenterCon("- Choose Name -")
      printCenterCon(input)
      return
    else
      printCenterCon("Name: " .. temp.name)
    end
    if temp.abre == nil then
      printCenterCon("- Choose Abbrevation -")
      printCenterCon(input)
      return
    else
      printCenterCon("Abbrevation: " .. temp.abre)
    end
    if temp.color == nil then
      printCenterCon("- Choose Color -")
      printCenterCon(input)
      return
    else
      printCenterCon("Color: " .. temp.color)
    end
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
    elseif "3" == input then -- Exit
      running = false
      answer = ""
    else
      answer = "Error on input (" .. input .. ")"
    end
    input = ""
    return ""
  elseif screennr == 1 then -- TASKS
    if "1" == input then -- Add
      screennr = 11
      answer = ""
    elseif "2" == input then -- Remove
      screennr = 12
      answer = ""
    elseif "3" == input then -- Update
      screennr = 13
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
      screennr = 21
      answer = ""
    elseif "2" == input then -- Remove
      screennr = 22
      answer = ""
    elseif "3" == input then -- Update
      screennr = 23
      answer = ""
    elseif "4" == input then -- Back
      screennr = 0
      answer = ""
    else
      answer = "Error on input (" .. input .. ")"
    end
    input = ""
    return ""
  elseif screennr == 21 and temp ~= nil then -- ADD WORKER
    if temp.name == nil then
      if 2 < #input and #input <= 32 then
        temp.name = input
      else
        answer = "Name must be between 3 to 32 letters"
      end
    elseif temp.abre == nil then
      if 0 < #input and #input <= 3 then
        temp.abre = input
      else
        answer = "Abbrevation must be between 1 to 3 letters"
      end
    elseif temp.color == nil then
      local number = tonumber(input)
      temp.color = number
      screennr = 2
      answer = "Worker added..."
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





















