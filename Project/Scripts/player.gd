extends KinematicBody2D

export (float) var friction = 0.9
export (float) var acceleracio = 0.8
export (float) var max_acc = 2.5
export (float) var frenada = 0.3
export (int) var speed = 200
export (int) var polvito = 100
var salud = 250

#onready var con = $Node2D
onready var cam = $playerCamera
onready var text = $playerCamera/Node2D/Polvo
onready var life = $playerCamera/Node2D/Life
var screensize
var velocity_ant = Vector2()
var faceUp = false
var hechizoBase = preload("res://Scenes/hechizos/hechizoBase.tscn");
var hechizoFoc = preload("res://Scenes/hechizos/hechizoFogo.tscn");
var hechizoAqua = preload("res://Scenes/hechizos/hechizoAqua.tscn");
var hechizoRayo = preload("res://Scenes/hechizos/hechizoRayo.tscn");


func _ready():
	screensize = get_viewport_rect().size

func get_input():
	var velocity = Vector2(0,0)
	if Input.is_action_pressed('ui_right'):
		velocity.x += (1 + acceleracio)
	if Input.is_action_pressed('ui_left'):
		velocity.x -= (1 + acceleracio)
	if Input.is_action_pressed('ui_down'):
		velocity.y += (1 + acceleracio)
	if Input.is_action_pressed('ui_up'):
		velocity.y -= (1 + acceleracio)
	velocity = velocity.normalized() * speed
	if (Input.is_action_pressed('ui_shift') and (velocity.x != 0 or velocity.y != 0)):
		acceleracio += 0.05
		acceleracio = min(acceleracio, max_acc)
		velocity *= acceleracio
		get_parent().get_node("SpellDetector").global_position = global_position
	else:
		if (acceleracio > 1):
			acceleracio -= frenada
		else:
			acceleracio = 1
	if (!velocity.x):
		if (abs(velocity_ant.x) > 0.1):
			velocity.x = velocity_ant.x * friction
		else:
			velocity.x = 0
	
	if (!velocity.y):
		if (abs(velocity_ant.y) > 0.1):
			velocity.y = velocity_ant.y * friction
		else:
			velocity.y = 0

	velocity_ant = velocity
	
	#manegar animacio
	$playerSprite.flip_h = false;
	if (abs(velocity.x) > abs(velocity.y)):
		if (velocity.x > 0):
			$playerSprite.play("right")
			faceUp = false
		elif (velocity.x < 0):
			$playerSprite.play("right")
			$playerSprite.flip_h = true;
			faceUp = false
	if (abs(velocity.x) < abs(velocity.y)):
		if (velocity.y < 0):
			$playerSprite.animation = "back"
			faceUp = true
		elif (velocity.y > 0):
			$playerSprite.animation = "front"
			faceUp = false
	elif(velocity.x == 0 and velocity.y == 0):
		if (!faceUp):
			$playerSprite.animation = "frontIdle"
		else:
			$playerSprite.animation = "backIdle"
	elif(velocity.x < 0 and velocity.y != 0):
			$playerSprite.flip_h = true;
	
	
	return velocity

func _physics_process(delta):
	if(ReglesRooms.screen_shake > 0):
		cam.offset = Vector2(rand_range(-ReglesRooms.screen_shake,ReglesRooms.screen_shake), rand_range(-ReglesRooms.screen_shake,ReglesRooms.screen_shake))
		ReglesRooms.screen_shake -= 0.1
	
	life.value = salud;
	if(salud <= 0):
		get_parent().game_over();
	text.value = polvito;
	move_and_slide(get_input())

func hechizo_base(dir, forza):
	var basico = hechizoBase.instance()
	get_parent().add_child(basico)
	basico.position = $playerEmitor.global_position
	if (dir == "0"):
		basico._0(forza)
	elif (dir == "1"):
		basico._1(forza)
	elif (dir == "2"):
		basico._2(forza)
	elif (dir == "3"):
		basico._3(forza)
	elif (dir == "4"):
		basico._4(forza)
	elif (dir == "5"):
		basico._5(forza)
	elif (dir == "6"):
		basico._6(forza)
	elif (dir == "7"):
		basico._7(forza)

func hechizo_fuego(size):
	var foco = hechizoFoc.instance()
	foco.position = position+Vector2(0,-size*2) 
	foco.scale = Vector2(size*0.1, size*0.1)
	get_parent().add_child(foco)

func hechizo_aqua(size):
	var aqua = hechizoAqua.instance()
	aqua.position = position 
	aqua.scale = Vector2(size*0.2, size*0.2)
	get_parent().add_child(aqua)

func hechizo_rayo(size):
	var rayo = hechizoRayo.instance()
	rayo.position = position+Vector2(0,-size*2) 
	rayo.scale = Vector2(size*0.2, size*0.2)
	get_parent().add_child(rayo)

func _on_hitbox_entered(body):
	if body.has_method("fer_mal"):
		body.fer_mal(self)
