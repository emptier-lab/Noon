local Noon = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CoreGui = game:GetService("CoreGui")

local NoonGui = Instance.new("ScreenGui")
NoonGui.Name = "NoonUI"
NoonGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
NoonGui.ResetOnSpawn = false

if syn then
    syn.protect_gui(NoonGui)
    NoonGui.Parent = CoreGui
elseif gethui then
    NoonGui.Parent = gethui()
else
    NoonGui.Parent = CoreGui
end

local function Ripple(obj)
    spawn(function()
        local Mouse = game.Players.LocalPlayer:GetMouse()
        local Circle = Instance.new("ImageLabel")
        Circle.Name = "Circle"
        Circle.Parent = obj
        Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Circle.BackgroundTransparency = 1
        Circle.ZIndex = 10
        Circle.Image = "rbxassetid://266543268"
        Circle.ImageColor3 = Color3.fromRGB(210, 210, 210)
        Circle.ImageTransparency = 0.8
        
        local NewX, NewY = Mouse.X - Circle.AbsolutePosition.X, Mouse.Y - Circle.AbsolutePosition.Y
        Circle.Position = UDim2.new(0, NewX, 0, NewY)
        
        local Size = obj.AbsoluteSize.X
        TweenService:Create(Circle, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -Size/2, 0.5, -Size/2), Size = UDim2.new(0, Size, 0, Size), ImageTransparency = 1}):Play()
        wait(0.5)
        Circle:Destroy()
    end)
end

local function DraggableObject(obj)
    local UserInputService = game:GetService("UserInputService")
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = obj.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    obj.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

function Noon:CreateWindow(title, gameName)
    local window = {}
    
    local MainFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local TopBar = Instance.new("Frame")
    local UICorner_2 = Instance.new("UICorner")
    local Title = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")
    local MinimizeButton = Instance.new("TextButton")
    local TabHolder = Instance.new("Frame")
    local UICorner_3 = Instance.new("UICorner")
    local TabScroll = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")
    local UIPadding = Instance.new("UIPadding")
    local ContentContainer = Instance.new("Frame")
    
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = NoonGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -175)
    MainFrame.Size = UDim2.new(0, 600, 0, 350)
    MainFrame.ClipsDescendants = true
    
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame
    
    TopBar.Name = "TopBar"
    TopBar.Parent = MainFrame
    TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TopBar.Size = UDim2.new(1, 0, 0, 30)
    
    UICorner_2.CornerRadius = UDim.new(0, 8)
    UICorner_2.Parent = TopBar
    
    Title.Name = "Title"
    Title.Parent = TopBar
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = title or "Noon UI"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 14.000
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = TopBar
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.BackgroundTransparency = 1.000
    CloseButton.Position = UDim2.new(1, -30, 0, 0)
    CloseButton.Size = UDim2.new(0, 30, 1, 0)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 14.000
    
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Parent = TopBar
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.BackgroundTransparency = 1.000
    MinimizeButton.Position = UDim2.new(1, -60, 0, 0)
    MinimizeButton.Size = UDim2.new(0, 30, 1, 0)
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Text = "-"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.TextSize = 14.000
    
    TabHolder.Name = "TabHolder"
    TabHolder.Parent = MainFrame
    TabHolder.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabHolder.Position = UDim2.new(0, 10, 0, 40)
    TabHolder.Size = UDim2.new(0, 120, 0, 300)
    
    UICorner_3.CornerRadius = UDim.new(0, 8)
    UICorner_3.Parent = TabHolder
    
    TabScroll.Name = "TabScroll"
    TabScroll.Parent = TabHolder
    TabScroll.Active = true
    TabScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabScroll.BackgroundTransparency = 1.000
    TabScroll.BorderSizePixel = 0
    TabScroll.Size = UDim2.new(1, 0, 1, 0)
    TabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabScroll.ScrollBarThickness = 2
    TabScroll.ScrollBarImageColor3 = Color3.fromRGB(40, 40, 40)
    
    UIListLayout.Parent = TabScroll
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)
    
    UIPadding.Parent = TabScroll
    UIPadding.PaddingTop = UDim.new(0, 5)
    UIPadding.PaddingLeft = UDim.new(0, 5)
    UIPadding.PaddingRight = UDim.new(0, 5)
    
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = MainFrame
    ContentContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ContentContainer.BackgroundTransparency = 1.000
    ContentContainer.Position = UDim2.new(0, 140, 0, 40)
    ContentContainer.Size = UDim2.new(0, 450, 0, 300)
    
    DraggableObject(MainFrame)
    
    CloseButton.MouseButton1Click:Connect(function()
        NoonGui:Destroy()
    end)
    
    local minimized = false
    MinimizeButton.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            TweenService:Create(MainFrame, TweenInfo.new(0.5), {Size = UDim2.new(0, 600, 0, 30)}):Play()
            TabHolder.Visible = false
            ContentContainer.Visible = false
        else
            TweenService:Create(MainFrame, TweenInfo.new(0.5), {Size = UDim2.new(0, 600, 0, 350)}):Play()
            TabHolder.Visible = true
            ContentContainer.Visible = true
        end
    end)
    
    local Tabs = {}
    local FirstTab = true
    
    function window:Tab(name, icon)
        local tab = {}
        
        local TabButton = Instance.new("TextButton")
        local TabContent = Instance.new("ScrollingFrame")
        local UIListLayout_2 = Instance.new("UIListLayout")
        local UIPadding_2 = Instance.new("UIPadding")
        
        TabButton.Name = name.."Tab"
        TabButton.Parent = TabScroll
        TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TabButton.Size = UDim2.new(1, 0, 0, 30)
        TabButton.Font = Enum.Font.GothamSemibold
        TabButton.Text = name
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.TextSize = 12.000
        TabButton.AutoButtonColor = false
        
        local UICorner_Tab = Instance.new("UICorner")
        UICorner_Tab.CornerRadius = UDim.new(0, 6)
        UICorner_Tab.Parent = TabButton
        
        TabContent.Name = name.."Content"
        TabContent.Parent = ContentContainer
        TabContent.Active = true
        TabContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabContent.BackgroundTransparency = 1.000
        TabContent.BorderSizePixel = 0
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.ScrollBarThickness = 2
        TabContent.ScrollBarImageColor3 = Color3.fromRGB(40, 40, 40)
        TabContent.Visible = FirstTab
        
        UIListLayout_2.Parent = TabContent
        UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout_2.Padding = UDim.new(0, 10)
        
        UIPadding_2.Parent = TabContent
        UIPadding_2.PaddingTop = UDim.new(0, 5)
        UIPadding_2.PaddingLeft = UDim.new(0, 5)
        UIPadding_2.PaddingRight = UDim.new(0, 5)
        
        if FirstTab then
            TabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            FirstTab = false
        end
        
        TabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(TabScroll:GetChildren()) do
                if v:IsA("TextButton") then
                    TweenService:Create(v, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
                end
            end
            
            for _, v in pairs(ContentContainer:GetChildren()) do
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            
            TweenService:Create(TabButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
            TabContent.Visible = true
            Ripple(TabButton)
        end)
        
        UIListLayout_2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_2.AbsoluteContentSize.Y + 10)
        end)
        
        function tab:Section(name)
            local section = {}
            
            local SectionFrame = Instance.new("Frame")
            local UICorner_4 = Instance.new("UICorner")
            local SectionTitle = Instance.new("TextLabel")
            local SectionContent = Instance.new("Frame")
            local UIListLayout_3 = Instance.new("UIListLayout")
            local UIPadding_3 = Instance.new("UIPadding")
            
            SectionFrame.Name = name.."Section"
            SectionFrame.Parent = TabContent
            SectionFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            SectionFrame.Size = UDim2.new(1, 0, 0, 36)
            SectionFrame.ClipsDescendants = true
            
            UICorner_4.CornerRadius = UDim.new(0, 6)
            UICorner_4.Parent = SectionFrame
            
            SectionTitle.Name = "SectionTitle"
            SectionTitle.Parent = SectionFrame
            SectionTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionTitle.BackgroundTransparency = 1.000
            SectionTitle.Position = UDim2.new(0, 10, 0, 0)
            SectionTitle.Size = UDim2.new(1, -20, 0, 36)
            SectionTitle.Font = Enum.Font.GothamSemibold
            SectionTitle.Text = name
            SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SectionTitle.TextSize = 14.000
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            SectionContent.Name = "SectionContent"
            SectionContent.Parent = SectionFrame
            SectionContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionContent.BackgroundTransparency = 1.000
            SectionContent.Position = UDim2.new(0, 0, 0, 36)
            SectionContent.Size = UDim2.new(1, 0, 0, 0)
            
            UIListLayout_3.Parent = SectionContent
            UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout_3.Padding = UDim.new(0, 8)
            
            UIPadding_3.Parent = SectionContent
            UIPadding_3.PaddingBottom = UDim.new(0, 10)
            UIPadding_3.PaddingLeft = UDim.new(0, 10)
            UIPadding_3.PaddingRight = UDim.new(0, 10)
            UIPadding_3.PaddingTop = UDim.new(0, 10)
            
            UIListLayout_3:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                SectionContent.Size = UDim2.new(1, 0, 0, UIListLayout_3.AbsoluteContentSize.Y + 20)
                SectionFrame.Size = UDim2.new(1, 0, 0, 36 + SectionContent.Size.Y.Offset)
            end)
            
            function section:Button(text, callback)
                local Button = Instance.new("TextButton")
                local UICorner_5 = Instance.new("UICorner")
                
                Button.Name = text.."Button"
                Button.Parent = SectionContent
                Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                Button.Size = UDim2.new(1, 0, 0, 30)
                Button.Font = Enum.Font.GothamSemibold
                Button.Text = text
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.TextSize = 12.000
                Button.AutoButtonColor = false
                
                UICorner_5.CornerRadius = UDim.new(0, 6)
                UICorner_5.Parent = Button
                
                Button.MouseButton1Click:Connect(function()
                    Ripple(Button)
                    if callback then callback() end
                end)
                
                Button.MouseEnter:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}):Play()
                end)
                
                Button.MouseLeave:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
                end)
                
                return Button
            end
            
            function section:Toggle(text, default, callback)
                local toggled = default or false
                local Toggle = Instance.new("TextButton")
                local UICorner_6 = Instance.new("UICorner")
                local Title_2 = Instance.new("TextLabel")
                local ToggleFrame = Instance.new("Frame")
                local UICorner_7 = Instance.new("UICorner")
                local ToggleButton = Instance.new("Frame")
                local UICorner_8 = Instance.new("UICorner")
                
                Toggle.Name = text.."Toggle"
                Toggle.Parent = SectionContent
                Toggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                Toggle.Size = UDim2.new(1, 0, 0, 30)
                Toggle.Font = Enum.Font.GothamSemibold
                Toggle.Text = ""
                Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
                Toggle.TextSize = 12.000
                Toggle.AutoButtonColor = false
                
                UICorner_6.CornerRadius = UDim.new(0, 6)
                UICorner_6.Parent = Toggle
                
                Title_2.Name = "Title"
                Title_2.Parent = Toggle
                Title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Title_2.BackgroundTransparency = 1.000
                Title_2.Position = UDim2.new(0, 10, 0, 0)
                Title_2.Size = UDim2.new(1, -60, 1, 0)
                Title_2.Font = Enum.Font.GothamSemibold
                Title_2.Text = text
                Title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title_2.TextSize = 12.000
                Title_2.TextXAlignment = Enum.TextXAlignment.Left
                
                ToggleFrame.Name = "ToggleFrame"
                ToggleFrame.Parent = Toggle
                ToggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                ToggleFrame.Position = UDim2.new(1, -50, 0.5, -8)
                ToggleFrame.Size = UDim2.new(0, 40, 0, 16)
                
                UICorner_7.CornerRadius = UDim.new(1, 0)
                UICorner_7.Parent = ToggleFrame
                
                ToggleButton.Name = "ToggleButton"
                ToggleButton.Parent = ToggleFrame
                ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleButton.Position = UDim2.new(0, 2, 0.5, -6)
                ToggleButton.Size = UDim2.new(0, 12, 0, 12)
                
                UICorner_8.CornerRadius = UDim.new(1, 0)
                UICorner_8.Parent = ToggleButton
                
                local function UpdateToggle()
                    if toggled then
                        TweenService:Create(ToggleFrame, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 120, 255)}):Play()
                        TweenService:Create(ToggleButton, TweenInfo.new(0.3), {Position = UDim2.new(1, -14, 0.5, -6)}):Play()
                    else
                        TweenService:Create(ToggleFrame, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
                        TweenService:Create(ToggleButton, TweenInfo.new(0.3), {Position = UDim2.new(0, 2, 0.5, -6)}):Play()
                    end
                    
                    if callback then callback(toggled) end
                end
                
                Toggle.MouseButton1Click:Connect(function()
                    toggled = not toggled
                    UpdateToggle()
                    Ripple(Toggle)
                end)
                
                Toggle.MouseEnter:Connect(function()
                    TweenService:Create(Toggle, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}):Play()
                end)
                
                Toggle.MouseLeave:Connect(function()
                    TweenService:Create(Toggle, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
                end)
                
                UpdateToggle()
                
                return Toggle
            end
            
            function section:Slider(text, min, max, default, callback)
                local Slider = Instance.new("Frame")
                local UICorner_9 = Instance.new("UICorner")
                local Title_3 = Instance.new("TextLabel")
                local SliderFrame = Instance.new("Frame")
                local UICorner_10 = Instance.new("UICorner")
                local SliderButton = Instance.new("TextButton")
                local UICorner_11 = Instance.new("UICorner")
                local SliderInner = Instance.new("Frame")
                local UICorner_12 = Instance.new("UICorner")
                local Value = Instance.new("TextLabel")
                
                Slider.Name = text.."Slider"
                Slider.Parent = SectionContent
                Slider.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                Slider.Size = UDim2.new(1, 0, 0, 45)
                
                UICorner_9.CornerRadius = UDim.new(0, 6)
                UICorner_9.Parent = Slider
                
                Title_3.Name = "Title"
                Title_3.Parent = Slider
                Title_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Title_3.BackgroundTransparency = 1.000
                Title_3.Position = UDim2.new(0, 10, 0, 0)
                Title_3.Size = UDim2.new(1, -20, 0, 30)
                Title_3.Font = Enum.Font.GothamSemibold
                Title_3.Text = text
                Title_3.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title_3.TextSize = 12.000
                Title_3.TextXAlignment = Enum.TextXAlignment.Left
                
                SliderFrame.Name = "SliderFrame"
                SliderFrame.Parent = Slider
                SliderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                SliderFrame.Position = UDim2.new(0, 10, 0, 30)
                SliderFrame.Size = UDim2.new(1, -20, 0, 6)
                
                UICorner_10.CornerRadius = UDim.new(1, 0)
                UICorner_10.Parent = SliderFrame
                
                SliderButton.Name = "SliderButton"
                SliderButton.Parent = SliderFrame
                SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderButton.BackgroundTransparency = 1.000
                SliderButton.Size = UDim2.new(1, 0, 1, 0)
                SliderButton.Font = Enum.Font.SourceSans
                SliderButton.Text = ""
                SliderButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                SliderButton.TextSize = 14.000
                
                UICorner_11.CornerRadius = UDim.new(1, 0)
                UICorner_11.Parent = SliderButton
                
                SliderInner.Name = "SliderInner"
                SliderInner.Parent = SliderFrame
                SliderInner.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
                SliderInner.Size = UDim2.new(0.5, 0, 1, 0)
                
                UICorner_12.CornerRadius = UDim.new(1, 0)
                UICorner_12.Parent = SliderInner
                
                Value.Name = "Value"
                Value.Parent = Slider
                Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Value.BackgroundTransparency = 1.000
                Value.Position = UDim2.new(0.899999976, 0, 0, 0)
                Value.Size = UDim2.new(0, 40, 0, 30)
                Value.Font = Enum.Font.GothamSemibold
                Value.Text = tostring(default or min)
                Value.TextColor3 = Color3.fromRGB(255, 255, 255)
                Value.TextSize = 12.000
                
                local value = default or min
                local dragging = false
                
                local function UpdateSlider()
                    local percent = (value - min) / (max - min)
                    SliderInner.Size = UDim2.new(percent, 0, 1, 0)
                    Value.Text = tostring(value)
                    
                    if callback then callback(value) end
                end
                
                UpdateSlider()
                
                SliderButton.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                    end
                end)
                
                SliderButton.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = false
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        local percent = math.clamp((input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1)
                        value = math.floor(min + (max - min) * percent)
                        UpdateSlider()
                    end
                end)
                
                return Slider
            end
            
            function section:Label(text)
                local Label = Instance.new("TextLabel")
                
                Label.Name = text.."Label"
                Label.Parent = SectionContent
                Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Label.BackgroundTransparency = 1.000
                Label.Size = UDim2.new(1, 0, 0, 20)
                Label.Font = Enum.Font.GothamSemibold
                Label.Text = text
                Label.TextColor3 = Color3.fromRGB(255, 255, 255)
                Label.TextSize = 12.000
                
                function Label:Update(newText)
                    Label.Text = newText
                end
                
                return Label
            end
            
            return section
        end
        
        return tab
    end
    
    return window
end

return Noon
