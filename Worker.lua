Worker = {}
Worker.__index = Worker

function Worker.create()          -- our new object
   local self = setmetatable({},Worker)  -- make Account handle lookup
   self.name = "NAME"      -- initialize our object
   self.abre = "NAM"
   self.color = colors.green
   return self
end

function Worker:printWorker()
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
  
  monitor.setTextColor(self.color)
  
  monitor.setCursorPos(x+(tableWidth-#self.name)/2,y+(tableHeight/2)-1)
  printinput(self.name)
  
  monitor.setCursorPos(x+(tableWidth-#self.abre)/2,y+(tableHeight/2))
  printinput(self.abre)
  
  monitor.setCursorPos(x+(tableWidth-#tostring(self.color))/2,y+(tableHeight/2)+1)
  printinput(tostring(self.color))
  
  monitor.setTextColor(colors.white)
end