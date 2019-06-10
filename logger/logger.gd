extends Node

# Change to false to completely disable logging
const ENABLE_LOGGING = true

# Use this on each script you wish to use the Logger:
# onready var Log = Logger.get_logger("script_name.gd")
func get_logger(script_name):
	if(ENABLE_LOGGING):
		return Log.new(script_name)
	else:
		return DummyLog.new()

class Log:
	# GLOBAL DEFAULT LOGGING CONFIGURATION
	# - This can be overridden within each script that utilizes the log tool.
	var info_logging = true
	var debug_logging = true
	var warn_logging = true
	var error_logging = true
	
	# LOGGING 
	const LOG_FORMAT = "[{current_time}] | {level} | [{script_name}] [{function_name}] >> {msg}"
	
	# Logger script name
	var script_name = ""
	var current_function_name = ""
	
	# Initializes the logger with the script name that is using it
	func _init(script_name = ""):
		self.script_name = script_name
	
	# Used to set function name at teh beginning of each function, 
	# in order to populate the logger with function name
	func start(function_name):
		current_function_name = function_name
	
	func end():
		current_function_name = ""
	
	func info(message, function_name = ""):
		if(!info_logging):
			return
		var level = "INFO "
		_log(level, message, function_name)
		
	func debug(message, function_name = ""):
		if(!debug_logging):
			return
		var level = "DEBUG"
		_log(level, message, function_name)

	func warn(message, function_name = ""):
		if(!warn_logging):
			return
		var level = "WARN "
		_log(level, message, function_name)
		
	func error(message, function_name = ""):
		if(!error_logging):
			return
		var level = "ERROR"
		_log(level, message, function_name)
	
	func _log(level, message, function_name = ""):
		if(function_name.empty()):
			function_name = current_function_name
		var log_message = LOG_FORMAT.format({"level": level, "current_time": _get_current_time(), "script_name": script_name, "function_name": function_name, "msg": message})
		print(log_message)
	
	func _get_current_time():
		var date_time = OS.get_datetime()
		var padding = 2
		_pad_zeros_in_dictionary(date_time, padding)
		
		# var time_format = "{year}.{month}." + ("{day}".pad_zeros(5)) + " - [{hour}:{minute}:{second}]"
		var time_format = "{year}.{month}.{day} {hour}:{minute}:{second}"
		return time_format.format(date_time)
	
	func _pad_zeros_in_dictionary(dictionary, padding):
		for key in dictionary:
			dictionary[key] = str(dictionary[key]).pad_zeros(padding)


# DummyLog is initialized if we have disabled logging. 
# This should effectively disable the logging without additional conditional checks, improving the speed considerably
# without the need to manually remove every log in the code for production.
class DummyLog:
	func _init():
		pass
	
	func start(function_name):
		pass
	
	func end():
		pass
	
	func info(message, function_name = ""):
		pass
	
	func debug(message, function_name = ""):
		pass
	
	func warn(message, function_name = ""):
		pass
	
	func error(message, function_name = ""):
		pas