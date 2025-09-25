# Godot-v4.5-Project-Template
Template with custom ProjectSettings used for non-pixel art games.
TODO (order may vary)
- list of features
- explain current ProjectSettings (error + window + etc)
- guide to use template + .gitignore for "local_testing"

# Modifications
## Project settings
### Display/Window
- Viewport Width/Height changed to ```1280*720``` resolution for non-pixel art games. ![Viewport Width/Height settings](/github/images/display_window_01.jpg)
- Stretch Mode changed to ```canvas_items``` as recommended for non-pixel art games.
- Stretch Aspect changed to ```expand``` as recommended for non-pixel art games. ![Stretch Mode/Aspect settings](/github/images/display_window_02.jpg)
### Debug/GDscript
- Untyped/Inferred Declaration changed to ```Error``` to **enforce static typing** on variables, parameters and functions return. ![Untyped/Inferred Declaration settings](/github/images/debug_gdscript_01.jpg) ![Untyped variable](/github/images/debug_gdscript_example_01.jpg) ![Untyped parameter](/github/images/debug_gdscript_example_02.jpg) ![All typed](/github/images/debug_gdscript_example_03.jpg)
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
    |   |-- meshes
    |   |   |-- theme_01
    |   |   |   |-- props_01
    |   |   |   |   |-- ...
    |   |-- characters
    |   |   |-- character_name
    |   |   |    |-- ...
    |   |   |-- common
    |   |       |-- animations
    |   |       |-- audio
    |   |-- effects
    |   |   |-- theme_01
    |   |       |-- effect_01
    |   |           |-- effect_01_halo.png
    |   |           |-- effect_01.tscn
    |   |-- maps
    |   |   |-- sandbox.tscn
    |   |-- ui
    |       |-- hud
    |-- core
    |   |-- fonts
    |   |-- images
    |   |-- autoloads
    |   |-- ui
    |       |-- menu
    |       |-- pause
    |-- local_testing
```
## 
