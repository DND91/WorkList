
input = ""

function handleChar(c)
  dnd_util.input = dnd_util.input .. c
end


function keyToChar(key)
  if key == keys.enter then
    return "\n"
  elseif key == keys.space then
    return " "
  elseif key == keys.backspace then
    if dnd_util.input ~= "" then
      dnd_util.input = string.sub(dnd_util.input,1,#dnd_util.input-1)
    end
    return ""
  else
    return ""
  end
end

function handleKey(key, isHeld)
  local c = keyToChar(key)
  dnd_util.input = dnd_util.input .. c
end

function saveTable(name, t)
  local file = fs.open(name,"w")
  file.write(textutils.serialize(t))
  file.close()
end

function loadTable(name)
  if not fs.exists(name) then
    return {}
  end
  local file = fs.open(name,"r")
  local data = file.readAll()
  file.close()
  return textutils.unserialize(data)
end

function printCenterCon(txt)
  local x, y = term.getCursorPos()
  local w, h = term.getSize()
  term.setCursorPos(math.floor(w - #txt)/2, y)
  print(txt)
end