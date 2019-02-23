extends Node2D

var spell = ""
var funcionar = false
onready var player = get_parent().get_node("player")
onready var container = get_node("Container")
var polvo = preload("res://Objects/Polvo.tscn")



func _ready():
	set_process_input(true)

var state = 0
func _input(event):
	if(event.is_action_pressed("ui_select")):
		if(not funcionar):
			spell = ""
			
			funcionar = true
		else:
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
	var regex = RegEx.new()
	regex.compile("^[0-1]{1,}7+[1-5]{1,}[3-4]{1,}$")
	var result = regex.search(spell)
	if(result):
		print("FIIIIIRE")
	else:
		print("Esto no tira")
	print(spell);

func detect(body, valor_augmentar):
	global_position = body.global_position
	spell = spell + String(valor_augmentar)

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
