# Stores the values from the config file. Make sure data have been validated beforehand!
extends Node

# Used to load data into our memory from the config file. 
# This should only run AFTER the config file have been validated through config_validator.
func load_data(config_file):
	Config.screen_width = get_value(config_file, Config.screen_width)
	Config.screen_height = get_value(config_file, Config.screen_height)
	Config.music_volume = get_value(config_file, Config.music_volume)

func get_value(config_file, config_map):
	return config_file.get_value(config_map.SECTION, config_map.KEY)