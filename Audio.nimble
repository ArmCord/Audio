# Package

version       = "0.1.0"
author        = "smartfrigde"
description   = "Pulseaudio based solution for screensharing"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["Audio"]


# Dependencies

requires "nim >= 1.6.14"

task napi, "Build a .node addon and run it":
  exec "denim build src/Audio.nim -yes"
  exec "node index.js"
