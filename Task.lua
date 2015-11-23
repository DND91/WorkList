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