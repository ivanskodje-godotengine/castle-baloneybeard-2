# Dependencies: config_map.gd
extends Node
# Put all config related interaction here. This includes loading, saving and what-have-you. Make sure this is universal, and can be used for any config file.
var config_file = ConfigFile.new()
var config_path

func _init(config_path):
	self.config_path = config_path
	config_file.load(config_path)

func get_value(section, key):
	return config_file.get_value(section, key)

func set_value(section, key, value):
	config_file.set_value(section, key, value)

func get_config_map_value(config_map):
	config_map.VALUE = config_file.get_value(config_map.SECTION, config_map.KEY) # This part makes sure to update the given config_map with the value loaded from config
	return config_map.VALUE

func set_config_map(config_map):
	config_file.set_value(config_map.SECTION, config_map.KEY, config_map.VALUE)

func save():
	config_file.save(config_path)

func get_config_path():
	return config_path