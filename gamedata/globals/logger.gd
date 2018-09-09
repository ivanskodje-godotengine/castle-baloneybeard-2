# A simple logger tool that includes a time stamp and log level.
extends Node

# ---------------------------------
# "Public"
# 
enum LOG_LEVEL {
	INFO,
	DEBUG,
	WARN,
	ERROR
}

func _init(script_name):
	self._script_name = script_name

func info(msg):
	msg(LOG_LEVEL.INFO, msg)

func debug(msg):
	msg(LOG_LEVEL.DEBUG, msg)

func warn(msg):
	msg(LOG_LEVEL.WARN, msg)

func error(msg):
	msg(LOG_LEVEL.ERROR, msg)



# ---------------------------------
# "Private"
#
var _script_name

func msg(log_level, msg):
	print(_get_time() + _get_log_level(log_level) + _get_script_name() + ": " + str(msg))

func _get_time():
	return " " + _get_formatted_datetime() + " -"

func _get_log_level(log_level):
	return " [" + _get_log_level_string(log_level) + "]"

func _get_script_name():
	if(_script_name != null && _script_name != ""):
		return " (" + _script_name + ")"

func _get_log_level_string(log_level):
	if(LOG_LEVEL.INFO == log_level):
		return "INFO "
	if(LOG_LEVEL.DEBUG == log_level):
		return "DEBUG"
	if(LOG_LEVEL.WARN == log_level):
		return "WARN "
	if(LOG_LEVEL.ERROR == log_level):
		return "ERROR"


func _get_formatted_datetime():
	var datetime = OS.get_datetime()
	
	var year = datetime.year
	var month = datetime.month
	var day = datetime.day
	
	var hours = datetime.hour
	var minutes = datetime.minute
	var seconds = datetime.second
	
	# Format: yyyy-mm-dd HH:mm:ss
	return str(year) + "-" + str(month).pad_zeros(2) + "-" + str(day).pad_zeros(2) + " " + str(hours).pad_zeros(2) + ":" + str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)