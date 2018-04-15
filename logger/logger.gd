extends Node


func get_logger(script_name):
	return Log.new(script_name)


class Log:
	# GLOBAL DEFAULT LOGGING CONFIGURATION
	# NB: Highly recommend you turn off logging on release, as it significanly reduces speed.
	# - This can be overridden within each script that utilizes the log tool.
	var info_logging = true
	var debug_logging = true
	var warn_logging = true
	var error_logging = true
	
	# LOGGING 
	const LOG_FORMAT = " {level} [{current_time}] [{script_name}] [{function_name}] >> {msg}"
	
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
		return Stopwatch.create_started()
	
	func end():
		current_function_name = ""
	
	func info(message, function_name = ""):
		var level = "INFO"
		_log(level, message, function_name)
	
	func debug(message, function_name = ""):
		var level = "DEBUG"
		_log(level, message, function_name)

	func warn(message, function_name = ""):
		var level = "WARN"
		_log(level, message, function_name)
		
	func error(message, function_name = ""):
		var level = "ERROR"
		_log(level, message, function_name)
	
	func _log(level, message, function_name = ""):
		if(!debug_logging):
			return
		
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