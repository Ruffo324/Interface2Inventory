-- Script for updateing the full I2I source.
-- Not in I2I directory -> error.
if(shell.resolve("./") ~= "I2I") then
  error("Only the subfolder \"I2I\" is allowed for I2I.")
end

-- Delete old files.
term.setTextColor(colors.green)
print("Deleting files..")
term.setTextColor(colors.white)
shell.run("delete", "/I2I/Console")
shell.run("delete", "/I2I/Utils")
shell.run("delete", "/I2I/makelist")
shell.run("delete", "/I2I/itemExporter")
shell.run("delete", "/I2I/updater")

-- Runn installer to get all new files.
shell.run("installer")
term.setTextColor(colors.green)
print("Done.")