extends KinematicBody2D

var velocitatEnemic = 40
var salud = 50
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
			$enemicSprite.play("left")
			if (direccio.x < 0):
				$enemicSprite.flip_h = false
			else:
				$enemicSprite.flip_h = true
			#salud -= 1
		else:
			$enemicSprite.play("idle")


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


func _detecta_personatge(body):
	if (body.name == "player"):
		cosDesti = body

func _perd_personatge(body):
	if (body.name == "player"):
		cosDesti = null
		direccio.x = 0
		direccio.y = 0

func fer_mal(body):
	body.salud -= 10