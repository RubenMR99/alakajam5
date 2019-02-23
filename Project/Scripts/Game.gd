extends Node

var porta_resource = preload("res://Objects/Porta.tscn");
onready var cont = $Container

var mapa = [[-1,-1,-1,-1,-1,-1,-1],
            [-1, 0, 0, 0, 0, 0,-1],
            [-1, 0, 0, 0, 0, 0,-1],
            [-1, 0, 0, 0, 0, 0,-1],
            [-1, 0, 0, 0, 0, 0,-1],
            [-1, 0, 0, 0, 0, 0,-1],
            [-1,-1,-1,-1,-1,-1,-1]]
var pos_actual = Vector2(3,3)

func generate_mapa(pos = Vector2(3,3)):
	if(mapa[pos.x][pos.y] == 0):
		mapa[pos.x][pos.y] = (randi()%(ReglesRooms.room.size()-1)) + 1
		
		var num_portes = 0
		while(num_portes == 0):
			if(randi()%3 == 0):    #Generate up
				generate_mapa(Vector2(pos.x, pos.y - 1))
				num_portes += 1;
			if(randi()%3 == 0):    #Generate down
				generate_mapa(Vector2(pos.x, pos.y + 1))
				num_portes += 1;
			if(randi()%3 == 0):    #Generate left
				generate_mapa(Vector2(pos.x - 1, pos.y))
				num_portes += 1;
			if(randi()%3 == 0):    #Generate up
				generate_mapa(Vector2(pos.x + 1, pos.y))
				num_portes += 1;
	

func _ready():
	randomize()
	generate_mapa()
	print(mapa)
	load_room()
	pass

func load_room():
	for i in cont.get_children():
		i.queue_free()
	
	var sala = (ReglesRooms.room[mapa[pos_actual.x][pos_actual.y]]).instance()
	sala.position.x = 0
	sala.position.y = 0
	cont.add_child(sala)
	
	if(mapa[pos_actual.x][pos_actual.y-1] > 0):
		var porta = porta_resource.instance()
		porta.direccio = Vector2(0,-1)
		porta.position = Vector2(ReglesRooms.screensize.x/2, 10)
		cont.add_child(porta)
	
	if(mapa[pos_actual.x][pos_actual.y+1] > 0):
		var porta = porta_resource.instance()
		porta.direccio = Vector2(0,1)
		porta.position = Vector2(ReglesRooms.screensize.x/2, ReglesRooms.screensize.y-10)
		cont.add_child(porta)
	
	if(mapa[pos_actual.x - 1][pos_actual.y] > 0):
		var porta = porta_resource.instance()
		porta.direccio = Vector2(-1,0)
		porta.position = Vector2(10, ReglesRooms.screensize.y/2)
		cont.add_child(porta)
	
	if(mapa[pos_actual.x + 1][pos_actual.y] > 0):
		var porta = porta_resource.instance()
		porta.direccio = Vector2(1,0)
		porta.position = Vector2(ReglesRooms.screensize.x-10, ReglesRooms.screensize.y/2)
		cont.add_child(porta)
	
	