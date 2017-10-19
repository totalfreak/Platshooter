extends RigidBody2D

var left = "move_left"
var right = "move_right"
var up = "move_jump"
var down = "move_down"

var moving = false
var grounded = false
var movedLeft = false
var hasShoot = false
var shootSpeed = 600


const GRAVITY = 150
const MOVE_SPEED = 100


var velocity = Vector2()

func _ready():
	set_fixed_process(true)
	set_process_input(true)


func _fixed_process(delta):
	
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		if body.get_pos().y > self.get_pos().y:
			grounded = true
	
	if Input.is_action_pressed("move_jump") and grounded:
		set_linear_velocity(Vector2(get_linear_velocity().x, -GRAVITY))
		grounded = false
	
	if Input.is_action_pressed(left):
		set_linear_velocity(Vector2(-MOVE_SPEED, get_linear_velocity().y))
		moving = true
		movedLeft = true
		get_node("AnimatedSprite").set_flip_h(true)
	elif Input.is_action_pressed(right):
		set_linear_velocity(Vector2(MOVE_SPEED, get_linear_velocity().y))
		moving = true
		movedLeft = false
		get_node("AnimatedSprite").set_flip_h(false)
	else:
		set_linear_velocity(Vector2(0, get_linear_velocity().y))
		moving = false
	

func set_ground():
	pass

func _input(event):
	if event.type == InputEvent.MOUSE_BUTTON and !event.is_pressed() and event.button_index == BUTTON_LEFT:
		shoot()
	if event.type == InputEvent.KEY and event.is_pressed() and Input.is_action_pressed("move_jump"):
		#jump()
		pass


func shoot():
	var bullet = load("res://Prefabs/Bullet.tscn")
	var bi = bullet.instance()
	get_parent().add_child(bi)
	var bullet_rot = get_angle_to(get_global_mouse_pos()) + bi.get_rot()
	bi.set_rot(bullet_rot)
	if movedLeft:
		bi.set_pos(get_pos()+Vector2(0, 0))
	elif !movedLeft:
		bi.set_pos(get_pos()+Vector2(0, 0))
	var rigidbody_vector = (get_global_mouse_pos() - self.get_pos()).normalized()
	bi.apply_impulse(bi.get_pos(), rigidbody_vector*shootSpeed)