os.loadAPI("dnd_util")
os.loadAPI("Env")

MainScreen = {}
MainScreen.__index = MainScreen

local answer = ""

function MainScreen.create()
   local self = setmetatable({},MainScreen)
   self.name = "KORWIN"
   return self
end

function MainScreen:draw()
  dnd_util.printCenterCon(" === MENU === ")
  dnd_util.printCenterCon("1. Tasks")
  dnd_util.printCenterCon("2. Workers")
  dnd_util.printCenterCon("3. Exit")
  dnd_util.printCenterCon("Answer: " .. answer)
  dnd_util.printCenterCon("- Choose menu -")
  dnd_util.printCenterCon(dnd_util.input)
end

function MainScreen:update()
  
end

function MainScreen:handleEvent(event, param1, param2, param3)
  if event == "char" then
   dnd_util.handleChar(param1)
  elseif event == "key" then
   if param1 == keys.enter then
    
   else
    dnd_util.handleKey(param1)
   end
  end
end


Env.currentScreen = MainScreen.create()