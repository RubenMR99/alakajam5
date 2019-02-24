extends KinematicBody2D

var velocitatEnemic = 70
var salud = 200
var posicioDesti = Vector2()
var direccio = Vector2()
var cosDesti
var screensize


func _ready():
	direccio.x = 0
	direccio.y = 0
	screensize = get_viewport_rect().size

func _process(delta):
	if (salud <= 0):
		desapareix()
	else:
		if cosDesti:
			direccio = cosDesti.position - self.position
			if (direccio.y < 0):
				$enemicSprite.play("front")
			else:
				$enemicSprite.play("back")
			#salud -= 1
		else:
			$enemicSprite.play("idle")
	direccio.x *= .5


func _physics_process(delta):
	move_and_slide(direccio.normalized() * velocitatEnemic)

func desapareix():
	if ($enemicSprite.animation != "idle"):
		$enemicSprite.play("idle")
	if ($enemicSprite.animation == "idle" and $enemicSprite.frame > 3):
		queue_free()

func fire(tamany):
	var dany = salud + 1
	salud -= dany

func basico(velocitat):
	var dany = velocitat * 5
	salud -= dany


func _on_Area2D_body_entered(body):
	if (body.name == "player"):
		cosDesti = body


func _on_Area2D_body_exited(body):
	if (body.name == "player"):
		cosDesti = null
		direccio.x = 0
		direccio.y = 0

func fer_mal(body):
	body.salud -= 20