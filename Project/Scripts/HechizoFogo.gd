extends Area2D

onready var anim = $AnimatedSprite
onready var col = $CollisionShape2D

func _ready():
	anim.playing = true
	anim.frame = 0

func _init():
	pass

func _on_AnimatedSprite_animation_finished():
	if(anim.animation == "carga"):
		anim.animation = "explosion"
		anim.play()
		ReglesRooms.screen_shake += 10
		col.disabled = true
		
	elif(anim.animation == "explosion"):
		queue_free()

func _on_HechizoFogo_body_entered(body):
	if(body.has_method("fire")):
		pass



