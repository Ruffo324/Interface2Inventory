-- Script for installing I2I
-- Not in I2I directory -> error.
if(shell.resolve("./") ~= "I2I") then
  -- Write error like message for user.
  term.setTextColor(colors.red)
  print("This script must runned from \"/I2I/\". Creating and changing to \"/I2I/\".")

  -- Create folder "/I2I" if it not exist.
  term.setTextColor(colors.orange)
  print("Checking existing of \"/I2I\".")
  term.setTextColor(colors.white)
  if(not fs.exists("/I2I")) then
    fs.makeDir("/I2I")
  end

  -- Moving to "/I2I".
  term.setTextColor(colors.orange)
  print("Moving to \"/I2I\".")
  term.setTextColor(colors.white)
  shell.run("cd", "/I2I")
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
shell.run("../openp/github", "get", "Ruffo324/Interface2Inventory/master/installer.lua","/I2I/installer")
shell.run("../openp/github", "get", "Ruffo324/Interface2Inventory/master/updater.lua","/I2I/updater")
shell.run("../openp/github", "get", "Ruffo324/Interface2Inventory/master/Console.lua","/I2I/Console")
shell.run("../openp/github", "get", "Ruffo324/Interface2Inventory/master/Utils.lua","/I2I/Utils")
shell.run("../openp/github", "get", "Ruffo324/Interface2Inventory/master/makelist.lua","/I2I/makelist")
shell.run("../openp/github", "get", "Ruffo324/Interface2Inventory/master/itemExporter.lua","/I2I/itemExporter")