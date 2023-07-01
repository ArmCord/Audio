# Package

version       = "0.1.0"
author        = "smartfrigde"
description   = "Pulseaudio based solution for screensharing"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["Audio"]


# Dependencies

requires "nim >= 1.6.14", "nimpy == 0.2.0", "denim == 0.1.6"

task napi, "Build a .node addon and run it":
  exec "denim build src/Audio.nim -yes"
  exec "node index.js"

task installPyDeps, "Install Python depedencies":
  exec "pip install pyaudio pulsectl"