-- Console handler
-- User for console output.

-- Path for "Console.lua".
--local UtilsLibaryPath = shell.resolve("Utils.lua")  -- TODO: Rethink this sometimes. http://computercraft.info/wiki/Os.loadAPI
local UtilsLibaryPath = "I2I/Utils"
-- "Utils.lua" not found -> error.
if (not fs.exists(UtilsLibaryPath)) then
  error("[FATAL ERROR][CONSOLE] Can't find libary \"" .. UtilsLibaryPath .. "\".")
end
-- "Utils.lua" not loadable -> error.
if(not os.loadAPI(UtilsLibaryPath)) then
  error("[FATAL ERROR][CONSOLE] Can't load libary \"" .. UtilsLibaryPath .. "\".")
end

--- Message types. Used for formatted console output.
Type = {
  Info = "Info",
  Warn = "Warn",
  Error = "Error",
  Init = "Init",
  Debug = "Debug",
  Line = "=====",
  Config = "Config",
  Hint = "Hint"
}

--- Writes a new line to the console output. Formated with the Type and time.
-- @param msgType {Console.Type} The type of the message.
-- @param message {string} The output string.
function WriteLine(msgType, message)
  -- Check msgType.
  isValidType(msgType)

  -- Build string
  local typeTextSpacing = Utils.padRight("[" .. msgType .. "]", 10)
  local finalMessage = "[Day " .. os.day() .. " - " .. textutils.formatTime(os.time(), false) .. "]"
  finalMessage = Utils.padRight(finalMessage, 20) .. typeTextSpacing .. message

  -- Print formated message.
  print(finalMessage)
end

--- Checks if the given message type is a existing Type.
-- @error: Throws error if message type is not a valid Type.
local function isValidType(msgType)
  for k in pairs(Type) do
    if (k == msgType) then
      return
    end
  end
  -- There is no same Type -> error.
  error("[FATAL ERROR][CONSOLE] The type \"" .. msgType.. "\" is not a valid \"Console.Type\".")
end

--- Prints a line with length 40 in the console. 
-- @param[opt="="] printChr Char for the printed line.
function PrintLine(printChr)
  printChr = printChr or "="
  -- printChr is more than one char -> error.
  if(#printChr ~= 1) then
    error("[FATAL ERROR][CONSOLE]The parameter \" printChr\" must be a string with a length of exactly one.")
  end
  WriteLine(Type.Line, Utils.padRight("", 40, printChr))
end

--- Workaround for os.execute("clear")
--- Function just flooded the console with empty prints.
function ClearScreen()
  for i = 1, 255 do
    print()
  end
end