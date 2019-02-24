extends Node2D

var spell = ""
var funcionar = false
onready var player = get_parent().get_node("player")
onready var container = get_node("Container")
var polvo = preload("res://Objects/Polvo.tscn")

var spellBook = [["Bullet","^(0+$|1+$|2+$|3+$|4+$|5+$|6+$|7+$)"],
                 #["Fire","^1+7+[0-1]{1,3}(|2)3+(|4)5+(|4)3+$"],
                 #["Fire","^1+7+[0-1]{1,3}2?3+4?5+4?3+$"],
                  ["Fire","^(0|2)?1+(0|6)?7+(0|2)?1+(2|4)?3+(4|6)?5+(2|4)?3+$"],
                 #["Water", "^4+3+(|4)5+(|6)7+(|0)1{1,6}$"],
                 ["Water", "^4+3+4?5+6?7+0?1{1,6}$"],
                 #["Rempalago", "^(|4|6)5+(|3)2+(|3|4)5+$"],
                 ["Rempalago", "^(4|6)?5+3?2+(3|4)?5+$"]
                ]


var funciona = []
var no_funciona = []

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
	if(event.is_action_pressed("ui_accept")):
		funciona.append(spell)
		#print("nice")
	elif(event.is_action_pressed("ui_cancel")):
		no_funciona.append(spell)
		#print("tonto")
	elif(event.is_action_pressed("ui_focus_next")):
		#print(funciona)
		#print(no_funciona)
		pass


var par = false
func _process(delta):
	if(not funcionar):
		global_position = player.global_position+Vector2(0,+8)
		if(player.polvito < 100):
			player.polvito += 1
	elif(funcionar and player.polvito > 0 and par and player.velocity_ant.length() > 2):
		var polvito = polvo.instance()
		polvito.global_position = player.global_position
		polvito.z_index = 0
		player.polvito -= 0.5
		container.add_child(polvito) 
		par = false
	else:
		par = true

func calcular_spell():
	var regex = RegEx.new()
	var trobat = false
	var i = 0
	print(spell)
	while i in range(spellBook.size()) and not trobat:
		regex.compile(spellBook[i][1])
		var result = regex.search(spell)
		if(result):
			trobat = true
			executar_echizo(spellBook[i][0], spell)
		i+= 1

func detect(body, valor_augmentar):
	global_position.x = body.global_position.x
	global_position.y = body.global_position.y+8
	if(player.polvito > 0):
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

func executar_echizo(nom, truco):
	print(nom)
	if (nom == "Bullet"):
		player.hechizo_base((truco.substr(truco.length() - 1, truco.length())), truco.length())
	elif (nom == "Fire"):
		player.hechizo_fuego(truco.length())
	elif (nom == "Water"):
		player.hechizo_aqua(truco.length())
	elif (nom == "Rempalago"):
		player.hechizo_rayo(truco.length())