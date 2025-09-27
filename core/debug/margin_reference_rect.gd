@tool
## Custom script to use on a [class ReferenceRect] to update in real-time the
## borders of a [class MarginContainer] without margins. [br]
## The project needs to be reload for [code]@tool[/code] to apply on the Node.
extends ReferenceRect

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		var parent: Control = get_parent()
		if parent is MarginContainer:
			var margin: MarginContainer = parent
			_set_reference_rect(margin.size)

func _set_reference_rect(new_size: Vector2) -> void:
	if Engine.is_editor_hint():
		self.position = Vector2(0.0, 0.0)
		self.size = new_size
