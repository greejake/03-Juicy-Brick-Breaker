extends ColorRect

var c = 0
var colors = [
	Color8(0,0,0)    
	,Color8(233,37,41) 
	,Color8(532,58,64)   
	,Color8(23,480,87)   
	,Color8(152,58,64)  
	,Color8(343,317,41)   
]

func _ready():
	update_color()

func update_color():
	queue_free()

func _on_Tween_tween_all_completed():
	c = wrapi(c+1, 0, colors.size())
	update_color()
