extends KinematicBody2D

var target = Vector2.ZERO
export var speed = 10.0
var width = 0
var time_highlight = 0.4
var time_highlight_size = 0.3
var time_bounce = 0.75


func _ready():
	width = $CollisionShape2D.get_shape().get_extents().x
	target = Vector2(Global.VP.x / 2, Global.VP.y - 80)

func _physics_process(_delta):
	target.x = clamp(target.x, 0, Global.VP.x - 2*width)
	position = target
	var ball_container = get_node_or_null("/root/Game/Ball_Container")
	if ball_container != null and ball_container.get_child_count() > 0:
		var ball = ball_container.get_child(0)
		$Eye1/Pupil/Sprite.position.x = 7
		$Eye2/Pupil/Sprite.position.x = 7
		$Eye1/Pupil.look_at(ball.position)
		$Eye2/Pupil.look_at(ball.position)
		var d = ((($Mouth.global_position.y - ball.global_position.y)/Global.VP.y)-0.2)*2
		d = clamp(d, -1, 1)
		$Mouth.scale.y = d
	else:
		$Eye1/Pupil/Sprite.position.x = 0
		$Eye2/Pupil/Sprite.position.x = 0
		$Mouth.scale.y = 1

func _input(event):
	if event is InputEventMouseMotion:
		target.x += event.relative.x

func hit(_ball):
	$Confetti.emitting = true
	$Tween.interpolate_property($Images/Highlight, "modulate:a", 1.0, 0.0, time_highlight, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Images/Highlight, "scale", Vector2(2.0,2.0), Vector2(1.0,1.0), time_highlight_size, Tween.TRANS_BOUNCE, Tween.EASE_IN)
	$Tween.interpolate_property($Images/Sprite, "position:y", 30, 10, time_bounce, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	$Tween.start()
	var paddle_audio = get_node_or_null("/root/Game/Paddle_Audio")
	if paddle_audio != null:
		paddle_audio.play()
