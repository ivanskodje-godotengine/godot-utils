# Stopwatch
A simple stopwatch tool to keep track of time used between start and stop.

# How to use
Add the stopwatch.gd script to AutoLoad as a global. Recommend you use the name Stopwatch.

Build a stopwatch object at the beginning of your function you wish to get the time spent on:
```
var stopwatch = Stopwatch.create_started()
```

At the end of your function (or wherever you can access the var), you can print out the time used by:
```
print("Ended in " + stopwatch.stop())
```

Output might look like this, depending how long it takes:
```
Ended in 2 ms
```