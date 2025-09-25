extends Control
class_name Debug

## Container where are added new properties with [method _update_or_add_debug_property].
@export var container: VBoxContainer
## List of properties created.
var properties: Array


func _ready() -> void:
	self.visible = false
	# Connect to signals and trigger custom function.
	Events.debug.property_changed.connect(_update_or_add_debug_property)


func _input(event: InputEvent) -> void:
	# Only works in the editor and in debug export build.
	if event.is_action_pressed("debug_panel") and OS.is_debug_build():
		self.visible = !self.visible


## - [param section] which own the property: e.g. "Player", "Enemy", "World", "". Used to sort properties by categories when using [method _sort_properties]. [br]
## - [param id_name] is the name of the property itself: e.g. "Currrent Health", "Current Animation", "Weapon Equiped". [br]
## - [param data] is the value to display. [br]
## [br]
## After a new property is added, runs [method _sort_properties].
func _update_or_add_debug_property(section: StringName, id_name: StringName, data: Variant) -> void:
	var id: StringName = section + " " + id_name
	# Update existing property.
	if properties.has(id):
		var target: Label = container.find_child(id, true, false)
		target.text = id + ": " + str(data)
	# Create a new property label and add it.
	else:
		var property: Label = Label.new()
		container.add_child(property)
		property.name = id
		property.text = id + ": " + str(data)
		properties.append(id)
		_sort_properties()

## Sort the [member properties] in alphabetical order by [param section] and  [param id_name], then rearrange the labels inside [member container].
func _sort_properties() -> void:
	if properties.size() > 1:
		properties.sort_custom(_sort_in_alphabetical_oder)
		for id: StringName in properties:
			var child: Node = find_child(id, true, false)
			var index: int = properties.find(id)
			container.move_child(child, index)
# Using String type because sorting by StringName is unreliable since each are unique.
func _sort_in_alphabetical_oder(a: String, b: String) -> bool:
	return a < b
