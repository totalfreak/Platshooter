extends RigidBody2D



func _ready():
	var timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout") 
	#timeout is what says in docs, in signals
	#self is who respond to the callback
	#_on_timer_timeout is the callback, can have any name
	add_child(timer) #to process
	timer.set_wait_time(2.0)
	timer.start() #to start
	pass


func _on_timer_timeout():
	self.queue_free()