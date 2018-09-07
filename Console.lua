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
  Line = "------",
  Config = "Config",
  Hint = "Hint"
}

ColorType = {
  Info = colors.green,
  Warn = colors.yellow,
  Error = colors.red,
  Init = colors.orange,
  Debug = colors.cyan,
  Line = colors.gray,
  Config = colors.lime,
  Hint = colors.blue
}

local longestTypeTextLength = 0
local consoleWidth = 0 -- Automatic setting in Init()
local consoleHeight = 0 -- Automatic setting in Init()

--- Initalize the console api.
--- Gets then length of the longest type text.
function Init()
  for key, value in pairs(Type) do
    if (#value > longestTypeTextLength) then
      longestTypeTextLength = #value
    end
  end

  -- TODO: Check if the console height&width is constant after startup.
  -- Remember console size.
  consoleWidth, consoleHeight = term.getSize()
end

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
  -- Check msgType.
  IsValidType(msgType)

  for key1, value1 in pairs(Type) do
    if (value1 == msgType) then
      for key2, value2 in pairs(ColorType) do
        if (key1 == key2) then
          return value2
        end
      end
    end
  end

 -- There is no color for the given type -> error.
 error("[FATAL ERROR][CONSOLE] The type \"" .. msgType.. "\" has no \"Console.ColorType\".")
end

--- Sets the console text color to the given colorStr.
function SetTextColor(colorStr)
  term.setTextColor(colorStr)
end

--- Returns the message day and time head part.
--- "[XX, XX:XX]"
-- @returns Color free string with this format: "[XX, XX:XX]".
function getHeadDayTime()
  return Utils.padRight(os.day() .. " " -- Minecraft world day.
  .. textutils.formatTime(os.time(), true)  -- Current time in 24H
  .. " | ", 8 + #tostring(os.day()))
end

--TODO: Rewrite this with function "cleanDurtyString(coloredString)".. [CleanerCode]
--- Returns the string length for the message head. 
--- "[12, XX:XX][TYPE]   "
--- Without color codes.
-- @returns The length of the full message head without colors.
function getMessageHeadLength(msgType)
  -- Check msgType.
  IsValidType(msgType)

  -- Write message type with correct spacing for table like look and return length of it.
  local messageHeadLength = #getHeadDayTime()
  local typeTextSpacing = Utils.padRight("", longestTypeTextLength - #msgType) .. " | "
  return messageHeadLength + #msgType + #typeTextSpacing
end

--- Writes a new line to the console output. Formated with the Type and time.
-- @param msgType {Console.Type} The type of the message.
-- @param message {string} The output string.
function WriteLine(msgType, message)
  -- Check msgType.
  IsValidType(msgType)

  -- Write day, time in gray.
  SetTextColor(colors.lightGray)
  write(getHeadDayTime()) -- Correct padRight, added day length.

  -- Write message type with correct color code and correct spacing for table like look.
  local typeText = msgType
  local typeTextSpacing = Utils.padRight("", longestTypeTextLength - #msgType)
  SetTextColor(GetColorForType(msgType))
  write(msgType)
  SetTextColor(colors.lightGray)
  write(typeTextSpacing)
  write("|")
 
  -- Message is line -> gray message color.
  if(msgType == Type.Line) then
    SetTextColor(colors.gray)
  else --> Other messages -> white message color.
    SetTextColor(colors.white)
  end
  
  -- Write message with print to add linefeed at the end.
  print(message)
end

--- Prints a line with length perfect length to cut the console. 
-- @param[opt="-"] printChr Char for the printed line.
function PrintLine(printChr)
  printChr = printChr or "-"
  -- printChr is more than one char -> error.
  if(#printChr ~= 1) then
    error("[FATAL ERROR][CONSOLE]The parameter \"printChr\" must be a string with a length of exactly one.")
  end


  WriteLine(Type.Line, Utils.padRight("", consoleWidth - getMessageHeadLength(Type.Line), printChr))
end

--- Workaround for os.execute("clear")
--- Function just flooded the console with empty prints.
function ClearScreen()
  for i = 1, 255 do
    print()
  end
end



-- Call of init function
Init()