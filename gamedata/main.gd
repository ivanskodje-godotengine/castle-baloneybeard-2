extends Control
# From here, we change between scenes.

# Scenes
var main_menu_scene = preload("res://gamedata/main_menu/main_menu.tscn")
var splash_screen_scene = preload("res://gamedata/splash_screen/splash_screen.tscn")

enum MENU_STATES {
	SPLASH_SCREEN,
	MAIN_MENU
}

var current_state = SPLASH_SCREEN
var current_instance = null
func _ready():
	set_scene(splash_screen_scene)
	pass

func _process(delta):
	if(current_state == SPLASH_SCREEN):
		if(Input.is_action_just_pressed("ui_accept") || Input.is_action_just_pressed("ui_start")):
			current_state = MAIN_MENU
			set_scene(main_menu_scene)
	
	elif(current_state == MAIN_MENU):
		if(Input.is_action_just_pressed("ui_accept") || Input.is_action_just_pressed("ui_start")):
			current_state = SPLASH_SCREEN
			set_scene(splash_screen_scene)


func set_scene(scene):
	if(current_instance != null):
		remove_child(current_instance)
	current_instance = scene.instance()
	add_child(current_instance)