data modify storage pvm:exec exec set value {command:""}
data modify storage pvm:exec exec.command set from storage pvm:argbuf buf[0].data
function pvm:lib/exec with storage pvm:exec exec
data modify storage pvm:exec return.data set value 0