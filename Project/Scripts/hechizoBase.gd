extends Area2D

onready var player = get_parent().get_node("player")
var SPEED = 80
var velocitat = Vector2()
var multiplicador = 1
var dir = 0

func _ready():
	#velocitat.x = 0
	#velocitat.y = 0
	$baseSprite.play("shoot")
	

func _process(delta):
	print("Posicio bala =" + String(position))
	if (dir == 0):
		_0(multiplicador)
	elif (dir == 1):
		_1(multiplicador)
	elif (dir == 2):
		_2(multiplicador)
	elif (dir == 3):
		_3(multiplicador)
	elif (dir == 4):
		_4(multiplicador)
	elif (dir == 5):
		_5(multiplicador)
	elif (dir == 6):
		_6(multiplicador)
	elif (dir == 7):
		_7(multiplicador)
	if $baseSprite.frame > 5:
		$baseSprite.play("loop")
	velocitat.x = (delta * (SPEED + (multiplicador * 10))  * velocitat.x)
	velocitat.y = (delta * (SPEED + (multiplicador * 10)) * velocitat.y)
	translate(velocitat)

func _0(vel):
	rotation_degrees = -90
	velocitat.x = 0
	velocitat.y = -1
	multiplicador = vel
	dir = 0

func _1(vel):
	rotation_degrees = -45
	velocitat.x = 1
	velocitat.y = -1
	multiplicador = vel
	dir = 1

func _2(vel):
	rotation_degrees = 0
	velocitat.x = 1
	velocitat.y = 0
	multiplicador = vel
	dir = 2

func _3(vel):
	rotation_degrees = 45
	velocitat.x = 1
	velocitat.y = 1
	multiplicador = vel
	dir = 3

func _4(vel):
	rotation_degrees = 90
	velocitat.x = 0
	velocitat.y = 1
	multiplicador = vel
	dir = 4

func _5(vel):
	rotation_degrees = 135
	velocitat.x = -1
	velocitat.y = 1
	multiplicador = vel
	dir = 5

func _6(vel):
	rotation_degrees = 180
	velocitat.x = -1
	velocitat.y = 0
	multiplicador = vel
	dir = 6

func _7(vel):
	rotation_degrees = 225
	velocitat.x = -1
	velocitat.y = -1
	multiplicador = vel
	dir = 7
