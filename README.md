# Important
I am not the official author of this script. 
The scripts **"makelist"** and **"I2I"** are based on this [Source](http://www.computercraft.info/forums2/index.php?/topic/24612-applied-energistics-item-exporter/). So the idea, and the base script comes from the author **[zacherl1990](http://www.computercraft.info/forums2/index.php?/user/18374-zacherl1990/)**.

The script is written for the [**To The Core**](https://www.technicpack.net/modpack/to-the-core-official.1293279) *Technic Launcher* modpack.


# Installation
Create a new folder in the root 
```shell
mkdir I2I
cd I2I
/openp/github get Ruffo324/Interface2Inventory/master/installer.lua installer
```

# Update
```shell
cd /I2I
updater
```
or
```shell
I2I/updater
```


# Add to autostart
Create a new file in root directory.
```shell
edit startup
```

Add the following to the startupscript.
```shell
shell.run("I2I/itemexporter")
```
That's all. 



# How to use
### Script "makelist"
To quickly and easily create a configuration file for I2I, there is the **"makelist"** command.
```shell

makelist [side]
```

### Script "itemExporter"
```shell
itemExporter
```


*TODO: Write this comments down into readme file*
```Lua
--================================================================================================--
--
--  Applied Energistics Item Exporter

--  Version 0.2a
--
--  Original Author : Zacherl
--  Modifications   : Miscellaniuz
--
--================================================================================================--
--
-- This program was designed to work with the mods and versions in the "FTB Infinity 1.10.1" pack.
-- It was edited to work with the ToTheCore Official Modpack.
--	
-- Features:
--  * Periodically exports items from an Applied Energistics ME Interface to an adjacent inventory
--  * Ability to preserve a certain amount of items in the system.
--
-- Table format (items.cfg):
-- {
  --   {
    --     fingerprint = {
      --       id = "minecraft:gold_ore",
--       dmg = 0,
--       nbt_hash = "3288456351062a1d4b01b5774241a664"
--     },
--     name = "Gold Ore",
--     preserve = 1000,
--   },
-- }
--
-- The "dmg" and "nbt_hash" fields are optional. Just remove them to ignore damage values and
-- NBT data for the specified item.
--
--================================================================================================--
```

#### makelist head commentary.
```lua
--================================================================================================--
--
--  Applied Energistics Item Exporter
--  Version 0.1
--
--  Original Author : Zacherl
--  Modifications   : 
--
--================================================================================================--
-- 
-- This program was designed to work with the mods and versions in the "FTB Infinity 1.10.1" pack.
--
--================================================================================================--

```


# Todo
Write readme file complete.