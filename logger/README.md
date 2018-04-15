
# Logger
A small undeveloped logger tool in order to print out more details.
When used, it will by default print out debug, warn, error or info logging, 
unless set to false in the script or on the object itself.

# How to use
Add the logger.gd to AutoLoad: Select Project -> Project Settings, and choose the AutoLoad tab.
Recommend you use the name Logger for the global.

In order to use it, you create your Log objec on your script (not inside a function):
```
onready var Log = Logger.get_logger("your_script_name.gd")
```

You can then specify the function name at the beginning (optional) by using:
```
Log.start("function_name()")
```
Which will enable the Log object to keep track of which function you are currently in. It will stay there until you use `Log.end()`, or set a new `Log.start("other_function_name")`.

You can specify 4 logging levels; Log.info, Log.debug, Log.warn, and Log.error.
There is no difference between them, other than what will be written in the log, and whether or not the "x_logger" boolean is set to true or false in the logger.gd script.

## Example of Use:
### example.gd script:
```
extends Node

# Logging
onready var Log = Logger.get_logger("example.gd")

func _ready():
	var stopwatch = Log.start("_ready()")
	Log.info("Starting the Awesome game. ")
	
	# Do some work here
	Log.debug("Attempting to do something important. ")
	# ...
	
	# Some warning
	Log.warn("User forgot to configure something. Falling back to default values. ")
	
	# Some critical error that prevents the application to function
	Log.error("Unable to retrieve cheesecake from the oven. Terminating game. ")

	# Usually everything would stop by now, but this is just to show you 
	# how we would tell the logger to end, and forget the function name stored.
	Log.end()
```

### Output (with default formatting)
```
[2018.04.15 12:57:47] | INFO  | [example.gd] [_ready()] >> Starting the Awesome game. 
[2018.04.15 12:57:47] | DEBUG | [example.gd] [_ready()] >> Attempting to do something important. 
[2018.04.15 12:57:47] | WARN  | [example.gd] [_ready()] >> User forgot to configure something. Falling back to default values. 
[2018.04.15 12:57:47] | ERROR | [example.gd] [_ready()] >> Unable to retrieve cheesecake from the oven. Terminating game. 
 ```