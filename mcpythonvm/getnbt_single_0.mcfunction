data modify storage pvm:get_nbt path set value ""
data modify storage pvm:get_nbt type set value ""
data modify storage pvm:get_nbt target set value ""
data modify storage pvm:get_nbt source set value ""

#get_nbt(source,target,type,path)

data modify storage pvm:get_nbt source set from storage pvm:argbuf buf[3].data
data modify storage pvm:get_nbt target set from storage pvm:argbuf buf[2].data
data modify storage pvm:get_nbt type set from storage pvm:argbuf buf[1].data
data modify storage pvm:get_nbt path set from storage pvm:argbuf buf[0].data
function pvm:lib/get_nbt with storage pvm:get_nbt