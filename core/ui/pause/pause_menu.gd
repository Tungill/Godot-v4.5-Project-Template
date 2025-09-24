## ATTENTION: This node code is only working "When Paused" c.f. [member process_mode].
extends Control
class_name PauseMenu

const CONFIG_PATH: StringName = "user://user_settings.cfg"
const DEFAULT_VOLUME: float = 50.0

@export_group("Music")
@export var music_volume_slider: HSlider
@export var music_volume_value_label: Label
@export_group("SFX")
@export var sfx_volume_slider: HSlider
@export var sfx_volume_value_label: Label
@export var sfx_audio_player: AudioStreamPlayer
@export var default_sfx_stream: AudioStream
@export_group("Buttons")
@export var save_button: Button
@export var close_button: Button

var config: ConfigFile = ConfigFile.new()


func _ready() -> void:
	music_volume_slider.value_changed.connect(_on_music_volume_slider_changed)
	sfx_volume_slider.value_changed.connect(_on_sfx_volume_slider_changed)
	save_button.pressed.connect(_on_save_button_pressed)
	close_button.pressed.connect(_on_close_button_pressed)


func on_enter() -> void:
	load_settings()


func save_settings(music_volume: float, sfx_volume: float) -> void:
	config.set_value("audio", "music volume", music_volume)
	config.set_value("audio", "sfx volume", sfx_volume)
	var error: Variant = config.save(CONFIG_PATH)
	if error != OK:
		printerr("Error saving settings: ", error)


func load_settings() -> void:
	var error: Variant = config.load(CONFIG_PATH)
	if error != OK:
		printerr("Error loading settings: ", error)
		# Create a new config with default values.
		save_settings(DEFAULT_VOLUME, DEFAULT_VOLUME)
	
	# Update the visual on the sliders from saved config or default if null.
	music_volume_slider.value = config.get_value("audio", "music volume", DEFAULT_VOLUME)
	sfx_volume_slider.value = config.get_value("audio", "sfx volume", DEFAULT_VOLUME)


func _on_music_volume_slider_changed(value: float) -> void:
	music_volume_value_label.text = str(int(value))
	var volume_db: float = linear_to_db(value / music_volume_slider.max_value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), volume_db)

func _on_sfx_volume_slider_changed(value: float) -> void:
	sfx_volume_value_label.text = str(int(value))
	var volume_db: float = linear_to_db(value / sfx_volume_slider.max_value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), volume_db)
	# Plays a sound to give feedback on the change of SFX volume.
	sfx_audio_player.stream = default_sfx_stream
	sfx_audio_player.play()


func _on_save_button_pressed() -> void:
	save_settings(music_volume_slider.value, sfx_volume_slider.value)
	_on_exit()

func _on_close_button_pressed() -> void:
	# Values are reset to the existing config values.
	load_settings()
	_on_exit()


func _on_exit() -> void:
	self.visible = false
	get_tree().paused = false
