extends KinematicBody2D

export (float) var friction = 0.9
export (int) var speed = 200

#var velocity = Vector2()
var screensize
var acceleracio = 1
var max_acc = 2.5
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
			acceleracio -= 0.2
		else:
			acceleracio = 1
	if (!velocity.x and !velocity.y):
		velocity.x = velocity_ant.x * friction
		velocity.y = velocity_ant.y * friction
	print(velocity)
	velocity_ant = velocity
	return velocity

func _physics_process(delta):
	move_and_slide(get_input())
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0 , screensize.y)