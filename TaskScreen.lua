os.loadAPI("dnd_util")
os.loadAPI("Env")
os.loadAPI("MainScreen")

TaskScreen = {}
TaskScreen.__index = TaskScreen

local answer = ""

function TaskScreen.create()
   local self = setmetatable({},TaskScreen)
   self.name = "KORWIN"
   return self
end

function TaskScreen:draw()
  dnd_util.printCenterCon(" === TASKS === ")
  dnd_util.printCenterCon("1. Add")
  dnd_util.printCenterCon("2. Remove")
  dnd_util.printCenterCon("3. Update")
  dnd_util.printCenterCon("4. Back")
  dnd_util.printCenterCon("Answer: " .. answer)
  dnd_util.printCenterCon("- Choose menu -")
  dnd_util.printCenterCon(dnd_util.input)
end

function TaskScreen:update()
  
end

function TaskScreen:handleEvent(event, param1, param2, param3)
  if event == "char" then
   dnd_util.handleChar(param1)
  elseif event == "key" then
   if param1 == keys.enter then
      if dnd_util.input == "4" then
        dnd_util.input = ""
        Env.currentScreen = MainScreen.MainScreen.create()
      end
   else
    dnd_util.handleKey(param1)
   end
  end
end


Env.currentScreen = TaskScreen.create()