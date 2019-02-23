extends KinematicBody2D

export (float) var velocitatEnemic = 50

var posicioDesti = Vector2()
var direccio = Vector2()
var cosDesti
var screensize

func _ready():
	direccio.x = 0
	direccio.y = 0
	screensize = get_viewport_rect().size

func _process(delta):
	if cosDesti:
		
		direccio = cosDesti.position - self.position
		#distancia = sqrt(direccio.x * direccio.x + direccio.y * direccio.y)
		#position += direccio.normalized() * velocitatEnemic * delta

func _physics_process(delta):
	move_and_slide(direccio.normalized() * velocitatEnemic)

func _player_visible(body):
	if (body.name == "player"):
		print("Jugador a l'area")
		cosDesti = body


func _player_no_visible(body):
	if (body.name == "player"):
		cosDesti = null
		print("Player no visible")
		direccio.x = 0
		direccio.y = 0
