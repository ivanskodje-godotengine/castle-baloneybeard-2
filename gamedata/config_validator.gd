# Helper script to validate the config file(s).
extends Node

# We want to make sure the config file is as expected. Any deviancy will be fixed. The config file will be created if it does not already exist. 
func validate_config_file(config_file, config_path):
	var config_validator = ConfigValidator.new(config_file, config_path)
	
	_validate_screen_width(config_validator)
	_validate_screen_height(config_validator)
	_validate_music_volume(config_validator)
	
	config_validator.log_message(Log.LOG_LEVEL.WARN)
	config_validator.save()
	config_validator.clear()


# Validate SCREEN WIDTH
func _validate_screen_width(config_validator):
	var config_map = Config.screen_width;
	if(_validate(config_validator, config_map)):
		_is_int(config_validator, config_map)


# Validate SCREEN HEIGHT
func _validate_screen_height(config_validator):
	var config_map = Config.screen_height;
	if(_validate(config_validator, config_map)):
		_is_int(config_validator, config_map)


# Validate MUSIC VOLUME
func _validate_music_volume(config_validator):
	var music_map = Config.music_volume
	if(_validate(config_validator, music_map)):
		var music_volume = _get_value(config_validator, music_map)
		
		if(_is_int(config_validator, music_map)):
			config_validator.set_value(music_map, clamp(music_volume, 0, 100))


# Make sure we are working with the expected datatype.
func _is_int(config_validator, config_map):
	var value = _get_value(config_validator, config_map)
	if(typeof(value) == TYPE_INT):
		return true
	else:
		config_validator.message += "Config file section '%s' has an invalid key '%s' that contains a value \"%s\". Setting value to '%s'. " % [config_map.SECTION, config_map.KEY, value, config_map.VALUE]
		_set_value(config_validator, config_map)


func _validate(config_validator, config_map):
	if (!config_validator.config_file.has_section_key(config_map.SECTION, config_map.KEY)):
		config_validator.message += "Config file section '%s' is missing key '%s'. Setting value to '%s'. " % [config_map.SECTION, config_map.KEY, config_map.VALUE]
		config_validator.set_value(config_map, config_map.VALUE)
		_set_value(config_validator, config_map)
		return false
	return true


func _set_value(config_validator, config_map):
	config_validator.set_value(config_map, config_map.VALUE)


func _get_value(config_validator, config_map):
	return config_validator.config_file.get_value(config_map.SECTION, config_map.KEY)


# Helper object to store both file, path and error message
class ConfigValidator:
	var config_file
	var config_path
	var message = ""
	
	func _init(config_file, config_path):
		self.config_file = config_file
		self.config_path = config_path
	
	func set_value(config_map, value):
		config_file.set_value(config_map.SECTION, config_map.KEY, value)
	
	func save():
		config_file.save(config_path)
	
	func log_message(log_level):
		if(message.length() > 0):
			Log.msg(log_level, message)
	
	# In case we want to reuse this later
	func clear():
		config_file = null
		config_path = null
		message = ""