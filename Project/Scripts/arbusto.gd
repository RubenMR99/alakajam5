extends KinematicBody2D

var velocitatEnemic = 20
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
			var distancia
			if ($enemicSprite.animation == "setoAmaga"):
				$enemicSprite.play("setoAixeca")
			if ($enemicSprite.animation == "setoAixeca" and $enemicSprite.frame > 1):
				$enemicSprite.play("setoMove")
			if ($enemicSprite.animation == "setoMove"):
				direccio = cosDesti.position - self.position
			distancia = sqrt(direccio.x * direccio.x + direccio.y * direccio.y)
		else:
			$enemicSprite.play("setoAmaga")


func _physics_process(delta):
	move_and_slide(direccio.normalized() * velocitatEnemic)

func _player_visible(body):
	if (body.name == "player"):
		cosDesti = body


func _player_no_visible(body):
	if (body.name == "player"):
		cosDesti = null
		direccio.x = 0
		direccio.y = 0

func desapareix():
	queue_free()

func fire(tamany):
	var dany = salud + 1
	salud -= dany

func basico(velocitat):
	var dany = velocitat * 5
	salud -= dany

func rayo(velocitat):
	var dany = velocitat * 8
	salud -= dany

func water(velocitat):
	var dany = velocitat * 3
	salud -= dany

func fer_mal(body):
	body.salud -= 5
	body.position.x += direccio.x * .2
	body.position.y += direccio.y * .2