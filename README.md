# Important
I'm (Ruffo324) not the official author of this script. 
The scripts **"makelist"** and **"I2I"** are based on this [Source](http://www.computercraft.info/forums2/index.php?/topic/24612-applied-energistics-item-exporter/). So the idea, and the base script comes from the author **[zacherl1990](http://www.computercraft.info/forums2/index.php?/user/18374-zacherl1990/)**.

The script is written for the [**To The Core**](https://www.technicpack.net/modpack/to-the-core-official.1293279) *Technic Launcher* modpack.


# Installation
Create a new folder in the root 
```shell
mkdir I2I
cd I2I
/openp/github get ToTheCore/Interface2Inventory/master/installer.lua installer
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
## Script "makelist"
To quickly and easily create a configuration file for I2I, there is the **"makelist"** command.
```shell
makelist [side]
```

## Script "itemExporter"
```shell
itemExporter
```

# Details
## "items.cfg" table format


