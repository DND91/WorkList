


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

