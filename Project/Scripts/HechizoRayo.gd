extends Area2D

func _ready():
	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "carga"):
		rotation = get_parent().get_node("player").velocity_ant.angle()
		position = get_parent().get_node("player").position
		$Sprite/AnimationPlayer.play("ataqueRayil")
		$Sprite.visible = true
		$Sprite2.visible = false
		ReglesRooms.screen_shake += scale.x *3


func _on_AnimationPlayer_animation2_finished(anim_name):
	queue_free()


func _on_HechizoRayo_body_entered(body):
	if(body.has_method("rayo")):
		body.rayo(scale.x)
