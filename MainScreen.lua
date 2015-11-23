os.loadAPI("dnd_util")
os.loadAPI("Env")

MainScreen = {}
MainScreen.__index = MainScreen

function MainScreen.create()
   local self = setmetatable({},MainScreen)
   self.name = "KORWIN"
   return self
end

function MainScreen:draw()
  printCenterCon(" === MENU === ")
  printCenterCon("1. Tasks")
  printCenterCon("2. Workers")
  printCenterCon("3. Exit")
  printCenterCon("Answer: " .. answer)
  printCenterCon("- Choose menu -")
  printCenterCon(input)
end

function MainScreen:update()
  
end

function MainScreen:event(event, param1, param2, param3)
  if event == "char" then
   handleChar(param1)
  elseif event == "key" then
   if param1 == keys.enter then
    
   else
    handleKey(param1)
   end
  end
end


Env.currentScreen = MainScreen.create()