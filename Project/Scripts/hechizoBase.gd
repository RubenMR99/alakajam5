extends Area2D


func _ready():
	$baseSprite.play("shoot")

func _process(delta):
	print($baseSprite.frame)
	if $baseSprite.frame > 5:
		$baseSprite.play("loop")
