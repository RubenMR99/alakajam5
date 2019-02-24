extends Area2D

onready var ani = $AnimatedSprite

func _ready():
	ani.playing = true

func _init():
	pass

func _on_HechizoFogo_body_entered(body):
	if(body.has_method("fire")):
		body.fire(scale.x)

func _on_AnimatedSprite_animation_finished():
	if(ani.animation == "carga"):
		ani.animation = "explosion"
		ReglesRooms.screen_shake += 4*scale.x
		print(scale.x)
	elif(ani.animation == "explosion"):
		queue_free()
