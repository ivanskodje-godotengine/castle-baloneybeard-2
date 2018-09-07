extends Node

# Set default config values here. These values are first read from the config file.
var screen_width = ConfigMap.new("Config", "screen_width", 1280)
var screen_height = ConfigMap.new("Config", "screen_height", 720)
var music_volume = ConfigMap.new("Config", "music_volume", 50)

# ----------------------------------------------------------------------

var _path = "res://gamedata/config.cfg"
func get_path():
	return _path

# Used to initially load the config file
func load_config():
	var config_file= ConfigFile.new()
	config_file.load(get_path())
	return config_file

class ConfigMap:
	var SECTION
	var KEY
	var VALUE
	
	func _init(section, key, value):
		self.SECTION = section
		self.KEY = key
		self.VALUE = value