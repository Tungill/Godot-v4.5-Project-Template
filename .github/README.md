# Godot-v4.5-Project-Template
Template with custom ProjectSettings used for non-pixel art games.
## Table of contents
1. []()
    - []()
    - []()
2. []()
# Modifications
## Project settings
### Display/Window
- Viewport Width/Height changed to ```1280*720``` resolution for non-pixel art games. ![Viewport Width/Height settings](/.github/images/display_window_01.jpg)
- Stretch Mode changed to ```canvas_items``` as recommended for non-pixel art games.
- Stretch Aspect changed to ```expand``` as recommended for non-pixel art games. ![Stretch Mode/Aspect settings](/.github/images/display_window_02.jpg)
### Debug/GDscript
- Untyped/Inferred Declaration changed to ```Error``` to **enforce static typing** on variables, parameters and functions return. ![Untyped/Inferred Declaration settings](/.github/images/debug_gdscript_01.jpg) ![Untyped variable](/.github/images/debug_gdscript_example_01.jpg) ![Untyped parameter](/.github/images/debug_gdscript_example_02.jpg) ![All typed](/github/images/debug_gdscript_example_03.jpg)
## Folder structure
Taking inspiration from the [UE4/5 Style Guide](https://github.com/Allar/ue5-style-guide?tab=readme-ov-file#2-content-directory-structure), partially adpated to Godot on [Godot Style Guide](https://github.com/bakneko/godot-style-guide?tab=readme-ov-file#3-directory).

```folder_name_readme.txt``` are available in each pre-existing folder to give you more information about their content.  

DISCLAIMER: _I never used this structure on a real project yet. I found this one because I was not satisfied with how I did things on past project. This section will be modified when I gather feedback on practical use._
``` plain-text
|-- res://
    |
    |-- addons
    |   |-- ...
    |-- project_name
    |   |-- meshes?
    |   |   |-- ...
    |   |-- characters
    |   |   |-- character_name
    |   |   |    |-- ...
    |   |   |-- common
    |   |       |-- animations
    |   |       |-- audio
    |   |-- effects?
    |   |   |-- ...
    |   |-- maps
    |   |   |-- ...
    |   |-- ui
    |       |-- hud
    |-- core
    |   |-- debug
    |   |-- fonts
    |   |-- images
    |   |-- autoloads
    |   |   |-- event_bus.gd
    |   |-- ui
    |   |   |-- menu
    |   |   |-- pause
    |   |       |-- setting_menu.gd
    |   |-- audio_bus_layout.tres
    |-- local_testing
```
## Pre-made scripts & nodes
### Audio Bus
Set a default ```audio_bus_layout.tres``` with 3 buses:
1. Master
2. Music → routed to Master
3. SFX → routed to Master

![Audio bus](/.github/images/audio_bus_01.jpg)

Music and SFX are modified by the [Setting Menu](#settings) to split AudioStream in two.  
Changing the dB volume of Master will impact Music and SFX.
### Event Bus
The ```event_bus.gd``` is a script set as an Autoload on the project. It is used to make components able to communicate through a publish-subscribe pattern without referencing each other.
It is done through the use of signals, which are globally accessible due to the script being an Autoload. This script is meant to only contain signals and doesn't work as a game manager.  

There are several ways to do an event bus in Godot. _For instance, it's possible to set up an event bus where you dynamically create the signals instead of pre-writing them like here._
I choose this version because it allows me to auto-complete when using a signal in a component, thus nullifying the possibility of typo for my events.

This event bus includes an example on how to set up signals with ```signal property_changed(section: StringName, id_name: StringName, data: Variant)```, used for [Debug](#debug).
### Debug
```debug_panel.tscn``` with ```debug.gd``` attached:
- Can add new properties to display on the ```debug_panel.tscn``` by using the signal in [EventBus](#event-bus).
- Those properties are auto-organised by sections, in alphabetic order, for better clarity.
- Those properties are updated if the signal is called again and the property already exists.

![Debug panel](/.github/images/debug_panel_example_02.jpg)

**Tips:** If you want to update the property everytime the variable change, you should add the ```Events.debug.property_changed.emit(...)``` of the signal inside a [setter](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html#properties-setters-and-getters) function for the variable.
### Settings
```setting_menu.gd``` script with sounds functionalities:
- Load/save settings into a ```ConfigFile```.
- Change music & sfx volume in real time (play a chosen sfx).
- Doesn't save the new settings if close without saving first.
