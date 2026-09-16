--//====================================================//--
--//                 RIVALS HUB                        //--
--//              CLEAN REBUILD 1.0                    //--
--//                    PART 1/4                       //--
--//====================================================//--

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

--//====================================================//--
--// CONFIG
--//====================================================//--

local Config = {
    MenuDestroyed = false,
    MenuOpen = true,

    AnimationSpeed = 0.22,

    MenuWidth = 620,
    MenuHeight = 430,

    Accent = Color3.fromRGB(132, 78, 255),
    AccentDark = Color3.fromRGB(78, 42, 160),

    Background = Color3.fromRGB(8, 8, 15),
    Panel = Color3.fromRGB(13, 13, 23),
    PanelLight = Color3.fromRGB(19, 19, 32),

    Text = Color3.fromRGB(240, 240, 248),
    TextDark = Color3.fromRGB(145, 145, 165),

    Border = Color3.fromRGB(47, 37, 78),

    MenuPosition = nil,
}

--//====================================================//--
--// HELPERS
--//====================================================//--

local function TweenObject(Object, Time, Properties, Style, Direction)
    if not Object then
        return
    end

    local Info = TweenInfo.new(
        Time or Config.AnimationSpeed,
        Style or Enum.EasingStyle.Quint,
        Direction or Enum.EasingDirection.Out
    )

    local Tween = TweenService:Create(Object, Info, Properties)
    Tween:Play()

    return Tween
end

local function AddCorner(Object, Radius)
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, Radius or 10)
    Corner.Parent = Object

    return Corner
end

local function AddStroke(Object, Color, Thickness, Transparency)
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color or Config.Border
    Stroke.Thickness = Thickness or 1
    Stroke.Transparency = Transparency or 0
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Stroke.Parent = Object

    return Stroke
end

local function AddPadding(Object, Left, Right, Top, Bottom)
    local Padding = Instance.new("UIPadding")

    Padding.PaddingLeft = UDim.new(0, Left or 0)
    Padding.PaddingRight = UDim.new(0, Right or 0)
    Padding.PaddingTop = UDim.new(0, Top or 0)
    Padding.PaddingBottom = UDim.new(0, Bottom or 0)

    Padding.Parent = Object

    return Padding
end

local function New(ClassName, Properties, Parent)
    local Object = Instance.new(ClassName)

    for Property, Value in pairs(Properties or {}) do
        Object[Property] = Value
    end

    if Parent then
        Object.Parent = Parent
    end

    return Object
end

--//====================================================//--
--// SCREEN GUI
--//====================================================//--

local OldGui = LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("RivalsHub")

if OldGui then
    OldGui:Destroy()
end

local ScreenGui = New("ScreenGui", {
    Name = "RivalsHub",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 999,
}, LocalPlayer.PlayerGui)

--//====================================================//--
--// MAIN HOLDER
--//====================================================//--

local Holder = New("Frame", {
    Name = "Holder",

    Size = UDim2.fromOffset(
        Config.MenuWidth,
        Config.MenuHeight
    ),

    Position = UDim2.new(
        0.5,
        -Config.MenuWidth / 2,
        0.5,
        -Config.MenuHeight / 2
    ),

    BackgroundColor3 = Config.Background,
    BorderSizePixel = 0,

    ClipsDescendants = true,
}, ScreenGui)

AddCorner(Holder, 16)
AddStroke(Holder, Config.Border, 1, 0.15)

Config.MenuPosition = Holder.Position

--//====================================================//--
--// BACKGROUND FX
--//====================================================//--

local BackgroundFX = New("Frame", {
    Name = "BackgroundFX",
    Size = UDim2.fromScale(1, 1),
    Position = UDim2.fromScale(0, 0),
    BackgroundTransparency = 1,
    ClipsDescendants = true,
    ZIndex = 0,
}, Holder)

-- Moving diagonal lines
local FXLines = {}

for Index = 1, 7 do
    local Line = New("Frame", {
        Name = "FXLine_" .. Index,

        Size = UDim2.new(0, 260, 0, 1),

        Position = UDim2.new(
            -0.45,
            Index * 95,
            0,
            -40 + Index * 75
        ),

        Rotation = -25,

        BackgroundColor3 = Config.Accent,
        BackgroundTransparency = 0.88,

        BorderSizePixel = 0,

        ZIndex = 0,
    }, BackgroundFX)

    FXLines[Index] = Line

    task.spawn(function()
        while Line.Parent and not Config.MenuDestroyed do
            local StartPosition = Line.Position

            local Goal = UDim2.new(
                StartPosition.X.Scale + 1,
                StartPosition.X.Offset,
                StartPosition.Y.Scale,
                StartPosition.Y.Offset + 30
            )

            local Animation = TweenObject(
                Line,
                3.5 + Index * 0.25,
                {
                    Position = Goal
                },
                Enum.EasingStyle.Linear,
                Enum.EasingDirection.InOut
            )

            if Animation then
                Animation.Completed:Wait()
            end

            if not Line.Parent or Config.MenuDestroyed then
                break
            end

            Line.Position = UDim2.new(
                -0.5,
                -Index * 60,
                0,
                -40 + Index * 75
            )
        end
    end)
end

-- Soft glow panels
local GlowTop = New("Frame", {
    Name = "GlowTop",
    Size = UDim2.new(0, 330, 0, 120),
    Position = UDim2.new(0, -100, 0, -70),
    BackgroundColor3 = Config.Accent,
    BackgroundTransparency = 0.94,
    BorderSizePixel = 0,
    ZIndex = 0,
}, BackgroundFX)

AddCorner(GlowTop, 100)

local GlowBottom = New("Frame", {
    Name = "GlowBottom",
    Size = UDim2.new(0, 360, 0, 130),
    Position = UDim2.new(1, -180, 1, -80),
    BackgroundColor3 = Config.AccentDark,
    BackgroundTransparency = 0.95,
    BorderSizePixel = 0,
    ZIndex = 0,
}, BackgroundFX)

AddCorner(GlowBottom, 100)

--//====================================================//--
--// MAIN PANEL
--//====================================================//--

local Main = New("Frame", {
    Name = "Main",

    Size = UDim2.fromScale(1, 1),
    Position = UDim2.fromScale(0, 0),

    BackgroundTransparency = 1,
    BorderSizePixel = 0,

    ZIndex = 2,
}, Holder)

--//====================================================//--
--// TOP BAR
--//====================================================//--

local TopBar = New("Frame", {
    Name = "TopBar",

    Size = UDim2.new(1, 0, 0, 68),

    Position = UDim2.fromOffset(0, 0),

    BackgroundColor3 = Config.Panel,
    BackgroundTransparency = 0.05,

    BorderSizePixel = 0,

    ZIndex = 5,
}, Main)

AddCorner(TopBar, 16)

-- cover lower rounded corners of top bar
local TopBarCover = New("Frame", {
    Size = UDim2.new(1, 0, 0, 18),
    Position = UDim2.new(0, 0, 1, -18),
    BackgroundColor3 = Config.Panel,
    BorderSizePixel = 0,
    ZIndex = 5,
}, TopBar)

--//====================================================//--
--// R LOGO
--//====================================================//--

local LogoHolder = New("Frame", {
    Name = "LogoHolder",

    Size = UDim2.fromOffset(42, 42),

    Position = UDim2.fromOffset(13, 13),

    BackgroundColor3 = Config.Accent,
    BackgroundTransparency = 0.82,

    BorderSizePixel = 0,

    ZIndex = 7,
}, TopBar)

AddCorner(LogoHolder, 12)
AddStroke(LogoHolder, Config.Accent, 1, 0.25)

local Logo = New("TextLabel", {
    Name = "Logo",

    Size = UDim2.fromScale(1, 1),

    BackgroundTransparency = 1,

    Text = "R",

    Font = Enum.Font.GothamBlack,
    TextSize = 25,

    TextColor3 = Config.Text,

    TextXAlignment = Enum.TextXAlignment.Center,
    TextYAlignment = Enum.TextYAlignment.Center,

    ZIndex = 8,
}, LogoHolder)

--//====================================================//--
--// TITLE
--//====================================================//--

local Title = New("TextLabel", {
    Name = "Title",

    Size = UDim2.new(0, 240, 0, 26),

    Position = UDim2.fromOffset(68, 12),

    BackgroundTransparency = 1,

    Text = "RIVALS HUB",

    Font = Enum.Font.GothamBold,
    TextSize = 18,

    TextColor3 = Config.Text,

    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Center,

    ZIndex = 7,
}, TopBar)

local Subtitle = New("TextLabel", {
    Name = "Subtitle",

    Size = UDim2.new(0, 280, 0, 18),

    Position = UDim2.fromOffset(69, 36),

    BackgroundTransparency = 1,

    Text = "Clean interface • Smooth controls",

    Font = Enum.Font.Gotham,
    TextSize = 11,

    TextColor3 = Config.TextDark,

    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Center,

    ZIndex = 7,
}, TopBar)

--//====================================================//--
--// CLOSE BUTTON
--//====================================================//--

local CloseButton = New("TextButton", {
    Name = "CloseButton",

    Size = UDim2.fromOffset(34, 34),

    Position = UDim2.new(1, -45, 0, 17),

    BackgroundColor3 = Color3.fromRGB(45, 25, 55),
    BackgroundTransparency = 0.15,

    BorderSizePixel = 0,

    AutoButtonColor = false,

    Text = "×",

    Font = Enum.Font.GothamBold,
    TextSize = 22,

    TextColor3 = Config.TextDark,

    ZIndex = 8,
}, TopBar)

AddCorner(CloseButton, 10)

--//====================================================//--
--// MINIMIZE BUTTON
--//====================================================//--

local MinimizeButton = New("TextButton", {
    Name = "MinimizeButton",

    Size = UDim2.fromOffset(34, 34),

    Position = UDim2.new(1, -84, 0, 17),

    BackgroundColor3 = Config.PanelLight,
    BackgroundTransparency = 0.1,

    BorderSizePixel = 0,

    AutoButtonColor = false,

    Text = "—",

    Font = Enum.Font.GothamBold,
    TextSize = 18,

    TextColor3 = Config.TextDark,

    ZIndex = 8,
}, TopBar)

AddCorner(MinimizeButton, 10)

-- Hover animations
CloseButton.MouseEnter:Connect(function()
    TweenObject(CloseButton, 0.15, {
        BackgroundColor3 = Color3.fromRGB(100, 40, 65),
        TextColor3 = Config.Text,
    })
end)

CloseButton.MouseLeave:Connect(function()
    TweenObject(CloseButton, 0.15, {
        BackgroundColor3 = Color3.fromRGB(45, 25, 55),
        TextColor3 = Config.TextDark,
    })
end)

MinimizeButton.MouseEnter:Connect(function()
    TweenObject(MinimizeButton, 0.15, {
        BackgroundColor3 = Config.AccentDark,
        TextColor3 = Config.Text,
    })
end)

MinimizeButton.MouseLeave:Connect(function()
    TweenObject(MinimizeButton, 0.15, {
        BackgroundColor3 = Config.PanelLight,
        TextColor3 = Config.TextDark,
    })
end)

--//====================================================//--
--// CONTENT AREA
--//====================================================//--

local Content = New("Frame", {
    Name = "Content",

    Size = UDim2.new(1, -20, 1, -88),

    Position = UDim2.fromOffset(10, 78),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ZIndex = 3,
}, Main)

--//====================================================//--
--// SIDEBAR
--//====================================================//--

local Sidebar = New("Frame", {
    Name = "Sidebar",

    Size = UDim2.new(0, 145, 1, 0),

    Position = UDim2.fromOffset(0, 0),

    BackgroundColor3 = Config.Panel,
    BackgroundTransparency = 0.1,

    BorderSizePixel = 0,

    ZIndex = 4,
}, Content)

AddCorner(Sidebar, 13)
AddStroke(Sidebar, Config.Border, 1, 0.35)

AddPadding(Sidebar, 8, 8, 10, 10)

local SidebarTitle = New("TextLabel", {
    Name = "SidebarTitle",

    Size = UDim2.new(1, 0, 0, 25),

    BackgroundTransparency = 1,

    Text = "PAGES",

    Font = Enum.Font.GothamBold,
    TextSize = 10,

    TextColor3 = Config.TextDark,

    TextXAlignment = Enum.TextXAlignment.Left,

    ZIndex = 5,
}, Sidebar)

--//====================================================//--
--// PAGE BUTTON HOLDER
--//====================================================//--

local PageButtonHolder = New("Frame", {
    Name = "PageButtonHolder",

    Size = UDim2.new(1, 0, 1, -35),

    Position = UDim2.fromOffset(0, 35),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ZIndex = 5,
}, Sidebar)

local PageLayout = New("UIListLayout", {
    Padding = UDim.new(0, 6),

    FillDirection = Enum.FillDirection.Vertical,

    HorizontalAlignment = Enum.HorizontalAlignment.Center,

    SortOrder = Enum.SortOrder.LayoutOrder,
}, PageButtonHolder)

--//====================================================//--
--// PAGE CONTAINER
--//====================================================//--

local PageContainer = New("Frame", {
    Name = "PageContainer",

    Size = UDim2.new(1, -155, 1, 0),

    Position = UDim2.fromOffset(155, 0),

    BackgroundColor3 = Config.Panel,
    BackgroundTransparency = 0.08,

    BorderSizePixel = 0,

    ClipsDescendants = true,

    ZIndex = 4,
}, Content)

AddCorner(PageContainer, 13)
AddStroke(PageContainer, Config.Border, 1, 0.35)

--//====================================================//--
--// PAGE SYSTEM
--//====================================================//--

local Pages = {}
local PageButtons = {}
local CurrentPage = nil

local function CreatePage(Name, LayoutOrder)
    local Page = New("ScrollingFrame", {
        Name = Name .. "Page",

        Size = UDim2.new(1, 0, 1, 0),

        Position = UDim2.fromScale(0, 0),

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        ScrollBarThickness = 3,

        ScrollBarImageColor3 = Config.Accent,

        CanvasSize = UDim2.fromOffset(0, 0),

        AutomaticCanvasSize = Enum.AutomaticSize.Y,

        ScrollingDirection = Enum.ScrollingDirection.Y,

        Visible = false,

        ZIndex = 5,
    }, PageContainer)

    AddPadding(Page, 15, 15, 15, 15)

    local Layout = New("UIListLayout", {
        Padding = UDim.new(0, 10),

        FillDirection = Enum.FillDirection.Vertical,

        HorizontalAlignment = Enum.HorizontalAlignment.Center,

        SortOrder = Enum.SortOrder.LayoutOrder,
    }, Page)

    local Button = New("TextButton", {
        Name = Name .. "Button",

        Size = UDim2.new(1, 0, 0, 40),

        BackgroundColor3 = Config.PanelLight,
        BackgroundTransparency = 0.65,

        BorderSizePixel = 0,

        AutoButtonColor = false,

        Text = Name,

        Font = Enum.Font.GothamMedium,
        TextSize = 12,

        TextColor3 = Config.TextDark,

        TextXAlignment = Enum.TextXAlignment.Left,

        LayoutOrder = LayoutOrder,

        ZIndex = 6,
    }, PageButtonHolder)

    AddCorner(Button, 9)

    AddPadding(Button, 13, 8, 0, 0)

    Pages[Name] = Page
    PageButtons[Name] = Button

    Button.MouseEnter:Connect(function()
        if CurrentPage ~= Name then
            TweenObject(Button, 0.15, {
                BackgroundTransparency = 0.35,
                TextColor3 = Config.Text,
            })
        end
    end)

    Button.MouseLeave:Connect(function()
        if CurrentPage ~= Name then
            TweenObject(Button, 0.15, {
                BackgroundTransparency = 0.65,
                TextColor3 = Config.TextDark,
            })
        end
    end)

    Button.MouseButton1Click:Connect(function()
        if CurrentPage == Name then
            return
        end

        local OldPage = CurrentPage

        CurrentPage = Name

        if OldPage and Pages[OldPage] then
            Pages[OldPage].Visible = false

            TweenObject(PageButtons[OldPage], 0.15, {
                BackgroundColor3 = Config.PanelLight,
                BackgroundTransparency = 0.65,
                TextColor3 = Config.TextDark,
            })
        end

        Page.Visible = true
        Page.Position = UDim2.new(0, 20, 0, 0)

        TweenObject(Page, 0.22, {
            Position = UDim2.fromScale(0, 0),
        })

        TweenObject(Button, 0.15, {
            BackgroundColor3 = Config.AccentDark,
            BackgroundTransparency = 0.2,
            TextColor3 = Config.Text,
        })
    end)

    return Page
end

--//====================================================//--
--// CREATE PAGES
--//====================================================//--

local CombatPage = CreatePage("Combat", 1)
local VisualsPage = CreatePage("Visuals", 2)
local MovementPage = CreatePage("Movement", 3)
local SettingsPage = CreatePage("Settings", 4)

-- Default page
CurrentPage = "Combat"
CombatPage.Visible = true

TweenObject(PageButtons.Combat, 0.15, {
    BackgroundColor3 = Config.AccentDark,
    BackgroundTransparency = 0.2,
    TextColor3 = Config.Text,
})

--//====================================================//--
--// DRAG SYSTEM
--//====================================================//--

local DraggingMenu = false
local MenuDragStart = nil
local MenuStartPosition = nil

TopBar.InputBegan:Connect(function(Input)
    if Config.MenuDestroyed then
        return
    end

    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

        DraggingMenu = true

        MenuDragStart = Input.Position
        MenuStartPosition = Holder.Position
    end
end)

TopBar.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

        DraggingMenu = false
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if Config.MenuDestroyed then
        return
    end

    if not DraggingMenu then
        return
    end

    if Input.UserInputType ~= Enum.UserInputType.MouseMovement
        and Input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    local Delta = Input.Position - MenuDragStart

    Holder.Position = UDim2.new(
        MenuStartPosition.X.Scale,
        MenuStartPosition.X.Offset + Delta.X,
        MenuStartPosition.Y.Scale,
        MenuStartPosition.Y.Offset + Delta.Y
    )
end)

--//====================================================//--
--// MINI BUTTON
--//====================================================//--

local MiniButton = New("TextButton", {
    Name = "MiniButton",

    Size = UDim2.fromOffset(56, 56),

    Position = Config.MenuPosition,

    BackgroundColor3 = Config.Background,

    BorderSizePixel = 0,

    AutoButtonColor = false,

    Text = "R",

    Font = Enum.Font.GothamBlack,
    TextSize = 27,

    TextColor3 = Config.Text,

    Visible = false,

    ZIndex = 100,
}, ScreenGui)

AddCorner(MiniButton, 16)
AddStroke(MiniButton, Config.Accent, 1, 0.15)

-- mini glow
local MiniGlow = New("Frame", {
    Size = UDim2.new(1, -8, 1, -8),
    Position = UDim2.fromOffset(4, 4),

    BackgroundColor3 = Config.Accent,
    BackgroundTransparency = 0.88,

    BorderSizePixel = 0,

    ZIndex = 99,
}, MiniButton)

AddCorner(MiniGlow, 13)

local MiniLogo = New("TextLabel", {
    Size = UDim2.fromScale(1, 1),

    BackgroundTransparency = 1,

    Text = "R",

    Font = Enum.Font.GothamBlack,
    TextSize = 27,

    TextColor3 = Config.Text,

    TextXAlignment = Enum.TextXAlignment.Center,
    TextYAlignment = Enum.TextYAlignment.Center,

    ZIndex = 101,
}, MiniButton)

--====================================================--
-- MINI DRAG SYSTEM
--====================================================--

local MiniDragging = false
local MiniDragStart = nil
local MiniStartPosition = nil

MiniButton.InputBegan:Connect(function(Input)
    if Config.MenuDestroyed then
        return
    end

    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

        MiniDragging = true

        MiniDragStart = Input.Position
        MiniStartPosition = MiniButton.Position
    end
end)

MiniButton.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

        MiniDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if Config.MenuDestroyed then
        return
    end

    if not MiniDragging then
        return
    end

    if Input.UserInputType ~= Enum.UserInputType.MouseMovement
        and Input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    local Delta = Input.Position - MiniDragStart

    MiniButton.Position = UDim2.new(
        MiniStartPosition.X.Scale,
        MiniStartPosition.X.Offset + Delta.X,
        MiniStartPosition.Y.Scale,
        MiniStartPosition.Y.Offset + Delta.Y
    )
end)

--====================================================--
-- MINI BUTTON HOVER
--====================================================--

MiniButton.MouseEnter:Connect(function()
    if Config.MenuDestroyed then
        return
    end

    TweenObject(MiniButton, 0.16, {
        Size = UDim2.fromOffset(62, 62),
    })

    TweenObject(MiniGlow, 0.16, {
        BackgroundTransparency = 0.76,
    })
end)

MiniButton.MouseLeave:Connect(function()
    if Config.MenuDestroyed then
        return
    end

    TweenObject(MiniButton, 0.16, {
        Size = UDim2.fromOffset(56, 56),
    })

    TweenObject(MiniGlow, 0.16, {
        BackgroundTransparency = 0.88,
    })
end)

--====================================================--
-- MINIMIZE / RESTORE / CLOSE
--====================================================--

local function RestoreMenu()
    if Config.MenuDestroyed then
        return
    end

    Config.MenuOpen = true

    -- Restore menu exactly where the mini button currently is
    Holder.Position = MiniButton.Position

    Holder.Visible = true
    Main.Visible = true

    Holder.Size = UDim2.fromOffset(56, 56)

    MiniButton.Visible = false

    TweenObject(
        Holder,
        Config.AnimationSpeed,
        {
            Size = UDim2.fromOffset(
                Config.MenuWidth,
                Config.MenuHeight
            ),
        },
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )
end

local function MinimizeMenu()
    if Config.MenuDestroyed or not Config.MenuOpen then
        return
    end

    Config.MenuOpen = false

    -- Save the exact current menu position
    Config.MenuPosition = Holder.Position

    -- Put mini R exactly where the menu was
    MiniButton.Position = Holder.Position

    TweenObject(
        Holder,
        Config.AnimationSpeed,
        {
            Size = UDim2.fromOffset(56, 56),
        },
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.In
    )

    task.delay(Config.AnimationSpeed, function()
        if Config.MenuDestroyed then
            return
        end

        Main.Visible = false
        Holder.Visible = false

        MiniButton.Visible = true

        MiniButton.Size = UDim2.fromOffset(42, 42)

        TweenObject(
            MiniButton,
            Config.AnimationSpeed,
            {
                Size = UDim2.fromOffset(56, 56),
            }
        )
    end)
end

local function CloseMenu()
    if Config.MenuDestroyed then
        return
    end

    Config.MenuDestroyed = true
    Config.MenuOpen = false

    -- Never minimize on close.
    -- Completely destroy the UI.
    MiniButton.Visible = false

    TweenObject(
        Holder,
        Config.AnimationSpeed,
        {
            Size = UDim2.fromOffset(0, 0),
        },
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.In
    )

    task.delay(Config.AnimationSpeed + 0.03, function()
        if ScreenGui then
            ScreenGui:Destroy()
        end
    end)
end

MinimizeButton.MouseButton1Click:Connect(function()
    MinimizeMenu()
end)

CloseButton.MouseButton1Click:Connect(function()
    CloseMenu()
end)

MiniButton.MouseButton1Click:Connect(function()
    -- If the button was dragged, don't instantly restore
    -- until the mouse has actually clicked it.
    if not MiniDragging then
        RestoreMenu()
    end
end)

--====================================================--
-- STARTUP ANIMATION
--====================================================--

Holder.Size = UDim2.fromOffset(40, 40)

TweenObject(
    Holder,
    0.38,
    {
        Size = UDim2.fromOffset(
            Config.MenuWidth,
            Config.MenuHeight
        ),
    },
    Enum.EasingStyle.Back,
    Enum.EasingDirection.Out
)

--====================================================--
-- KEYBIND
-- RightShift = Minimize / Restore
--====================================================--

UserInputService.InputBegan:Connect(function(Input, GameProcessed)
    if GameProcessed then
        return
    end

    if Config.MenuDestroyed then
        return
    end

    if Input.KeyCode == Enum.KeyCode.RightShift then
        if Config.MenuOpen then
            MinimizeMenu()
        else
            RestoreMenu()
        end
    end
end)

--//====================================================//--
--// END OF PART 1/4
--//====================================================//--

--//====================================================//--
--//                 RIVALS HUB                        //--
--//                    PART 2/4                       //--
--//              COMPONENTS + COMBAT                  //--
--//                    + VISUALS                      //--
--//====================================================//--

--====================================================--
-- COMPONENT SYSTEM
--====================================================--

local Components = {}

local function RegisterComponent(Object)
    table.insert(Components, Object)
    return Object
end

local function CreateSection(Page, TitleText, DescriptionText)
    local Section = RegisterComponent(New("Frame", {
        Name = "Section_" .. TitleText:gsub("%s+", ""),
        Size = UDim2.new(1, 0, 0, 48),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 6,
    }, Page))

    local SectionTitle = New("TextLabel", {
        Size = UDim2.new(1, 0, 0, 22),
        Position = UDim2.fromOffset(0, 0),

        BackgroundTransparency = 1,

        Text = TitleText,

        Font = Enum.Font.GothamBold,
        TextSize = 15,

        TextColor3 = Config.Text,

        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,

        ZIndex = 7,
    }, Section)

    local Description = New("TextLabel", {
        Size = UDim2.new(1, 0, 0, 20),
        Position = UDim2.fromOffset(0, 24),

        BackgroundTransparency = 1,

        Text = DescriptionText or "",

        Font = Enum.Font.Gotham,
        TextSize = 10,

        TextColor3 = Config.TextDark,

        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,

        ZIndex = 7,
    }, Section)

    return Section
end

--====================================================--
-- INFO CARD
--====================================================--

local function CreateInfoCard(Page, TitleText, DescriptionText)
    local Card = RegisterComponent(New("Frame", {
        Name = "Info_" .. TitleText:gsub("%s+", ""),
        Size = UDim2.new(1, 0, 0, 58),

        BackgroundColor3 = Config.PanelLight,
        BackgroundTransparency = 0.35,

        BorderSizePixel = 0,

        ZIndex = 6,
    }, Page))

    AddCorner(Card, 10)
    AddStroke(Card, Config.Border, 1, 0.45)

    local Title = New("TextLabel", {
        Size = UDim2.new(1, -24, 0, 20),
        Position = UDim2.fromOffset(12, 8),

        BackgroundTransparency = 1,

        Text = TitleText,

        Font = Enum.Font.GothamBold,
        TextSize = 12,

        TextColor3 = Config.Text,

        TextXAlignment = Enum.TextXAlignment.Left,

        ZIndex = 7,
    }, Card)

    local Description = New("TextLabel", {
        Size = UDim2.new(1, -24, 0, 20),
        Position = UDim2.fromOffset(12, 29),

        BackgroundTransparency = 1,

        Text = DescriptionText,

        Font = Enum.Font.Gotham,
        TextSize = 10,

        TextColor3 = Config.TextDark,

        TextXAlignment = Enum.TextXAlignment.Left,

        ZIndex = 7,
    }, Card)

    return Card
end

--====================================================--
-- TOGGLE
--====================================================--

local function CreateToggle(Page, TitleText, DescriptionText, Default, Callback)
    local State = Default == true

    local Card = RegisterComponent(New("Frame", {
        Name = "Toggle_" .. TitleText:gsub("%s+", ""),

        Size = UDim2.new(1, 0, 0, 62),

        BackgroundColor3 = Config.PanelLight,
        BackgroundTransparency = 0.38,

        BorderSizePixel = 0,

        ZIndex = 6,
    }, Page))

    AddCorner(Card, 10)
    AddStroke(Card, Config.Border, 1, 0.5)

    local Title = New("TextLabel", {
        Size = UDim2.new(1, -90, 0, 20),
        Position = UDim2.fromOffset(13, 8),

        BackgroundTransparency = 1,

        Text = TitleText,

        Font = Enum.Font.GothamMedium,
        TextSize = 12,

        TextColor3 = Config.Text,

        TextXAlignment = Enum.TextXAlignment.Left,

        ZIndex = 7,
    }, Card)

    local Description = New("TextLabel", {
        Size = UDim2.new(1, -90, 0, 20),
        Position = UDim2.fromOffset(13, 31),

        BackgroundTransparency = 1,

        Text = DescriptionText or "",

        Font = Enum.Font.Gotham,
        TextSize = 9,

        TextColor3 = Config.TextDark,

        TextXAlignment = Enum.TextXAlignment.Left,

        ZIndex = 7,
    }, Card)

    local Switch = New("TextButton", {
        Name = "Switch",

        Size = UDim2.fromOffset(44, 24),

        Position = UDim2.new(1, -57, 0.5, -12),

        BackgroundColor3 = Color3.fromRGB(35, 35, 48),

        BorderSizePixel = 0,

        AutoButtonColor = false,

        Text = "",

        ZIndex = 8,
    }, Card)

    AddCorner(Switch, 12)

    local Knob = New("Frame", {
        Name = "Knob",

        Size = UDim2.fromOffset(18, 18),

        Position = UDim2.fromOffset(3, 3),

        BackgroundColor3 = Config.TextDark,

        BorderSizePixel = 0,

        ZIndex = 9,
    }, Switch)

    AddCorner(Knob, 9)

    local function Update(Value, Instant)
        State = Value

        local SwitchColor
        local KnobPosition
        local KnobColor

        if State then
            SwitchColor = Config.Accent
            KnobPosition = UDim2.new(1, -21, 0, 3)
            KnobColor = Color3.fromRGB(255, 255, 255)
        else
            SwitchColor = Color3.fromRGB(35, 35, 48)
            KnobPosition = UDim2.fromOffset(3, 3)
            KnobColor = Config.TextDark
        end

        if Instant then
            Switch.BackgroundColor3 = SwitchColor
            Knob.Position = KnobPosition
            Knob.BackgroundColor3 = KnobColor
        else
            TweenObject(Switch, 0.18, {
                BackgroundColor3 = SwitchColor,
            })

            TweenObject(Knob, 0.18, {
                Position = KnobPosition,
                BackgroundColor3 = KnobColor,
            })
        end

        if Callback then
            task.spawn(function()
                Callback(State)
            end)
        end
    end

    Switch.MouseButton1Click:Connect(function()
        Update(not State, false)
    end)

    Card.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            Update(not State, false)
        end
    end)

    Update(State, true)

    return {
        Set = function(Value)
            Update(Value, false)
        end,

        Get = function()
            return State
        end,
    }
end

--====================================================--
-- SLIDER
--====================================================--

local function CreateSlider(Page, TitleText, DescriptionText, Minimum, Maximum, Default, Callback)
    local Value = math.clamp(Default or Minimum, Minimum, Maximum)

    local Card = RegisterComponent(New("Frame", {
        Name = "Slider_" .. TitleText:gsub("%s+", ""),

        Size = UDim2.new(1, 0, 0, 78),

        BackgroundColor3 = Config.PanelLight,
        BackgroundTransparency = 0.38,

        BorderSizePixel = 0,

        ZIndex = 6,
    }, Page))

    AddCorner(Card, 10)
    AddStroke(Card, Config.Border, 1, 0.5)

    local Title = New("TextLabel", {
        Size = UDim2.new(1, -90, 0, 20),
        Position = UDim2.fromOffset(13, 7),

        BackgroundTransparency = 1,

        Text = TitleText,

        Font = Enum.Font.GothamMedium,
        TextSize = 12,

        TextColor3 = Config.Text,

        TextXAlignment = Enum.TextXAlignment.Left,

        ZIndex = 7,
    }, Card)

    local ValueLabel = New("TextLabel", {
        Size = UDim2.fromOffset(65, 20),
        Position = UDim2.new(1, -78, 0, 7),

        BackgroundTransparency = 1,

        Text = tostring(Value),

        Font = Enum.Font.GothamBold,
        TextSize = 11,

        TextColor3 = Config.Accent,

        TextXAlignment = Enum.TextXAlignment.Right,

        ZIndex = 7,
    }, Card)

    local Description = New("TextLabel", {
        Size = UDim2.new(1, -26, 0, 17),
        Position = UDim2.fromOffset(13, 28),

        BackgroundTransparency = 1,

        Text = DescriptionText or "",

        Font = Enum.Font.Gotham,
        TextSize = 9,

        TextColor3 = Config.TextDark,

        TextXAlignment = Enum.TextXAlignment.Left,

        ZIndex = 7,
    }, Card)

    local Bar = New("Frame", {
        Size = UDim2.new(1, -26, 0, 5),
        Position = UDim2.new(0, 13, 1, -16),

        BackgroundColor3 = Color3.fromRGB(35, 35, 48),

        BorderSizePixel = 0,

        ZIndex = 7,
    }, Card)

    AddCorner(Bar, 5)

    local Fill = New("Frame", {
        Size = UDim2.new(
            (Value - Minimum) / (Maximum - Minimum),
            0,
            1,
            0
        ),

        BackgroundColor3 = Config.Accent,

        BorderSizePixel = 0,

        ZIndex = 8,
    }, Bar)

    AddCorner(Fill, 5)

    local SliderButton = New("TextButton", {
        Size = UDim2.new(1, 0, 0, 24),
        Position = UDim2.new(0, 0, 0.5, -12),

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        Text = "",

        AutoButtonColor = false,

        ZIndex = 10,
    }, Bar)

    local Sliding = false

    local function SetValue(NewValue)
        Value = math.clamp(NewValue, Minimum, Maximum)

        local Percent = (Value - Minimum) / (Maximum - Minimum)

        TweenObject(Fill, 0.08, {
            Size = UDim2.new(Percent, 0, 1, 0),
        })

        ValueLabel.Text = tostring(
            math.floor(Value * 100) / 100
        )

        if Callback then
            task.spawn(function()
                Callback(Value)
            end)
        end
    end

    local function UpdateFromInput(Input)
        local X = Input.Position.X
        local AbsolutePosition = Bar.AbsolutePosition.X
        local AbsoluteSize = Bar.AbsoluteSize.X

        local Percent = math.clamp(
            (X - AbsolutePosition) / AbsoluteSize,
            0,
            1
        )

        SetValue(
            Minimum + (Maximum - Minimum) * Percent
        )
    end

    SliderButton.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1
            or Input.UserInputType == Enum.UserInputType.Touch then

            Sliding = true
            UpdateFromInput(Input)
        end
    end)

    UserInputService.InputChanged:Connect(function(Input)
        if not Sliding then
            return
        end

        if Input.UserInputType == Enum.UserInputType.MouseMovement
            or Input.UserInputType == Enum.UserInputType.Touch then

            UpdateFromInput(Input)
        end
    end)

    UserInputService.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1
            or Input.UserInputType == Enum.UserInputType.Touch then

            Sliding = false
        end
    end)

    SetValue(Value)

    return {
        Set = SetValue,

        Get = function()
            return Value
        end,
    }
end

--====================================================--
-- DROPDOWN
--====================================================--

local function CreateDropdown(Page, TitleText, DescriptionText, Options, Default, Callback)
    local CurrentValue = Default or Options[1]
    local Open = false

    local Card = RegisterComponent(New("Frame", {
        Name = "Dropdown_" .. TitleText:gsub("%s+", ""),

        Size = UDim2.new(1, 0, 0, 62),

        BackgroundColor3 = Config.PanelLight,
        BackgroundTransparency = 0.38,

        BorderSizePixel = 0,

        ClipsDescendants = true,

        ZIndex = 10,
    }, Page))

    AddCorner(Card, 10)
    AddStroke(Card, Config.Border, 1, 0.5)

    local Title = New("TextLabel", {
        Size = UDim2.new(1, -180, 0, 20),
        Position = UDim2.fromOffset(13, 8),

        BackgroundTransparency = 1,

        Text = TitleText,

        Font = Enum.Font.GothamMedium,
        TextSize = 12,

        TextColor3 = Config.Text,

        TextXAlignment = Enum.TextXAlignment.Left,

        ZIndex = 12,
    }, Card)

    local Description = New("TextLabel", {
        Size = UDim2.new(1, -180, 0, 18),
        Position = UDim2.fromOffset(13, 31),

        BackgroundTransparency = 1,

        Text = DescriptionText or "",

        Font = Enum.Font.Gotham,
        TextSize = 9,

        TextColor3 = Config.TextDark,

        TextXAlignment = Enum.TextXAlignment.Left,

        ZIndex = 12,
    }, Card)

    local Selector = New("TextButton", {
        Size = UDim2.fromOffset(145, 34),
        Position = UDim2.new(1, -157, 0, 14),

        BackgroundColor3 = Color3.fromRGB(29, 29, 43),

        BorderSizePixel = 0,

        AutoButtonColor = false,

        Text = "",

        ZIndex = 13,
    }, Card)

    AddCorner(Selector, 8)

    local Selected = New("TextLabel", {
        Size = UDim2.new(1, -32, 1, 0),
        Position = UDim2.fromOffset(10, 0),

        BackgroundTransparency = 1,

        Text = tostring(CurrentValue),

        Font = Enum.Font.GothamMedium,
        TextSize = 10,

        TextColor3 = Config.Text,

        TextXAlignment = Enum.TextXAlignment.Left,

        ZIndex = 14,
    }, Selector)

    local Arrow = New("TextLabel", {
        Size = UDim2.fromOffset(20, 20),
        Position = UDim2.new(1, -24, 0.5, -10),

        BackgroundTransparency = 1,

        Text = "▼",

        Font = Enum.Font.GothamBold,
        TextSize = 9,

        TextColor3 = Config.TextDark,

        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,

        ZIndex = 14,
    }, Selector)

    local OptionsFrame = New("Frame", {
        Name = "Options",

        Size = UDim2.new(1, -26, 0, 0),

        Position = UDim2.fromOffset(13, 60),

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        ZIndex = 20,
    }, Card)

    local OptionsLayout = New("UIListLayout", {
        Padding = UDim.new(0, 5),

        FillDirection = Enum.FillDirection.Vertical,

        HorizontalAlignment = Enum.HorizontalAlignment.Center,

        SortOrder = Enum.SortOrder.LayoutOrder,
    }, OptionsFrame)

    local function SelectOption(Option)
        CurrentValue = Option

        Selected.Text = tostring(Option)

        if Callback then
            task.spawn(function()
                Callback(Option)
            end)
        end

        Open = false

        TweenObject(Card, 0.18, {
            Size = UDim2.new(1, 0, 0, 62),
        })

        TweenObject(Arrow, 0.18, {
            Rotation = 0,
        })
    end

    for Index, Option in ipairs(Options) do
        local OptionButton = New("TextButton", {
            Name = "Option_" .. Index,

            Size = UDim2.new(1, 0, 0, 30),

            BackgroundColor3 = Config.PanelLight,
            BackgroundTransparency = 0.1,

            BorderSizePixel = 0,

            AutoButtonColor = false,

            Text = tostring(Option),

            Font = Enum.Font.GothamMedium,
            TextSize = 10,

            TextColor3 = Config.TextDark,

            ZIndex = 21,
        }, OptionsFrame)

        AddCorner(OptionButton, 7)

        OptionButton.MouseEnter:Connect(function()
            TweenObject(OptionButton, 0.12, {
                BackgroundColor3 = Config.AccentDark,
                TextColor3 = Config.Text,
            })
        end)

        OptionButton.MouseLeave:Connect(function()
            TweenObject(OptionButton, 0.12, {
                BackgroundColor3 = Config.PanelLight,
                TextColor3 = Config.TextDark,
            })
        end)

        OptionButton.MouseButton1Click:Connect(function()
            SelectOption(Option)
        end)
    end

    Selector.MouseButton1Click:Connect(function()
        Open = not Open

        if Open then
            local Height = 62 + (#Options * 35) + 10

            TweenObject(Card, 0.2, {
                Size = UDim2.new(1, 0, 0, Height),
            })

            TweenObject(Arrow, 0.2, {
                Rotation = 180,
            })
        else
            TweenObject(Card, 0.2, {
                Size = UDim2.new(1, 0, 0, 62),
            })

            TweenObject(Arrow, 0.2, {
                Rotation = 0,
            })
        end
    end)

    return {
        Set = SelectOption,

        Get = function()
            return CurrentValue
        end,
    }
end

--====================================================--
-- SEARCH BOX
--====================================================--

local function CreateSearch(Page)
    local SearchFrame = RegisterComponent(New("Frame", {
        Name = "Search",

        Size = UDim2.new(1, 0, 0, 42),

        BackgroundColor3 = Config.PanelLight,
        BackgroundTransparency = 0.25,

        BorderSizePixel = 0,

        ZIndex = 8,
    }, Page))

    AddCorner(SearchFrame, 10)
    AddStroke(SearchFrame, Config.Border, 1, 0.4)

    local SearchIcon = New("TextLabel", {
        Size = UDim2.fromOffset(28, 42),
        Position = UDim2.fromOffset(8, 0),

        BackgroundTransparency = 1,

        Text = "⌕",

        Font = Enum.Font.GothamBold,
        TextSize = 20,

        TextColor3 = Config.Accent,

        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,

        ZIndex = 9,
    }, SearchFrame)

    local SearchBox = New("TextBox", {
        Size = UDim2.new(1, -50, 1, 0),
        Position = UDim2.fromOffset(42, 0),

        BackgroundTransparency = 1,

        Text = "",

        PlaceholderText = "Search features...",

        PlaceholderColor3 = Config.TextDark,

        Font = Enum.Font.Gotham,
        TextSize = 11,

        TextColor3 = Config.Text,

        ClearTextOnFocus = false,

        TextXAlignment = Enum.TextXAlignment.Left,

        ZIndex = 9,
    }, SearchFrame)

    return SearchBox
end

--====================================================--
-- COMBAT PAGE
--====================================================--

CreateInfoCard(
    CombatPage,
    "Combat Controls",
    "Configure targeting and aiming features."
)

CreateSection(
    CombatPage,
    "Aim Assistance",
    "Target selection and aiming behavior."
)

local AimAssist = CreateToggle(
    CombatPage,
    "Aim Assist",
    "Assist your aim toward a selected target.",
    false,
    function(Value)
        Config.AimAssist = Value
    end
)

local TeamCheck = CreateToggle(
    CombatPage,
    "Team Check",
    "Ignore players who are on your team.",
    true,
    function(Value)
        Config.TeamCheck = Value
    end
)

local VisibleOnly = CreateToggle(
    CombatPage,
    "Visible Only",
    "Only target players that can be seen.",
    true,
    function(Value)
        Config.VisibleOnly = Value
    end
)

local SilentAim = CreateToggle(
    CombatPage,
    "Silent Aim",
    "Redirect shots toward the selected target.",
    false,
    function(Value)
        Config.SilentAim = Value
    end
)

local TargetPart = CreateDropdown(
    CombatPage,
    "Target Part",
    "Select the body part used for targeting.",
    {
        "Head",
        "UpperTorso",
        "HumanoidRootPart",
        "LowerTorso",
    },
    "Head",
    function(Value)
        Config.TargetPart = Value
    end
)

local AimFOV = CreateSlider(
    CombatPage,
    "Aim FOV",
    "Maximum targeting field of view.",
    10,
    500,
    150,
    function(Value)
        Config.AimFOV = Value
    end
)

--====================================================--
-- VISUALS PAGE
--====================================================--

CreateInfoCard(
    VisualsPage,
    "Visual Controls",
    "Configure player and world visual features."
)

CreateSection(
    VisualsPage,
    "Player ESP",
    "Display useful information around players."
)

local ESP = CreateToggle(
    VisualsPage,
    "Player ESP",
    "Display players through walls.",
    false,
    function(Value)
        Config.ESP = Value
    end
)

local ESPNames = CreateToggle(
    VisualsPage,
    "Player Names",
    "Show player names above characters.",
    true,
    function(Value)
        Config.ESPNames = Value
    end
)

local ESPDistance = CreateToggle(
    VisualsPage,
    "Distance",
    "Display distance to players.",
    true,
    function(Value)
        Config.ESPDistance = Value
    end
)

local ESPHealth = CreateToggle(
    VisualsPage,
    "Health Bar",
    "Display player health information.",
    true,
    function(Value)
        Config.ESPHealth = Value
    end
)

local TeamESP = CreateToggle(
    VisualsPage,
    "Team Check",
    "Ignore teammates in ESP.",
    true,
    function(Value)
        Config.TeamESP = Value
    end
)

CreateSection(
    VisualsPage,
    "FOV",
    "Configure the visual aiming field."
)

local FOVCircle = CreateToggle(
    VisualsPage,
    "FOV Circle",
    "Display your current aim field.",
    false,
    function(Value)
        Config.FOVCircle = Value
    end
)

local FOVSize = CreateSlider(
    VisualsPage,
    "FOV Size",
    "Change the size of the FOV circle.",
    25,
    500,
    150,
    function(Value)
        Config.FOVSize = Value
    end
)

local FOVThickness = CreateSlider(
    VisualsPage,
    "FOV Thickness",
    "Change the thickness of the FOV circle.",
    1,
    5,
    2,
    function(Value)
        Config.FOVThickness = Value
    end
)

--====================================================--
-- DEFAULT VALUES
--====================================================--

Config.AimAssist = false
Config.TeamCheck = true
Config.VisibleOnly = true
Config.SilentAim = false

Config.TargetPart = "Head"
Config.AimFOV = 150

Config.ESP = false
Config.ESPNames = true
Config.ESPDistance = true
Config.ESPHealth = true
Config.TeamESP = true

Config.FOVCircle = false
Config.FOVSize = 150
Config.FOVThickness = 2

--====================================================--
-- SEARCH FILTER
--====================================================--

local function GetFeatureText(Object)
    local Text = ""

    for _, Child in ipairs(Object:GetDescendants()) do
        if Child:IsA("TextLabel")
            or Child:IsA("TextButton")
            or Child:IsA("TextBox") then

            Text = Text .. " " .. tostring(Child.Text)
        end
    end

    return string.lower(Text)
end

local CombatSearch = CreateSearch(CombatPage)
local VisualsSearch = CreateSearch(VisualsPage)

local function SetupSearch(SearchBox, Page)
    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local Query = string.lower(SearchBox.Text)

        for _, Child in ipairs(Page:GetChildren()) do
            if Child:IsA("Frame")
                and Child.Name ~= "Search" then

                if Query == "" then
                    Child.Visible = true
                else
                    Child.Visible =
                        string.find(
                            GetFeatureText(Child),
                            Query,
                            1,
                            true
                        ) ~= nil
                end
            end
        end
    end)
end

SetupSearch(CombatSearch, CombatPage)
SetupSearch(VisualsSearch, VisualsPage)

--//====================================================//--
--// END OF PART 2/4
--//====================================================//--

--//====================================================//
--// RIVALS HUB 2.1 - PART 3/4
--// MOVEMENT PAGE + SETTINGS PAGE
--//====================================================//

--//====================================================//
--// MOVEMENT PAGE
--//====================================================//

CreateInfoCard(
    MovementPage,
    "Movement Controls",
    "Customize your movement and character behavior."
)

CreateSection(
    MovementPage,
    "Movement"
)

CreateToggle(
    MovementPage,
    "Walk Speed",
    "Change your character's walking speed.",
    "WalkSpeed",
    false,
    function(Value)
        Config.WalkSpeedEnabled = Value
    end
)

CreateSlider(
    MovementPage,
    "Speed",
    "Walking speed value.",
    "SpeedValue",
    16,
    16,
    100,
    function(Value)
        Config.WalkSpeed = Value
    end
)

CreateToggle(
    MovementPage,
    "Jump Power",
    "Change your character's jump power.",
    "JumpPowerEnabled",
    false,
    function(Value)
        Config.JumpPowerEnabled = Value
    end
)

CreateSlider(
    MovementPage,
    "Jump",
    "Jump power value.",
    "JumpValue",
    50,
    50,
    150,
    function(Value)
        Config.JumpPower = Value
    end
)

CreateToggle(
    MovementPage,
    "Infinite Jump",
    "Jump again while already in the air.",
    "InfiniteJump",
    false,
    function(Value)
        Config.InfiniteJump = Value
    end
)

CreateToggle(
    MovementPage,
    "Noclip",
    "Walk through physical objects.",
    "Noclip",
    false,
    function(Value)
        Config.Noclip = Value
    end
)

CreateToggle(
    MovementPage,
    "Auto Sprint",
    "Automatically move at sprint speed when available.",
    "AutoSprint",
    false,
    function(Value)
        Config.AutoSprint = Value
    end
)

CreateSection(
    MovementPage,
    "Character"
)

CreateToggle(
    MovementPage,
    "Anti Fall",
    "Reduce accidental falls caused by movement.",
    "AntiFall",
    false,
    function(Value)
        Config.AntiFall = Value
    end
)

CreateToggle(
    MovementPage,
    "No Slow",
    "Prevent movement slowdowns when possible.",
    "NoSlow",
    false,
    function(Value)
        Config.NoSlow = Value
    end
)

--//====================================================//
--// SETTINGS PAGE
--//====================================================//

CreateInfoCard(
    SettingsPage,
    "Hub Settings",
    "Customize the interface and controls."
)

CreateSection(
    SettingsPage,
    "Interface"
)

CreateToggle(
    SettingsPage,
    "Animations",
    "Enable menu opening, closing and page animations.",
    "Animations",
    true,
    function(Value)
        Config.Animations = Value
    end
)

CreateToggle(
    SettingsPage,
    "Background Effects",
    "Enable the animated purple background.",
    "BackgroundEffects",
    true,
    function(Value)
        Config.BackgroundEffects = Value
    end
)

CreateToggle(
    SettingsPage,
    "UI Glow",
    "Enable subtle purple glow effects.",
    "UIGlow",
    true,
    function(Value)
        Config.UIGlow = Value
    end
)

CreateSection(
    SettingsPage,
    "Menu Controls"
)

CreateInfoCard(
    SettingsPage,
    "Keyboard Controls",
    "RightShift — Minimize / Restore\nMouse — Drag the menu or mini button"
)

CreateToggle(
    SettingsPage,
    "RightShift Key",
    "Enable the RightShift minimize shortcut.",
    "RightShift",
    true,
    function(Value)
        Config.RightShift = Value
    end
)

CreateSection(
    SettingsPage,
    "Reset"
)

local ResetCard = New(
    "Frame",
    {
        Parent = SettingsPage,
        Size = UDim2.new(1, -12, 0, 58),
        BackgroundColor3 = Config.Panel,
        BorderSizePixel = 0,
    }
)

AddCorner(ResetCard, 10)
AddStroke(ResetCard, Config.Border, 1, 0.25)

local ResetTitle = New(
    "TextLabel",
    {
        Parent = ResetCard,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 14, 0, 8),
        Size = UDim2.new(1, -125, 0, 20),
        Font = Enum.Font.GothamMedium,
        Text = "Reset Settings",
        TextColor3 = Config.Text,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
    }
)

local ResetDescription = New(
    "TextLabel",
    {
        Parent = ResetCard,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 14, 0, 29),
        Size = UDim2.new(1, -125, 0, 18),
        Font = Enum.Font.Gotham,
        Text = "Restore default hub settings.",
        TextColor3 = Config.TextDark,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
    }
)

local ResetButton = New(
    "TextButton",
    {
        Parent = ResetCard,
        BackgroundColor3 = Config.AccentDark,
        Position = UDim2.new(1, -100, 0.5, -17),
        Size = UDim2.new(0, 86, 0, 34),
        AutoButtonColor = false,
        Font = Enum.Font.GothamMedium,
        Text = "RESET",
        TextColor3 = Config.Text,
        TextSize = 11,
    }
)

AddCorner(ResetButton, 8)

ResetButton.MouseEnter:Connect(function()
    TweenObject(
        ResetButton,
        {BackgroundColor3 = Config.Accent},
        0.12
    )
end)

ResetButton.MouseLeave:Connect(function()
    TweenObject(
        ResetButton,
        {BackgroundColor3 = Config.AccentDark},
        0.12
    )
end)

ResetButton.MouseButton1Click:Connect(function()

    Config.AimAssist = false
    Config.TeamCheck = false
    Config.VisibleOnly = false
    Config.SilentAim = false

    Config.PlayerESP = false
    Config.PlayerNames = false
    Config.Distance = false
    Config.HealthBar = false
    Config.FOVCircle = false

    Config.WalkSpeedEnabled = false
    Config.JumpPowerEnabled = false
    Config.InfiniteJump = false
    Config.Noclip = false
    Config.AutoSprint = false
    Config.AntiFall = false
    Config.NoSlow = false

    Config.Animations = true
    Config.BackgroundEffects = true
    Config.UIGlow = true
    Config.RightShift = true

    Config.WalkSpeed = 16
    Config.JumpPower = 50
    Config.AimFOV = 150
    Config.FOVSize = 150
    Config.FOVThickness = 2

    for Name, Component in pairs(Components) do

        if Component.Type == "Toggle" then

            local State = false

            if Name == "Animations" then
                State = true
            elseif Name == "BackgroundEffects" then
                State = true
            elseif Name == "UIGlow" then
                State = true
            elseif Name == "RightShift" then
                State = true
            end

            Component:Set(State)

        elseif Component.Type == "Slider" then

            if Name == "SpeedValue" then
                Component:Set(16)
            elseif Name == "JumpValue" then
                Component:Set(50)
            elseif Name == "AimFOV" then
                Component:Set(150)
            elseif Name == "FOVSize" then
                Component:Set(150)
            elseif Name == "FOVThickness" then
                Component:Set(2)
            end

        end
    end

    if typeof(LocalPlayer) == "Instance" then

        local Character = LocalPlayer.Character

        if Character then

            local Humanoid = Character:FindFirstChildOfClass("Humanoid")

            if Humanoid then
                Humanoid.WalkSpeed = 16
                Humanoid.JumpPower = 50
            end
        end
    end
end)

--//====================================================//
--// PAGE SCROLL SETTINGS
--//====================================================//

local function UpdateCanvas(Page)

    if not Page then
        return
    end

    task.defer(function()

        local Layout = Page:FindFirstChildOfClass("UIListLayout")

        if Layout then
            Page.CanvasSize = UDim2.new(
                0,
                0,
                0,
                Layout.AbsoluteContentSize.Y + 16
            )
        end
    end)
end

for _, Page in pairs({
    CombatPage,
    VisualsPage,
    MovementPage,
    SettingsPage
}) do

    local Layout = Page:FindFirstChildOfClass("UIListLayout")

    if Layout then

        Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            UpdateCanvas(Page)
        end)

        UpdateCanvas(Page)
    end
end

--//====================================================//
--// SETTINGS DEFAULTS
--//====================================================//

Config.WalkSpeedEnabled = Config.WalkSpeedEnabled or false
Config.WalkSpeed = Config.WalkSpeed or 16

Config.JumpPowerEnabled = Config.JumpPowerEnabled or false
Config.JumpPower = Config.JumpPower or 50

Config.InfiniteJump = Config.InfiniteJump or false
Config.Noclip = Config.Noclip or false
Config.AutoSprint = Config.AutoSprint or false

Config.AntiFall = Config.AntiFall or false
Config.NoSlow = Config.NoSlow or false

Config.Animations = Config.Animations ~= false
Config.BackgroundEffects = Config.BackgroundEffects ~= false
Config.UIGlow = Config.UIGlow ~= false
Config.RightShift = Config.RightShift ~= false

--//====================================================//
--// BACKGROUND EFFECT TOGGLE
--//====================================================//

local BackgroundObjects = {}

for _, Object in ipairs(Holder:GetDescendants()) do

    if Object.Name == "BackgroundLine"
    or Object.Name == "BackgroundGlow" then

        table.insert(BackgroundObjects, Object)
    end
end

local function UpdateBackgroundEffects()

    for _, Object in ipairs(BackgroundObjects) do

        if Object and Object.Parent then
            Object.Visible = Config.BackgroundEffects
        end
    end
end

local function UpdateUIEffects()

    for _, Object in ipairs(Holder:GetDescendants()) do

        if Object:IsA("UIStroke") then

            if Object.Name == "GlowStroke" then
                Object.Transparency = Config.UIGlow and 0.15 or 0.65
            end

        end
    end
end

UpdateBackgroundEffects()
UpdateUIEffects()

--//====================================================//
--// ANIMATION UPDATE
--//====================================================//

local function RefreshAnimationState()

    if Config.Animations then
        Config.AnimationSpeed = 0.22
    else
        Config.AnimationSpeed = 0.01
    end
end

RefreshAnimationState()

if Components.Animations then
    Components.Animations:Set(Config.Animations)
end

if Components.BackgroundEffects then
    Components.BackgroundEffects:Set(Config.BackgroundEffects)
end

if Components.UIGlow then
    Components.UIGlow:Set(Config.UIGlow)
end

if Components.RightShift then
    Components.RightShift:Set(Config.RightShift)
end

--//====================================================//
--// LIVE SETTINGS CONNECTIONS
--//====================================================//

local function ApplyInterfaceSettings()

    RefreshAnimationState()
    UpdateBackgroundEffects()
    UpdateUIEffects()

end

if Components.Animations then

    local OldCallback = Components.Animations.Callback

    Components.Animations.Callback = function(Value)

        Config.Animations = Value

        ApplyInterfaceSettings()

        if OldCallback then
            OldCallback(Value)
        end
    end
end

if Components.BackgroundEffects then

    local OldCallback = Components.BackgroundEffects.Callback

    Components.BackgroundEffects.Callback = function(Value)

        Config.BackgroundEffects = Value

        UpdateBackgroundEffects()

        if OldCallback then
            OldCallback(Value)
        end
    end
end

if Components.UIGlow then

    local OldCallback = Components.UIGlow.Callback

    Components.UIGlow.Callback = function(Value)

        Config.UIGlow = Value

        UpdateUIEffects()

        if OldCallback then
            OldCallback(Value)
        end
    end
end

--//====================================================//
--// MOVEMENT VALUES
--//====================================================//

local function GetCharacter()
    return LocalPlayer and LocalPlayer.Character
end

local function GetHumanoid()

    local Character = GetCharacter()

    if not Character then
        return nil
    end

    return Character:FindFirstChildOfClass("Humanoid")
end

--//====================================================//
--// CHARACTER RESPAWN RESET
--//====================================================//

if LocalPlayer then

    LocalPlayer.CharacterAdded:Connect(function(Character)

        task.wait(0.5)

        local Humanoid = Character:FindFirstChildOfClass("Humanoid")

        if Humanoid then

            if Config.WalkSpeedEnabled then
                Humanoid.WalkSpeed = Config.WalkSpeed
            else
                Humanoid.WalkSpeed = 16
            end

            if Config.JumpPowerEnabled then
                Humanoid.JumpPower = Config.JumpPower
            else
                Humanoid.JumpPower = 50
            end
        end
    end)
end

--//====================================================//
--// END OF PART 3/4
--//====================================================//

--//====================================================//
--// RIVALS HUB 2.1 - PART 4/4
--// FEATURE LOGIC + ESP + MOVEMENT + FINAL
--//====================================================//

--//====================================================//
--// FEATURE STATE
--//====================================================//

local FeatureConnections = {}
local ESPObjects = {}
local FOVCircle = nil

local function DisconnectFeature(Name)

    local Connection = FeatureConnections[Name]

    if Connection then
        Connection:Disconnect()
        FeatureConnections[Name] = nil
    end
end

local function SetFeatureConnection(Name, Connection)

    DisconnectFeature(Name)

    if Connection then
        FeatureConnections[Name] = Connection
    end
end

--//====================================================//
--// TARGET SYSTEM
--//====================================================//

local function IsAlive(Player)

    if not Player then
        return false
    end

    local Character = Player.Character

    if not Character then
        return false
    end

    local Humanoid = Character:FindFirstChildOfClass("Humanoid")

    return Humanoid and Humanoid.Health > 0
end

local function IsEnemy(Player)

    if not Player or Player == LocalPlayer then
        return false
    end

    if not Config.TeamCheck then
        return true
    end

    if LocalPlayer.Team == nil or Player.Team == nil then
        return true
    end

    return Player.Team ~= LocalPlayer.Team
end

local function GetTargetPart(Character)

    if not Character then
        return nil
    end

    local PartName = Config.TargetPart or "Head"

    local Part = Character:FindFirstChild(PartName)

    if Part then
        return Part
    end

    return Character:FindFirstChild("HumanoidRootPart")
        or Character:FindFirstChild("Head")
end

local function GetClosestTarget()

    local Camera = workspace.CurrentCamera

    if not Camera then
        return nil
    end

    local Center = Camera.ViewportSize / 2
    local ClosestPlayer = nil
    local ClosestDistance = math.huge

    for _, Player in ipairs(Players:GetPlayers()) do

        if IsEnemy(Player) and IsAlive(Player) then

            local Character = Player.Character
            local TargetPart = GetTargetPart(Character)

            if TargetPart then

                local Position, OnScreen =
                    Camera:WorldToViewportPoint(TargetPart.Position)

                if OnScreen then

                    local ScreenPosition =
                        Vector2.new(Position.X, Position.Y)

                    local Distance =
                        (ScreenPosition - Center).Magnitude

                    if Distance <= (Config.AimFOV or 150)
                    and Distance < ClosestDistance then

                        if Config.VisibleOnly then

                            local Origin =
                                Camera.CFrame.Position

                            local Direction =
                                TargetPart.Position - Origin

                            local Params =
                                RaycastParams.new()

                            Params.FilterType =
                                Enum.RaycastFilterType.Exclude

                            Params.FilterDescendantsInstances = {
                                LocalPlayer.Character,
                                Camera
                            }

                            local Result =
                                workspace:Raycast(
                                    Origin,
                                    Direction,
                                    Params
                                )

                            if Result
                            and not Result.Instance:IsDescendantOf(Character) then
                                continue
                            end
                        end

                        ClosestDistance = Distance
                        ClosestPlayer = Player
                    end
                end
            end
        end
    end

    return ClosestPlayer
end

--//====================================================//
--// AIM ASSIST
--//====================================================//

local function StopAimAssist()

    DisconnectFeature("AimAssist")

end

local function StartAimAssist()

    StopAimAssist()

    SetFeatureConnection(
        "AimAssist",
        RunService.RenderStepped:Connect(function()

            if not Config.AimAssist then
                return
            end

            local Camera = workspace.CurrentCamera

            if not Camera then
                return
            end

            local Target = GetClosestTarget()

            if not Target then
                return
            end

            local Character = Target.Character
            local Part = GetTargetPart(Character)

            if not Part then
                return
            end

            local Current =
                Camera.CFrame.Position

            local Desired =
                CFrame.lookAt(
                    Current,
                    Part.Position
                )

            Camera.CFrame =
                Camera.CFrame:Lerp(
                    Desired,
                    0.14
                )
        end)
    )

end

--//====================================================//
--// FOV CIRCLE
--//====================================================//

local function CreateFOVCircle()

    if FOVCircle then
        FOVCircle:Destroy()
        FOVCircle = nil
    end

    local Circle = New(
        "Frame",
        {
            Name = "FOVCircle",
            Parent = ScreenGui,
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.fromOffset(
                Config.FOVSize * 2,
                Config.FOVSize * 2
            ),
            Position = UDim2.fromScale(0.5, 0.5),
            ZIndex = 50,
            Visible = Config.FOVCircle,
        }
    )

    AddCorner(Circle, 999)

    local Stroke =
        AddStroke(
            Circle,
            Config.Accent,
            Config.FOVThickness,
            0.25
        )

    Stroke.Name = "FOVStroke"

    FOVCircle = Circle

end

local function UpdateFOVCircle()

    if not FOVCircle then
        CreateFOVCircle()
    end

    if not FOVCircle then
        return
    end

    FOVCircle.Visible = Config.FOVCircle

    FOVCircle.Size = UDim2.fromOffset(
        Config.FOVSize * 2,
        Config.FOVSize * 2
    )

    local Stroke =
        FOVCircle:FindFirstChild("FOVStroke")

    if Stroke then
        Stroke.Thickness = Config.FOVThickness
    end
end

CreateFOVCircle()

--//====================================================//
--// ESP
--//====================================================//

local function RemoveESP(Player)

    local Data = ESPObjects[Player]

    if not Data then
        return
    end

    if Data.Highlight then
        Data.Highlight:Destroy()
    end

    if Data.Billboard then
        Data.Billboard:Destroy()
    end

    ESPObjects[Player] = nil

end

local function CreateESP(Player)

    if not Player or Player == LocalPlayer then
        return
    end

    RemoveESP(Player)

    local Character = Player.Character

    if not Character then
        return
    end

    local Root =
        Character:FindFirstChild("HumanoidRootPart")
        or Character:FindFirstChild("Head")

    if not Root then
        return
    end

    local Data = {}

    --// Highlight

    local Highlight = Instance.new("Highlight")

    Highlight.Name = "RivalsESP"
    Highlight.Adornee = Character
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Highlight.FillTransparency = 0.78
    Highlight.OutlineTransparency = 0.1
    Highlight.FillColor = Config.Accent
    Highlight.OutlineColor = Config.Accent

    if Config.TeamCheck and Player.Team == LocalPlayer.Team then
        Highlight.FillTransparency = 1
        Highlight.OutlineTransparency = 1
    end

    Highlight.Parent = Character

    Data.Highlight = Highlight

    --// Billboard

    local Billboard =
        Instance.new("BillboardGui")

    Billboard.Name = "RivalsESPInfo"
    Billboard.Adornee = Root
    Billboard.Size = UDim2.fromOffset(180, 55)
    Billboard.StudsOffset = Vector3.new(0, 3.2, 0)
    Billboard.AlwaysOnTop = true
    Billboard.Enabled =
        Config.PlayerNames
        or Config.Distance
        or Config.HealthBar

    Billboard.Parent = Root

    Data.Billboard = Billboard

    local Holder =
        Instance.new("Frame")

    Holder.BackgroundTransparency = 1
    Holder.Size = UDim2.fromScale(1, 1)
    Holder.Parent = Billboard

    local NameLabel =
        Instance.new("TextLabel")

    NameLabel.BackgroundTransparency = 1
    NameLabel.Position = UDim2.new(0, 0, 0, 0)
    NameLabel.Size = UDim2.new(1, 0, 0, 20)
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextColor3 = Config.Text
    NameLabel.TextSize = 12
    NameLabel.TextStrokeTransparency = 0.5
    NameLabel.Text = Player.DisplayName
    NameLabel.Visible = Config.PlayerNames
    NameLabel.Parent = Holder

    local DistanceLabel =
        Instance.new("TextLabel")

    DistanceLabel.BackgroundTransparency = 1
    DistanceLabel.Position = UDim2.new(0, 0, 0, 19)
    DistanceLabel.Size = UDim2.new(1, 0, 0, 16)
    DistanceLabel.Font = Enum.Font.Gotham
    DistanceLabel.TextColor3 = Config.TextDark
    DistanceLabel.TextSize = 10
    DistanceLabel.TextStrokeTransparency = 0.6
    DistanceLabel.Text = ""
    DistanceLabel.Visible = Config.Distance
    DistanceLabel.Parent = Holder

    local HealthLabel =
        Instance.new("TextLabel")

    HealthLabel.BackgroundTransparency = 1
    HealthLabel.Position = UDim2.new(0, 0, 0, 35)
    HealthLabel.Size = UDim2.new(1, 0, 0, 16)
    HealthLabel.Font = Enum.Font.Gotham
    HealthLabel.TextColor3 = Config.Text
    HealthLabel.TextSize = 10
    HealthLabel.TextStrokeTransparency = 0.6
    HealthLabel.Text = ""
    HealthLabel.Visible = Config.HealthBar
    HealthLabel.Parent = Holder

    Data.NameLabel = NameLabel
    Data.DistanceLabel = DistanceLabel
    Data.HealthLabel = HealthLabel

    ESPObjects[Player] = Data

end

local function UpdateESP(Player)

    local Data = ESPObjects[Player]

    if not Data then
        return
    end

    local Character = Player.Character

    if not Character then
        RemoveESP(Player)
        return
    end

    local Root =
        Character:FindFirstChild("HumanoidRootPart")

    local Humanoid =
        Character:FindFirstChildOfClass("Humanoid")

    if not Root or not Humanoid then
        return
    end

    local Allowed =
        not Config.TeamCheck
        or Player.Team ~= LocalPlayer.Team

    if Data.Highlight then

        Data.Highlight.Enabled =
            Config.PlayerESP and Allowed

        Data.Highlight.FillColor =
            Config.Accent

        Data.Highlight.OutlineColor =
            Config.Accent
    end

    if Data.Billboard then

        Data.Billboard.Enabled =
            Config.PlayerESP
            and (
                Config.PlayerNames
                or Config.Distance
                or Config.HealthBar
            )
            and Allowed
    end

    if Data.NameLabel then
        Data.NameLabel.Visible =
            Config.PlayerNames
    end

    if Data.DistanceLabel then

        Data.DistanceLabel.Visible =
            Config.Distance

        local MyCharacter =
            LocalPlayer.Character

        local MyRoot =
            MyCharacter
            and MyCharacter:FindFirstChild("HumanoidRootPart")

        if MyRoot then

            local Distance =
                (Root.Position - MyRoot.Position).Magnitude

            Data.DistanceLabel.Text =
                string.format(
                    "%d studs",
                    math.floor(Distance)
                )
        end
    end

    if Data.HealthLabel then

        Data.HealthLabel.Visible =
            Config.HealthBar

        Data.HealthLabel.Text =
            string.format(
                "HP: %d / %d",
                math.floor(Humanoid.Health),
                math.floor(Humanoid.MaxHealth)
            )
    end

end

local function RefreshESP()

    for _, Player in ipairs(Players:GetPlayers()) do

        if Player ~= LocalPlayer then

            if Config.PlayerESP then
                CreateESP(Player)
            else
                RemoveESP(Player)
            end
        end
    end

end

Players.PlayerAdded:Connect(function(Player)

    Player.CharacterAdded:Connect(function()

        task.wait(0.5)

        if Config.PlayerESP then
            CreateESP(Player)
        end
    end)

end)

Players.PlayerRemoving:Connect(function(Player)

    RemoveESP(Player)

end)

for _, Player in ipairs(Players:GetPlayers()) do

    if Player ~= LocalPlayer then

        Player.CharacterAdded:Connect(function()

            task.wait(0.4)

            if Config.PlayerESP then
                CreateESP(Player)
            end
        end)
    end
end

--//====================================================//
--// ESP UPDATE LOOP
--//====================================================//

SetFeatureConnection(
    "ESPUpdate",
    RunService.RenderStepped:Connect(function()

        if Config.PlayerESP then

            for Player in pairs(ESPObjects) do
                UpdateESP(Player)
            end

        end

        if FOVCircle then
            UpdateFOVCircle()
        end
    end)
)

--//====================================================//
--// MOVEMENT SYSTEM
--//====================================================//

local OriginalWalkSpeed = 16
local OriginalJumpPower = 50

local function ApplyMovement()

    local Humanoid = GetHumanoid()

    if not Humanoid then
        return
    end

    if Config.WalkSpeedEnabled then
        Humanoid.WalkSpeed = Config.WalkSpeed
    else
        Humanoid.WalkSpeed = OriginalWalkSpeed
    end

    if Config.JumpPowerEnabled then
        Humanoid.JumpPower = Config.JumpPower
    else
        Humanoid.JumpPower = OriginalJumpPower
    end
end

--//====================================================//
--// INFINITE JUMP
--//====================================================//

SetFeatureConnection(
    "InfiniteJump",
    UserInputService.JumpRequest:Connect(function()

        if not Config.InfiniteJump then
            return
        end

        local Humanoid = GetHumanoid()

        if Humanoid then
            Humanoid:ChangeState(
                Enum.HumanoidStateType.Jumping
            )
        end
    end)
)

--//====================================================//
--// NOCLIP
--//====================================================//

SetFeatureConnection(
    "Noclip",
    RunService.Stepped:Connect(function()

        if not Config.Noclip then
            return
        end

        local Character = GetCharacter()

        if not Character then
            return
        end

        for _, Object in ipairs(Character:GetDescendants()) do

            if Object:IsA("BasePart") then
                Object.CanCollide = false
            end
        end
    end)
)

--//====================================================//
--// AUTO MOVEMENT UPDATE
--//====================================================//

SetFeatureConnection(
    "MovementUpdate",
    RunService.RenderStepped:Connect(function()

        if Config.WalkSpeedEnabled
        or Config.JumpPowerEnabled then

            ApplyMovement()
        end
    end)
)

--//====================================================//
--// NO SLOW
--//====================================================//

SetFeatureConnection(
    "NoSlow",
    RunService.RenderStepped:Connect(function()

        if not Config.NoSlow then
            return
        end

        local Humanoid = GetHumanoid()

        if Humanoid
        and Humanoid.WalkSpeed < Config.WalkSpeed
        and Config.WalkSpeedEnabled then

            Humanoid.WalkSpeed =
                Config.WalkSpeed
        end
    end)
)

--//====================================================//
--// AIM CALLBACK
--//====================================================//

if Components.AimAssist then

    Components.AimAssist.Callback = function(Value)

        Config.AimAssist = Value

        if Value then
            StartAimAssist()
        else
            StopAimAssist()
        end
    end
end

--//====================================================//
--// VISUAL CALLBACKS
--//====================================================//

local function SetupVisualCallbacks()

    if Components.PlayerESP then

        Components.PlayerESP.Callback = function(Value)

            Config.PlayerESP = Value

            RefreshESP()
        end
    end

    if Components.PlayerNames then

        Components.PlayerNames.Callback = function(Value)

            Config.PlayerNames = Value

            for Player in pairs(ESPObjects) do
                UpdateESP(Player)
            end
        end
    end

    if Components.Distance then

        Components.Distance.Callback = function(Value)

            Config.Distance = Value

            for Player in pairs(ESPObjects) do
                UpdateESP(Player)
            end
        end
    end

    if Components.HealthBar then

        Components.HealthBar.Callback = function(Value)

            Config.HealthBar = Value

            for Player in pairs(ESPObjects) do
                UpdateESP(Player)
            end
        end
    end

    if Components.TeamCheck then

        Components.TeamCheck.Callback = function(Value)

            Config.TeamCheck = Value

            RefreshESP()
        end
    end

    if Components.FOVCircle then

        Components.FOVCircle.Callback = function(Value)

            Config.FOVCircle = Value

            UpdateFOVCircle()
        end
    end

    if Components.FOVSize then

        Components.FOVSize.Callback = function(Value)

            Config.FOVSize = Value

            UpdateFOVCircle()
        end
    end

    if Components.FOVThickness then

        Components.FOVThickness.Callback = function(Value)

            Config.FOVThickness = Value

            UpdateFOVCircle()
        end
    end
end

SetupVisualCallbacks()

--//====================================================//
--// MOVEMENT CALLBACKS
--//====================================================//

local function SetupMovementCallbacks()

    if Components.WalkSpeedEnabled then

        Components.WalkSpeedEnabled.Callback =
            function(Value)

                Config.WalkSpeedEnabled = Value

                ApplyMovement()
            end
    end

    if Components.SpeedValue then

        Components.SpeedValue.Callback =
            function(Value)

                Config.WalkSpeed = Value

                if Config.WalkSpeedEnabled then
                    ApplyMovement()
                end
            end
    end

    if Components.JumpPowerEnabled then

        Components.JumpPowerEnabled.Callback =
            function(Value)

                Config.JumpPowerEnabled = Value

                ApplyMovement()
            end
    end

    if Components.JumpValue then

        Components.JumpValue.Callback =
            function(Value)

                Config.JumpPower = Value

                if Config.JumpPowerEnabled then
                    ApplyMovement()
                end
            end
    end

    if Components.InfiniteJump then

        Components.InfiniteJump.Callback =
            function(Value)

                Config.InfiniteJump = Value
            end
    end

    if Components.Noclip then

        Components.Noclip.Callback =
            function(Value)

                Config.Noclip = Value

                if not Value then

                    local Character =
                        GetCharacter()

                    if Character then

                        for _, Object in
                            ipairs(Character:GetDescendants()) do

                            if Object:IsA("BasePart") then
                                Object.CanCollide = true
                            end
                        end
                    end
                end
            end
    end

    if Components.AutoSprint then

        Components.AutoSprint.Callback =
            function(Value)

                Config.AutoSprint = Value
            end
    end

    if Components.AntiFall then

        Components.AntiFall.Callback =
            function(Value)

                Config.AntiFall = Value
            end
    end

    if Components.NoSlow then

        Components.NoSlow.Callback =
            function(Value)

                Config.NoSlow = Value
            end
    end
end

SetupMovementCallbacks()

--//====================================================//
--// SLIDER CALLBACKS
--//====================================================//

if Components.AimFOV then

    Components.AimFOV.Callback = function(Value)

        Config.AimFOV = Value

        if Config.FOVCircle then
            UpdateFOVCircle()
        end
    end
end

--//====================================================//
--// TARGET DROPDOWN CALLBACK
--//====================================================//

if Components.TargetPart then

    Components.TargetPart.Callback =
        function(Value)

            Config.TargetPart = Value
        end
end

--//====================================================//
--// SILENT AIM STATE
--//====================================================//

if Components.SilentAim then

    Components.SilentAim.Callback =
        function(Value)

            Config.SilentAim = Value
        end
end

--//====================================================//
--// VISUAL INITIALIZATION
--//====================================================//

task.defer(function()

    RefreshESP()
    UpdateFOVCircle()
    ApplyMovement()

end)

--//====================================================//
--// BACKGROUND ANIMATION
--//====================================================//

local BackgroundTime = 0

SetFeatureConnection(
    "BackgroundAnimation",
    RunService.RenderStepped:Connect(function(Delta)

        if Config.MenuDestroyed then
            return
        end

        if not Config.BackgroundEffects then
            return
        end

        BackgroundTime += Delta

        for Index, Line in ipairs(BackgroundObjects) do

            if Line
            and Line.Parent
            and Line.Name == "BackgroundLine" then

                local Offset =
                    math.sin(
                        BackgroundTime * 0.55
                        + Index * 0.65
                    ) * 0.025

                Line.Position =
                    UDim2.new(
                        -0.2 + Offset,
                        0,
                        Line.Position.Y.Scale,
                        Line.Position.Y.Offset
                    )
            end
        end
    end)
)

--//====================================================//
--// MENU SAFETY
--//====================================================//

local function CleanupAll()

    if Config.MenuDestroyed then
        return
    end

    Config.MenuDestroyed = true

    for Name, Connection in pairs(FeatureConnections) do

        if Connection then
            Connection:Disconnect()
        end

        FeatureConnections[Name] = nil
    end

    for Player in pairs(ESPObjects) do
        RemoveESP(Player)
    end

    if FOVCircle then
        FOVCircle:Destroy()
        FOVCircle = nil
    end
end

--//====================================================//
--// CLOSE OVERRIDE
--//====================================================//

local OriginalCloseMenu = CloseMenu

CloseMenu = function()

    if Config.MenuDestroyed then
        return
    end

    CleanupAll()

    if ScreenGui and ScreenGui.Parent then

        local Scale =
            Holder:FindFirstChildOfClass("UIScale")

        if Scale then

            TweenObject(
                Scale,
                {Scale = 0.82},
                Config.AnimationSpeed
            )

        end

        task.delay(
            Config.AnimationSpeed + 0.03,
            function()

                if ScreenGui
                and ScreenGui.Parent then

                    ScreenGui:Destroy()
                end
            end
        )
    end
end

--//====================================================//
--// FINAL RIGHTSHIFT HANDLER
--//====================================================//

UserInputService.InputBegan:Connect(function(Input, GameProcessed)

    if GameProcessed then
        return
    end

    if Config.MenuDestroyed then
        return
    end

    if not Config.RightShift then
        return
    end

    if Input.KeyCode == Enum.KeyCode.RightShift then

        if Config.MenuOpen then
            MinimizeMenu()
        else
            RestoreMenu()
        end
    end
end)

--//====================================================//
--// MINI BUTTON SAFETY
--//====================================================//

MiniButton.MouseButton1Click:Connect(function()

    if Config.MenuDestroyed then
        return
    end

    if Config.MenuOpen then
        MinimizeMenu()
    else
        RestoreMenu()
    end
end)

--//====================================================//
--// FINAL MENU STATE
--//====================================================//

Config.MenuOpen = true
MiniButton.Visible = false
Main.Visible = true
Holder.Visible = true

--//====================================================//
--// FINAL CLEANUP WHEN GUI IS REMOVED
--//====================================================//

ScreenGui.AncestryChanged:Connect(function(_, Parent)

    if Parent == nil then

        Config.MenuDestroyed = true

        for Name, Connection in pairs(FeatureConnections) do

            if Connection then
                Connection:Disconnect()
            end

            FeatureConnections[Name] = nil
        end

        for Player in pairs(ESPObjects) do
            RemoveESP(Player)
        end

        ESPObjects = {}
    end
end)

--//====================================================//
--// STARTUP
--//====================================================//

task.defer(function()

    task.wait(0.1)

    if Config.MenuDestroyed then
        return
    end

    Main.Visible = true
    MiniButton.Visible = false

    local Scale =
        Holder:FindFirstChildOfClass("UIScale")

    if Scale then

        Scale.Scale = 0.94

        TweenObject(
            Scale,
            {Scale = 1},
            Config.AnimationSpeed
        )
    end

end)

--//====================================================//
--// END OF RIVALS HUB 2.1
--//====================================================//
