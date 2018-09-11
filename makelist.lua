-- Resolve relative path for "Console".
local ConsoleLibaryPath = "/Utils/Console"
-- "Console.lua" not found -> error.
if (not fs.exists(ConsoleLibaryPath)) then
  error("[FATAL ERROR] Can't find libary \"" .. ConsoleLibaryPath .. "\".")
end
-- "Console.lua" not loadable -> error.
if(not os.loadAPI(ConsoleLibaryPath)) then
  error("[FATAL ERROR] Can't load libary \"" .. ConsoleLibaryPath .. "\".")
end


Console.ClearScreen()
Console.PrintLine()

-- Parsing arguments
local args = {...}
if (#args < 1) then
  Console.WriteLine(Console.Type.Info, "Current available peripherals:")
  local peripherals = peripheral.getNames()
  for i = 1, #peripherals do
    Console.WriteLine(Console.Type.Info, "Type: \"" .. peripheral.getType(peripherals[i]) .. "\" attached as \"".. peripherals[i] .. "\"")
  end
  Console.WriteLine(Console.Type.Error, "Usage: makelist [side]")
  error()
end

local inventory = peripheral.wrap(args[1])
local items = {}

Console.WriteLine(Console.Type.Error, "Get items from \"".. peripheral.getType(args[1]).."\" ("..args[1]..")...")
for i = 1, inventory.getInventorySize() do
  local stack = inventory.getStackInSlot(i)
  if (stack ~= nil) then
    local item = {}
    item.name = stack.display_name
    item.fingerprint = {}
    item.fingerprint.id = stack.id
    item.fingerprint.dmg = stack.dmg
    item.fingerprint.nbt_hash = stack.nbt_hash
    item.preserve = 0
    table.insert(items, item)
    Console.WriteLine(Console.Type.Export, "\""..item.name .. "\" found")
  end
end

Console.WriteLine(Console.Type.Info, "done.")
Console.PrintLine()
Console.WriteLine(Console.Type.Info, "Sorting items...")

table.sort(items, function(a, b)
  local id_a = a.fingerprint.id:lower()
  local id_b = b.fingerprint.id:lower()
  for i = 1, math.min(#id_a, #id_b) do
    if (id_a:byte(i) < id_b:byte(i)) then
      return true
    end
    if (id_a:byte(i) > id_b:byte(i)) then
      return false
    end
  end
  if (#id_a == #id_b) then
    return a.fingerprint.dmg < b.fingerprint.dmg
  end
  return #id_a < #id_b
end)

Console.WriteLine(Console.Type.Info, "done.")
Console.PrintLine()

--TODO: Make filename possible as startup parameter.
local filename = shell.resolve("items.cfg")
Console.WriteLine(Console.Type.Info, "Saving items in file \""..filename.."\"..")
local file = io.open(filename, "w")
file:write(textutils.serialise(items))
file:close()
Console.WriteLine(Console.Type.Info, "done.")