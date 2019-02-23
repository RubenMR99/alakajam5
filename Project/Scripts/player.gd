extends KinematicBody2D

export (float) var friction = 0.9
export (float) var acceleracio = 0.8
export (float) var max_acc = 2.5
export (float) var frenada = 0.3
export (int) var speed = 200

var screensize
var velocity_ant = Vector2()

func _ready():
	screensize = get_viewport_rect().size

func get_input():
	var velocity = Vector2()
	velocity.x = 0
	velocity.y = 0
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1 + acceleracio
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1 + acceleracio
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1 + acceleracio
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1 + acceleracio
	velocity = velocity.normalized() * speed
	if (Input.is_action_pressed('ui_shift') and (velocity.x != 0 or velocity.y != 0)):
		acceleracio += 0.05
		velocity *= min(acceleracio, max_acc)
	else:
		if (acceleracio > 1):
			acceleracio -= frenada
		else:
			acceleracio = 1
	if (!velocity.x):
		velocity.x = velocity_ant.x * friction
	
	if (!velocity.y):
		velocity.y = velocity_ant.y * friction

	velocity_ant = velocity
	return velocity

func _physics_process(delta):
	move_and_slide(get_input())
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0 , screensize.y)