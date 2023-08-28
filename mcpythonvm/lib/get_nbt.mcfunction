$data modify storage pvm:getnbt_single return.data set from $(source) $(target) $(path)
$data modify storage pvm:getnbt_single return.type set value "$(type)"
$data modify storage pvm:getnbt_single return.$(type) set value 1