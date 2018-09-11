-- Script for updateing the full "Interface2Inventory" source.
-- Not in "Interface2Inventory" directory -> error.
if(shell.resolve("./") ~= "Interface2Inventory") then
  error("Only the subfolder \"Interface2Inventory\" is allowed for Interface2Inventory.")
end

-- Delete old files.
term.setTextColor(colors.green)
print("Deleting files..")
term.setTextColor(colors.white)
shell.run("delete", "/Utils/Console")
shell.run("delete", "/Utils/Utils")
shell.run("delete", "/Interface2Inventory/makelist")
shell.run("delete", "/Interface2Inventory/itemExporter")
shell.run("delete", "/Interface2Inventory/updater")

-- Runn installer to get all new files.
shell.run("installer")
term.setTextColor(colors.green)
print("Done.")