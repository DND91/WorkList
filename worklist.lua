
os.loadAPI("touchpoint")
os.loadAPI("dnd_util")
os.loadAPI("Task")
os.loadAPI("Worker")
os.loadAPI("MainScreen")

-- I'M KORWIN A RETARTED WORKSHOP LIST!!

-- VARIABELS --

local taskMode = true

local monitor = peripheral.wrap("left")
local tp = touchpoint.new("left")


local w, h = monitor.getSize()

function toggleMode() 
  taskMode = not taskMode 
  if taskMode then
    tp:rename("Workers", "Tasks")
  else
    tp:rename("Tasks", "Workers")
  end
end

tp:add("Tasks", toggleMode, 2, h-3, 11, h-1, colors.red, colors.lime)

local running = true
local input = ""
local answer = ""

local screennr = 0

local temp = nil

local tableWidth = 36
local tableHeight = 4
local tableSpace = 1

-- table.insert(workers, temp)
function loadWorkers()
  local data = loadTable("workers.save")
  local workers = {}
  
  for _, v in pairs(data) do
    local worker = Worker.create()
    worker.name = v.name
    worker.abre = v.abre
    worker.color = v.color
    table.insert(workers, worker)
  end
  
  return workers
end

function loadTasks()
  local data = loadTable("tasks.save")
  local tasks = {}
  
  for _, v in pairs(data) do
    local task = Task.create()
    task.status = v.status
    task.task = v.task
    task.worker = v.worker
    table.insert(tasks, task)
  end
  
  return tasks
end

local tasks = loadTasks()
local workers = loadWorkers()

-- DEBUG SETUP --

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
          elseif temp.abre == nil then
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

function printTaskTable()
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

function printWorkerTable()
  local w,h = monitor.getSize()
  local x, y = monitor.getCursorPos()
  local sx = x
  
  for key,cell in pairs(workers) do
    monitor.setCursorPos(x,y)
    cell:printWorker()
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
      table.insert(workers, temp)
      temp = nil
      saveTable("workers.save", workers)
    end
    input = ""
    return ""
  end
  
  return "\n"
end



while running do -- MAIN LOOP
  local event, param1, param2, param3 = tp:handleEvents(os.pullEvent())
  -- local event, key, isHeld = os.pullEvent("key")
  -- EVENT HANDLING
  -- if event == "char" then
  --  handleChar(param1)
  -- elseif event == "key" then
  --  handleKey(param1, param2)
  if event == "button_click" then
    tp:toggleButton(param1)
    tp.buttonList[param1].func()
  else
    currentScreen:event(event, param1, param2, param3)
  end
  -- BODY
  
  currentScreen:update()
  
  -- MONITOR
  
  monitor.clear()
  tp:draw()
  local w,h = monitor.getSize()
  local x = (w - math.floor(w/(tableWidth+tableSpace)) * (tableWidth+tableSpace)) / 2 + 1
  
  monitor.setCursorPos(x,tableSpace)
  monitor.setTextColor(colors.white)
  monitor.setBackgroundColor(colors.black)
  
  if taskMode then
    printTaskTable()
  else
    printWorkerTable()
  end
  
  -- CONSOLE
  shell.run("clear")
  term.setCursorPos(1, 1)
  -- screenHandler()
  currentScreen:draw()
end


-- PRINT FUNCTION
-- INPUT FUNCTION
-- INPUT TO CHAR CONVERTER
-- MAIN LOOP WITH MENU
-- SAVE/LOAD FILE; WORKLIST TABLE
-- BUTTON HANDLER FUNCTION





















