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
--- IMPORTANT: Be sure, that there is a "ColorType" for each "Type".
--- IMPORTANT: Be sure, that there is no type with text length over 8. -- @Github issue #6
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

ColorType = {
  Info = colors.green,
  Warn = colors.yellow,
  Error = colors.red,
  Init = colors.lightGray,
  Debug = colors.cyan,
  Line = colors.gray,
  Config = colors.lime,
  Hint = colors.blue
}

--- Checks if the given message type is a existing Type.
-- @error Throws error if message type is not a valid Type.
function IsValidType(msgType)
  for k,v in pairs(Type) do
    if (v == msgType) then
      return
    end
  end
  -- There is no same Type -> error.
  error("[FATAL ERROR][CONSOLE] The type \"" .. msgType.. "\" is not a valid \"Console.Type\".")
end

--- Returns the color for the given type.
-- @params msgType Wanted type.
-- @returns {string} Matching color for the given type.
-- @error Throws error if there is no matching ColorType for the given Type.
function GetColorForType(msgType)
  for k,v in pairs(ColorType) do
    if (v == msgType) then
      return k
    end
  end
 -- There is no color for the given type -> error.
 error("[FATAL ERROR][CONSOLE] The type \"" .. msgType.. "\" has no \"Console.ColorType\".")
end

--- Writes a new line to the console output. Formated with the Type and time.
-- @param msgType {Console.Type} The type of the message.
-- @param message {string} The output string.
function WriteLine(msgType, message)
  -- Check msgType.
  IsValidType(msgType)

  -- Write day, time in gray.
  SetTextColor(colors.gray)
  write(Utils.padRight("[" .. os.day() .. ", " .. textutils.formatTime(os.time(), true) .. "]", 9 + #os.day()))

  -- Write message type with correct color code.
  local typeTextSpacing = Utils.padRight("[" .. msgType .. "]", 10 - #("[" .. msgType .. "]"))
  write("[")
  SetTextColor(GetColorForType(msgType))
  SetTextColor(colors.gray)
  write("]")
  write(typeTextSpacing)
 
  -- Write message.
  SetTextColor(colors.white)
  write(finalMessage, 14))
end

--- Sets the console text color to the given colorStr.
function SetTextColor(colorStr)
  term.setTextColor(colorStr)
end


--- Prints a line with length 40 in the console. 
-- @param[opt="="] printChr Char for the printed line.
function PrintLine(printChr)
  printChr = printChr or "-"
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