##########################################################################################################
# How to use:
# 
# 1. Add stopwatch.gd to AutoLoad: Project -> Project Settings -> AutoLoad tab
# 2. When you wish to track time, create a stopwatch object: var my_stopwatch = Stopwatch.start_created()
# 3. When you wish to get the time used (stored as a string): var time_used = my_stopwatch.stop()
##########################################################################################################

extends Node

func create_started():
	var stopwatch = Stopwatch.new()
	return stopwatch

class Stopwatch:
	var time_start = null
	
	func _init():
		time_start = OS.get_ticks_msec()
	
	func stop():
		return str(OS.get_ticks_msec() - time_start) + " ms "