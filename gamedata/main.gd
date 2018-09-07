extends Control

func _ready():
	initiate_configuration()

# Handles config verification while fixing errors and loading it into memory. 
# If the config file does not exist, it will be created.
func initiate_configuration():
	var config_file = Config.load_config()
	validate_config(config_file)
	load_config(config_file)

func validate_config(config_file):
	var config_validator = load("res://gamedata/config_validator.gd").new()
	config_validator.validate_config_file(config_file, Config.get_path())

func load_config(config_file):
	var config_loader = load("res://gamedata/config_loader.gd").new()
	config_loader.load_data(config_file)