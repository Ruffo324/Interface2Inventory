--- Script for installing Interface2Inventory.
--- Don't remove this script, or change anything in here.
local thisRepoName = "Interface2Inventory"

-- Try removing the old Interface2Inventory installer.
term.setTextColor(colors.green)
print("Try removing old installer")
term.setTextColor(colors.gray)
shell.run("delete", "installer")

-- Download Interface2Inventory files.
term.setTextColor(colors.green)
print("Downloading \"" .. thisRepoName .. "\" files..")
term.setTextColor(colors.gray)
shell.run("/openp/github", "get", "ToTheCore/" .. thisRepoName .. "/master/installer.lua","/" .. thisRepoName .. "/installer")
shell.run("/openp/github", "get", "ToTheCore/" .. thisRepoName .. "/master/updater.lua","/" .. thisRepoName .. "/updater")
shell.run("/openp/github", "get", "ToTheCore/" .. thisRepoName .. "/master/makelist.lua","/" .. thisRepoName .. "/makelist")
shell.run("/openp/github", "get", "ToTheCore/" .. thisRepoName .. "/master/itemExporter.lua","/" .. thisRepoName .. "/itemExporter")