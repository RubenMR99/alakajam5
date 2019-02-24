extends Area2D

onready var aigua = $aigua
onready var magia = $magiaMagic
onready var cercleMagic = $cercleMagic
onready var comp = $compExp
onready var col = $CollisionShape2D

func _ready():
	pass

func _init():
	pass

func _on_HechizoFogo_body_entered(body):
	if(body.has_method("fire")):
		pass

func _on_AnimationPlayer_animation_finished(anim_name):
	aigua.visible = true
	cercleMagic.visible = true
	comp.play_backwards("Compressio")
	magia.visible = false

var state = 0
func _on_compExp_animation_finished(anim_name):
	if(state == 0):
		state = 1
		col.disabled = false
		yield(get_tree().create_timer(2), "timeout")
		comp.play("Compressio")
		
	elif(state == 1):
		queue_free()
