#append the right arg(0) to the left arg(1)
data modify storage pvm:argbuf buf[1].data append from storage pvm:argbuf buf[0]
data modify storage pvm:append return set from storage pvm:argbuf buf[1]
#due to direct calls in bytecode call,the cleanup must be done manually other than by the caller automatically
data modify storage pvm:argbuf buf set value []