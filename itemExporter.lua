-- Resolve relative path for "Console".
local ConsoleLibaryPath = "I2I/Console"
-- "Console.lua" not found -> error.
if (not fs.exists(ConsoleLibaryPath)) then
  error("[FATAL ERROR] Can't find libary \"" .. ConsoleLibaryPath .. "\".")
end
-- "Console.lua" not loadable -> error.
if(not os.loadAPI(ConsoleLibaryPath)) then
  error("[FATAL ERROR] Can't load libary \"" .. ConsoleLibaryPath .. "\".")
end

-- Configuration variables, overwritten by "./I2Iconfig".
-- This are the default values for new config files.
local interfaceSide             = "back" 
local exportDirection           = "east" 
local tickInterval              = 5 
local itemsConfigurationFile    = "./items.cfg" 

-- Internal variables
local interface = peripheral.wrap(interfaceSide)
local exports   = {}

-- Main
local function mainTick()
  local items = interface.getAvailableItems()
  for index, item in pairs(exports) do
    local fingerprint = {}
    local itemCount = 0
    for _, a in pairs(items) do
      if ((a.fingerprint.id == item.fingerprint.id) and 
          ((item.fingerprint.dmg == nil) or (a.fingerprint.dmg == item.fingerprint.dmg)) and 
          ((item.fingerprint.nbt_hash == nil) or 
          (a.fingerprint.nbt_hash == item.fingerprint.nbt_hash))) 
      then
        fingerprint = a.fingerprint
        itemCount = a.size
        break
      end
    end

    itemCount = itemCount - item.preserve
    if (itemCount > 0) then
      Console.WriteLine(Console.Type.Export, fingerprint.id .. "[".. itemCount .. "/" .. item.preserve .. "]")
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
            Console.WriteLine(Console.Type.Error, "Container space exceeded.")
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

--- Gets the settings from the "I2I.cfg" file.
--- If there is no settings file, it creates one.
function getOrCreateSettingsFile()
  local settingsFilePath = shell.resolve("./I2Iconfig")

  -- There is no settings file? -> create one.
  if (not fs.exists(settingsFilePath)) then
    Console.WriteLine(Console.Type.Warn, "There is not \"./I2Iconfig\" file.")
    Console.WriteLine(Console.Type.Hint, "Creating new \"./I2Iconfig\"")
    Console.WriteLine(Console.Type.Hint, "with default settings..")

    local file = io.open(settingsFilePath, "w")
    file:write("interfaceSide = \"" .. interfaceSide .."\" -- The name or side of the ME Interface.\n")
    file:write("exportDirection = \"" .. exportDirection .."\" -- The export direction (target inventory) relative to the ME Interface.\n")
    file:write("tickInterval = " .. tickInterval .." -- The export program tick interval. Recommended range is between 5 and 60 seconds.\n")
    file:write("itemsConfigurationFile = \"" .. itemsConfigurationFile .."\" -- The file where the item-rules are setten. \n")
    file:close()
    Console.WriteLine(Console.Type.Hint, "done.")
  end    

  -- Load settings file
  Console.WriteLine(Console.Type.Init, "Loading config \"./I2Iconfig\".")
  os.loadAPI(settingsFilePath)
  interfaceSide = I2Iconfig.interfaceSide
  exportDirection = I2Iconfig.exportDirection
  tickInterval = I2Iconfig.tickInterval
  itemsConfigurationFile = I2Iconfig.itemsConfigurationFile

  -- Write values of settings to console
  Console.WriteLine(Console.Type.Config, "Interface side:   " .. interfaceSide)
  Console.WriteLine(Console.Type.Config, "Export direction: " .. exportDirection)
  Console.WriteLine(Console.Type.Config, "Tick interval:    " .. tickInterval)
  Console.WriteLine(Console.Type.Config, "Items config:     " .. itemsConfigurationFile)
end

--- Does all the things that are needed on Server startup.
--- Also giving advanced console output.
local function ServerStartup()
  -- Clear console and write startup things.
  Console.ClearScreen()
  Console.PrintLine("-")
  getOrCreateSettingsFile()
  Console.PrintLine("-")

  -- Parse interfaces.
  Console.WriteLine(Console.Type.Init, "Parsing given interface.")
  interface = peripheral.wrap(interfaceSide)

  -- Read "items.cfg"
  local itemsCfgPath = shell.resolve(itemsConfigurationFile)
  Console.WriteLine(Console.Type.Init, "Reading \"" .. itemsCfgPath .. "\".")
  -- File "items.cfg" does not exist -> error.
  if (not fs.exists(itemsCfgPath)) then
    error("There is no \"" .. itemsCfgPath .. "\" file.")
  end
  -- Load and serialize items.cfg.
  local f = fs.open(itemsCfgPath, "r")
  exports = textutils.unserialise(f.readAll())
  f.close()

  -- Startup done.
  Console.WriteLine(Console.Type.Info, "Startup done.")
  Console.PrintLine("-")
end

--- Entry point of the program.
local function main()
  ServerStartup()
  Console.WriteLine(Console.Type.Hint, "Hold \"CTRL + T\" to terminate.")
  -- Begin with tick loop
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

--- Endless loop, calling entry point.
while true do
  -- Prevent "not attached" error
  pcall(main())
end