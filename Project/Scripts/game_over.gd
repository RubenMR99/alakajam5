extends Sprite


func _on_Timer_timeout():
	get_tree().change_scene("res://current_scene.tscn")
	queue_free()
