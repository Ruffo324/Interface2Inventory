-- Script for updateing the full I2I source.
setTextColor(colors.green)
print("Deleting files..")
setTextColor(colors.white)
shell.run("delete", "Console")
shell.run("delete", "Utils")
shell.run("delete", "makelist")
shell.run("delete", "itemExporter")
shell.run("delete", "update")

shell.run("installer")
setTextColor(colors.green)
print("Done.")