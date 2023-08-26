data modify storage pvm:concat concat set value {a:"",b:""}
data modify storage pvm:concat concat.a set from storage pvm:argbuf buf[1].data
data modify storage pvm:concat concat.b set from storage pvm:argbuf buf[0].data
function pvm:lib/concat with storage pvm:concat concat
data modify storage pvm:strcat return set value {"data":"","type":"str","str":1}
data modify storage pvm:strcat return.data set from storage pvm:concat result