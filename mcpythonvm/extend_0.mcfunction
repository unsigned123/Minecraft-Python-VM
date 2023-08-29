#combines TOS1(left arg) and TOS(right arg)
#get len(TOS)
execute store result score vm counter run data get storage pvm:argbuf buf[0].data
function pvm:lib/extend_loop
data modify storage pvm:extend return set from storage pvm:argbuf buf[1]
#due to direct calls in bytecode LIST_EXTEND and BINARAY_OP's call,the cleanup must be done manually other than by the caller automatically
data modify storage pvm:argbuf buf set value []