extends Area2D

export (float) var SPEED = 100
var velocitat = Vector2()


func _ready():
	velocitat.x = 0
	velocitat.y = 0
	$baseSprite.play("shoot")

func _process(delta):
	_7()
	print($baseSprite.frame)
	if $baseSprite.frame > 5:
		$baseSprite.play("loop")
	velocitat.x = (delta * SPEED) * velocitat.x
	velocitat.y = (delta * SPEED) * velocitat.y
	translate(velocitat)

func _0():
	rotation_degrees = -90
	velocitat.x = 0
	velocitat.y = -1

func _1():
	rotation_degrees = -45
	velocitat.x = 1
	velocitat.y = -1

func _2():
	rotation_degrees = 0
	velocitat.x = 1
	velocitat.y = 0

func _3():
	rotation_degrees = 45
	velocitat.x = 1
	velocitat.y = 1

func _4():
	rotation_degrees = 90
	velocitat.x = 0
	velocitat.y = 1

func _5():
	rotation_degrees = 135
	velocitat.x = -1
	velocitat.y = 1

func _6():
	rotation_degrees = 180
	velocitat.x = -1
	velocitat.y = 0

func _7():
	rotation_degrees = 225
	velocitat.x = -1
	velocitat.y = -1
