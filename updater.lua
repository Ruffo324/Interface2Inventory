-- Delete old files.
term.setTextColor(colors.green)
print("Deleting files..")
term.setTextColor(colors.gray)
shell.run("delete", "/Interface2Inventory/makelist")
shell.run("delete", "/Interface2Inventory/itemExporter")
shell.run("delete", "/Interface2Inventory/updater")

-- Runn installer to get all new files.
shell.run("/Interface2Inventory/installer")
term.setTextColor(colors.green)
print("Done.")