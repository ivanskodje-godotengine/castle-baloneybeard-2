extends Node
# Store all available config field data and validation here. 
# 
# Keep the config code related to Settings in one place. If a dev have to make 
# changes to multiple scripts when adding new config fields, you are doing something wrong.
# 
# HOW-TO-USE
# - Add a new ConfigMap property.
# - Add a custom validation for the new property.
# - Done.

# CLASSES
var StringBuilder = preload("res://gamedata/helper/string_builder.gd")
var ConfigMap = preload("res://gamedata/config/config_map.gd")
var Config = preload("res://gamedata/config/config.gd")
var Logger = preload("res://gamedata/helper/logger.gd")

# CONSTANTS
const SETTINGS_PATH = "res://gamedata/settings.cfg"
const SECTION = "Settings"

# VARS
var logger = Logger.new("settings.gd")
var config = Config.new(SETTINGS_PATH)
var string_builder = StringBuilder.new()

# CONFIGURATION PROPERTIES
var full_screen = ConfigMap.new(SECTION, "full_screen", 0)
var screen_width = ConfigMap.new(SECTION, "screen_width", 1280)
var screen_height = ConfigMap.new(SECTION, "screen_height", 720)
var music_volume = ConfigMap.new(SECTION, "music_volume", 50)

# Whenever we start our game, this will automatically load 
# (given that it remains as a singleton and is AutoLoaded).
# 
# This allows is to make sure our config file (settings.cfg) is valid without having to it within our main scene.
# This will also fix any issues, and set the default values.
func _init():
	validate_settings()
	load_settings()

func validate_settings():
	validate_full_screen()
	validate_screen_width()
	validate_screen_height()
	validate_music_volume()
	handle_errors()

func load_settings():
	
	if(full_screen.VALUE):
		logger.debug("Setting full-screen window size (" + str(OS.get_screen_size()) + ")")
		OS.set_window_size(OS.get_screen_size())
		OS.window_fullscreen = full_screen.VALUE
	else:
		logger.debug("Setting window size (" + str(screen_width.VALUE) + ", " + str(screen_height.VALUE) + ")")
		OS.set_window_size(Vector2(screen_width.VALUE, screen_height.VALUE))

func validate_full_screen():
	validate_int_range(full_screen, 0, 1)

func validate_screen_width():
	var min_value = 0
	var max_value = OS.get_screen_size().x
	validate_int_range(screen_width, min_value, max_value)

func validate_screen_height():
	var min_value = 0
	var max_value = OS.get_screen_size().y
	validate_int_range(screen_height, min_value, max_value)

func validate_music_volume():
	var min_value = 0
	var max_value = 100
	validate_int_range(music_volume, min_value, max_value)

func validate_int_range(config_map, min_value, max_value):
	var value = config.get_config_map_value(config_map) 
	
	if(!typeof(value) == TYPE_INT || value < min_value || value > max_value):
		string_builder.append("Settings field '%s' can only have a value from %s to %s (was '%s'). Setting the default value '%s'. \n" % [config_map.KEY, min_value, max_value, value, config_map.DEFAULT_VALUE])
		config_map.reset_to_default()
		config.set_config_map(config_map)

func handle_errors():
	if(string_builder.get().length() > 0):
		logger.warn(string_builder.get())
		string_builder.clear()
		config.save()