-- Script for updateing the full I2I source.
shell.run("delete", "Console")
shell.run("delete", "Utils")
shell.run("delete", "makelist")
shell.run("delete", "itemExporter")
shell.run("delete", "update")

shell.run("../openp/github", "get", "Ruffo324/Interface2Inventory/master/Console.lua","Console")
shell.run("../openp/github", "get", "Ruffo324/Interface2Inventory/master/Utils.lua","Utils")
shell.run("../openp/github", "get", "Ruffo324/Interface2Inventory/master/makelist.lua","makelist")
shell.run("../openp/github", "get", "Ruffo324/Interface2Inventory/master/itemExporter.lua","itemExporter")
shell.run("../openp/github", "get", "Ruffo324/Interface2Inventory/master/update.lua","update")