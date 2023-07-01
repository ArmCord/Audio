import denim
import std/strformat
import nimpy
let pulsectl = pyImport("pulsectl")
let pyaudio = pyImport("pyaudio")
var pa = pulsectl.Pulse("armcord-screenshare-cable")
    
init proc(module: Module) =
  proc getWindowNames() {.export_napi} =
    var e = """{"windowNames":["""
    for sink in pa.sink_input_list():
      e = fmt"""{e}"{sink.name}","""
    return  %*(e[.. ^2] & "]}")
  proc getOutputNames() {.export_napi} =
    var e = """{"outputNames":["""
    for source in pa.source_list():
      e = fmt"""{e}"{source.name}","""
    return  %*(e[.. ^2] & "]}")
  proc startAudioDevice(sourceName:string, sinkName:string) {.export_napi} =
    var source: PyObject
    var sink: PyObject
    for s in pa.source_list(): 
      if (args.get("sourceName").getStr == s.name.to(string)):
        source = s
    for s in pa.sink_list(): 
      if (args.get("sinkName").getStr == s.name.to(string)):
        sink = s
    discard pa.source_output_new(source, sink, stream_name="armcord-screenshare-output")
    discard pa.event_listen()

  var awesome {.export_napi.} = "Nim is Awesome!"