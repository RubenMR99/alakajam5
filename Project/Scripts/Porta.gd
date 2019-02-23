extends Area2D

var direccio = Vector2()
var funciona = false
onready var game = get_parent().get_parent()

func _ready():
	if(direccio == Vector2(0,-1)):
		rotation_degrees = 0
	elif(direccio == Vector2(0, 1)):
		rotation_degrees = 180
	elif(direccio == Vector2(-1, 0)):
		rotation_degrees = -90
	else:
		rotation_degrees = 90
		
	yield(get_tree().create_timer(0.5), "timeout")
	funciona = true
	pass

func colocar_body(body):
	if(direccio == Vector2(0,-1)):
		body.global_position.y = ReglesRooms.screensize.y - 32
	elif(direccio == Vector2(0, 1)):
		body.global_position.y = 0
	elif(direccio == Vector2(-1, 0)):
		body.global_position.x = ReglesRooms.screensize.x - 0
	else:
		body.global_position.x = 0

func _on_Porta_body_entered(body):
	if(funciona and body.name == "player"):
		game.pos_actual += direccio;
		game.load_room()
		colocar_body(body)

