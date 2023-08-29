data modify storage pvm:exec exec set value {command:""}
data modify storage pvm:exec exec.command set from storage pvm:argbuf buf[0].data
function pvm:lib/exec with storage pvm:exec exec
data modify storage pvm:exec return set value {"data":0,"none":1,type:"none"}