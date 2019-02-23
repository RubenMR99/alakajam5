extends Node2D

var blanc = preload("res://Sprites/RANDOM/3X2 blanco.png")
var negre = preload("res://Sprites/RANDOM/3X2 negro.png")

func _ready():
	pass

func dibuixar_mapa(mapa, pos):
	for i in range(1, mapa.size()-1):
		for j in range(1, mapa[i].size()-1):
			if (mapa[i][j] > 0):
				var peca = Sprite.new()
				if(i == pos.x and j == pos.y):
					peca.set_texture(blanc)
				else:
					peca.set_texture(negre)
				peca.scale = Vector2(3, 3)
				peca.position = Vector2(i*10, j*10)
				add_child(peca)
	