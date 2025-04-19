# Noon

A modern, sleek UI library with a focus on simplicity, aesthetics, and customization.

## Features

- Clean, modern design with smooth animations and ripple effects
- Easy to use API for creating windows, tabs, sections, and elements
- Includes  UI elements: buttons, toggles, sliders, labels, and dropdowns
- Draggable windows (from topbar only) with minimize functionality

## Usage

```lua
-- Load the library
local Noon = loadstring(game:HttpGet("https://raw.githubusercontent.com/emptier-lab/Noon/refs/heads/main/UI.lua"))()

-- Set a theme (optional)
Noon:SetTheme("TokyoNight") -- Options: Default, TokyoNight, Japan, Sun, Midnight

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

-- Create a dropdown
local options = {"Option 1", "Option 2", "Option 3"}
local dropdown = FeaturesSection:Dropdown("Select Option", options, function(selected)
    print("Selected:", selected)
end)

-- You can update dropdown options later
dropdown:Refresh({"New Option 1", "New Option 2"})

-- You can programmatically select a value
dropdown:Select("New Option 1")

-- Add theme selector to your UI
local themes = {"Default", "TokyoNight", "Japan", "Sun", "Midnight"}
ConfigSection:Dropdown("Theme", themes, function(selected)
    Noon:SetTheme(selected)
end)
```

## Credits

empty? - everything ;(
