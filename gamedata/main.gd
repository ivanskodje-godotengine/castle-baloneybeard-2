extends Control

# Scenes
var main_menu_scene = preload("res://gamedata/main_menu/main_menu.tscn")

# State controller
enum GAME_STATES {
	SPLASH_SCREEN,
	MAIN_MENU,
	GAMEPLAY
}


func _ready():
	pass