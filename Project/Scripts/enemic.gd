extends KinematicBody2D

var posicioDesti = Vector2()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass

func _player_visible(body):
	print("Jugador a l'area")


func _player_no_visible(body):
	print("Player no visible")
