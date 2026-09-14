--==================================================
-- RIVALS HUB
-- PART 1/4
-- UI CORE
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

--==================================================
-- CONFIG
--==================================================

local Config = {
    Version = "v1.0",
    Creator = "By: Lunar Hub",

    -- Combat
    AimAssist = false,
    VisibleOnly = false,
    AimFOV = false,
    FOVSize = 250,
    Smoothness = 0.15,
    TargetPart = "Head",

    -- Visuals
    ESP = false,
    ModelESP = false,
    Box = false,
    Names = false,
    Health = false,
    Distance = false,

    -- Movement
    Speed = false,
    SpeedValue = 16,
    Jump = false,
    JumpPower = 50,
    Noclip = false
}

--==================================================
-- COLORS
--==================================================

local Colors = {
    Background = Color3.fromRGB(10, 12, 17),
    Panel = Color3.fromRGB(15, 18, 25),
    Card = Color3.fromRGB(19, 23, 31),
    CardHover = Color3.fromRGB(25, 30, 40),

    Menu = Color3.fromRGB(55, 115, 255),
    MenuDark = Color3.fromRGB(35, 80, 190),

    Text = Color3.fromRGB(245, 247, 255),
    SubText = Color3.fromRGB(170, 177, 192),
    Muted = Color3.fromRGB(105, 113, 130),

    Border = Color3.fromRGB(48, 56, 72)
}

--==================================================
-- HELPERS
--==================================================

local function New(className, properties, parent)
    local object = Instance.new(className)

    for property, value in pairs(properties or {}) do
        object[property] = value
    end

    if parent then
        object.Parent = parent
    end

    return object
end

local function Corner(object, radius)
    return New("UICorner", {
        CornerRadius = UDim.new(0, radius)
    }, object)
end

local function Stroke(object, color, thickness, transparency)
    return New("UIStroke", {
        Color = color or Colors.Border,
        Thickness = thickness or 1,
        Transparency = transparency or 0
    }, object)
end

local function Tween(object, info, properties)
    local tween = TweenService:Create(
        object,
        info,
        properties
    )

    tween:Play()

    return tween
end

local function FastTween(object, properties, duration)
    return Tween(
        object,
        TweenInfo.new(
            duration or 0.15,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        properties
    )
end

--==================================================
-- SCREEN GUI
--==================================================

local ScreenGui = New("ScreenGui", {
    Name = "RivalsHub",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
})

pcall(function()
    ScreenGui.Parent = CoreGui
end)

if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

--==================================================
-- MAIN HOLDER
--==================================================

local Holder = New("Frame", {
    Name = "Holder",
    Parent = ScreenGui,

    Size = UDim2.fromOffset(720, 470),

    Position = UDim2.fromScale(0.5, 0.5),

    AnchorPoint = Vector2.new(0.5, 0.5),

    BackgroundTransparency = 1,
    BorderSizePixel = 0
})

local HolderScale = New("UIScale", {
    Scale = 0.82
}, Holder)

--==================================================
-- GLOW
--==================================================

local Glow = New("ImageLabel", {
    Name = "Glow",

    Size = UDim2.new(1, 70, 1, 70),
    Position = UDim2.fromOffset(-35, -35),

    BackgroundTransparency = 1,

    Image = "rbxassetid://5028857084",

    ImageColor3 = Colors.Menu,

    ImageTransparency = 0.68,

    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(24, 24, 276, 276),

    ZIndex = 0
}, Holder)

--==================================================
-- MAIN
--==================================================

local Main = New("Frame", {
    Name = "Main",

    Size = UDim2.fromScale(1, 1),

    BackgroundColor3 = Colors.Background,

    BackgroundTransparency = 0,

    BorderSizePixel = 0,

    ZIndex = 2
}, Holder)

Corner(Main, 22)
Stroke(Main, Colors.Border, 1, 0.25)

--==================================================
-- BACKGROUND DECORATION
--==================================================

local BackgroundGlow = New("Frame", {
    Name = "BackgroundGlow",

    Size = UDim2.fromOffset(260, 260),

    Position = UDim2.new(1, -220, 0, -100),

    BackgroundColor3 = Colors.Menu,

    BackgroundTransparency = 0.92,

    BorderSizePixel = 0,

    ZIndex = 2
}, Main)

Corner(BackgroundGlow, 999)

--==================================================
-- TOP BAR
--==================================================

local TopBar = New("Frame", {
    Name = "TopBar",

    Size = UDim2.new(1, 0, 0, 68),

    Position = UDim2.fromOffset(0, 0),

    BackgroundColor3 = Colors.Panel,

    BorderSizePixel = 0,

    ZIndex = 10
}, Main)

Corner(TopBar, 22)

-- cover bottom corners of top bar
local TopBarCover = New("Frame", {
    Size = UDim2.new(1, 0, 0, 22),

    Position = UDim2.new(0, 0, 1, -22),

    BackgroundColor3 = Colors.Panel,

    BorderSizePixel = 0,

    ZIndex = 10
}, TopBar)

--==================================================
-- LOGO
--==================================================

local LogoHolder = New("Frame", {
    Name = "LogoHolder",

    Size = UDim2.fromOffset(46, 46),

    Position = UDim2.fromOffset(12, 11),

    BackgroundColor3 = Colors.Card,

    BorderSizePixel = 0,

    ZIndex = 15
}, TopBar)

Corner(LogoHolder, 14)
Stroke(LogoHolder, Colors.Menu, 1.2, 0.25)

local LogoGlow = New("Frame", {
    Size = UDim2.fromOffset(30, 30),

    Position = UDim2.fromOffset(8, 8),

    BackgroundColor3 = Colors.Menu,

    BackgroundTransparency = 0.88,

    BorderSizePixel = 0,

    ZIndex = 15
}, LogoHolder)

Corner(LogoGlow, 999)

local LogoText = New("TextLabel", {
    Name = "Logo",

    Size = UDim2.fromScale(1, 1),

    BackgroundTransparency = 1,

    Text = "R",

    TextColor3 = Colors.Text,

    TextSize = 26,

    Font = Enum.Font.GothamBlack,

    TextXAlignment = Enum.TextXAlignment.Center,

    TextYAlignment = Enum.TextYAlignment.Center,

    ZIndex = 20
}, LogoHolder)

--==================================================
-- TITLE
--==================================================

local Title = New("TextLabel", {
    Name = "Title",

    Size = UDim2.fromOffset(260, 27),

    Position = UDim2.fromOffset(70, 10),

    BackgroundTransparency = 1,

    Text = "RIVALS HUB",

    TextColor3 = Colors.Text,

    TextSize = 18,

    Font = Enum.Font.GothamBold,

    TextXAlignment = Enum.TextXAlignment.Left,

    ZIndex = 15
}, TopBar)

local Subtitle = New("TextLabel", {
    Name = "Subtitle",

    Size = UDim2.fromOffset(280, 18),

    Position = UDim2.fromOffset(70, 35),

    BackgroundTransparency = 1,

    Text = "Clean • Fast • Competitive",

    TextColor3 = Colors.Muted,

    TextSize = 9,

    Font = Enum.Font.GothamMedium,

    TextXAlignment = Enum.TextXAlignment.Left,

    ZIndex = 15
}, TopBar)

--==================================================
-- WINDOW BUTTONS
--==================================================

local MinimizeButton = New("TextButton", {
    Name = "Minimize",

    Size = UDim2.fromOffset(38, 38),

    Position = UDim2.new(1, -88, 0, 15),

    BackgroundColor3 = Colors.Card,

    BorderSizePixel = 0,

    Text = "—",

    TextColor3 = Colors.SubText,

    TextSize = 17,

    Font = Enum.Font.GothamBold,

    AutoButtonColor = false,

    ZIndex = 20
}, TopBar)

Corner(MinimizeButton, 12)
Stroke(MinimizeButton, Colors.Border, 1, 0.35)

local CloseButton = New("TextButton", {
    Name = "Close",

    Size = UDim2.fromOffset(38, 38),

    Position = UDim2.new(1, -44, 0, 15),

    BackgroundColor3 = Colors.Card,

    BorderSizePixel = 0,

    Text = "×",

    TextColor3 = Colors.SubText,

    TextSize = 20,

    Font = Enum.Font.GothamBold,

    AutoButtonColor = false,

    ZIndex = 20
}, TopBar)

Corner(CloseButton, 12)
Stroke(CloseButton, Colors.Border, 1, 0.35)

--==================================================
-- BODY
--==================================================

local Body = New("Frame", {
    Name = "Body",

    Size = UDim2.new(1, 0, 1, -68),

    Position = UDim2.fromOffset(0, 68),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ZIndex = 5
}, Main)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = New("Frame", {
    Name = "Sidebar",

    Size = UDim2.fromOffset(175, 1),

    Position = UDim2.fromOffset(0, 0),

    BackgroundColor3 = Colors.Panel,

    BorderSizePixel = 0,

    ZIndex = 8
}, Body)

local SidebarCover = New("Frame", {
    Size = UDim2.new(0, 22, 1, 0),

    Position = UDim2.new(1, -22, 0, 0),

    BackgroundColor3 = Colors.Panel,

    BorderSizePixel = 0,

    ZIndex = 8
}, Sidebar)

--==================================================
-- SIDEBAR LABEL
--==================================================

local NavigationTitle = New("TextLabel", {
    Size = UDim2.new(1, -30, 0, 20),

    Position = UDim2.fromOffset(16, 18),

    BackgroundTransparency = 1,

    Text = "NAVIGATION",

    TextColor3 = Colors.Muted,

    TextSize = 9,

    Font = Enum.Font.GothamBold,

    TextXAlignment = Enum.TextXAlignment.Left,

    ZIndex = 15
}, Sidebar)

--==================================================
-- CATEGORY HOLDER
--==================================================

local CategoryHolder = New("Frame", {
    Name = "Categories",

    Size = UDim2.new(1, -20, 1, -55),

    Position = UDim2.fromOffset(10, 45),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ZIndex = 10
}, Sidebar)

local CategoryLayout = New("UIListLayout", {
    Padding = UDim.new(0, 7),

    SortOrder = Enum.SortOrder.LayoutOrder
}, CategoryHolder)

--==================================================
-- CONTENT
--==================================================

local Content = New("Frame", {
    Name = "Content",

    Size = UDim2.new(1, -175, 1, 0),

    Position = UDim2.fromOffset(175, 0),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ClipsDescendants = true,

    ZIndex = 5
}, Body)

--==================================================
-- PAGE HEADER
--==================================================

local PageHeader = New("Frame", {
    Name = "PageHeader",

    Size = UDim2.new(1, -34, 0, 55),

    Position = UDim2.fromOffset(17, 12),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ZIndex = 15
}, Content)

local PageTitle = New("TextLabel", {
    Size = UDim2.new(1, 0, 0, 28),

    Position = UDim2.fromOffset(0, 0),

    BackgroundTransparency = 1,

    Text = "Combat",

    TextColor3 = Colors.Text,

    TextSize = 21,

    Font = Enum.Font.GothamBold,

    TextXAlignment = Enum.TextXAlignment.Left,

    ZIndex = 16
}, PageHeader)

local PageDescription = New("TextLabel", {
    Size = UDim2.new(1, 0, 0, 20),

    Position = UDim2.fromOffset(0, 29),

    BackgroundTransparency = 1,

    Text = "Aim and targeting functions",

    TextColor3 = Colors.Muted,

    TextSize = 9,

    Font = Enum.Font.Gotham,

    TextXAlignment = Enum.TextXAlignment.Left,

    ZIndex = 16
}, PageHeader)

--==================================================
-- PAGES
--==================================================

local Pages = New("Frame", {
    Name = "Pages",

    Size = UDim2.new(1, -34, 1, -82),

    Position = UDim2.fromOffset(17, 72),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ClipsDescendants = true,

    ZIndex = 10
}, Content)

local CombatPage = New("ScrollingFrame", {
    Name = "Combat",

    Size = UDim2.new(1, 0, 1, 0),

    Position = UDim2.fromOffset(0, 0),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ScrollBarThickness = 2,

    ScrollBarImageColor3 = Colors.Menu,

    CanvasSize = UDim2.fromOffset(0, 0),

    AutomaticCanvasSize = Enum.AutomaticSize.Y,

    Visible = true,

    ZIndex = 10
}, Pages)

local VisualsPage = New("ScrollingFrame", {
    Name = "Visuals",

    Size = UDim2.new(1, 0, 1, 0),

    Position = UDim2.fromOffset(35, 0),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ScrollBarThickness = 2,

    ScrollBarImageColor3 = Colors.Menu,

    CanvasSize = UDim2.fromOffset(0, 0),

    AutomaticCanvasSize = Enum.AutomaticSize.Y,

    Visible = false,

    ZIndex = 10
}, Pages)

local MovementPage = New("ScrollingFrame", {
    Name = "Movement",

    Size = UDim2.new(1, 0, 1, 0),

    Position = UDim2.fromOffset(35, 0),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ScrollBarThickness = 2,

    ScrollBarImageColor3 = Colors.Menu,

    CanvasSize = UDim2.fromOffset(0, 0),

    AutomaticCanvasSize = Enum.AutomaticSize.Y,

    Visible = false,

    ZIndex = 10
}, Pages)

local SettingsPage = New("ScrollingFrame", {
    Name = "Settings",

    Size = UDim2.new(1, 0, 1, 0),

    Position = UDim2.fromOffset(35, 0),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ScrollBarThickness = 2,

    ScrollBarImageColor3 = Colors.Menu,

    CanvasSize = UDim2.fromOffset(0, 0),

    AutomaticCanvasSize = Enum.AutomaticSize.Y,

    Visible = false,

    ZIndex = 10
}, Pages)

--==================================================
-- CATEGORY DATA
--==================================================

local CategoryButtons = {}

local PageDescriptions = {
    Combat = "Aim and targeting functions",
    Visuals = "ESP and player information",
    Movement = "Movement and player controls",
    Settings = "Rivals Hub configuration"
}

local Categories = {
    {
        Name = "Combat",
        Icon = "C",
        Order = 1
    },

    {
        Name = "Visuals",
        Icon = "V",
        Order = 2
    },

    {
        Name = "Movement",
        Icon = "M",
        Order = 3
    },

    {
        Name = "Settings",
        Icon = "S",
        Order = 4
    }
}

--==================================================
-- CATEGORY CREATION
--==================================================

for _, category in ipairs(Categories) do

    local Button = New("TextButton", {
        Name = category.Name,

        Size = UDim2.new(1, 0, 0, 44),

        BackgroundColor3 = Colors.Card,

        BackgroundTransparency = 0.35,

        BorderSizePixel = 0,

        Text = "",

        AutoButtonColor = false,

        LayoutOrder = category.Order,

        ZIndex = 20
    }, CategoryHolder)

    Corner(Button, 13)
    Stroke(Button, Colors.Border, 1, 0.65)

    local Icon = New("TextLabel", {
        Size = UDim2.fromOffset(30, 30),

        Position = UDim2.fromOffset(7, 7),

        BackgroundColor3 = Colors.Panel,

        BorderSizePixel = 0,

        Text = category.Icon,

        TextColor3 = Colors.SubText,

        TextSize = 12,

        Font = Enum.Font.GothamBold,

        TextXAlignment = Enum.TextXAlignment.Center,

        TextYAlignment = Enum.TextYAlignment.Center,

        ZIndex = 22
    }, Button)

    Corner(Icon, 9)

    local Text = New("TextLabel", {
        Size = UDim2.new(1, -48, 1, 0),

        Position = UDim2.fromOffset(45, 0),

        BackgroundTransparency = 1,

        Text = category.Name,

        TextColor3 = Colors.SubText,

        TextSize = 11,

        Font = Enum.Font.GothamSemibold,

        TextXAlignment = Enum.TextXAlignment.Left,

        TextYAlignment = Enum.TextYAlignment.Center,

        ZIndex = 22
    }, Button)

    CategoryButtons[category.Name] = {
        Button = Button,
        Icon = Icon,
        Text = Text
    }

    Button.MouseEnter:Connect(function()

        FastTween(Button, {
            BackgroundColor3 = Colors.CardHover,
            BackgroundTransparency = 0
        }, 0.14)

        FastTween(Icon, {
            BackgroundColor3 = Colors.MenuDark,
            TextColor3 = Colors.Text
        }, 0.14)

        FastTween(Text, {
            TextColor3 = Colors.Text
        }, 0.14)

    end)

    Button.MouseLeave:Connect(function()

        FastTween(Button, {
            BackgroundColor3 = Colors.Card,
            BackgroundTransparency = 0.35
        }, 0.14)

    end)

end

--==================================================
-- CATEGORY VISUAL
--==================================================

local function SetCategoryVisual(name)

    for categoryName, data in pairs(CategoryButtons) do

        local active = categoryName == name

        if active then

            FastTween(data.Button, {
                BackgroundColor3 = Colors.Menu,
                BackgroundTransparency = 0
            }, 0.18)

            FastTween(data.Icon, {
                BackgroundColor3 = Colors.MenuDark,
                TextColor3 = Colors.Text
            }, 0.18)

            FastTween(data.Text, {
                TextColor3 = Colors.Text
            }, 0.18)

        else

            FastTween(data.Button, {
                BackgroundColor3 = Colors.Card,
                BackgroundTransparency = 0.35
            }, 0.18)

            FastTween(data.Icon, {
                BackgroundColor3 = Colors.Panel,
                TextColor3 = Colors.SubText
            }, 0.18)

            FastTween(data.Text, {
                TextColor3 = Colors.SubText
            }, 0.18)

        end

    end

end

SetCategoryVisual("Combat")

--==================================================
-- END PART 1/4
--==================================================

--==================================================
-- RIVALS HUB
-- PART 2/4
-- CONTROLS + PAGES
--==================================================

--==================================================
-- PAGE HELPERS
--==================================================

local PageData = {
    Combat = {
        Page = CombatPage,
        Title = "Combat",
        Description = PageDescriptions.Combat
    },

    Visuals = {
        Page = VisualsPage,
        Title = "Visuals",
        Description = PageDescriptions.Visuals
    },

    Movement = {
        Page = MovementPage,
        Title = "Movement",
        Description = PageDescriptions.Movement
    },

    Settings = {
        Page = SettingsPage,
        Title = "Settings",
        Description = PageDescriptions.Settings
    }
}

local CurrentCategory = "Combat"
local SwitchingPage = false

local function HideAllPages()
    CombatPage.Visible = false
    VisualsPage.Visible = false
    MovementPage.Visible = false
    SettingsPage.Visible = false
end

local function GetPage(name)
    return PageData[name] and PageData[name].Page
end

local function SwitchPage(name)

    if not PageData[name] then
        return
    end

    if SwitchingPage then
        return
    end

    if name == CurrentCategory then
        return
    end

    SwitchingPage = true

    local oldName = CurrentCategory
    local oldPage = GetPage(oldName)
    local newPage = GetPage(name)

    local direction = 1

    local order = {
        Combat = 1,
        Visuals = 2,
        Movement = 3,
        Settings = 4
    }

    if order[name] < order[oldName] then
        direction = -1
    end

    newPage.Position = UDim2.fromScale(direction, 0)
    newPage.Visible = true

    FastTween(
        oldPage,
        {
            Position = UDim2.fromScale(-direction, 0)
        },
        0.24
    )

    FastTween(
        newPage,
        {
            Position = UDim2.fromScale(0, 0)
        },
        0.28
    )

    FastTween(
        PageTitle,
        {
            TextTransparency = 1
        },
        0.10
    )

    FastTween(
        PageDescription,
        {
            TextTransparency = 1
        },
        0.10
    )

    task.delay(0.10, function()

        PageTitle.Text = PageData[name].Title
        PageDescription.Text = PageData[name].Description

        FastTween(
            PageTitle,
            {
                TextTransparency = 0
            },
            0.16
        )

        FastTween(
            PageDescription,
            {
                TextTransparency = 0
            },
            0.16
        )
    end)

    task.delay(0.25, function()
        oldPage.Visible = false
        oldPage.Position = UDim2.fromScale(0, 0)

        CurrentCategory = name
        SetCategoryVisual(name)

        SwitchingPage = false
    end)
end

for name, data in pairs(CategoryButtons) do
    data.Button.MouseButton1Click:Connect(function()
        SwitchPage(name)
    end)
end

--==================================================
-- CONTROL HELPERS
--==================================================

local Controls = {}

local function RegisterControl(id, object)
    Controls[id] = object
    return object
end

local function MakeCard(parent, height)

    local Card = New("Frame", {
        Size = UDim2.new(1, -4, 0, height or 52),
        BackgroundColor3 = Colors.Card,
        BackgroundTransparency = 0,
        BorderSizePixel = 0
    }, parent)

    Corner(Card, 14)
    Stroke(Card, Colors.Border, 1, 0.55)

    return Card
end

local function AddPageLayout(parent)

    local Padding = New("UIPadding", {
        PaddingTop = UDim.new(0, 2),
        PaddingBottom = UDim.new(0, 8),
        PaddingLeft = UDim.new(0, 2),
        PaddingRight = UDim.new(0, 4)
    }, parent)

    local Layout = New("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, parent)

    return Layout
end

AddPageLayout(CombatPage)
AddPageLayout(VisualsPage)
AddPageLayout(MovementPage)
AddPageLayout(SettingsPage)

--==================================================
-- TOGGLE
--==================================================

local function MakeToggle(parent, id, title, description, defaultValue, callback)

    local Card = MakeCard(parent, 58)

    local Title = New("TextLabel", {
        Size = UDim2.new(1, -75, 0, 22),
        Position = UDim2.fromOffset(14, 7),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Colors.Text,
        TextSize = 11,
        Font = Enum.Font.GothamSemibold,
        TextXAlignment = Enum.TextXAlignment.Left
    }, Card)

    local Description = New("TextLabel", {
        Size = UDim2.new(1, -75, 0, 18),
        Position = UDim2.fromOffset(14, 30),
        BackgroundTransparency = 1,
        Text = description or "",
        TextColor3 = Colors.Muted,
        TextSize = 8,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left
    }, Card)

    local Toggle = New("TextButton", {
        Size = UDim2.fromOffset(43, 24),
        Position = UDim2.new(1, -56, 0.5, -12),
        BackgroundColor3 = Colors.Panel,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false
    }, Card)

    Corner(Toggle, 999)
    Stroke(Toggle, Colors.Border, 1, 0.4)

    local Knob = New("Frame", {
        Size = UDim2.fromOffset(18, 18),
        Position = UDim2.fromOffset(3, 3),
        BackgroundColor3 = Colors.Muted,
        BorderSizePixel = 0
    }, Toggle)

    Corner(Knob, 999)

    local State = defaultValue == true

    local function Update(instant)

        if State then

            local properties = {
                BackgroundColor3 = Colors.Menu
            }

            local knobProperties = {
                Position = UDim2.new(1, -21, 0, 3),
                BackgroundColor3 = Colors.Text
            }

            if instant then
                Toggle.BackgroundColor3 = properties.BackgroundColor3
                Knob.Position = knobProperties.Position
                Knob.BackgroundColor3 = knobProperties.BackgroundColor3
            else
                FastTween(Toggle, properties, 0.16)
                FastTween(Knob, knobProperties, 0.16)
            end

        else

            local properties = {
                BackgroundColor3 = Colors.Panel
            }

            local knobProperties = {
                Position = UDim2.fromOffset(3, 3),
                BackgroundColor3 = Colors.Muted
            }

            if instant then
                Toggle.BackgroundColor3 = properties.BackgroundColor3
                Knob.Position = knobProperties.Position
                Knob.BackgroundColor3 = knobProperties.BackgroundColor3
            else
                FastTween(Toggle, properties, 0.16)
                FastTween(Knob, knobProperties, 0.16)
            end
        end

        if callback then
            callback(State)
        end
    end

    Toggle.MouseEnter:Connect(function()
        FastTween(Toggle, {
            Size = UDim2.fromOffset(45, 25)
        }, 0.10)
    end)

    Toggle.MouseLeave:Connect(function()
        FastTween(Toggle, {
            Size = UDim2.fromOffset(43, 24)
        }, 0.10)
    end)

    Toggle.MouseButton1Click:Connect(function()

        State = not State

        Update(false)

        local scale = Toggle:FindFirstChild("ClickScale")

        if not scale then
            scale = New("UIScale", {
                Name = "ClickScale",
                Scale = 1
            }, Toggle)
        end

        scale.Scale = 0.88

        FastTween(scale, {
            Scale = 1
        }, 0.16)
    end)

    RegisterControl(id, {
        Card = Card,
        Button = Toggle,

        Get = function()
            return State
        end,

        Set = function(value)
            State = value == true
            Update(false)
        end
    })

    Update(true)

    return Card
end

--==================================================
-- NUMBER CONTROL
--==================================================

local function MakeNumber(parent, id, title, description, defaultValue, minimum, maximum, step, callback)

    local Card = MakeCard(parent, 58)

    local Title = New("TextLabel", {
        Size = UDim2.new(1, -170, 0, 22),
        Position = UDim2.fromOffset(14, 7),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Colors.Text,
        TextSize = 11,
        Font = Enum.Font.GothamSemibold,
        TextXAlignment = Enum.TextXAlignment.Left
    }, Card)

    local Description = New("TextLabel", {
        Size = UDim2.new(1, -170, 0, 18),
        Position = UDim2.fromOffset(14, 30),
        BackgroundTransparency = 1,
        Text = description or "",
        TextColor3 = Colors.Muted,
        TextSize = 8,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left
    }, Card)

    local Minus = New("TextButton", {
        Size = UDim2.fromOffset(30, 30),
        Position = UDim2.new(1, -132, 0.5, -15),
        BackgroundColor3 = Colors.Panel,
        BorderSizePixel = 0,
        Text = "−",
        TextColor3 = Colors.SubText,
        TextSize = 17,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false
    }, Card)

    Corner(Minus, 9)
    Stroke(Minus, Colors.Border, 1, 0.4)

    local Value = New("TextLabel", {
        Size = UDim2.fromOffset(52, 30),
        Position = UDim2.new(1, -98, 0.5, -15),
        BackgroundColor3 = Colors.Panel,
        BorderSizePixel = 0,
        Text = tostring(defaultValue),
        TextColor3 = Colors.Text,
        TextSize = 10,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center
    }, Card)

    Corner(Value, 9)
    Stroke(Value, Colors.Border, 1, 0.4)

    local Plus = New("TextButton", {
        Size = UDim2.fromOffset(30, 30),
        Position = UDim2.new(1, -42, 0.5, -15),
        BackgroundColor3 = Colors.Panel,
        BorderSizePixel = 0,
        Text = "+",
        TextColor3 = Colors.SubText,
        TextSize = 17,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false
    }, Card)

    Corner(Plus, 9)
    Stroke(Plus, Colors.Border, 1, 0.4)

    local CurrentValue = defaultValue

    local function ClampValue(value)
        return math.clamp(value, minimum, maximum)
    end

    local function Refresh()

        CurrentValue = ClampValue(CurrentValue)

        if math.floor(CurrentValue) == CurrentValue then
            Value.Text = tostring(math.floor(CurrentValue))
        else
            Value.Text = string.format("%.2f", CurrentValue)
        end

        if callback then
            callback(CurrentValue)
        end
    end

    local function PressAnimation(button)

        local scale = button:FindFirstChild("NumberScale")

        if not scale then
            scale = New("UIScale", {
                Name = "NumberScale",
                Scale = 1
            }, button)
        end

        scale.Scale = 0.82

        FastTween(scale, {
            Scale = 1
        }, 0.14)
    end

    Minus.MouseEnter:Connect(function()
        FastTween(Minus, {
            BackgroundColor3 = Colors.CardHover,
            TextColor3 = Colors.Text
        }, 0.10)
    end)

    Minus.MouseLeave:Connect(function()
        FastTween(Minus, {
            BackgroundColor3 = Colors.Panel,
            TextColor3 = Colors.SubText
        }, 0.10)
    end)

    Plus.MouseEnter:Connect(function()
        FastTween(Plus, {
            BackgroundColor3 = Colors.CardHover,
            TextColor3 = Colors.Text
        }, 0.10)
    end)

    Plus.MouseLeave:Connect(function()
        FastTween(Plus, {
            BackgroundColor3 = Colors.Panel,
            TextColor3 = Colors.SubText
        }, 0.10)
    end)

    Minus.MouseButton1Click:Connect(function()

        CurrentValue = CurrentValue - step

        Refresh()
        PressAnimation(Minus)
    end)

    Plus.MouseButton1Click:Connect(function()

        CurrentValue = CurrentValue + step

        Refresh()
        PressAnimation(Plus)
    end)

    RegisterControl(id, {
        Card = Card,

        Get = function()
            return CurrentValue
        end,

        Set = function(value)
            CurrentValue = tonumber(value) or CurrentValue
            Refresh()
        end
    })

    Refresh()

    return Card
end

--==================================================
-- DROPDOWN
--==================================================

local function MakeDropdown(parent, id, title, description, defaultValue, options, callback)

    local Card = MakeCard(parent, 58)

    local Title = New("TextLabel", {
        Size = UDim2.new(1, -150, 0, 22),
        Position = UDim2.fromOffset(14, 7),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Colors.Text,
        TextSize = 11,
        Font = Enum.Font.GothamSemibold,
        TextXAlignment = Enum.TextXAlignment.Left
    }, Card)

    local Description = New("TextLabel", {
        Size = UDim2.new(1, -150, 0, 18),
        Position = UDim2.fromOffset(14, 30),
        BackgroundTransparency = 1,
        Text = description or "",
        TextColor3 = Colors.Muted,
        TextSize = 8,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left
    }, Card)

    local Button = New("TextButton", {
        Size = UDim2.fromOffset(105, 34),
        Position = UDim2.new(1, -117, 0.5, -17),
        BackgroundColor3 = Colors.Panel,
        BorderSizePixel = 0,
        Text = tostring(defaultValue),
        TextColor3 = Colors.Text,
        TextSize = 9,
        Font = Enum.Font.GothamSemibold,
        AutoButtonColor = false
    }, Card)

    Corner(Button, 10)
    Stroke(Button, Colors.Border, 1, 0.4)

    local CurrentValue = defaultValue
    local Open = false

    local List = New("Frame", {
        Size = UDim2.new(0, 105, 0, 0),
        Position = UDim2.new(1, -117, 1, 5),
        BackgroundColor3 = Colors.Panel,
        BorderSizePixel = 0,
        Visible = false,
        ClipsDescendants = true,
        ZIndex = 100
    }, Card)

    Corner(List, 10)
    Stroke(List, Colors.Border, 1, 0.3)

    local ListLayout = New("UIListLayout", {
        Padding = UDim.new(0, 3),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, List)

    New("UIPadding", {
        PaddingTop = UDim.new(0, 5),
        PaddingBottom = UDim.new(0, 5),
        PaddingLeft = UDim.new(0, 5),
        PaddingRight = UDim.new(0, 5)
    }, List)

    local function SetValue(value)

        CurrentValue = value
        Button.Text = tostring(value)

        if callback then
            callback(value)
        end
    end

    for index, option in ipairs(options) do

        local Option = New("TextButton", {
            Size = UDim2.new(1, 0, 0, 27),
            BackgroundColor3 = Colors.Card,
            BorderSizePixel = 0,
            Text = tostring(option),
            TextColor3 = Colors.SubText,
            TextSize = 9,
            Font = Enum.Font.GothamMedium,
            AutoButtonColor = false,
            LayoutOrder = index,
            ZIndex = 110
        }, List)

        Corner(Option, 7)

        Option.MouseEnter:Connect(function()
            FastTween(Option, {
                BackgroundColor3 = Colors.CardHover,
                TextColor3 = Colors.Text
            }, 0.10)
        end)

        Option.MouseLeave:Connect(function()
            FastTween(Option, {
                BackgroundColor3 = Colors.Card,
                TextColor3 = Colors.SubText
            }, 0.10)
        end)

        Option.MouseButton1Click:Connect(function()

            SetValue(option)

            Open = false

            FastTween(List, {
                Size = UDim2.new(0, 105, 0, 0)
            }, 0.16)

            task.delay(0.16, function()
                List.Visible = false
            end)
        end)
    end

    Button.MouseButton1Click:Connect(function()

        Open = not Open

        if Open then

            List.Visible = true

            local count = #options
            local height = math.clamp(count * 30 + 10, 40, 150)

            List.Size = UDim2.new(0, 105, 0, 0)

            FastTween(List, {
                Size = UDim2.new(0, 105, 0, height)
            }, 0.18)

        else

            FastTween(List, {
                Size = UDim2.new(0, 105, 0, 0)
            }, 0.16)

            task.delay(0.16, function()
                List.Visible = false
            end)
        end
    end)

    RegisterControl(id, {
        Card = Card,

        Get = function()
            return CurrentValue
        end,

        Set = function(value)
            SetValue(value)
        end
    })

    SetValue(defaultValue)

    return Card
end

--==================================================
-- COMBAT PAGE
--==================================================

MakeToggle(
    CombatPage,
    "AimAssist",
    "Aim Assist",
    "Automatically assists your aim",
    Config.AimAssist,
    function(value)
        Config.AimAssist = value
    end
)

MakeToggle(
    CombatPage,
    "VisibleOnly",
    "Visible Only",
    "Target players that are visible",
    Config.VisibleOnly,
    function(value)
        Config.VisibleOnly = value
    end
)

MakeToggle(
    CombatPage,
    "AimFOV",
    "Aim FOV",
    "Limit aim assist to the FOV circle",
    Config.AimFOV,
    function(value)
        Config.AimFOV = value
    end
)

MakeNumber(
    CombatPage,
    "FOVSize",
    "FOV Size",
    "Size of the aim FOV circle",
    Config.FOVSize,
    50,
    1000,
    25,
    function(value)
        Config.FOVSize = value
    end
)

MakeNumber(
    CombatPage,
    "Smoothness",
    "Smoothness",
    "Aim movement smoothness",
    Config.Smoothness,
    0.01,
    1,
    0.01,
    function(value)
        Config.Smoothness = value
    end
)

MakeDropdown(
    CombatPage,
    "TargetPart",
    "Target Part",
    "Body part used for targeting",
    Config.TargetPart,
    {
        "Head",
        "Torso",
        "Body"
    },
    function(value)
        Config.TargetPart = value
    end
)

--==================================================
-- VISUALS PAGE
--==================================================

MakeToggle(
    VisualsPage,
    "ESP",
    "ESP",
    "Display players through walls",
    Config.ESP,
    function(value)
        Config.ESP = value
    end
)

MakeToggle(
    VisualsPage,
    "ModelESP",
    "Model ESP",
    "Highlight player models",
    Config.ModelESP,
    function(value)
        Config.ModelESP = value
    end
)

MakeToggle(
    VisualsPage,
    "Box",
    "Box",
    "Draw a box around players",
    Config.Box,
    function(value)
        Config.Box = value
    end
)

MakeToggle(
    VisualsPage,
    "Names",
    "Names",
    "Show player names",
    Config.Names,
    function(value)
        Config.Names = value
    end
)

MakeToggle(
    VisualsPage,
    "Health",
    "Health",
    "Show player health",
    Config.Health,
    function(value)
        Config.Health = value
    end
)

MakeToggle(
    VisualsPage,
    "Distance",
    "Distance",
    "Show distance to players",
    Config.Distance,
    function(value)
        Config.Distance = value
    end
)

--==================================================
-- MOVEMENT PAGE
--==================================================

MakeToggle(
    MovementPage,
    "Speed",
    "Speed",
    "Enable custom walk speed",
    Config.Speed,
    function(value)
        Config.Speed = value
    end
)

MakeNumber(
    MovementPage,
    "SpeedValue",
    "Speed Value",
    "Custom walk speed",
    Config.SpeedValue,
    1,
    200,
    1,
    function(value)
        Config.SpeedValue = value
    end
)

MakeToggle(
    MovementPage,
    "Jump",
    "Jump",
    "Enable custom jump power",
    Config.Jump,
    function(value)
        Config.Jump = value
    end
)

MakeNumber(
    MovementPage,
    "JumpPower",
    "Jump Power",
    "Custom jump power",
    Config.JumpPower,
    1,
    200,
    5,
    function(value)
        Config.JumpPower = value
    end
)

MakeToggle(
    MovementPage,
    "Noclip",
    "Noclip",
    "Walk through physical objects",
    Config.Noclip,
    function(value)
        Config.Noclip = value
    end
)

--==================================================
-- SETTINGS PAGE
--==================================================

local InfoCard = MakeCard(SettingsPage, 128)

local InfoTitle = New("TextLabel", {
    Size = UDim2.new(1, -28, 0, 25),
    Position = UDim2.fromOffset(14, 10),
    BackgroundTransparency = 1,
    Text = "RIVALS HUB",
    TextColor3 = Colors.Text,
    TextSize = 15,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
}, InfoCard)

local VersionLabel = New("TextLabel", {
    Size = UDim2.new(1, -28, 0, 18),
    Position = UDim2.fromOffset(14, 38),
    BackgroundTransparency = 1,
    Text = "Version: " .. Config.Version,
    TextColor3 = Colors.SubText,
    TextSize = 9,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left
}, InfoCard)

local CreatorLabel = New("TextLabel", {
    Size = UDim2.new(1, -28, 0, 18),
    Position = UDim2.fromOffset(14, 58),
    BackgroundTransparency = 1,
    Text = "Creator: " .. Config.Creator,
    TextColor3 = Colors.SubText,
    TextSize = 9,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left
}, InfoCard)

local TelegramLabel = New("TextLabel", {
    Size = UDim2.new(1, -28, 0, 18),
    Position = UDim2.fromOffset(14, 78),
    BackgroundTransparency = 1,
    Text = "Telegram: @lunarhub_script",
    TextColor3 = Colors.SubText,
    TextSize = 9,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left
}, InfoCard)

local StatusLabel = New("TextLabel", {
    Size = UDim2.new(1, -28, 0, 18),
    Position = UDim2.fromOffset(14, 98),
    BackgroundTransparency = 1,
    Text = "●  Rivals Hub is running",
    TextColor3 = Colors.Menu,
    TextSize = 9,
    Font = Enum.Font.GothamSemibold,
    TextXAlignment = Enum.TextXAlignment.Left
}, InfoCard)

local TelegramButton = New("TextButton", {
    Size = UDim2.new(1, -4, 0, 50),
    BackgroundColor3 = Colors.Card,
    BorderSizePixel = 0,
    Text = "Open Telegram  →",
    TextColor3 = Colors.Text,
    TextSize = 10,
    Font = Enum.Font.GothamSemibold,
    AutoButtonColor = false
}, SettingsPage)

Corner(TelegramButton, 14)
Stroke(TelegramButton, Colors.Border, 1, 0.55)

TelegramButton.MouseEnter:Connect(function()

    FastTween(
        TelegramButton,
        {
            BackgroundColor3 = Colors.Menu
        },
        0.14
    )
end)

TelegramButton.MouseLeave:Connect(function()

    FastTween(
        TelegramButton,
        {
            BackgroundColor3 = Colors.Card
        },
        0.14
    )
end)

TelegramButton.MouseButton1Click:Connect(function()

    pcall(function()
        if setclipboard then
            setclipboard("https://t.me/lunarhub_script")
        end
    end)

end)

--==================================================
-- INITIAL PAGE POSITIONS
--==================================================

CombatPage.Position = UDim2.fromScale(0, 0)
VisualsPage.Position = UDim2.fromScale(0, 0)
MovementPage.Position = UDim2.fromScale(0, 0)
SettingsPage.Position = UDim2.fromScale(0, 0)

CombatPage.Visible = true
VisualsPage.Visible = false
MovementPage.Visible = false
SettingsPage.Visible = false

PageTitle.Text = "Combat"
PageDescription.Text = PageDescriptions.Combat

--==================================================
-- END PART 2/4
--==================================================

--==================================================
-- RIVALS HUB
-- PART 3/4
-- MENU ANIMATIONS + DRAG + MINIMIZE
--==================================================

--==================================================
-- MENU STATE
--==================================================

local MenuOpen = true
local MenuClosed = false
local MenuAnimating = false

local OriginalPosition = Holder.Position
local OriginalScale = HolderScale.Scale

--==================================================
-- FLOATING RESTORE BUTTON
--==================================================

local RestoreButton = New("TextButton", {
    Name = "RestoreButton",
    Size = UDim2.fromOffset(42, 42),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),

    BackgroundColor3 = Colors.Background,
    BorderSizePixel = 0,

    Text = "R",
    TextColor3 = Colors.Text,
    TextSize = 20,
    Font = Enum.Font.GothamBlack,

    AutoButtonColor = false,

    Visible = false,
    ZIndex = 200
}, ScreenGui)

Corner(RestoreButton, 13)
Stroke(RestoreButton, Colors.Menu, 1.5, 0.15)

local RestoreGlow = New("Frame", {
    Size = UDim2.fromOffset(26, 26),
    Position = UDim2.fromOffset(8, 8),

    BackgroundColor3 = Colors.Menu,
    BackgroundTransparency = 0.88,

    BorderSizePixel = 0,
    ZIndex = 201
}, RestoreButton)

Corner(RestoreGlow, 999)

local RestoreScale = New("UIScale", {
    Scale = 1
}, RestoreButton)

--==================================================
-- BUTTON HOVER ANIMATIONS
--==================================================

MinimizeButton.MouseEnter:Connect(function()

    FastTween(
        MinimizeButton,
        {
            BackgroundColor3 = Colors.CardHover,
            TextColor3 = Colors.Text
        },
        0.12
    )
end)

MinimizeButton.MouseLeave:Connect(function()

    FastTween(
        MinimizeButton,
        {
            BackgroundColor3 = Colors.Card,
            TextColor3 = Colors.SubText
        },
        0.12
    )
end)

CloseButton.MouseEnter:Connect(function()

    FastTween(
        CloseButton,
        {
            BackgroundColor3 = Colors.CardHover,
            TextColor3 = Colors.Text
        },
        0.12
    )
end)

CloseButton.MouseLeave:Connect(function()

    FastTween(
        CloseButton,
        {
            BackgroundColor3 = Colors.Card,
            TextColor3 = Colors.SubText
        },
        0.12
    )
end)

--==================================================
-- RESTORE BUTTON HOVER
--==================================================

RestoreButton.MouseEnter:Connect(function()

    FastTween(
        RestoreButton,
        {
            BackgroundColor3 = Colors.Panel
        },
        0.12
    )

    FastTween(
        RestoreScale,
        {
            Scale = 1.10
        },
        0.12
    )

    FastTween(
        RestoreGlow,
        {
            BackgroundTransparency = 0.76
        },
        0.12
    )
end)

RestoreButton.MouseLeave:Connect(function()

    FastTween(
        RestoreButton,
        {
            BackgroundColor3 = Colors.Background
        },
        0.12
    )

    FastTween(
        RestoreScale,
        {
            Scale = 1
        },
        0.12
    )

    FastTween(
        RestoreGlow,
        {
            BackgroundTransparency = 0.88
        },
        0.12
    )
end)

RestoreButton.MouseButton1Down:Connect(function()

    FastTween(
        RestoreScale,
        {
            Scale = 0.90
        },
        0.08
    )
end)

RestoreButton.MouseButton1Up:Connect(function()

    FastTween(
        RestoreScale,
        {
            Scale = 1.10
        },
        0.08
    )
end)

--==================================================
-- OPEN MENU ANIMATION
--==================================================

local function OpenMenu()

    if MenuAnimating then
        return
    end

    if MenuOpen then
        return
    end

    MenuAnimating = true
    MenuClosed = false

    RestoreButton.Visible = false

    Holder.Visible = true

    Holder.Position = UDim2.new(
        OriginalPosition.X.Scale,
        OriginalPosition.X.Offset,
        OriginalPosition.Y.Scale,
        OriginalPosition.Y.Offset + 35
    )

    HolderScale.Scale = 0.78

    Main.BackgroundTransparency = 0.25

    Tween(
        Holder,
        TweenInfo.new(
            0.42,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        {
            Position = OriginalPosition
        }
    )

    Tween(
        HolderScale,
        TweenInfo.new(
            0.42,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.Out
        ),
        {
            Scale = OriginalScale
        }
    )

    Tween(
        Main,
        TweenInfo.new(
            0.25,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        {
            BackgroundTransparency = 0
        }
    )

    task.delay(0.43, function()

        MenuOpen = true
        MenuAnimating = false

    end)
end

--==================================================
-- MINIMIZE MENU
--==================================================

local function MinimizeMenu()

    if MenuAnimating then
        return
    end

    if not MenuOpen then
        return
    end

    MenuAnimating = true
    MenuOpen = false

    local centerPosition = UDim2.new(
        0.5,
        0,
        0.5,
        0
    )

    Tween(
        Holder,
        TweenInfo.new(
            0.32,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.In
        ),
        {
            Position = centerPosition
        }
    )

    Tween(
        HolderScale,
        TweenInfo.new(
            0.32,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.In
        ),
        {
            Scale = 0.08
        }
    )

    Tween(
        Main,
        TweenInfo.new(
            0.20,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.In
        ),
        {
            BackgroundTransparency = 0.45
        }
    )

    task.delay(0.34, function()

        Holder.Visible = false

        RestoreButton.Visible = true

        RestoreButton.Position = centerPosition
        RestoreScale.Scale = 0.2

        FastTween(
            RestoreScale,
            {
                Scale = 1
            },
            0.30
        )

        MenuClosed = true
        MenuAnimating = false

    end)
end

--==================================================
-- CLOSE MENU
--==================================================

local function CloseMenu()

    if MenuAnimating then
        return
    end

    MenuAnimating = true

    Tween(
        HolderScale,
        TweenInfo.new(
            0.28,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.In
        ),
        {
            Scale = 0.05
        }
    )

    Tween(
        Main,
        TweenInfo.new(
            0.20,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.In
        ),
        {
            BackgroundTransparency = 1
        }
    )

    task.delay(0.30, function()

        ScreenGui:Destroy()

    end)
end

--==================================================
-- BUTTON CONNECTIONS
--==================================================

MinimizeButton.MouseButton1Click:Connect(function()
    MinimizeMenu()
end)

RestoreButton.MouseButton1Click:Connect(function()
    OpenMenu()
end)

CloseButton.MouseButton1Click:Connect(function()
    CloseMenu()
end)

--==================================================
-- DRAG SYSTEM
--==================================================

local Dragging = false
local DragStart
local StartPosition

local function UpdateDrag(input)

    local Delta = input.Position - DragStart

    Holder.Position = UDim2.new(
        StartPosition.X.Scale,
        StartPosition.X.Offset + Delta.X,
        StartPosition.Y.Scale,
        StartPosition.Y.Offset + Delta.Y
    )

    OriginalPosition = Holder.Position
end

TopBar.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true
        DragStart = input.Position
        StartPosition = Holder.Position

        input.Changed:Connect(function()

            if input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end

        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)

    if not Dragging then
        return
    end

    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then

        UpdateDrag(input)
    end
end)

--==================================================
-- RESTORE BUTTON DRAG
--==================================================

local RestoreDragging = false
local RestoreDragStart
local RestoreStartPosition

RestoreButton.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        RestoreDragging = true
        RestoreDragStart = input.Position
        RestoreStartPosition = RestoreButton.Position

        input.Changed:Connect(function()

            if input.UserInputState == Enum.UserInputState.End then
                RestoreDragging = false
            end

        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)

    if not RestoreDragging then
        return
    end

    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then

        local Delta = input.Position - RestoreDragStart

        RestoreButton.Position = UDim2.new(
            RestoreStartPosition.X.Scale,
            RestoreStartPosition.X.Offset + Delta.X,
            RestoreStartPosition.Y.Scale,
            RestoreStartPosition.Y.Offset + Delta.Y
        )
    end
end)

--==================================================
-- LOGO ANIMATION
--==================================================

task.spawn(function()

    while ScreenGui.Parent do

        if MenuOpen then

            FastTween(
                LogoHolder,
                {
                    Rotation = 2
                },
                0.9
            )

            task.wait(0.9)

            FastTween(
                LogoHolder,
                {
                    Rotation = -2
                },
                0.9
            )

            task.wait(0.9)

        else

            task.wait(0.5)

        end
    end

end)

--==================================================
-- SUBTLE GLOW ANIMATION
--==================================================

task.spawn(function()

    while ScreenGui.Parent do

        FastTween(
            BackgroundGlow,
            {
                BackgroundTransparency = 0.89
            },
            1.2
        )

        task.wait(1.2)

        FastTween(
            BackgroundGlow,
            {
                BackgroundTransparency = 0.94
            },
            1.2
        )

        task.wait(1.2)

    end

end)

--==================================================
-- CATEGORY CLICK ANIMATION
--==================================================

for name, data in pairs(CategoryButtons) do

    data.Button.MouseButton1Click:Connect(function()

        local scale = data.Scale

        scale.Scale = 0.94

        FastTween(
            scale,
            {
                Scale = 1
            },
            0.20
        )

    end)

end

--==================================================
-- INITIAL OPEN ANIMATION
--==================================================

Holder.Visible = true
RestoreButton.Visible = false

Holder.Position = UDim2.new(
    0.5,
    0,
    0.5,
    25
)

HolderScale.Scale = 0.78

task.delay(0.05, function()

    Tween(
        Holder,
        TweenInfo.new(
            0.45,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        {
            Position = OriginalPosition
        }
    )

    Tween(
        HolderScale,
        TweenInfo.new(
            0.45,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.Out
        ),
        {
            Scale = OriginalScale
        }
    )

end)

--==================================================
-- END PART 3/4
--==================================================

--==================================================
-- RIVALS HUB
-- PART 4/4
-- GAME LOGIC + FOV + ESP + MOVEMENT
--==================================================

--==================================================
-- SERVICES
--==================================================

local Camera = workspace.CurrentCamera

--==================================================
-- CHARACTER HELPERS
--==================================================

local function GetCharacter()
    return LocalPlayer.Character
end

local function GetHumanoid(character)

    if not character then
        return nil
    end

    return character:FindFirstChildOfClass("Humanoid")
end

local function GetRoot(character)

    if not character then
        return nil
    end

    return character:FindFirstChild("HumanoidRootPart")
end

--==================================================
-- FOV CIRCLE
--==================================================

local FOVCircle

pcall(function()

    FOVCircle = Drawing.new("Circle")

    FOVCircle.Visible = false
    FOVCircle.Radius = Config.FOVSize
    FOVCircle.Thickness = 1.5
    FOVCircle.NumSides = 64
    FOVCircle.Filled = false
    FOVCircle.Color = Colors.Menu
    FOVCircle.Transparency = 0.85

end)

local function UpdateFOV()

    if not FOVCircle then
        return
    end

    FOVCircle.Radius = Config.FOVSize

    -- Всегда центрируем FOV по центру экрана.
    FOVCircle.Position = Vector2.new(
        Camera.ViewportSize.X / 2,
        Camera.ViewportSize.Y / 2
    )

    FOVCircle.Visible =
        Config.AimFOV
        and MenuOpen
        and not MenuClosed
end

--==================================================
-- TARGET PART
--==================================================

local function GetTargetPart(character)

    if not character then
        return nil
    end

    if Config.TargetPart == "Head" then

        return character:FindFirstChild("Head")
            or character:FindFirstChild("UpperTorso")
            or character:FindFirstChild("HumanoidRootPart")

    elseif Config.TargetPart == "Torso" then

        return character:FindFirstChild("UpperTorso")
            or character:FindFirstChild("Torso")
            or character:FindFirstChild("HumanoidRootPart")

    elseif Config.TargetPart == "Body" then

        return character:FindFirstChild("HumanoidRootPart")
            or character:FindFirstChild("UpperTorso")
            or character:FindFirstChild("Torso")
    end

    return character:FindFirstChild("HumanoidRootPart")
end

--==================================================
-- VISIBILITY CHECK
--==================================================

local function IsVisible(part)

    if not part then
        return false
    end

    local origin = Camera.CFrame.Position
    local direction = part.Position - origin

    local params = RaycastParams.new()

    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {
        LocalPlayer.Character
    }

    local result = workspace:Raycast(
        origin,
        direction,
        params
    )

    if not result then
        return true
    end

    return result.Instance:IsDescendantOf(part.Parent)
end

--==================================================
-- CLOSEST TARGET
--==================================================

local function GetClosestTarget()

    local closestCharacter = nil
    local closestDistance = math.huge

    local center = Vector2.new(
        Camera.ViewportSize.X / 2,
        Camera.ViewportSize.Y / 2
    )

    for _, player in ipairs(Players:GetPlayers()) do

        if player ~= LocalPlayer then

            local character = player.Character
            local humanoid = GetHumanoid(character)
            local targetPart = GetTargetPart(character)

            if character
                and humanoid
                and humanoid.Health > 0
                and targetPart then

                if Config.VisibleOnly and not IsVisible(targetPart) then
                    continue
                end

                local screenPosition, onScreen =
                    Camera:WorldToViewportPoint(targetPart.Position)

                if onScreen then

                    local distance = (
                        Vector2.new(
                            screenPosition.X,
                            screenPosition.Y
                        ) - center
                    ).Magnitude

                    if Config.AimFOV then

                        if distance > Config.FOVSize then
                            continue
                        end
                    end

                    if distance < closestDistance then

                        closestDistance = distance
                        closestCharacter = character

                    end
                end
            end
        end
    end

    return closestCharacter
end

--==================================================
-- AIM ASSIST
--==================================================

local function AimAtTarget(character)

    if not character then
        return
    end

    local targetPart = GetTargetPart(character)

    if not targetPart then
        return
    end

    local cameraPosition = Camera.CFrame.Position

    local targetCFrame = CFrame.lookAt(
        cameraPosition,
        targetPart.Position
    )

    local smoothness = math.clamp(
        Config.Smoothness,
        0.01,
        1
    )

    Camera.CFrame = Camera.CFrame:Lerp(
        targetCFrame,
        smoothness
    )
end

--==================================================
-- ESP STORAGE
--==================================================

local ESPObjects = {}

local function RemoveESP(player)

    local data = ESPObjects[player]

    if not data then
        return
    end

    for _, object in pairs(data) do

        pcall(function()

            if typeof(object) == "Instance" then
                object:Destroy()

            elseif typeof(object) == "table" then

                for _, subObject in pairs(object) do

                    pcall(function()
                        subObject:Destroy()
                    end)

                end
            end

        end)
    end

    ESPObjects[player] = nil
end

local function RemoveAllESP()

    for player in pairs(ESPObjects) do
        RemoveESP(player)
    end
end

--==================================================
-- CREATE ESP
--==================================================

local function CreateESP(player)

    if player == LocalPlayer then
        return
    end

    local character = player.Character

    if not character then
        return
    end

    RemoveESP(player)

    local data = {}

    --==============================================
    -- HIGHLIGHT
    --==============================================

    if Config.ModelESP or Config.ESP then

        local highlight = Instance.new("Highlight")

        highlight.Name = "RivalsHubHighlight"
        highlight.Adornee = character

        highlight.DepthMode =
            Enum.HighlightDepthMode.AlwaysOnTop

        highlight.FillColor = Colors.Menu
        highlight.FillTransparency = 0.78

        highlight.OutlineColor = Colors.Text
        highlight.OutlineTransparency = 0.25

        highlight.Parent = CoreGui

        data.Highlight = highlight
    end

    --==============================================
    -- BILLBOARD
    --==============================================

    if Config.Names or Config.Health or Config.Distance then

        local root = GetRoot(character)

        if root then

            local Billboard = Instance.new("BillboardGui")

            Billboard.Name = "RivalsHubESP"
            Billboard.Adornee = root
            Billboard.Size = UDim2.fromOffset(150, 65)
            Billboard.StudsOffset = Vector3.new(0, 3.2, 0)
            Billboard.AlwaysOnTop = true

            Billboard.Parent = CoreGui

            local Text = Instance.new("TextLabel")

            Text.Size = UDim2.fromScale(1, 1)
            Text.BackgroundTransparency = 1

            Text.TextColor3 = Colors.Text
            Text.TextStrokeTransparency = 0.4

            Text.TextSize = 11
            Text.Font = Enum.Font.GothamBold

            Text.TextWrapped = true

            Text.Parent = Billboard

            data.Billboard = Billboard
            data.Text = Text
        end
    end

    --==============================================
    -- BOX
    --==============================================

    if Config.Box then

        local box = Instance.new("BoxHandleAdornment")

        box.Name = "RivalsHubBox"

        box.Adornee = character

        box.Size = Vector3.new(
            4,
            6,
            2
        )

        box.Color3 = Colors.Menu
        box.Transparency = 0.55

        box.AlwaysOnTop = true
        box.ZIndex = 5

        box.Parent = CoreGui

        data.Box = box
    end

    ESPObjects[player] = data
end

--==================================================
-- UPDATE ESP TEXT
--==================================================

local function UpdateESP(player, data)

    if not data then
        return
    end

    local character = player.Character

    if not character then
        RemoveESP(player)
        return
    end

    local humanoid = GetHumanoid(character)
    local root = GetRoot(character)

    if not humanoid or not root then
        return
    end

    --==============================================
    -- HIGHLIGHT ENABLE/DISABLE
    --==============================================

    if data.Highlight then

        local enabled =
            Config.ESP
            or Config.ModelESP

        data.Highlight.Enabled = enabled
    end

    --==============================================
    -- BOX ENABLE/DISABLE
    --==============================================

    if data.Box then
        data.Box.Visible = Config.Box
    end

    --==============================================
    -- TEXT
    --==============================================

    if data.Billboard and data.Text then

        local lines = {}

        if Config.Names then
            table.insert(lines, player.DisplayName)
        end

        if Config.Health then
            table.insert(
                lines,
                "HP: " .. math.floor(humanoid.Health)
            )
        end

        if Config.Distance then

            local localRoot = GetRoot(
                LocalPlayer.Character
            )

            if localRoot then

                local distance = (
                    localRoot.Position
                    - root.Position
                ).Magnitude

                table.insert(
                    lines,
                    math.floor(distance) .. " studs"
                )
            end
        end

        data.Text.Text = table.concat(
            lines,
            "\n"
        )

        data.Billboard.Enabled =
            #lines > 0
    end
end

--==================================================
-- ESP UPDATE LOOP
--==================================================

local ESPConnection

ESPConnection = RunService.RenderStepped:Connect(function()

    if not ScreenGui.Parent then
        ESPConnection:Disconnect()
        return
    end

    local espNeeded =
        Config.ESP
        or Config.ModelESP
        or Config.Box
        or Config.Names
        or Config.Health
        or Config.Distance

    if not espNeeded then

        RemoveAllESP()
        return
    end

    for _, player in ipairs(Players:GetPlayers()) do

        if player ~= LocalPlayer then

            if not ESPObjects[player] then
                CreateESP(player)
            end

            UpdateESP(
                player,
                ESPObjects[player]
            )
        end
    end
end)

--==================================================
-- PLAYER CONNECTIONS
--==================================================

Players.PlayerRemoving:Connect(function(player)

    RemoveESP(player)

end)

local function ConnectCharacter(player)

    if player == LocalPlayer then
        return
    end

    player.CharacterAdded:Connect(function()

        task.wait(0.25)

        if Config.ESP
            or Config.ModelESP
            or Config.Box
            or Config.Names
            or Config.Health
            or Config.Distance then

            CreateESP(player)
        end
    end)

    player.CharacterRemoving:Connect(function()

        RemoveESP(player)

    end)
end

for _, player in ipairs(Players:GetPlayers()) do
    ConnectCharacter(player)
end

Players.PlayerAdded:Connect(function(player)
    ConnectCharacter(player)
end)

--==================================================
-- MOVEMENT
--==================================================

local OriginalWalkSpeed = 16
local OriginalJumpPower = 50

local function UpdateMovement()

    local character = GetCharacter()
    local humanoid = GetHumanoid(character)

    if not humanoid then
        return
    end

    --==============================================
    -- SPEED
    --==============================================

    if Config.Speed then

        humanoid.WalkSpeed =
            Config.SpeedValue

    else

        humanoid.WalkSpeed =
            OriginalWalkSpeed
    end

    --==============================================
    -- JUMP
    --==============================================

    if Config.Jump then

        humanoid.UseJumpPower = true
        humanoid.JumpPower =
            Config.JumpPower

    else

        humanoid.UseJumpPower = true
        humanoid.JumpPower =
            OriginalJumpPower
    end
end

--==================================================
-- NOCLIP
--==================================================

local function UpdateNoclip()

    local character = GetCharacter()

    if not character then
        return
    end

    for _, object in ipairs(character:GetDescendants()) do

        if object:IsA("BasePart") then

            object.CanCollide =
                not Config.Noclip

        end
    end
end

--==================================================
-- MOVEMENT LOOP
--==================================================

RunService.Stepped:Connect(function()

    if not ScreenGui.Parent then
        return
    end

    UpdateMovement()
    UpdateNoclip()

end)

--==================================================
-- RESPAWN SUPPORT
--==================================================

LocalPlayer.CharacterAdded:Connect(function(character)

    local humanoid =
        character:WaitForChild(
            "Humanoid",
            5
        )

    if humanoid then

        OriginalWalkSpeed =
            humanoid.WalkSpeed

        if humanoid.UseJumpPower then
            OriginalJumpPower =
                humanoid.JumpPower
        end
    end

    task.wait(0.2)

    UpdateMovement()
    UpdateNoclip()

end)

--==================================================
-- FOV LOOP
--==================================================

RunService.RenderStepped:Connect(function()

    if not ScreenGui.Parent then
        return
    end

    UpdateFOV()

end)

--==================================================
-- CONFIG LIVE UPDATE
--==================================================

task.spawn(function()

    while ScreenGui.Parent do

        -- FOV
        if FOVCircle then
            FOVCircle.Radius =
                Config.FOVSize
        end

        -- Movement
        UpdateMovement()

        -- Noclip
        UpdateNoclip()

        task.wait(0.05)

    end

end)

--==================================================
-- AIM LOOP
--==================================================

RunService.RenderStepped:Connect(function()

    if not ScreenGui.Parent then
        return
    end

    if not MenuOpen then
        return
    end

    if not Config.AimAssist then
        return
    end

    local target =
        GetClosestTarget()

    if target then
        AimAtTarget(target)
    end

end)

--==================================================
-- CLEANUP
--==================================================

local function Cleanup()

    if FOVCircle then

        pcall(function()
            FOVCircle:Remove()
        end)

        FOVCircle = nil
    end

    RemoveAllESP()

    local character = GetCharacter()
    local humanoid = GetHumanoid(character)

    if humanoid then

        humanoid.WalkSpeed =
            OriginalWalkSpeed

        humanoid.UseJumpPower = true

        humanoid.JumpPower =
            OriginalJumpPower
    end

    if character then

        for _, object in ipairs(
            character:GetDescendants()
        ) do

            if object:IsA("BasePart") then
                object.CanCollide = true
            end
        end
    end
end

--==================================================
-- CLOSE CLEANUP
--==================================================

CloseButton.MouseButton1Click:Connect(function()

    Cleanup()

end)

--==================================================
-- CHARACTER INITIALIZATION
--==================================================

task.spawn(function()

    local character =
        LocalPlayer.Character
        or LocalPlayer.CharacterAdded:Wait()

    local humanoid =
        character:WaitForChild(
            "Humanoid",
            5
        )

    if humanoid then

        OriginalWalkSpeed =
            humanoid.WalkSpeed

        if humanoid.UseJumpPower then
            OriginalJumpPower =
                humanoid.JumpPower
        end
    end

    UpdateMovement()
    UpdateNoclip()

end)

--==================================================
-- FINAL UI STATE
--==================================================

SetCategoryVisual("Combat")

PageTitle.Text = "Combat"
PageDescription.Text =
    PageDescriptions.Combat

Holder.Visible = true
RestoreButton.Visible = false

--==================================================
-- RIVALS HUB READY
--==================================================

print("Rivals Hub loaded successfully.")

--==================================================
-- END PART 4/4
--==================================================
