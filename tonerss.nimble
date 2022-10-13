# Package

version       = "0.1.0"
author        = "guineu"
description   = "Conseguir datos sobre tinta de impresoras"
license       = "MIT"
srcDir        = "src"
bin           = @["tonerss"]


# Dependencies

requires "nim >= 1.6.8"
requires "yaml >= 1.0.0"
requires "terminaltables >= 0.1.1"
requires "colorize"
requires "pronimgress >= 0.1.0"