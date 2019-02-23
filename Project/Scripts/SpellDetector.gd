extends Node2D

var spell = [0,0,0,0,0,0,0,0]
var funcionar = false
onready var player = get_parent().get_node("player")
onready var container = get_node("Container")
var polvo = preload("res://Objects/Polvo.tscn")

func _ready():
	set_process_input(true)

func _input(event):
	if(event.is_action_pressed("ui_select")):
		spell = [0,0,0,0,0,0,0,0]
		
		funcionar = true
	elif(event.is_action_released("ui_select")):
		calcular_spell()
		for i in container.get_children():
			i.queue_free()
		funcionar = false


var par = false
func _process(delta):
	if(not funcionar):
		global_position = player.global_position
	elif(funcionar and par):
		var polvito = polvo.instance()
		polvito.global_position = player.global_position
		polvito.z_index = 0
		container.add_child(polvito) 
		par = false
	else:
		par = true

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
