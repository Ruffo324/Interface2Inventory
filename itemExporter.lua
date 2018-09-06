--================================================================================================--
--
--  Applied Energistics Item Exporter
--  Version 0.2a
--
--  Original Author : Zacherl
--  Modifications   : Miscellaniuz
--
--================================================================================================--
--
-- This program was designed to work with the mods and versions in the "FTB Infinity 1.10.1" pack.
-- It was edited to work with the ToTheCore Official Modpack.
--	
-- Features:
--  * Periodically exports items from an Applied Energistics ME Interface to an adjacent inventory
--  * Ability to preserve a certain amount of items in the system.
--
-- Table format (items.cfg):
-- {
--   {
--     fingerprint = {
--       id = "minecraft:gold_ore",
--       dmg = 0,
--       nbt_hash = "3288456351062a1d4b01b5774241a664"
--     },
--     name = "Gold Ore",
--     preserve = 1000,
--   },
-- }
--
-- The "dmg" and "nbt_hash" fields are optional. Just remove them to ignore damage values and
-- NBT data for the specified item.
--
--================================================================================================--

-- The name or side of the ME Interface.
local interfaceSide  = "back"

-- The export direction (target inventory) relative to the ME Interface.
local exportDirection = "north"

-- The export program tick interval. Recommended range is between 5 and 60 seconds.
local tickInterval    = 5

--================================================================================================--

-- Internal variables
local interface = peripheral.wrap(interfaceSide)
local exports   = {}

-- Main
local function mainTick()
  print("Getting available items from interface \"\"")
  local items = interface.getAvailableItems()
  for index, item in pairs(exports) do
    local fingerprint = {}
    local itemCount = 0
    for _, a in pairs(items) do
      if ((a.fingerprint.id == item.fingerprint.id) and 
          ((item.fingerprint.dmg == nil) or (a.fingerprint.dmg == item.fingerprint.dmg)) and 
          ((item.fingerprint.nbt_hash == nil) or 
          (a.fingerprint.nbt_hash == item.fingerprint.nbt_hash))) then
        fingerprint = a.fingerprint
        itemCount = a.size
        break
      end
    end
    itemCount = itemCount - item.preserve
    if (itemCount > 0) then
      print("Exportiere [" .. item.name .. "]")
      print("  id      : " .. fingerprint.id)
      print("  dmg     : " .. fingerprint.dmg)
      print("  nbt_hash: " .. fingerprint.nbt_hash)
      print("  Anzahl  : " .. itemCount + item.preserve)
      print("  Mindestbestand: " .. item.preserve)
      while (itemCount > 0) do
        -- Prevent "Too long without yielding" error
        local loopTimerId = os.startTimer(0.1) 
        while (true) do
          local amount = 64
          if (itemCount < amount) then
            amount = itemCount
          end
          local status = interface.exportItem(fingerprint, exportDirection, amount)
          itemCount = itemCount - status.size
          if (status.size ~= amount) then
            print("Container space exceeded.")
            return
          end
          local event, timerId = os.pullEvent("timer")    
          if (timerId == loopTimerId) then
            break
          end
        end

      end
    end
  end
end

local function printLine()
{
  local lineStr = "==================================================="
  print(lineStr)
}

-- Prints informations about the programm settings.
local function printConstInfo()
{
  print("[SETTINGS]")  
}

local function main()
  printLine()
  printConstInfo()
  printLine() -- line
  print("[INIT] Wrapping interface.") -- Init
  interface = peripheral.wrap(interfaceSide)
  print("[INIT] Reading \"items.cfg\".")
  if (fs.exists("items.cfg")) then
    local f = fs.open("items.cfg", "r")
    exports = textutils.unserialise(f.readAll())
    f.close()
  else
    error("There is no \"items.cfg\" file.")
  end
  print("[INIT] Programm startup done.")
  printLine() -- line
  while (true) do
    mainTick()
    local loopTimerId = os.startTimer(tickInterval) 
    while (true) do
      local event, timerId = os.pullEvent("timer")    
      if (timerId == loopTimerId) then
        break
      end
    end
  end
end

while true do
  -- Prevent "not attached" error
  pcall(main())
end