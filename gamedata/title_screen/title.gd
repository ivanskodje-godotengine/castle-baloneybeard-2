extends Control

# Vars
var stack_size = 0
var total = 5 # Number of Boloney slices to spawn

# Scenes
var bread_scene = preload('res://gamedata/title_screen/bread.tscn')
var baloney_scene = preload('res://gamedata/title_screen/bologne.tscn')

# Nodes
onready var position_2d = $center_container/animation/position_2d

# Timer
var timer = null
var delay = 0.75


func _ready():
	# Create and start timer
	timer = Timer.new()
	timer.set_one_shot(false)
	timer.set_wait_time(delay)
	timer.connect("timeout", self, "_tick")
	timer.set_name("title_timer")
	add_child(timer)
	timer.start()

# Reset animation
func reset():
	for c in position_2d.get_children():
		c.queue_free()


# Adds bread or baloney to form a sandwich
func add_to_sandwich():
	# Create baloney
	var scene = baloney_scene.instance()
	
	# If it is the first or last
	if(stack_size == 0 || stack_size == total + 1):
		# Add bread instead of baloney
		scene = bread_scene.instance()
	
	# Add baloney/bread
	position_2d.add_child(scene)
	
	# Set position
	# scene.set_position(Vector2(80, 120 - (stack_size * 4)))
	
	# Increment stack size by one
	stack_size += 1


# Runs each tick
func _tick():
	if(stack_size < total + 2):
		add_to_sandwich()
	else:
		stack_size += 1
	
	# Reset and start over after 10 ticks
	if(stack_size > 10):
		reset()
		stack_size = 0