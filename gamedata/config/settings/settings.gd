extends Node
# Store all available config field data and validation here. 
# 
# Keep the config code related to Settings in one place. If a dev have to make 
# changes to multiple scripts when adding new config fields, you are doing something wrong.
# 
# HOW-TO-USE
# - Add a new config property.
# - Add validation for that new property.
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

# CONFIGURATION PROPERTIES
var full_screen = ConfigMap.new(SECTION, "full_screen", 1)
var screen_width = ConfigMap.new(SECTION, "screen_width", 1280)
var screen_height = ConfigMap.new(SECTION, "screen_height", 720)
var music_volume = ConfigMap.new(SECTION, "music_volume", 50)


# Whenever we start our game, this will automatically load 
# (given that it remains as a singleton and is AutoLoaded).
# 
# This allows is to make sure our config file (settings.cfg) is valid without having to it within our main scene.
# This will also fix any issues, and set the default values.
func _init():
	logger.debug("Validating and setting data from '%s'. " % SETTINGS_PATH)
	var string_builder = StringBuilder.new()
	
	validate_full_screen(string_builder)
	validate_screen_width(string_builder)
	validate_screen_height(string_builder)
	validate_music_volume(string_builder)
	handle_errors(string_builder)
	
	if(full_screen.VALUE):
		OS.window_fullscreen = true

func validate_full_screen(string_builder):
	validate_int_range(string_builder, full_screen, 0, 1)

func validate_screen_width(string_builder):
	validate_int_range(string_builder, screen_width, 0, OS.get_screen_size().x)

func validate_screen_height(string_builder):
	validate_int_range(string_builder, screen_height, 0, OS.get_screen_size().y)

func validate_music_volume(string_builder):
	validate_int_range(string_builder, music_volume, 0, 100)

func validate_int_range(string_builder, config_map, from_value, to_value):
	var value = config.get_config_map_value(config_map) 
	
	if(!typeof(value) == TYPE_INT || value < from_value || value > to_value):
		string_builder.append("Settings field '%s' can only have a value from %s to %s (was '%s'). Setting the default value '%s'. \n" % [config_map.KEY, from_value, to_value, value, config_map.DEFAULT_VALUE])
		config_map.reset_to_default()
		config.set_config_map(config_map)
		return false
	return true

func handle_errors(string_builder):
	if(string_builder.get().length() > 0):
		logger.warn(string_builder.get())
		config.save()