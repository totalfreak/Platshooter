extends Sprite

#onready var root = get_node(World)

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	Input.set_mouse_mode(1)

func _fixed_process(delta):
	set_pos(Vector2(get_global_mouse_pos()))

func _input(event):
	pass


func _on_Brick_mouse_enter():
	set_modulate(Color("eb1313"))


func _on_Brick_mouse_exit():
	set_modulate(Color("ffffff"))
