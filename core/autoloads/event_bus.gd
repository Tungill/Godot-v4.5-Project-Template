## An Autoloads node used to make an Event Bus pattern.
## 
## Pattern using publish-subscribe-style communication between components without requiring the components to explicitly register with one another.
## Inspired by [url=https://youtu.be/yB3Wv-Lr7pg?list=PLeG_dAglpVo5oOrjQqDTMQadVDqe1Zsom]Eric Peterson's talk[/url].[br]
## [br]
## - Functions, variables and so on, should [b]never[/b] be used in this script. Only signals.[br]
extends Node
class_name EventBus
@warning_ignore_start("unused_signal") # Avoid unecessary warnings in the output.

# Use local classes to organise signals into categories.
class DebugEvents: # This is a single category.
	signal property_changed(section: StringName, id_name: StringName, data: Variant) 
	# ... other signals.
# Mandatory to reference the local class and access its signals. Name the category carefully.
var debug: DebugEvents = DebugEvents.new()

# Repeat the above structure for every category of events you want to make.
# Enter your events categories and signals.
