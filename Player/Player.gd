extends KinematicBody2D

var left = "move_left"
var right = "move_right"
var up = "move_jump"
var down = "move_down"

var moving = false
var grounded = false
var movedLeft = false
var hasShoot = false
var shootSpeed = 800


const GRAVITY = 300.0
const MOVE_SPEED = 200


var velocity = Vector2()

func _ready():
	set_fixed_process(true)
	set_process_input(true)


func _fixed_process(delta):
	
	
	
	
	if(Input.is_action_pressed(up) and grounded):
		velocity.y += delta * -10000
		grounded = false
	
	velocity.y += delta * GRAVITY
	
	if Input.is_action_pressed(left):
		velocity.x = -MOVE_SPEED
		moving = true
		movedLeft = true
		get_node("AnimatedSprite").set_flip_h(true)
	elif Input.is_action_pressed(right):
		velocity.x = MOVE_SPEED
		moving = true
		movedLeft = false
		get_node("AnimatedSprite").set_flip_h(false)
	else:
		velocity.x = 0
		moving = false
	
	var motion = velocity * delta
	motion = move(motion)
	
	if (is_colliding()):
		var n = get_collision_normal()
		#print(n.angle())
		if(abs(n.angle()) > 2 and abs(n.angle()) < 4):
			grounded = true
		else:
			grounded = false
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		move(motion)

func _input(event):
	if event.type == InputEvent.MOUSE_BUTTON and !event.is_pressed() and event.button_index == BUTTON_LEFT:
		shoot()


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