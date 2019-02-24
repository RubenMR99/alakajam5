extends Node

var porta_resource = preload("res://Objects/Porta.tscn");

onready var cont = $Container
onready var pla = $player
onready var mini = $player/miniMapa

var mapa = [[-1,-1,-1,-1,-1,-1,-1],
            [-1, 0, 0, 0, 0, 0,-1],
            [-1, 0, 0, 0, 0, 0,-1],
            [-1, 0, 0, 0, 0, 0,-1],
            [-1, 0, 0, 0, 0, 0,-1],
            [-1, 0, 0, 0, 0, 0,-1],
            [-1,-1,-1,-1,-1,-1,-1]]

var visto = [[-1,-1,-1,-1,-1,-1,-1],
            [-1, 0, 0, 0, 0, 0,-1],
            [-1, 0, 0, 0, 0, 0,-1],
            [-1, 0, 0, 0, 0, 0,-1],
            [-1, 0, 0, 0, 0, 0,-1],
            [-1, 0, 0, 0, 0, 0,-1],
            [-1,-1,-1,-1,-1,-1,-1]]

var pos_actual = Vector2(3,3)

func generate_random_spots():
	for i in range(randi()%3+2):
		mapa[(randi()%5)+2][(randi()%5)+2] = -1
	
	mapa[3][3] = 0

func generar_sala(pos, direccio, probabilitat):
	if(randf() <= probabilitat):
		generate_mapa(pos, direccio)
		return 1
	else:
		return 0


func generate_mapa(pos = Vector2(3,3), direccio = Vector2(0,0)):
	if(mapa[pos.x][pos.y] == 0):
		mapa[pos.x][pos.y] = (randi()%(ReglesRooms.room.size()-1)) + 1
		var alguna_porta = 0
		while(alguna_porta == 0):
			if(direccio == Vector2(0,-1)):  #Up
				alguna_porta += generar_sala(Vector2(pos.x, pos.y - 1), Vector2(0,-1), 0.7) #up
				alguna_porta += generar_sala(Vector2(pos.x-1, pos.y), Vector2(0,-1), 0.25)   #Left
				alguna_porta += generar_sala(Vector2(pos.x+1, pos.y), Vector2(0,-1), 0.25)    #Right
			elif(direccio == Vector2(0,1)):  #Down
				alguna_porta += generar_sala(Vector2(pos.x, pos.y + 1), Vector2(0,1), 0.7)  #Down
				alguna_porta += generar_sala(Vector2(pos.x-1, pos.y), Vector2(0,1), 0.25)   #Left
				alguna_porta += generar_sala(Vector2(pos.x+1, pos.y), Vector2(0,1), 0.25)    #Right
			elif(direccio == Vector2(-1,0)): #Left
				alguna_porta += generar_sala(Vector2(pos.x-1, pos.y), Vector2(-1, 0), 0.7)   #Left
				alguna_porta += generar_sala(Vector2(pos.x, pos.y-1), Vector2(-1, 0), 0.25)  #Up
				alguna_porta += generar_sala(Vector2(pos.x, pos.y+1), Vector2(-1, 0), 0.25)  #Down
			elif(direccio == Vector2(1,0)): #Right
				alguna_porta += generar_sala(Vector2(pos.x +1, pos.y), Vector2(1, 0), 0.7)  #Right
				alguna_porta += generar_sala(Vector2(pos.x, pos.y-1), Vector2(1, 0), 0.25)  #Up
				alguna_porta += generar_sala(Vector2(pos.x, pos.y+1), Vector2(1, 0), 0.25)  #Down
			else:
				alguna_porta += generar_sala(Vector2(pos.x, pos.y - 1), Vector2(0,-1), 0.85) #up
				alguna_porta += generar_sala(Vector2(pos.x, pos.y + 1), Vector2(0,1), 0.85)  #Down
				alguna_porta += generar_sala(Vector2(pos.x-1, pos.y), Vector2(-1, 0), 0.85)   #Left
				alguna_porta += generar_sala(Vector2(pos.x +1, pos.y), Vector2(1, 0), 0.85)  #Right

func _ready():
	randomize()
	generate_random_spots()
	generate_mapa()
	mapa[3][3] = 1
	print(mapa)
	load_room()
	pass


func load_room():
	for i in cont.get_children():
			i.queue_free()
	
	visto[pos_actual.x][pos_actual.y] = 1
	mini.dibuixar_mapa(mapa, pos_actual)
	
	var sala = (ReglesRooms.room[mapa[pos_actual.x][pos_actual.y]]).instance()
	sala.position.x = 0
	sala.name = "sala"
	sala.position.y = 0
	cont.add_child(sala)

	if(mapa[pos_actual.x][pos_actual.y-1] > 0):
		var porta = porta_resource.instance()
		porta.direccio = Vector2(0,-1)
		porta.position = Vector2(ReglesRooms.screensize.x/2, -10)
		cont.add_child(porta)
	
	if(mapa[pos_actual.x][pos_actual.y+1] > 0):
		var porta = porta_resource.instance()
		porta.direccio = Vector2(0,1)
		porta.position = Vector2(ReglesRooms.screensize.x/2, ReglesRooms.screensize.y-20)
		cont.add_child(porta)
	
	if(mapa[pos_actual.x - 1][pos_actual.y] > 0):
		var porta = porta_resource.instance()
		porta.direccio = Vector2(-1,0)
		porta.position = Vector2(2, ReglesRooms.screensize.y/2-32)
		cont.add_child(porta)
	
	if(mapa[pos_actual.x + 1][pos_actual.y] > 0):
		var porta = porta_resource.instance()
		porta.direccio = Vector2(1,0)
		porta.position = Vector2(ReglesRooms.screensize.x-2, ReglesRooms.screensize.y/2-32)
		cont.add_child(porta)
	
	