-- Script for installing I2I
-- Not in I2I directory -> error.
if(shell.resolve("./") ~= "I2I") then
  error("Only the subfolder \"I2I\" is allowed for I2I.")
end

-- Try removing the old I2I installer.
term.setTextColor(colors.green)
print("Try removing old installer")
term.setTextColor(colors.white)
shell.run("delete", "installer")

-- Download new files.
term.setTextColor(colors.green)
print("Downloading files..")
term.setTextColor(colors.white)
shell.run("../openp/github", "get", "Ruffo324/Interface2Inventory/master/installer.lua","installer")
shell.run("../openp/github", "get", "Ruffo324/Interface2Inventory/master/updater.lua","updater")
shell.run("../openp/github", "get", "Ruffo324/Interface2Inventory/master/Console.lua","Console")
shell.run("../openp/github", "get", "Ruffo324/Interface2Inventory/master/Utils.lua","Utils")
shell.run("../openp/github", "get", "Ruffo324/Interface2Inventory/master/makelist.lua","makelist")
shell.run("../openp/github", "get", "Ruffo324/Interface2Inventory/master/itemExporter.lua","itemExporter")