--================================================================================================--
--
--  Applied Energistics Item Exporter
--  Version 0.1
--
--  Original Author : Zacherl
--  Modifications   : 
--
--================================================================================================--
-- 
-- This program was designed to work with the mods and versions in the "FTB Infinity 1.10.1" pack.
--
--================================================================================================--

local args = {...}
if (#args < 1) then
  print("Current available peripherals:")
  local peripherals = peripheral.getNames()
  peripheral.
  for i = 1, #peripherals do
    print("Type: \"" .. peripheral.getType(peripherals[i]) .. "\" attached as \"".. peripherals[i] .. "\".")
  end
  error("Usage: makelist [side]")
end

local inventory = peripheral.wrap(args[1])
local items = {}

print("Get items from \"".. peripheral.getType(args[1]).."\" ("..args[1]..")...");
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
    print("  > \""..item.name .. "\" found.")
  end
end
print("done.")
print("-----------------------------------------")
print("Sorting items..")
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
print("done.")
print("-----------------------------------------")
--TODO: Make filename possible as startup parameter.
local filename = shell.resolve("items.cfg")
print("Saving items in file \""..filename.."\"..")
local file =io.open(filename, "w")
file:write(textutils.serialise(items))
file:close()
print("done.")