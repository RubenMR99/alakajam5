extends Node

var room = ["vacia", preload("res://Rooms/S_Rm_1.tscn")]

var screen_shake = 0
var screensize = Vector2(576, 384)

func _ready():
	for i in range(2,20):
		room.append(load("res://Rooms/S_Rm_" + String(i) + ".tscn"))
