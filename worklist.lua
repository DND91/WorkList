




local monitor = peripheral.wrap("left")


local running = true
while running do
  local event, str = os.pullEvent( "char" ) -- limit os.pullEvent to the 'key' event
  monitor.clear()
  monitor.setCursorPos(1,1)
  monitor.write(str)
end


-- PRINT FUNCTION
-- INPUT FUNCTION
-- MAIN LOOP WITH MENU
-- SAVE/LOAD FILE; WORKLIST TABLE
-- BUTTON HANDLER FUNCTION





















