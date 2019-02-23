extends Node2D

var spell = [0,0,0,0,0,0,0,0]
var funcionar = false
onready var player = get_parent().get_node("player")

func _ready():
	set_process_input(true)

func _input(event):
	if(event.is_action_pressed("ui_select")):
		spell = [0,0,0,0,0,0,0,0]
		
		funcionar = true
		set_process(false)
	elif(event.is_action_released("ui_select")):
		calcular_spell()
		funcionar = false
		set_process(true)

func _process(delta):
	global_position = player.global_position

func calcular_spell():
	print(spell);

func detect(body, valor_augmentar):
	global_position = body.global_position
	spell[valor_augmentar] += 1

func _on_Up(body):
	detect(body, 0)

func _on_RightUp(body):
	detect(body, 1)

func _on_Right(body):
	detect(body, 2)

func _on_RightDown(body):
	detect(body, 3)

func _on_Down(body):
	detect(body, 4)

func _on_DownLeft(body):
	detect(body, 5)

func _on_Left(body):
	detect(body, 6)

func _on_UpLeft(body):
	detect(body, 7)
