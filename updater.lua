-- Script for updateing the full I2I source.
-- Not in I2I directory -> error.
if(shell.resolve("./") ~= "I2I") then
  error("Only the subfolder \"I2I\" is allowed for I2I.")
end


-- Delete old files.
setTextColor(colors.green)
print("Deleting files..")
setTextColor(colors.white)
shell.run("delete", "Console")
shell.run("delete", "Utils")
shell.run("delete", "makelist")
shell.run("delete", "itemExporter")
shell.run("delete", "updater")

-- Runn installer to get all new files.
shell.run("installer")
setTextColor(colors.green)
print("Done.")