# Noon UI Library

A modern, sleek UI library for Roblox exploits with a focus on simplicity and aesthetics.

## Features

- Clean, modern design with smooth animations
- Easy to use API for creating windows, tabs, sections, and elements
- Includes common UI elements: buttons, toggles, sliders, and labels
- Draggable windows with minimize functionality

## Usage

```lua
-- Load the library
local Noon = loadstring(game:HttpGet("https://raw.githubusercontent.com/USERNAME/noon-ui/main/NoonLibrary.lua"))()

-- Create a window
local Window = Noon:CreateWindow("Noon UI", "Game Name")

-- Create tabs
local MainTab = Window:Tab("Main")
local SettingsTab = Window:Tab("Settings")

-- Create sections
local FeaturesSection = MainTab:Section("Features")
local ConfigSection = SettingsTab:Section("Configuration")

-- Add elements
FeaturesSection:Button("Click Me", function()
    print("Button clicked!")
end)

FeaturesSection:Toggle("Enable Feature", false, function(toggled)
    print("Toggle state:", toggled)
end)

FeaturesSection:Slider("Speed", 0, 100, 50, function(value)
    print("Slider value:", value)
end)

FeaturesSection:Label("This is a label")
```

## Credits

empty - everything ;(
