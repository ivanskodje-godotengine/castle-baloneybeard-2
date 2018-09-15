# Dependencies: config_map.gd
extends Node
# Put all config related interaction here. This includes loading, saving and what-have-you. Make sure this is universal, and can be used for any config file.
var config_file = ConfigFile.new()
var config_path

func _init(config_path):
	self.config_path = config_path
	config_file.load(config_path)

func get_value(config_map):
	return config_file.get_value(config_map.SECTION, config_map.KEY)

func save_value(config_map):
	    config_file.set_value(config_map.SECTION, config_map.KEY, config_map.VALUE)

func get_config_path():
	return config_path