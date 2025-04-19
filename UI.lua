local Noon = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CoreGui = game:GetService("CoreGui")

Noon.Themes = {
    Default = {
        Background = Color3.fromRGB(30, 30, 30),
        TopBar = Color3.fromRGB(25, 25, 25),
        Section = Color3.fromRGB(35, 35, 35),
        Element = Color3.fromRGB(45, 45, 45),
        ElementHover = Color3.fromRGB(55, 55, 55),
        Text = Color3.fromRGB(255, 255, 255),
        Accent = Color3.fromRGB(0, 120, 255)
    },
    TokyoNight = {
        Background = Color3.fromRGB(26, 27, 38),
        TopBar = Color3.fromRGB(22, 22, 30),
        Section = Color3.fromRGB(30, 32, 45),
        Element = Color3.fromRGB(38, 40, 55),
        ElementHover = Color3.fromRGB(48, 50, 65),
        Text = Color3.fromRGB(192, 202, 245),
        Accent = Color3.fromRGB(125, 207, 255)
    },
    Japan = {
        Background = Color3.fromRGB(40, 40, 40),
        TopBar = Color3.fromRGB(35, 35, 35),
        Section = Color3.fromRGB(45, 45, 45),
        Element = Color3.fromRGB(50, 50, 50),
        ElementHover = Color3.fromRGB(60, 60, 60),
        Text = Color3.fromRGB(255, 255, 255),
        Accent = Color3.fromRGB(255, 0, 0)
    },
    Sun = {
        Background = Color3.fromRGB(255, 236, 179),
        TopBar = Color3.fromRGB(255, 213, 128),
        Section = Color3.fromRGB(255, 245, 213),
        Element = Color3.fromRGB(255, 222, 153),
        ElementHover = Color3.fromRGB(255, 200, 100),
        Text = Color3.fromRGB(40, 40, 40),
        Accent = Color3.fromRGB(255, 128, 0)
    },
    Midnight = {
        Background = Color3.fromRGB(15, 15, 20),
        TopBar = Color3.fromRGB(10, 10, 15),
        Section = Color3.fromRGB(20, 20, 25),
        Element = Color3.fromRGB(30, 30, 35),
        ElementHover = Color3.fromRGB(40, 40, 45),
        Text = Color3.fromRGB(220, 220, 240),
        Accent = Color3.fromRGB(103, 89, 179)
    }
}

Noon.CurrentTheme = Noon.Themes.Default

-- Check for existing UI and remove it
if CoreGui:FindFirstChild("NoonUI") then
    CoreGui:FindFirstChild("NoonUI"):Destroy()
end

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

local function DraggableObject(object, dragArea)
    local UserInputService = game:GetService("UserInputService")
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        object.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    dragArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = object.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    dragArea.InputChanged:Connect(function(input)
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

function Noon:SetTheme(themeName)
    if self.Themes[themeName] then
        self.CurrentTheme = self.Themes[themeName]
        
        if self.Windows then
            for _, window in pairs(self.Windows) do
                if window.ApplyTheme then
                    window:ApplyTheme()
                end
            end
        end
    end
end

function Noon:CreateWindow(title, gameName)
    local window = {}
    
    if not Noon.Windows then
        Noon.Windows = {}
    end
    
    table.insert(Noon.Windows, window)
    
    local MainFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local TopBar = Instance.new("Frame")
    local UICorner_2 = Instance.new("UICorner")
    local Title = Instance.new("TextLabel")
    local GameName = Instance.new("TextLabel")
    local Minimize = Instance.new("ImageButton")
    local Close = Instance.new("ImageButton")
    local TabHolder = Instance.new("Frame")
    local UICorner_3 = Instance.new("UICorner")
    local TabScroll = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")
    local UIPadding = Instance.new("UIPadding")
    local ContentContainer = Instance.new("Frame")
    
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = NoonGui
    MainFrame.BackgroundColor3 = Noon.CurrentTheme.Background
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
    MainFrame.Size = UDim2.new(0, 500, 0, 300)
    MainFrame.ClipsDescendants = true
    
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = MainFrame
    
    TopBar.Name = "TopBar"
    TopBar.Parent = MainFrame
    TopBar.BackgroundColor3 = Noon.CurrentTheme.TopBar
    TopBar.Size = UDim2.new(1, 0, 0, 30)
    
    UICorner_2.CornerRadius = UDim.new(0, 6)
    UICorner_2.Parent = TopBar
    
    Title.Name = "Title"
    Title.Parent = TopBar
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = title or "Noon UI"
    Title.TextColor3 = Noon.CurrentTheme.Text
    Title.TextSize = 14.000
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    GameName.Name = "GameName"
    GameName.Parent = TopBar
    GameName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    GameName.BackgroundTransparency = 1.000
    GameName.Position = UDim2.new(0, 10, 0.5, 0)
    GameName.Size = UDim2.new(0, 200, 0, 15)
    GameName.Font = Enum.Font.Gotham
    GameName.Text = gameName or ""
    GameName.TextColor3 = Noon.CurrentTheme.Text
    GameName.TextSize = 12.000
    GameName.TextTransparency = 0.400
    GameName.TextXAlignment = Enum.TextXAlignment.Left
    
    Minimize.Name = "Minimize"
    Minimize.Parent = TopBar
    Minimize.BackgroundTransparency = 1.000
    Minimize.Position = UDim2.new(1, -60, 0, 0)
    Minimize.Size = UDim2.new(0, 30, 0, 30)
    Minimize.Image = "rbxassetid://7072719338"
    Minimize.ImageColor3 = Noon.CurrentTheme.Text
    
    Close.Name = "Close"
    Close.Parent = TopBar
    Close.BackgroundTransparency = 1.000
    Close.Position = UDim2.new(1, -30, 0, 0)
    Close.Size = UDim2.new(0, 30, 0, 30)
    Close.Image = "rbxassetid://7072725342"
    Close.ImageColor3 = Noon.CurrentTheme.Text
    
    TabHolder.Name = "TabHolder"
    TabHolder.Parent = MainFrame
    TabHolder.BackgroundColor3 = Noon.CurrentTheme.TopBar
    TabHolder.Position = UDim2.new(0, 0, 0, 30)
    TabHolder.Size = UDim2.new(0, 120, 1, -30)
    
    UICorner_3.CornerRadius = UDim.new(0, 6)
    UICorner_3.Parent = TabHolder
    
    TabScroll.Name = "TabScroll"
    TabScroll.Parent = TabHolder
    TabScroll.Active = true
    TabScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabScroll.BackgroundTransparency = 1.000
    TabScroll.BorderSizePixel = 0
    TabScroll.Position = UDim2.new(0, 0, 0, 10)
    TabScroll.Size = UDim2.new(1, 0, 1, -10)
    TabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabScroll.ScrollBarThickness = 2
    TabScroll.ScrollBarImageColor3 = Color3.fromRGB(40, 40, 40)
    
    UIListLayout.Parent = TabScroll
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)
    
    UIPadding.Parent = TabScroll
    UIPadding.PaddingTop = UDim.new(0, 5)
    
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = MainFrame
    ContentContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ContentContainer.BackgroundTransparency = 1.000
    ContentContainer.Position = UDim2.new(0, 125, 0, 35)
    ContentContainer.Size = UDim2.new(1, -130, 1, -40)
    
    -- Only allow dragging from the TopBar
    DraggableObject(MainFrame, TopBar)
    
    -- Minimize button functionality
    local minimized = false
    local originalSize = MainFrame.Size
    local originalPosition = MainFrame.Position
    
    Minimize.MouseButton1Click:Connect(function()
        minimized = not minimized
        
        if minimized then
            TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, originalSize.X.Offset, 0, 30)}):Play()
            TweenService:Create(ContentContainer, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, -130, 0, 0)}):Play()
            TweenService:Create(TabHolder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 120, 0, 0)}):Play()
        else
            TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = originalSize}):Play()
            TweenService:Create(ContentContainer, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, -130, 1, -40)}):Play()
            TweenService:Create(TabHolder, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 120, 1, -30)}):Play()
        end
    end)
    
    -- Close button functionality
    Close.MouseButton1Click:Connect(function()
        NoonGui:Destroy()
    end)
    
    UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabScroll.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
    end)
    
    function window:ApplyTheme()
        MainFrame.BackgroundColor3 = Noon.CurrentTheme.Background
        TopBar.BackgroundColor3 = Noon.CurrentTheme.TopBar
        TabHolder.BackgroundColor3 = Noon.CurrentTheme.TopBar
        Title.TextColor3 = Noon.CurrentTheme.Text
        GameName.TextColor3 = Noon.CurrentTheme.Text
        Minimize.ImageColor3 = Noon.CurrentTheme.Text
        Close.ImageColor3 = Noon.CurrentTheme.Text
        
        for _, v in pairs(TabScroll:GetChildren()) do
            if v:IsA("TextButton") then
                v.TextColor3 = Noon.CurrentTheme.Text
                if v.BackgroundColor3 ~= Noon.CurrentTheme.ElementHover then
                    v.BackgroundColor3 = Noon.CurrentTheme.Element
                end
            end
        end
        
        for _, v in pairs(ContentContainer:GetChildren()) do
            if v:IsA("ScrollingFrame") then
                for _, section in pairs(v:GetChildren()) do
                    if section:IsA("Frame") then
                        section.BackgroundColor3 = Noon.CurrentTheme.Section
                        
                        for _, element in pairs(section:GetDescendants()) do
                            if element:IsA("TextLabel") or element:IsA("TextButton") then
                                element.TextColor3 = Noon.CurrentTheme.Text
                                if element:IsA("TextButton") and element.BackgroundTransparency < 1 then
                                    element.BackgroundColor3 = Noon.CurrentTheme.Element
                                end
                            end
                            
                            if element.Name == "SliderInner" then
                                element.BackgroundColor3 = Noon.CurrentTheme.Accent
                            end
                            
                            if element.Name == "ToggleFrame" and element.BackgroundColor3 ~= Color3.fromRGB(30, 30, 30) then
                                element.BackgroundColor3 = Noon.CurrentTheme.Accent
                            end
                        end
                    end
                end
            end
        end
    end
    
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
        TabButton.BackgroundColor3 = FirstTab and Noon.CurrentTheme.ElementHover or Noon.CurrentTheme.Element
        TabButton.Size = UDim2.new(1, 0, 0, 30)
        TabButton.Font = Enum.Font.GothamSemibold
        TabButton.Text = name
        TabButton.TextColor3 = Noon.CurrentTheme.Text
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
        
        TabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(TabScroll:GetChildren()) do
                if v:IsA("TextButton") then
                    TweenService:Create(v, TweenInfo.new(0.3), {BackgroundColor3 = Noon.CurrentTheme.Element}):Play()
                end
            end
            
            for _, v in pairs(ContentContainer:GetChildren()) do
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            
            TweenService:Create(TabButton, TweenInfo.new(0.3), {BackgroundColor3 = Noon.CurrentTheme.ElementHover}):Play()
            TabContent.Visible = true
            Ripple(TabButton)
        end)
        
        UIListLayout_2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_2.AbsoluteContentSize.Y + 10)
        end)
        
        if FirstTab then
            FirstTab = false
        end
        
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
            SectionFrame.BackgroundColor3 = Noon.CurrentTheme.Section
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
            SectionTitle.TextColor3 = Noon.CurrentTheme.Text
            SectionTitle.TextSize = 14.000
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            SectionContent.Name = "SectionContent"
            SectionContent.Parent = SectionFrame
            SectionContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionContent.BackgroundTransparency = 1.000
            SectionContent.Position = UDim2.new(0, 0, 0, 36)
            SectionContent.Size = UDim2.new(1, 0, 1, -36)
            
            UIListLayout_3.Parent = SectionContent
            UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout_3.Padding = UDim.new(0, 5)
            
            UIPadding_3.Parent = SectionContent
            UIPadding_3.PaddingLeft = UDim.new(0, 10)
            UIPadding_3.PaddingRight = UDim.new(0, 10)
            UIPadding_3.PaddingTop = UDim.new(0, 5)
            UIPadding_3.PaddingBottom = UDim.new(0, 5)
            
            UIListLayout_3:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                SectionFrame.Size = UDim2.new(1, 0, 0, 36 + UIListLayout_3.AbsoluteContentSize.Y + 10)
            end)
            
            function section:Button(text, callback)
                local Button = Instance.new("TextButton")
                local UICorner_5 = Instance.new("UICorner")
                
                Button.Name = text.."Button"
                Button.Parent = SectionContent
                Button.BackgroundColor3 = Noon.CurrentTheme.Element
                Button.Size = UDim2.new(1, 0, 0, 30)
                Button.Font = Enum.Font.GothamSemibold
                Button.Text = text
                Button.TextColor3 = Noon.CurrentTheme.Text
                Button.TextSize = 12.000
                Button.AutoButtonColor = false
                
                UICorner_5.CornerRadius = UDim.new(0, 6)
                UICorner_5.Parent = Button
                
                Button.MouseButton1Click:Connect(function()
                    Ripple(Button)
                    if callback then callback() end
                end)
                
                Button.MouseEnter:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.3), {BackgroundColor3 = Noon.CurrentTheme.ElementHover}):Play()
                end)
                
                Button.MouseLeave:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.3), {BackgroundColor3 = Noon.CurrentTheme.Element}):Play()
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
                Toggle.BackgroundColor3 = Noon.CurrentTheme.Element
                Toggle.Size = UDim2.new(1, 0, 0, 30)
                Toggle.Font = Enum.Font.GothamSemibold
                Toggle.Text = ""
                Toggle.TextColor3 = Noon.CurrentTheme.Text
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
                Title_2.TextColor3 = Noon.CurrentTheme.Text
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
                        TweenService:Create(ToggleFrame, TweenInfo.new(0.3), {BackgroundColor3 = Noon.CurrentTheme.Accent}):Play()
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
                    TweenService:Create(Toggle, TweenInfo.new(0.3), {BackgroundColor3 = Noon.CurrentTheme.ElementHover}):Play()
                end)
                
                Toggle.MouseLeave:Connect(function()
                    TweenService:Create(Toggle, TweenInfo.new(0.3), {BackgroundColor3 = Noon.CurrentTheme.Element}):Play()
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
                Slider.BackgroundColor3 = Noon.CurrentTheme.Element
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
                Title_3.TextColor3 = Noon.CurrentTheme.Text
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
                SliderInner.BackgroundColor3 = Noon.CurrentTheme.Accent
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
                Value.TextColor3 = Noon.CurrentTheme.Text
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
                Label.TextColor3 = Noon.CurrentTheme.Text
                Label.TextSize = 12.000
                
                function Label:Update(newText)
                    Label.Text = newText
                end
                
                return Label
            end
            
            function section:Dropdown(text, options, callback)
                local Dropdown = Instance.new("Frame")
                local UICorner = Instance.new("UICorner")
                local Title = Instance.new("TextLabel")
                local DropButton = Instance.new("TextButton")
                local UICorner_2 = Instance.new("UICorner")
                local Arrow = Instance.new("ImageLabel")
                local DropdownFrame = Instance.new("Frame")
                local UICorner_3 = Instance.new("UICorner")
                local DropdownContainer = Instance.new("ScrollingFrame")
                local UIListLayout = Instance.new("UIListLayout")
                local UIPadding = Instance.new("UIPadding")
                
                Dropdown.Name = text.."Dropdown"
                Dropdown.Parent = SectionContent
                Dropdown.BackgroundColor3 = Noon.CurrentTheme.Element
                Dropdown.Size = UDim2.new(1, 0, 0, 30)
                
                UICorner.CornerRadius = UDim.new(0, 6)
                UICorner.Parent = Dropdown
                
                Title.Name = "Title"
                Title.Parent = Dropdown
                Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Title.BackgroundTransparency = 1.000
                Title.Position = UDim2.new(0, 10, 0, 0)
                Title.Size = UDim2.new(1, -40, 1, 0)
                Title.Font = Enum.Font.GothamSemibold
                Title.Text = text
                Title.TextColor3 = Noon.CurrentTheme.Text
                Title.TextSize = 12.000
                Title.TextXAlignment = Enum.TextXAlignment.Left
                
                DropButton.Name = "DropButton"
                DropButton.Parent = Dropdown
                DropButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropButton.BackgroundTransparency = 1.000
                DropButton.Size = UDim2.new(1, 0, 1, 0)
                DropButton.Font = Enum.Font.SourceSans
                DropButton.Text = ""
                DropButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                DropButton.TextSize = 14.000
                
                UICorner_2.CornerRadius = UDim.new(0, 6)
                UICorner_2.Parent = DropButton
                
                Arrow.Name = "Arrow"
                Arrow.Parent = Dropdown
                Arrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Arrow.BackgroundTransparency = 1.000
                Arrow.Position = UDim2.new(1, -25, 0.5, -8)
                Arrow.Size = UDim2.new(0, 16, 0, 16)
                Arrow.Image = "rbxassetid://6031091004"
                Arrow.ImageColor3 = Noon.CurrentTheme.Text
                
                DropdownFrame.Name = "DropdownFrame"
                DropdownFrame.Parent = Dropdown
                DropdownFrame.BackgroundColor3 = Noon.CurrentTheme.Element
                DropdownFrame.Position = UDim2.new(0, 0, 1, 5)
                DropdownFrame.Size = UDim2.new(1, 0, 0, 0)
                DropdownFrame.ClipsDescendants = true
                DropdownFrame.Visible = false
                DropdownFrame.ZIndex = 5
                
                UICorner_3.CornerRadius = UDim.new(0, 6)
                UICorner_3.Parent = DropdownFrame
                
                DropdownContainer.Name = "DropdownContainer"
                DropdownContainer.Parent = DropdownFrame
                DropdownContainer.Active = true
                DropdownContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownContainer.BackgroundTransparency = 1.000
                DropdownContainer.BorderSizePixel = 0
                DropdownContainer.Size = UDim2.new(1, 0, 1, 0)
                DropdownContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
                DropdownContainer.ScrollBarThickness = 2
                DropdownContainer.ScrollBarImageColor3 = Noon.CurrentTheme.Accent
                DropdownContainer.ZIndex = 5
                
                UIListLayout.Parent = DropdownContainer
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.Padding = UDim.new(0, 5)
                
                UIPadding.Parent = DropdownContainer
                UIPadding.PaddingBottom = UDim.new(0, 5)
                UIPadding.PaddingLeft = UDim.new(0, 5)
                UIPadding.PaddingRight = UDim.new(0, 5)
                UIPadding.PaddingTop = UDim.new(0, 5)
                
                local selected = options[1]
                local dropped = false
                
                local function UpdateDropdown()
                    if dropped then
                        DropdownFrame.Visible = true
                        TweenService:Create(Arrow, TweenInfo.new(0.3), {Rotation = 180}):Play()
                        TweenService:Create(DropdownFrame, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 0, math.min(#options * 25, 100))}):Play()
                    else
                        TweenService:Create(Arrow, TweenInfo.new(0.3), {Rotation = 0}):Play()
                        TweenService:Create(DropdownFrame, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 0, 0)}):Play()
                        spawn(function()
                            wait(0.3)
                            if not dropped then
                                DropdownFrame.Visible = false
                            end
                        end)
                    end
                end
                
                DropButton.MouseButton1Click:Connect(function()
                    dropped = not dropped
                    UpdateDropdown()
                    Ripple(Dropdown)
                end)
                
                Dropdown.MouseEnter:Connect(function()
                    TweenService:Create(Dropdown, TweenInfo.new(0.3), {BackgroundColor3 = Noon.CurrentTheme.ElementHover}):Play()
                end)
                
                Dropdown.MouseLeave:Connect(function()
                    TweenService:Create(Dropdown, TweenInfo.new(0.3), {BackgroundColor3 = Noon.CurrentTheme.Element}):Play()
                end)
                
                UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    DropdownContainer.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
                end)
                
                local function AddOptions(optionsList)
                    for _, option in pairs(optionsList) do
                        local OptionButton = Instance.new("TextButton")
                        local UICorner_4 = Instance.new("UICorner")
                        
                        OptionButton.Name = option.."Option"
                        OptionButton.Parent = DropdownContainer
                        OptionButton.BackgroundColor3 = Noon.CurrentTheme.Element
                        OptionButton.Size = UDim2.new(1, 0, 0, 20)
                        OptionButton.Font = Enum.Font.GothamSemibold
                        OptionButton.Text = option
                        OptionButton.TextColor3 = Noon.CurrentTheme.Text
                        OptionButton.TextSize = 12.000
                        OptionButton.ZIndex = 6
                        OptionButton.AutoButtonColor = false
                        
                        UICorner_4.CornerRadius = UDim.new(0, 6)
                        UICorner_4.Parent = OptionButton
                        
                        OptionButton.MouseButton1Click:Connect(function()
                            selected = option
                            Title.Text = text..": "..selected
                            dropped = false
                            UpdateDropdown()
                            if callback then callback(selected) end
                        end)
                        
                        OptionButton.MouseEnter:Connect(function()
                            TweenService:Create(OptionButton, TweenInfo.new(0.3), {BackgroundColor3 = Noon.CurrentTheme.ElementHover}):Play()
                        end)
                        
                        OptionButton.MouseLeave:Connect(function()
                            TweenService:Create(OptionButton, TweenInfo.new(0.3), {BackgroundColor3 = Noon.CurrentTheme.Element}):Play()
                        end)
                    end
                end
                
                AddOptions(options)
                Title.Text = text..": "..selected
                
                local DropdownObject = {}
                
                function DropdownObject:Refresh(newOptions)
                    for _, item in pairs(DropdownContainer:GetChildren()) do
                        if item:IsA("TextButton") then
                            item:Destroy()
                        end
                    end
                    
                    AddOptions(newOptions)
                    
                    if not table.find(newOptions, selected) then
                        selected = newOptions[1]
                        Title.Text = text..": "..selected
                        if callback then callback(selected) end
                    end
                end
                
                function DropdownObject:Select(option)
                    if table.find(options, option) then
                        selected = option
                        Title.Text = text..": "..selected
                        if callback then callback(selected) end
                    end
                end
                
                return DropdownObject
            end
            
            return section
        end
        
        return tab
    end
    
    return window
end

return Noon
