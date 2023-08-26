data modify storage pvm:slicer slicer set value {str:"",start:0,end:0}
data modify storage pvm:slicer slicer.end set from storage pvm:argbuf buf[0].data
data modify storage pvm:slicer slicer.start set from storage pvm:argbuf buf[1].data
data modify storage pvm:slicer slicer.str set from storage pvm:argbuf buf[2].data
function pvm:lib/slicer with storage pvm:slicer slicer
data modify storage pvm:substr return set value {"data":"","type":"str","str":1}
data modify storage pvm:substr return.data set from storage pvm:slicer result