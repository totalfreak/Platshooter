extends Sprite

func _ready():
	rand_seed(1337)
	set_fixed_process(true)

func _fixed_process(delta):
	var rand = rand_range(2, 7)
	rand = round(rand)
	if rand == 3:
		get_node("Light2D").set_texture_scale(0.54)
		get_node("Light2D").set_energy(0.90)
	elif rand == 6:
		get_node("Light2D").set_texture_scale(0.52)
		get_node("Light2D").set_energy(0.80)