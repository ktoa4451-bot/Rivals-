--==================================================
-- RIVALS HUB
-- CLEAN REBUILD
-- PART 1/4
--==================================================

--==================================================
-- SERVICES
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

--==================================================
-- DESTROY OLD VERSIONS
--==================================================

pcall(function()

    for _, name in ipairs({
        "RivalsHub",
        "RivalsHub_v1",
        "NeutralizationHub",
        "LunarHub"
    }) do

        local old = CoreGui:FindFirstChild(name)

        if old then
            old:Destroy()
        end

    end

end)

pcall(function()

    local old = LocalPlayer.PlayerGui:FindFirstChild("RivalsHub")

    if old then
        old:Destroy()
    end

end)

--==================================================
-- CONFIG
--==================================================

local Config = {

    Version = "v1.1",
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

    Background = Color3.fromRGB(8, 10, 15),
    Panel = Color3.fromRGB(12, 15, 22),
    Sidebar = Color3.fromRGB(11, 14, 20),

    Card = Color3.fromRGB(18, 22, 30),
    CardHover = Color3.fromRGB(23, 29, 40),

    Blue = Color3.fromRGB(55, 115, 255),
    BlueDark = Color3.fromRGB(36, 78, 180),
    BlueSoft = Color3.fromRGB(65, 125, 255),

    Text = Color3.fromRGB(245, 247, 255),
    SubText = Color3.fromRGB(170, 177, 192),
    Muted = Color3.fromRGB(95, 103, 120),

    Border = Color3.fromRGB(42, 49, 63),

    Off = Color3.fromRGB(25, 29, 38)
}

--==================================================
-- HELPERS
--==================================================

local function New(className, properties, parent)

    local object = Instance.new(className)

    for property, value in pairs(properties or {}) do

        pcall(function()
            object[property] = value
        end)

    end

    if parent then
        object.Parent = parent
    end

    return object
end

local function Corner(object, radius)

    local corner = Instance.new("UICorner")

    corner.CornerRadius =
        UDim.new(0, radius or 10)

    corner.Parent = object

    return corner
end

local function Stroke(object, color, thickness, transparency)

    local stroke = Instance.new("UIStroke")

    stroke.Color =
        color or Colors.Border

    stroke.Thickness =
        thickness or 1

    stroke.Transparency =
        transparency or 0

    stroke.ApplyStrokeMode =
        Enum.ApplyStrokeMode.Border

    stroke.Parent = object

    return stroke
end

local function Tween(object, duration, properties, style, direction)

    local tween = TweenService:Create(

        object,

        TweenInfo.new(
            duration or 0.2,
            style or Enum.EasingStyle.Quint,
            direction or Enum.EasingDirection.Out
        ),

        properties
    )

    tween:Play()

    return tween
end

local function FastTween(object, properties, duration)

    return Tween(
        object,
        duration or 0.16,
        properties,
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )

end

--==================================================
-- SCREEN GUI
--==================================================

local ScreenGui = New("ScreenGui", {

    Name = "RivalsHub",

    ResetOnSpawn = false,

    IgnoreGuiInset = true,

    ZIndexBehavior =
        Enum.ZIndexBehavior.Sibling

})

pcall(function()
    ScreenGui.Parent = CoreGui
end)

if not ScreenGui.Parent then

    ScreenGui.Parent =
        LocalPlayer:WaitForChild("PlayerGui")

end

--==================================================
-- MAIN HOLDER
--==================================================

local Holder = New("Frame", {

    Name = "Holder",

    Size = UDim2.fromOffset(
        720,
        470
    ),

    Position = UDim2.fromScale(
        0.5,
        0.5
    ),

    AnchorPoint =
        Vector2.new(0.5, 0.5),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ZIndex = 1

}, ScreenGui)

local HolderScale = New("UIScale", {

    Scale = 0.84

}, Holder)

--==================================================
-- MAIN
--==================================================

local Main = New("Frame", {

    Name = "Main",

    Size = UDim2.fromScale(
        1,
        1
    ),

    BackgroundColor3 =
        Colors.Background,

    BorderSizePixel = 0,

    ClipsDescendants = true,

    ZIndex = 5

}, Holder)

Corner(Main, 22)

Stroke(
    Main,
    Colors.Border,
    1,
    0.15
)

--==================================================
-- ANIMATED BACKGROUND
-- IMPORTANT:
-- NO HUGE CIRCLES OUTSIDE MENU
--==================================================

local Background = New("Frame", {

    Name = "AnimatedBackground",

    Size = UDim2.fromScale(
        1,
        1
    ),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ClipsDescendants = true,

    ZIndex = 6

}, Main)

Corner(Background, 22)

--==================================================
-- BACKGROUND LIGHT 1
--==================================================

local BackgroundLight1 = New("Frame", {

    Name = "Light1",

    Size = UDim2.fromOffset(
        250,
        180
    ),

    Position = UDim2.new(
        0.78,
        0,
        -0.18,
        0
    ),

    BackgroundColor3 =
        Colors.BlueDark,

    BackgroundTransparency = 0.93,

    BorderSizePixel = 0,

    ZIndex = 6

}, Background)

Corner(
    BackgroundLight1,
    999
)

--==================================================
-- BACKGROUND LIGHT 2
--==================================================

local BackgroundLight2 = New("Frame", {

    Name = "Light2",

    Size = UDim2.fromOffset(
        210,
        150
    ),

    Position = UDim2.new(
        -0.08,
        0,
        0.68,
        0
    ),

    BackgroundColor3 =
        Colors.Blue,

    BackgroundTransparency = 0.95,

    BorderSizePixel = 0,

    ZIndex = 6

}, Background)

Corner(
    BackgroundLight2,
    999
)

--==================================================
-- BACKGROUND LIGHT 3
--==================================================

local BackgroundLight3 = New("Frame", {

    Name = "Light3",

    Size = UDim2.fromOffset(
        170,
        130
    ),

    Position = UDim2.new(
        0.42,
        0,
        0.52,
        0
    ),

    BackgroundColor3 =
        Colors.BlueSoft,

    BackgroundTransparency = 0.965,

    BorderSizePixel = 0,

    ZIndex = 6

}, Background)

Corner(
    BackgroundLight3,
    999
)

--==================================================
-- BACKGROUND ANIMATION
--==================================================

local BackgroundAnimationRunning = true

task.spawn(function()

    while BackgroundAnimationRunning
        and ScreenGui.Parent do

        FastTween(
            BackgroundLight1,
            {
                Position = UDim2.new(
                    0.60,
                    0,
                    -0.08,
                    0
                ),

                BackgroundTransparency = 0.95
            },
            2.8
        )

        FastTween(
            BackgroundLight2,
            {
                Position = UDim2.new(
                    0.04,
                    0,
                    0.55,
                    0
                ),

                BackgroundTransparency = 0.965
            },
            2.8
        )

        FastTween(
            BackgroundLight3,
            {
                Position = UDim2.new(
                    0.50,
                    0,
                    0.40,
                    0
                ),

                BackgroundTransparency = 0.95
            },
            2.8
        )

        task.wait(2.8)

        FastTween(
            BackgroundLight1,
            {
                Position = UDim2.new(
                    0.78,
                    0,
                    -0.18,
                    0
                ),

                BackgroundTransparency = 0.93
            },
            2.8
        )

        FastTween(
            BackgroundLight2,
            {
                Position = UDim2.new(
                    -0.08,
                    0,
                    0.68,
                    0
                ),

                BackgroundTransparency = 0.95
            },
            2.8
        )

        FastTween(
            BackgroundLight3,
            {
                Position = UDim2.new(
                    0.42,
                    0,
                    0.52,
                    0
                ),

                BackgroundTransparency = 0.965
            },
            2.8
        )

        task.wait(2.8)

    end

end)

--==================================================
-- TOP BAR
--==================================================

local TopBar = New("Frame", {

    Name = "TopBar",

    Size = UDim2.new(
        1,
        -20,
        0,
        68
    ),

    Position = UDim2.fromOffset(
        10,
        10
    ),

    BackgroundColor3 =
        Colors.Panel,

    BorderSizePixel = 0,

    ZIndex = 20

}, Main)

Corner(
    TopBar,
    17
)

--==================================================
-- LOGO HOLDER
--==================================================

local LogoHolder = New("Frame", {

    Name = "LogoHolder",

    Size = UDim2.fromOffset(
        48,
        48
    ),

    Position = UDim2.fromOffset(
        10,
        10
    ),

    BackgroundColor3 =
        Colors.Card,

    BorderSizePixel = 0,

    ZIndex = 25

}, TopBar)

Corner(
    LogoHolder,
    14
)

Stroke(
    LogoHolder,
    Colors.Blue,
    1.2,
    0.2
)

--==================================================
-- LOGO
--==================================================

local Logo = New("TextLabel", {

    Name = "Logo",

    Size = UDim2.fromScale(
        1,
        1
    ),

    BackgroundTransparency = 1,

    Text = "R",

    TextColor3 =
        Colors.Text,

    TextSize = 27,

    Font =
        Enum.Font.GothamBlack,

    TextXAlignment =
        Enum.TextXAlignment.Center,

    TextYAlignment =
        Enum.TextYAlignment.Center,

    ZIndex = 30

}, LogoHolder)

--==================================================
-- LOGO SUBTLE GLOW
--==================================================

local LogoGlow = New("Frame", {

    Name = "LogoGlow",

    Size = UDim2.fromOffset(
        24,
        24
    ),

    Position = UDim2.fromOffset(
        12,
        12
    ),

    BackgroundColor3 =
        Colors.Blue,

    BackgroundTransparency = 0.90,

    BorderSizePixel = 0,

    ZIndex = 26

}, LogoHolder)

Corner(
    LogoGlow,
    999
)

-- Keep logo text above glow
Logo.ZIndex = 30

--==================================================
-- TITLE
--==================================================

local Title = New("TextLabel", {

    Name = "Title",

    Size = UDim2.fromOffset(
        300,
        26
    ),

    Position = UDim2.fromOffset(
        70,
        10
    ),

    BackgroundTransparency = 1,

    Text = "RIVALS HUB",

    TextColor3 =
        Colors.Text,

    TextSize = 18,

    Font =
        Enum.Font.GothamBold,

    TextXAlignment =
        Enum.TextXAlignment.Left,

    ZIndex = 25

}, TopBar)

--==================================================
-- SUBTITLE
--==================================================

local Subtitle = New("TextLabel", {

    Name = "Subtitle",

    Size = UDim2.fromOffset(
        300,
        18
    ),

    Position = UDim2.fromOffset(
        70,
        36
    ),

    BackgroundTransparency = 1,

    Text = "Clean • Fast • Competitive",

    TextColor3 =
        Colors.Muted,

    TextSize = 9,

    Font =
        Enum.Font.GothamMedium,

    TextXAlignment =
        Enum.TextXAlignment.Left,

    ZIndex = 25

}, TopBar)

--==================================================
-- MINIMIZE
--==================================================

local MinimizeButton = New("TextButton", {

    Name = "Minimize",

    Size = UDim2.fromOffset(
        40,
        40
    ),

    Position = UDim2.new(
        1,
        -92,
        0.5,
        -20
    ),

    BackgroundColor3 =
        Colors.Card,

    BorderSizePixel = 0,

    Text = "—",

    TextColor3 =
        Colors.SubText,

    TextSize = 17,

    Font =
        Enum.Font.GothamBold,

    AutoButtonColor = false,

    ZIndex = 30

}, TopBar)

Corner(
    MinimizeButton,
    12
)

Stroke(
    MinimizeButton,
    Colors.Border,
    1,
    0.35
)

--==================================================
-- CLOSE
--==================================================

local CloseButton = New("TextButton", {

    Name = "Close",

    Size = UDim2.fromOffset(
        40,
        40
    ),

    Position = UDim2.new(
        1,
        -46,
        0.5,
        -20
    ),

    BackgroundColor3 =
        Colors.Card,

    BorderSizePixel = 0,

    Text = "×",

    TextColor3 =
        Colors.SubText,

    TextSize = 19,

    Font =
        Enum.Font.GothamBold,

    AutoButtonColor = false,

    ZIndex = 30

}, TopBar)

Corner(
    CloseButton,
    12
)

Stroke(
    CloseButton,
    Colors.Border,
    1,
    0.35
)

--==================================================
-- BODY
--==================================================

local Body = New("Frame", {

    Name = "Body",

    Size = UDim2.new(
        1,
        -20,
        1,
        -88
    ),

    Position = UDim2.fromOffset(
        10,
        78
    ),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ClipsDescendants = true,

    ZIndex = 15

}, Main)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = New("Frame", {

    Name = "Sidebar",

    Size = UDim2.new(
        0,
        175,
        1,
        0
    ),

    Position = UDim2.fromOffset(
        0,
        0
    ),

    BackgroundColor3 =
        Colors.Sidebar,

    BorderSizePixel = 0,

    ZIndex = 20

}, Body)

Corner(
    Sidebar,
    17
)

--==================================================
-- SIDEBAR HEADER
--==================================================

local NavigationTitle = New("TextLabel", {

    Name = "NavigationTitle",

    Size = UDim2.new(
        1,
        -28,
        0,
        20
    ),

    Position = UDim2.fromOffset(
        14,
        15
    ),

    BackgroundTransparency = 1,

    Text = "NAVIGATION",

    TextColor3 =
        Colors.Muted,

    TextSize = 9,

    Font =
        Enum.Font.GothamBold,

    TextXAlignment =
        Enum.TextXAlignment.Left,

    ZIndex = 25

}, Sidebar)

--==================================================
-- CATEGORY CONTAINER
-- FIXED POSITION
--==================================================

local CategoryHolder = New("Frame", {

    Name = "Categories",

    Size = UDim2.new(
        1,
        -20,
        0,
        190
    ),

    Position = UDim2.fromOffset(
        10,
        48
    ),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ZIndex = 22

}, Sidebar)

local CategoryLayout = New("UIListLayout", {

    FillDirection =
        Enum.FillDirection.Vertical,

    HorizontalAlignment =
        Enum.HorizontalAlignment.Center,

    VerticalAlignment =
        Enum.VerticalAlignment.Top,

    Padding =
        UDim.new(0, 7),

    SortOrder =
        Enum.SortOrder.LayoutOrder

}, CategoryHolder)

--==================================================
-- CONTENT
--==================================================

local Content = New("Frame", {

    Name = "Content",

    Size = UDim2.new(
        1,
        -185,
        1,
        0
    ),

    Position = UDim2.fromOffset(
        185,
        0
    ),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ClipsDescendants = true,

    ZIndex = 20

}, Body)

--==================================================
-- PAGE HEADER
--==================================================

local PageHeader = New("Frame", {

    Name = "PageHeader",

    Size = UDim2.new(
        1,
        -30,
        0,
        55
    ),

    Position = UDim2.fromOffset(
        15,
        5
    ),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ZIndex = 25

}, Content)

local PageTitle = New("TextLabel", {

    Name = "PageTitle",

    Size = UDim2.new(
        1,
        0,
        0,
        28
    ),

    Position = UDim2.fromOffset(
        0,
        0
    ),

    BackgroundTransparency = 1,

    Text = "Combat",

    TextColor3 =
        Colors.Text,

    TextSize = 21,

    Font =
        Enum.Font.GothamBold,

    TextXAlignment =
        Enum.TextXAlignment.Left,

    ZIndex = 26

}, PageHeader)

local PageDescription = New("TextLabel", {

    Name = "PageDescription",

    Size = UDim2.new(
        1,
        0,
        0,
        18
    ),

    Position = UDim2.fromOffset(
        0,
        30
    ),

    BackgroundTransparency = 1,

    Text = "Aim and targeting functions",

    TextColor3 =
        Colors.Muted,

    TextSize = 9,

    Font =
        Enum.Font.Gotham,

    TextXAlignment =
        Enum.TextXAlignment.Left,

    ZIndex = 26

}, PageHeader)

--==================================================
-- PAGES HOLDER
--==================================================

local Pages = New("Frame", {

    Name = "Pages",

    Size = UDim2.new(
        1,
        -30,
        1,
        -70
    ),

    Position = UDim2.fromOffset(
        15,
        65
    ),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ClipsDescendants = true,

    ZIndex = 22

}, Content)

--==================================================
-- PAGE CREATION
--==================================================

local function CreatePage(name)

    local page = New("ScrollingFrame", {

        Name = name,

        Size = UDim2.fromScale(
            1,
            1
        ),

        Position = UDim2.fromScale(
            0,
            0
        ),

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        ScrollBarThickness = 2,

        ScrollBarImageColor3 =
            Colors.Blue,

        ScrollBarImageTransparency = 0.3,

        CanvasSize =
            UDim2.fromOffset(
                0,
                0
            ),

        AutomaticCanvasSize =
            Enum.AutomaticSize.Y,

        ScrollingDirection =
            Enum.ScrollingDirection.Y,

        ClipsDescendants = true,

        Visible = false,

        ZIndex = 23

    }, Pages)

    New("UIPadding", {

        PaddingTop =
            UDim.new(0, 2),

        PaddingBottom =
            UDim.new(0, 8),

        PaddingLeft =
            UDim.new(0, 2),

        PaddingRight =
            UDim.new(0, 5)

    }, page)

    New("UIListLayout", {

        Padding =
            UDim.new(0, 8),

        SortOrder =
            Enum.SortOrder.LayoutOrder

    }, page)

    return page
end

local CombatPage =
    CreatePage("Combat")

local VisualsPage =
    CreatePage("Visuals")

local MovementPage =
    CreatePage("Movement")

local SettingsPage =
    CreatePage("Settings")

CombatPage.Visible = true

--==================================================
-- CATEGORY DATA
--==================================================

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

local PageDescriptions = {

    Combat =
        "Aim and targeting functions",

    Visuals =
        "ESP and player information",

    Movement =
        "Movement and player controls",

    Settings =
        "Rivals Hub configuration"
}

local CategoryButtons = {}

--==================================================
-- CATEGORY BUTTONS
--==================================================

for _, category in ipairs(Categories) do

    local Button = New("TextButton", {

        Name = category.Name,

        Size = UDim2.new(
            1,
            0,
            0,
            44
        ),

        BackgroundColor3 =
            Colors.Card,

        BackgroundTransparency = 0.28,

        BorderSizePixel = 0,

        Text = "",

        AutoButtonColor = false,

        LayoutOrder =
            category.Order,

        ZIndex = 30

    }, CategoryHolder)

    Corner(
        Button,
        13
    )

    Stroke(
        Button,
        Colors.Border,
        1,
        0.62
    )

    local Icon = New("TextLabel", {

        Name = "Icon",

        Size = UDim2.fromOffset(
            30,
            30
        ),

        Position = UDim2.fromOffset(
            7,
            7
        ),

        BackgroundColor3 =
            Colors.Panel,

        BorderSizePixel = 0,

        Text = category.Icon,

        TextColor3 =
            Colors.SubText,

        TextSize = 11,

        Font =
            Enum.Font.GothamBold,

        TextXAlignment =
            Enum.TextXAlignment.Center,

        TextYAlignment =
            Enum.TextYAlignment.Center,

        ZIndex = 32

    }, Button)

    Corner(
        Icon,
        9
    )

    local Text = New("TextLabel", {

        Name = "Text",

        Size = UDim2.new(
            1,
            -48,
            1,
            0
        ),

        Position = UDim2.fromOffset(
            45,
            0
        ),

        BackgroundTransparency = 1,

        Text = category.Name,

        TextColor3 =
            Colors.SubText,

        TextSize = 10,

        Font =
            Enum.Font.GothamSemibold,

        TextXAlignment =
            Enum.TextXAlignment.Left,

        TextYAlignment =
            Enum.TextYAlignment.Center,

        ZIndex = 32

    }, Button)

    local Scale = New("UIScale", {

        Scale = 1

    }, Button)

    CategoryButtons[category.Name] = {

        Button = Button,
        Icon = Icon,
        Text = Text,
        Scale = Scale

    }

end

--==================================================
-- CATEGORY VISUAL
--==================================================

local function SetCategoryVisual(name)

    for categoryName, data in pairs(CategoryButtons) do

        local active =
            categoryName == name

        if active then

            FastTween(
                data.Button,
                {
                    BackgroundColor3 =
                        Colors.Blue,

                    BackgroundTransparency = 0
                },
                0.18
            )

            FastTween(
                data.Icon,
                {
                    BackgroundColor3 =
                        Colors.BlueDark,

                    TextColor3 =
                        Colors.Text
                },
                0.18
            )

            FastTween(
                data.Text,
                {
                    TextColor3 =
                        Colors.Text
                },
                0.18
            )

        else

            FastTween(
                data.Button,
                {
                    BackgroundColor3 =
                        Colors.Card,

                    BackgroundTransparency =
                        0.28
                },
                0.18
            )

            FastTween(
                data.Icon,
                {
                    BackgroundColor3 =
                        Colors.Panel,

                    TextColor3 =
                        Colors.SubText
                },
                0.18
            )

            FastTween(
                data.Text,
                {
                    TextColor3 =
                        Colors.SubText
                },
                0.18
            )

        end

    end

end

--==================================================
-- INITIAL CATEGORY
--==================================================

SetCategoryVisual("Combat")

--==================================================
-- END PART 1/4
--==================================================

--==================================================
-- RIVALS HUB
-- PART 2/4
-- PAGE SWITCHING + CONTROLS
--==================================================

--==================================================
-- PAGE DATA
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

--==================================================
-- PAGE SWITCHING
--==================================================

local function SwitchPage(name)

    if SwitchingPage then
        return
    end

    if not PageData[name] then
        return
    end

    if name == CurrentCategory then
        return
    end

    SwitchingPage = true

    local oldName = CurrentCategory
    local oldPage = PageData[oldName].Page
    local newPage = PageData[name].Page

    local direction = 1

    local oldOrder = PageData[oldName].Page.LayoutOrder
    local newOrder = PageData[name].Page.LayoutOrder

    if newOrder < oldOrder then
        direction = -1
    end

    PageTitle.Text = PageData[name].Title
    PageDescription.Text =
        PageData[name].Description

    SetCategoryVisual(name)

    -- Start the new page from the correct side.
    newPage.Position =
        UDim2.fromScale(direction, 0)

    newPage.Visible = true

    FastTween(
        oldPage,
        {
            Position =
                UDim2.fromScale(-direction, 0)
        },
        0.23
    )

    local newTween = FastTween(
        newPage,
        {
            Position =
                UDim2.fromScale(0, 0)
        },
        0.27
    )

    newTween.Completed:Connect(function()

        if oldPage and oldPage.Parent then

            oldPage.Visible = false

            oldPage.Position =
                UDim2.fromScale(0, 0)

        end

        CurrentCategory = name
        SwitchingPage = false

    end)

end

--==================================================
-- CATEGORY CLICK EVENTS
--==================================================

for name, data in pairs(CategoryButtons) do

    data.Button.MouseButton1Click:Connect(function()

        if SwitchingPage then
            return
        end

        -- Small click animation.
        FastTween(
            data.Scale,
            {
                Scale = 0.94
            },
            0.08
        )

        task.delay(0.08, function()

            if data.Scale.Parent then

                FastTween(
                    data.Scale,
                    {
                        Scale = 1
                    },
                    0.14
                )

            end

        end)

        SwitchPage(name)

    end)

    data.Button.MouseEnter:Connect(function()

        if name ~= CurrentCategory then

            FastTween(
                data.Button,
                {
                    BackgroundColor3 =
                        Colors.CardHover,

                    BackgroundTransparency = 0
                },
                0.12
            )

        end

    end)

    data.Button.MouseLeave:Connect(function()

        if name ~= CurrentCategory then

            FastTween(
                data.Button,
                {
                    BackgroundColor3 =
                        Colors.Card,

                    BackgroundTransparency = 0.28
                },
                0.12
            )

        end

    end)

end

--==================================================
-- CONTROL HELPERS
--==================================================

local function MakeCard(parent, title, description)

    local Card = New("Frame", {

        Size = UDim2.new(
            1,
            -4,
            0,
            68
        ),

        BackgroundColor3 =
            Colors.Card,

        BorderSizePixel = 0,

        ZIndex = 25

    }, parent)

    Corner(
        Card,
        15
    )

    Stroke(
        Card,
        Colors.Border,
        1,
        0.45
    )

    local Title = New("TextLabel", {

        Size = UDim2.new(
            1,
            -125,
            0,
            20
        ),

        Position = UDim2.fromOffset(
            15,
            12
        ),

        BackgroundTransparency = 1,

        Text = title,

        TextColor3 =
            Colors.Text,

        TextSize = 11,

        Font =
            Enum.Font.GothamSemibold,

        TextXAlignment =
            Enum.TextXAlignment.Left,

        ZIndex = 27

    }, Card)

    local Description = New("TextLabel", {

        Size = UDim2.new(
            1,
            -125,
            0,
            17
        ),

        Position = UDim2.fromOffset(
            15,
            34
        ),

        BackgroundTransparency = 1,

        Text = description or "",

        TextColor3 =
            Colors.Muted,

        TextSize = 8,

        Font =
            Enum.Font.Gotham,

        TextXAlignment =
            Enum.TextXAlignment.Left,

        ZIndex = 27

    }, Card)

    return Card
end

--==================================================
-- TOGGLE
--==================================================

local function MakeToggle(
    parent,
    title,
    description,
    configKey
)

    local Card =
        MakeCard(
            parent,
            title,
            description
        )

    local Toggle = New("TextButton", {

        Size = UDim2.fromOffset(
            48,
            26
        ),

        Position = UDim2.new(
            1,
            -64,
            0.5,
            -13
        ),

        BackgroundColor3 =
            Colors.Off,

        BorderSizePixel = 0,

        Text = "",

        AutoButtonColor = false,

        ZIndex = 30

    }, Card)

    Corner(
        Toggle,
        999
    )

    local Knob = New("Frame", {

        Size = UDim2.fromOffset(
            20,
            20
        ),

        Position = UDim2.fromOffset(
            3,
            3
        ),

        BackgroundColor3 =
            Color3.fromRGB(
                130,
                138,
                154
            ),

        BorderSizePixel = 0,

        ZIndex = 31

    }, Toggle)

    Corner(
        Knob,
        999
    )

    local function Update()

        local enabled =
            Config[configKey] == true

        if enabled then

            FastTween(
                Toggle,
                {
                    BackgroundColor3 =
                        Colors.Blue
                },
                0.16
            )

            FastTween(
                Knob,
                {
                    Position =
                        UDim2.new(
                            1,
                            -23,
                            0,
                            3
                        ),

                    BackgroundColor3 =
                        Colors.Text
                },
                0.16
            )

        else

            FastTween(
                Toggle,
                {
                    BackgroundColor3 =
                        Colors.Off
                },
                0.16
            )

            FastTween(
                Knob,
                {
                    Position =
                        UDim2.fromOffset(
                            3,
                            3
                        ),

                    BackgroundColor3 =
                        Color3.fromRGB(
                            130,
                            138,
                            154
                        )
                },
                0.16
            )

        end

    end

    Toggle.MouseButton1Click:Connect(function()

        Config[configKey] =
            not Config[configKey]

        Update()

    end)

    Toggle.MouseEnter:Connect(function()

        FastTween(
            Card,
            {
                BackgroundColor3 =
                    Colors.CardHover
            },
            0.12
        )

    end)

    Toggle.MouseLeave:Connect(function()

        FastTween(
            Card,
            {
                BackgroundColor3 =
                    Colors.Card
            },
            0.12
        )

    end)

    Update()

    return Card, Toggle, Update
end

--==================================================
-- NUMBER CONTROL
--==================================================

local function MakeNumber(
    parent,
    title,
    description,
    configKey,
    minimum,
    maximum,
    step
)

    local Card =
        MakeCard(
            parent,
            title,
            description
        )

    local Minus = New("TextButton", {

        Size = UDim2.fromOffset(
            36,
            34
        ),

        Position = UDim2.new(
            1,
            -142,
            0.5,
            -17
        ),

        BackgroundColor3 =
            Colors.Panel,

        BorderSizePixel = 0,

        Text = "−",

        TextColor3 =
            Colors.SubText,

        TextSize = 15,

        Font =
            Enum.Font.GothamBold,

        AutoButtonColor = false,

        ZIndex = 30

    }, Card)

    Corner(
        Minus,
        10
    )

    Stroke(
        Minus,
        Colors.Border,
        1,
        0.4
    )

    local Value = New("TextLabel", {

        Size = UDim2.fromOffset(
            52,
            34
        ),

        Position = UDim2.new(
            1,
            -101,
            0.5,
            -17
        ),

        BackgroundColor3 =
            Colors.Panel,

        BorderSizePixel = 0,

        Text = tostring(
            Config[configKey]
        ),

        TextColor3 =
            Colors.Text,

        TextSize = 10,

        Font =
            Enum.Font.GothamBold,

        TextXAlignment =
            Enum.TextXAlignment.Center,

        TextYAlignment =
            Enum.TextYAlignment.Center,

        ZIndex = 30

    }, Card)

    Corner(
        Value,
        10
    )

    local Plus = New("TextButton", {

        Size = UDim2.fromOffset(
            36,
            34
        ),

        Position = UDim2.new(
            1,
            -43,
            0.5,
            -17
        ),

        BackgroundColor3 =
            Colors.Panel,

        BorderSizePixel = 0,

        Text = "+",

        TextColor3 =
            Colors.SubText,

        TextSize = 14,

        Font =
            Enum.Font.GothamBold,

        AutoButtonColor = false,

        ZIndex = 30

    }, Card)

    Corner(
        Plus,
        10
    )

    Stroke(
        Plus,
        Colors.Border,
        1,
        0.4
    )

    local function Refresh()

        local current =
            tonumber(Config[configKey])
            or minimum

        Value.Text =
            tostring(current)

    end

    local function Change(amount)

        local current =
            tonumber(Config[configKey])
            or minimum

        current =
            current + amount

        current =
            math.clamp(
                current,
                minimum,
                maximum
            )

        Config[configKey] =
            current

        Refresh()

    end

    Minus.MouseButton1Click:Connect(function()

        Change(-step)

        FastTween(
            Minus,
            {
                Size =
                    UDim2.fromOffset(
                        33,
                        31
                    )
            },
            0.06
        )

        task.delay(0.06, function()

            if Minus.Parent then

                FastTween(
                    Minus,
                    {
                        Size =
                            UDim2.fromOffset(
                                36,
                                34
                            )
                    },
                    0.1
                )

            end

        end)

    end)

    Plus.MouseButton1Click:Connect(function()

        Change(step)

        FastTween(
            Plus,
            {
                Size =
                    UDim2.fromOffset(
                        33,
                        31
                    )
            },
            0.06
        )

        task.delay(0.06, function()

            if Plus.Parent then

                FastTween(
                    Plus,
                    {
                        Size =
                            UDim2.fromOffset(
                                36,
                                34
                            )
                    },
                    0.1
                )

            end

        end)

    end)

    Refresh()

    return Card
end

--==================================================
-- DROPDOWN
--==================================================

local function MakeDropdown(
    parent,
    title,
    description,
    configKey,
    options
)

    local Card =
        MakeCard(
            parent,
            title,
            description
        )

    local DropButton = New("TextButton", {

        Size = UDim2.fromOffset(
            112,
            34
        ),

        Position = UDim2.new(
            1,
            -125,
            0.5,
            -17
        ),

        BackgroundColor3 =
            Colors.Panel,

        BorderSizePixel = 0,

        Text = tostring(
            Config[configKey]
        ) .. "  ▾",

        TextColor3 =
            Colors.SubText,

        TextSize = 9,

        Font =
            Enum.Font.GothamSemibold,

        AutoButtonColor = false,

        ZIndex = 30

    }, Card)

    Corner(
        DropButton,
        10
    )

    Stroke(
        DropButton,
        Colors.Border,
        1,
        0.4
    )

    local Open = false

    local List = New("Frame", {

        Size = UDim2.new(
            1,
            0,
            0,
            #options * 32 + 8
        ),

        Position = UDim2.new(
            0,
            0,
            1,
            5
        ),

        BackgroundColor3 =
            Colors.Panel,

        BorderSizePixel = 0,

        Visible = false,

        ZIndex = 100

    }, DropButton)

    Corner(
        List,
        10
    )

    Stroke(
        List,
        Colors.Border,
        1,
        0.25
    )

    local ListLayout = New(
        "UIListLayout",
        {
            Padding =
                UDim.new(0, 2),

            SortOrder =
                Enum.SortOrder.LayoutOrder
        },
        List
    )

    New("UIPadding", {

        PaddingTop =
            UDim.new(0, 4),

        PaddingBottom =
            UDim.new(0, 4),

        PaddingLeft =
            UDim.new(0, 4),

        PaddingRight =
            UDim.new(0, 4)

    }, List)

    for index, option in ipairs(options) do

        local Option = New("TextButton", {

            Size = UDim2.new(
                1,
                0,
                0,
                30
            ),

            BackgroundColor3 =
                Colors.Card,

            BackgroundTransparency = 0.2,

            BorderSizePixel = 0,

            Text = tostring(option),

            TextColor3 =
                Colors.SubText,

            TextSize = 9,

            Font =
                Enum.Font.GothamSemibold,

            AutoButtonColor = false,

            LayoutOrder = index,

            ZIndex = 101

        }, List)

        Corner(
            Option,
            7
        )

        Option.MouseButton1Click:Connect(function()

            Config[configKey] =
                option

            DropButton.Text =
                tostring(option) .. "  ▾"

            Open = false
            List.Visible = false

        end)

        Option.MouseEnter:Connect(function()

            FastTween(
                Option,
                {
                    BackgroundColor3 =
                        Colors.CardHover,

                    TextColor3 =
                        Colors.Text
                },
                0.1
            )

        end)

        Option.MouseLeave:Connect(function()

            FastTween(
                Option,
                {
                    BackgroundColor3 =
                        Colors.Card,

                    TextColor3 =
                        Colors.SubText
                },
                0.1
            )

        end)

    end

    DropButton.MouseButton1Click:Connect(function()

        Open = not Open

        List.Visible = Open

    end)

    return Card
end

--==================================================
-- COMBAT PAGE
--==================================================

MakeToggle(
    CombatPage,
    "Aim Assist",
    "Automatically assists your aim",
    "AimAssist"
)

MakeToggle(
    CombatPage,
    "Visible Only",
    "Only target players visible to you",
    "VisibleOnly"
)

MakeToggle(
    CombatPage,
    "Aim FOV",
    "Limit aim assistance to the FOV circle",
    "AimFOV"
)

MakeNumber(
    CombatPage,
    "FOV Size",
    "Size of the aim field of view",
    "FOVSize",
    50,
    1000,
    25
)

MakeNumber(
    CombatPage,
    "Smoothness",
    "Aim movement smoothness",
    "Smoothness",
    0.01,
    1,
    0.01
)

MakeDropdown(
    CombatPage,
    "Target Part",
    "Body part used by Aim Assist",
    "TargetPart",
    {
        "Head",
        "Torso",
        "Body"
    }
)

--==================================================
-- VISUALS PAGE
--==================================================

MakeToggle(
    VisualsPage,
    "ESP",
    "Master switch for player ESP",
    "ESP"
)

MakeToggle(
    VisualsPage,
    "Model ESP",
    "Highlight player models",
    "ModelESP"
)

MakeToggle(
    VisualsPage,
    "Box",
    "Display a box around players",
    "Box"
)

MakeToggle(
    VisualsPage,
    "Names",
    "Display player names",
    "Names"
)

MakeToggle(
    VisualsPage,
    "Health",
    "Display player health",
    "Health"
)

MakeToggle(
    VisualsPage,
    "Distance",
    "Display player distance",
    "Distance"
)

--==================================================
-- MOVEMENT PAGE
--==================================================

MakeToggle(
    MovementPage,
    "Speed",
    "Enable custom WalkSpeed",
    "Speed"
)

MakeNumber(
    MovementPage,
    "Speed Value",
    "Custom WalkSpeed",
    "SpeedValue",
    1,
    200,
    1
)

MakeToggle(
    MovementPage,
    "Jump",
    "Enable custom JumpPower",
    "Jump"
)

MakeNumber(
    MovementPage,
    "Jump Power",
    "Custom JumpPower",
    "JumpPower",
    1,
    200,
    5
)

MakeToggle(
    MovementPage,
    "Noclip",
    "Walk through physical objects",
    "Noclip"
)

--==================================================
-- SETTINGS PAGE
--==================================================

local SettingsInfo = New("Frame", {

    Size = UDim2.new(
        1,
        -4,
        0,
        190
    ),

    BackgroundColor3 =
        Colors.Card,

    BorderSizePixel = 0,

    ZIndex = 25

}, SettingsPage)

Corner(
    SettingsInfo,
    16
)

Stroke(
    SettingsInfo,
    Colors.Border,
    1,
    0.4
)

--==================================================
-- SETTINGS TITLE
--==================================================

local SettingsTitle = New("TextLabel", {

    Size = UDim2.new(
        1,
        -30,
        0,
        25
    ),

    Position = UDim2.fromOffset(
        15,
        14
    ),

    BackgroundTransparency = 1,

    Text = "RIVALS HUB",

    TextColor3 =
        Colors.Text,

    TextSize = 16,

    Font =
        Enum.Font.GothamBold,

    TextXAlignment =
        Enum.TextXAlignment.Left,

    ZIndex = 27

}, SettingsInfo)

--==================================================
-- VERSION
--==================================================

local SettingsVersion = New("TextLabel", {

    Size = UDim2.new(
        1,
        -30,
        0,
        22
    ),

    Position = UDim2.fromOffset(
        15,
        50
    ),

    BackgroundTransparency = 1,

    Text = "Version: " .. Config.Version,

    TextColor3 =
        Colors.SubText,

    TextSize = 10,

    Font =
        Enum.Font.Gotham,

    TextXAlignment =
        Enum.TextXAlignment.Left,

    ZIndex = 27

}, SettingsInfo)

--==================================================
-- CREATOR
--==================================================

local SettingsCreator = New("TextLabel", {

    Size = UDim2.new(
        1,
        -30,
        0,
        22
    ),

    Position = UDim2.fromOffset(
        15,
        76
    ),

    BackgroundTransparency = 1,

    Text = "Creator: " .. Config.Creator,

    TextColor3 =
        Colors.SubText,

    TextSize = 10,

    Font =
        Enum.Font.Gotham,

    TextXAlignment =
        Enum.TextXAlignment.Left,

    ZIndex = 27

}, SettingsInfo)

--==================================================
-- TELEGRAM
--==================================================

local Telegram = New("TextLabel", {

    Size = UDim2.new(
        1,
        -30,
        0,
        22
    ),

    Position = UDim2.fromOffset(
        15,
        102
    ),

    BackgroundTransparency = 1,

    Text = "Telegram: @lunarhub_script",

    TextColor3 =
        Colors.SubText,

    TextSize = 10,

    Font =
        Enum.Font.Gotham,

    TextXAlignment =
        Enum.TextXAlignment.Left,

    ZIndex = 27

}, SettingsInfo)

--==================================================
-- STATUS
--==================================================

local Status = New("TextLabel", {

    Size = UDim2.new(
        1,
        -30,
        0,
        22
    ),

    Position = UDim2.fromOffset(
        15,
        128
    ),

    BackgroundTransparency = 1,

    Text = "●  Rivals Hub is running",

    TextColor3 =
        Colors.BlueSoft,

    TextSize = 10,

    Font =
        Enum.Font.GothamSemibold,

    TextXAlignment =
        Enum.TextXAlignment.Left,

    ZIndex = 27

}, SettingsInfo)

--==================================================
-- TELEGRAM BUTTON
--==================================================

local TelegramButton = New("TextButton", {

    Size = UDim2.fromOffset(
        145,
        34
    ),

    Position = UDim2.new(
        1,
        -160,
        1,
        -48
    ),

    BackgroundColor3 =
        Colors.Blue,

    BorderSizePixel = 0,

    Text = "Open Telegram  →",

    TextColor3 =
        Colors.Text,

    TextSize = 9,

    Font =
        Enum.Font.GothamBold,

    AutoButtonColor = false,

    ZIndex = 30

}, SettingsInfo)

Corner(
    TelegramButton,
    10
)

TelegramButton.MouseEnter:Connect(function()

    FastTween(
        TelegramButton,
        {
            BackgroundColor3 =
                Colors.BlueSoft
        },
        0.12
    )

end)

TelegramButton.MouseLeave:Connect(function()

    FastTween(
        TelegramButton,
        {
            BackgroundColor3 =
                Colors.Blue
        },
        0.12
    )

end)

TelegramButton.MouseButton1Click:Connect(function()

    pcall(function()

        if setclipboard then

            setclipboard(
                "https://t.me/lunarhub_script"
            )

        end

    end)

end)

--==================================================
-- INITIAL PAGE STATE
--==================================================

CombatPage.Position =
    UDim2.fromScale(0, 0)

VisualsPage.Position =
    UDim2.fromScale(0, 0)

MovementPage.Position =
    UDim2.fromScale(0, 0)
х
SettingsPage.Position =
    UDim2.fromScale(0, 0)

CombatPage.Visible = true
VisualsPage.Visible = false
MovementPage.Visible = false
SettingsPage.Visible = false

PageTitle.Text = "Combat"

PageDescription.Text =
    PageDescriptions.Combat

--==================================================
-- END PART 2/4
--==================================================

--==================================================
-- RIVALS HUB
-- PART 3/4
-- MENU ANIMATIONS + MINIMIZE + RESTORE + DRAG
--==================================================

--==================================================
-- MENU STATE
--==================================================

local MenuOpen = true
local MenuClosed = false
local MenuAnimating = false

local LastMenuPosition =
    Holder.Position

--==================================================
-- FLOATING RESTORE BUTTON
--==================================================

local RestoreButton = New("TextButton", {

    Name = "RestoreButton",

    Size = UDim2.fromOffset(
        44,
        44
    ),

    Position =
        LastMenuPosition,

    AnchorPoint =
        Vector2.new(0.5, 0.5),

    BackgroundColor3 =
        Colors.Panel,

    BorderSizePixel = 0,

    Text = "R",

    TextColor3 =
        Colors.Text,

    TextSize = 18,

    Font =
        Enum.Font.GothamBlack,

    AutoButtonColor = false,

    Visible = false,

    ZIndex = 200

}, ScreenGui)

Corner(
    RestoreButton,
    14
)

local RestoreStroke =
    Stroke(
        RestoreButton,
        Colors.Blue,
        1.5,
        0.12
    )

local RestoreScale = New("UIScale", {

    Scale = 0.65

}, RestoreButton)

--==================================================
-- RESTORE GLOW
--==================================================

local RestoreGlow = New("Frame", {

    Name = "Glow",

    Size = UDim2.fromOffset(
        20,
        20
    ),

    Position = UDim2.fromOffset(
        12,
        12
    ),

    BackgroundColor3 =
        Colors.Blue,

    BackgroundTransparency = 0.88,

    BorderSizePixel = 0,

    ZIndex = 201

}, RestoreButton)

Corner(
    RestoreGlow,
    999
)

-- Keep R above glow.
RestoreButton.ZIndex = 200

--==================================================
-- MENU ANIMATION HELPERS
--==================================================

local function AnimateMenuElements(show)

    if show then

        FastTween(
            LogoHolder,
            {
                BackgroundTransparency = 0
            },
            0.22
        )

        FastTween(
            Title,
            {
                TextTransparency = 0
            },
            0.22
        )

        FastTween(
            Subtitle,
            {
                TextTransparency = 0
            },
            0.22
        )

        FastTween(
            PageTitle,
            {
                TextTransparency = 0
            },
            0.22
        )

        FastTween(
            PageDescription,
            {
                TextTransparency = 0
            },
            0.22
        )

    else

        FastTween(
            LogoHolder,
            {
                BackgroundTransparency = 1
            },
            0.12
        )

        FastTween(
            Title,
            {
                TextTransparency = 1
            },
            0.12
        )

        FastTween(
            Subtitle,
            {
                TextTransparency = 1
            },
            0.12
        )

        FastTween(
            PageTitle,
            {
                TextTransparency = 1
            },
            0.12
        )

        FastTween(
            PageDescription,
            {
                TextTransparency = 1
            },
            0.12
        )

    end

end

--==================================================
-- OPEN MENU
--==================================================

local function OpenMenu()

    if MenuAnimating then
        return
    end

    if MenuClosed then
        return
    end

    MenuAnimating = true
    MenuOpen = true

    RestoreButton.Visible = false

    Holder.Visible = true

    -- Restore exactly where the menu was.
    Holder.Position =
        LastMenuPosition

    HolderScale.Scale = 0.78

    Main.BackgroundTransparency = 0.25

    AnimateMenuElements(true)

    FastTween(
        HolderScale,
        {
            Scale = 0.84
        },
        0.38
    )

    FastTween(
        Main,
        {
            BackgroundTransparency = 0
        },
        0.28
    )

    task.delay(
        0.38,
        function()

            MenuAnimating = false

        end
    )

end

--==================================================
-- MINIMIZE MENU
--==================================================

local function MinimizeMenu()

    if MenuAnimating then
        return
    end

    if MenuClosed then
        return
    end

    MenuAnimating = true
    MenuOpen = false

    -- IMPORTANT:
    -- Save the exact current menu position.
    LastMenuPosition =
        Holder.Position

    AnimateMenuElements(false)

    -- Shrink around the current position.
    FastTween(
        HolderScale,
        {
            Scale = 0.05
        },
        0.30
    )

    FastTween(
        Main,
        {
            BackgroundTransparency = 1
        },
        0.24
    )

    task.delay(
        0.30,
        function()

            if not Holder.Parent then
                return
            end

            Holder.Visible = false

            Main.BackgroundTransparency = 0

            -- R appears exactly where the menu was.
            RestoreButton.Position =
                LastMenuPosition

            RestoreButton.Visible = true

            RestoreScale.Scale = 0.45

            FastTween(
                RestoreScale,
                {
                    Scale = 1
                },
                0.25
            )

            MenuAnimating = false

        end
    )

end

--==================================================
-- CLOSE MENU
--==================================================

local function CloseMenu()

    if MenuAnimating then
        return
    end

    if MenuClosed then
        return
    end

    MenuAnimating = true
    MenuClosed = true
    MenuOpen = false

    AnimateMenuElements(false)

    FastTween(
        HolderScale,
        {
            Scale = 0.05
        },
        0.25
    )

    FastTween(
        Main,
        {
            BackgroundTransparency = 1
        },
        0.22
    )

    task.delay(
        0.28,
        function()

            if ScreenGui then

                ScreenGui:Destroy()

            end

        end
    )

end

--==================================================
-- MINIMIZE BUTTON
--==================================================

MinimizeButton.MouseEnter:Connect(function()

    FastTween(
        MinimizeButton,
        {
            BackgroundColor3 =
                Colors.CardHover,

            TextColor3 =
                Colors.Text
        },
        0.12
    )

end)

MinimizeButton.MouseLeave:Connect(function()

    FastTween(
        MinimizeButton,
        {
            BackgroundColor3 =
                Colors.Card,

            TextColor3 =
                Colors.SubText
        },
        0.12
    )

end)

MinimizeButton.MouseButton1Click:Connect(
    MinimizeMenu
)

--==================================================
-- CLOSE BUTTON
--==================================================

CloseButton.MouseEnter:Connect(function()

    FastTween(
        CloseButton,
        {
            BackgroundColor3 =
                Colors.CardHover,

            TextColor3 =
                Colors.Text
        },
        0.12
    )

end)

CloseButton.MouseLeave:Connect(function()

    FastTween(
        CloseButton,
        {
            BackgroundColor3 =
                Colors.Card,

            TextColor3 =
                Colors.SubText
        },
        0.12
    )

end)

CloseButton.MouseButton1Click:Connect(
    CloseMenu
)

--==================================================
-- RESTORE BUTTON HOVER
--==================================================

RestoreButton.MouseEnter:Connect(function()

    FastTween(
        RestoreButton,
        {
            BackgroundColor3 =
                Colors.Blue
        },
        0.15
    )

    FastTween(
        RestoreScale,
        {
            Scale = 1.08
        },
        0.15
    )

end)

RestoreButton.MouseLeave:Connect(function()

    FastTween(
        RestoreButton,
        {
            BackgroundColor3 =
                Colors.Panel
        },
        0.15
    )

    FastTween(
        RestoreScale,
        {
            Scale = 1
        },
        0.15
    )

end)

RestoreButton.MouseButton1Click:Connect(
    OpenMenu
)

--==================================================
-- DRAG SYSTEM
--==================================================

local DraggingMenu = false
local MenuDragStart
local MenuStartPosition

local function UpdateMenuDrag(input)

    local delta =
        input.Position - MenuDragStart

    Holder.Position =
        UDim2.new(
            MenuStartPosition.X.Scale,
            MenuStartPosition.X.Offset + delta.X,
            MenuStartPosition.Y.Scale,
            MenuStartPosition.Y.Offset + delta.Y
        )

    LastMenuPosition =
        Holder.Position

end

TopBar.InputBegan:Connect(function(input)

    if input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or
        input.UserInputType ==
        Enum.UserInputType.Touch then

        DraggingMenu = true

        MenuDragStart =
            input.Position

        MenuStartPosition =
            Holder.Position

        input.Changed:Connect(function()

            if input.UserInputState ==
                Enum.UserInputState.End then

                DraggingMenu = false

                LastMenuPosition =
                    Holder.Position

            end

        end)

    end

end)

UserInputService.InputChanged:Connect(function(input)

    if not DraggingMenu then
        return
    end

    if input.UserInputType ==
        Enum.UserInputType.MouseMovement
        or
        input.UserInputType ==
        Enum.UserInputType.Touch then

        UpdateMenuDrag(input)

    end

end)

--==================================================
-- DRAG RESTORE BUTTON
--==================================================

local DraggingRestore = false
local RestoreDragStart
local RestoreStartPosition
local RestoreMoved = false

RestoreButton.InputBegan:Connect(function(input)

    if input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or
        input.UserInputType ==
        Enum.UserInputType.Touch then

        DraggingRestore = true
        RestoreMoved = false

        RestoreDragStart =
            input.Position

        RestoreStartPosition =
            RestoreButton.Position

        input.Changed:Connect(function()

            if input.UserInputState ==
                Enum.UserInputState.End then

                DraggingRestore = false

                LastMenuPosition =
                    RestoreButton.Position

            end

        end)

    end

end)

UserInputService.InputChanged:Connect(function(input)

    if not DraggingRestore then
        return
    end

    if input.UserInputType ==
        Enum.UserInputType.MouseMovement
        or
        input.UserInputType ==
        Enum.UserInputType.Touch then

        local delta =
            input.Position - RestoreDragStart

        if math.abs(delta.X) > 3
            or math.abs(delta.Y) > 3 then

            RestoreMoved = true

        end

        RestoreButton.Position =
            UDim2.new(
                RestoreStartPosition.X.Scale,
                RestoreStartPosition.X.Offset + delta.X,
                RestoreStartPosition.Y.Scale,
                RestoreStartPosition.Y.Offset + delta.Y
            )

    end

end)

--==================================================
-- LOGO ANIMATION
--==================================================

task.spawn(function()

    while ScreenGui.Parent
        and not MenuClosed do

        FastTween(
            LogoHolder,
            {
                Rotation = 2
            },
            1.2
        )

        task.wait(1.2)

        FastTween(
            LogoHolder,
            {
                Rotation = -2
            },
            1.2
        )

        task.wait(1.2)

    end

end)

--==================================================
-- RESTORE BUTTON PULSE
--==================================================

task.spawn(function()

    while ScreenGui.Parent
        and not MenuClosed do

        if RestoreButton.Visible then

            FastTween(
                RestoreStroke,
                {
                    Transparency = 0.35
                },
                0.8
            )

            task.wait(0.8)

            if RestoreButton.Visible then

                FastTween(
                    RestoreStroke,
                    {
                        Transparency = 0.05
                    },
                    0.8
                )

            end

        else

            task.wait(0.25)

        end

    end

end)

--==================================================
-- INITIAL OPEN ANIMATION
--==================================================

Holder.Visible = true
RestoreButton.Visible = false

Holder.Position =
    LastMenuPosition

HolderScale.Scale = 0.72

Main.BackgroundTransparency = 0.35

task.delay(
    0.05,
    function()

        FastTween(
            HolderScale,
            {
                Scale = 0.84
            },
            0.42
        )

        FastTween(
            Main,
            {
                BackgroundTransparency = 0
            },
            0.30
        )

    end
)

--==================================================
-- END PART 3/4
--==================================================

--==================================================
-- RIVALS HUB
-- PART 4/4
-- AIM ASSIST + FOV + ESP + MOVEMENT
--==================================================

--==================================================
-- CAMERA
--==================================================

local Camera = workspace.CurrentCamera

--==================================================
-- CHARACTER HELPERS
--==================================================

local function GetCharacter(player)

    if not player then
        return nil
    end

    return player.Character
end

local function GetHumanoid(player)

    local character =
        GetCharacter(player)

    if not character then
        return nil
    end

    return character:FindFirstChildOfClass(
        "Humanoid"
    )
end

local function GetRoot(player)

    local character =
        GetCharacter(player)

    if not character then
        return nil
    end

    return character:FindFirstChild(
        "HumanoidRootPart"
    )
end

local function IsAlive(player)

    local humanoid =
        GetHumanoid(player)

    return humanoid
        and humanoid.Health > 0
end

--==================================================
-- FOV CIRCLE
--==================================================

local FOVCircle = nil

pcall(function()

    if Drawing and Drawing.new then

        FOVCircle =
            Drawing.new("Circle")

        FOVCircle.Visible = false
        FOVCircle.Radius =
            Config.FOVSize

        FOVCircle.Thickness = 1.5
        FOVCircle.NumSides = 80

        FOVCircle.Filled = false

        FOVCircle.Color =
            Colors.Blue

        FOVCircle.Transparency = 0.9

    end

end)

--==================================================
-- UPDATE FOV
--==================================================

local function UpdateFOV()

    Camera =
        workspace.CurrentCamera

    if not Camera then
        return
    end

    if not FOVCircle then
        return
    end

    local viewport =
        Camera.ViewportSize

    FOVCircle.Position =
        Vector2.new(
            viewport.X / 2,
            viewport.Y / 2
        )

    FOVCircle.Radius =
        Config.FOVSize

    -- IMPORTANT:
    -- FOV does NOT depend on MenuOpen.
    FOVCircle.Visible =
        Config.AimFOV
        and not MenuClosed

end

--==================================================
-- TARGET PART
--==================================================

local function GetTargetPart(player)

    local character =
        GetCharacter(player)

    if not character then
        return nil
    end

    local requested =
        Config.TargetPart

    if requested == "Head" then

        return character:FindFirstChild(
            "Head"
        )

    elseif requested == "Torso" then

        return character:FindFirstChild(
            "UpperTorso"
        )
        or character:FindFirstChild(
            "Torso"
        )

    elseif requested == "Body" then

        return character:FindFirstChild(
            "HumanoidRootPart"
        )
        or character:FindFirstChild(
            "UpperTorso"
        )
        or character:FindFirstChild(
            "Torso"
        )

    end

    return character:FindFirstChild(
        "Head"
    )

end

--==================================================
-- TEAM CHECK
--==================================================

local function IsEnemy(player)

    if player == LocalPlayer then
        return false
    end

    if not IsAlive(player) then
        return false
    end

    -- If both players have the same team,
    -- don't target the teammate.
    if LocalPlayer.Team
        and player.Team
        and LocalPlayer.Team ==
            player.Team then

        return false

    end

    return true

end

--==================================================
-- VISIBILITY CHECK
--==================================================

local function IsVisible(part, player)

    if not part then
        return false
    end

    if not Config.VisibleOnly then
        return true
    end

    Camera =
        workspace.CurrentCamera

    if not Camera then
        return false
    end

    local character =
        GetCharacter(player)

    if not character then
        return false
    end

    local origin =
        Camera.CFrame.Position

    local direction =
        part.Position - origin

    local params =
        RaycastParams.new()

    params.FilterType =
        Enum.RaycastFilterType.Exclude

    params.FilterDescendantsInstances = {

        LocalPlayer.Character,
        Camera

    }

    local result =
        workspace:Raycast(
            origin,
            direction,
            params
        )

    if not result then
        return true
    end

    return result.Instance:IsDescendantOf(
        character
    )

end

--==================================================
-- GET CLOSEST TARGET
--==================================================

local function GetClosestTarget()

    Camera =
        workspace.CurrentCamera

    if not Camera then
        return nil
    end

    local viewport =
        Camera.ViewportSize

    local center =
        Vector2.new(
            viewport.X / 2,
            viewport.Y / 2
        )

    local closestPlayer = nil
    local closestDistance = math.huge

    local maxFOV =
        Config.FOVSize

    for _, player in ipairs(
        Players:GetPlayers()
    ) do

        if IsEnemy(player) then

            local part =
                GetTargetPart(player)

            if part then

                local screenPosition,
                    onScreen =
                    Camera:WorldToViewportPoint(
                        part.Position
                    )

                if onScreen then

                    local screenPoint =
                        Vector2.new(
                            screenPosition.X,
                            screenPosition.Y
                        )

                    local distance =
                        (
                            screenPoint -
                            center
                        ).Magnitude

                    local allowed = true

                    if Config.AimFOV then

                        allowed =
                            distance <= maxFOV

                    end

                    if allowed
                        and distance <
                            closestDistance
                        and IsVisible(
                            part,
                            player
                        ) then

                        closestDistance =
                            distance

                        closestPlayer =
                            player

                    end

                end

            end

        end

    end

    return closestPlayer

end

--==================================================
-- AIM AT TARGET
--==================================================

local function AimAtTarget(player, deltaTime)

    if not player then
        return
    end

    local part =
        GetTargetPart(player)

    if not part then
        return
    end

    Camera =
        workspace.CurrentCamera

    if not Camera then
        return
    end

    local cameraPosition =
        Camera.CFrame.Position

    local targetCFrame =
        CFrame.lookAt(
            cameraPosition,
            part.Position
        )

    local smoothness =
        math.clamp(
            tonumber(
                Config.Smoothness
            ) or 0.15,
            0.01,
            1
        )

    -- Frame-rate independent smoothing.
    local alpha =
        1 - math.exp(
            -(
                smoothness * 18
            ) * deltaTime
        )

    alpha =
        math.clamp(
            alpha,
            0,
            1
        )

    Camera.CFrame =
        Camera.CFrame:Lerp(
            targetCFrame,
            alpha
        )

end

--==================================================
-- ESP STORAGE
--==================================================

local ESPObjects = {}

--==================================================
-- REMOVE ESP
--==================================================

local function RemoveESP(player)

    local data =
        ESPObjects[player]

    if not data then
        return
    end

    for _, object in pairs(data) do

        if typeof(object) == "Instance" then

            pcall(function()
                object:Destroy()
            end)

        end

    end

    ESPObjects[player] = nil

end

--==================================================
-- REMOVE ALL ESP
--==================================================

local function RemoveAllESP()

    for player in pairs(ESPObjects) do

        RemoveESP(player)

    end

    table.clear(ESPObjects)

end

--==================================================
-- CREATE ESP
--==================================================

local function CreateESP(player)

    if player == LocalPlayer then
        return
    end

    if not Config.ESP then
        return
    end

    local character =
        GetCharacter(player)

    if not character then
        return
    end

    RemoveESP(player)

    local data = {}

    --==================================================
    -- MODEL ESP
    --==================================================

    if Config.ModelESP then

        local highlight =
            Instance.new("Highlight")

        highlight.Name =
            "RivalsHub_ModelESP"

        highlight.Adornee =
            character

        highlight.FillColor =
            Colors.Blue

        highlight.OutlineColor =
            Colors.BlueSoft

        highlight.FillTransparency =
            0.78

        highlight.OutlineTransparency =
            0.15

        highlight.DepthMode =
            Enum.HighlightDepthMode.AlwaysOnTop

        highlight.Parent =
            character

        data.Highlight =
            highlight

    end

    --==================================================
    -- BOX
    --==================================================

    if Config.Box then

        local box =
            Instance.new(
                "BoxHandleAdornment"
            )

        box.Name =
            "RivalsHub_Box"

        box.Adornee =
            character:FindFirstChild(
                "HumanoidRootPart"
            )

        box.AlwaysOnTop = true

        box.ZIndex = 5

        box.Transparency = 0.45

        box.Color3 =
            Colors.Blue

        box.Size =
            Vector3.new(
                4,
                6,
                2
            )

        box.Parent =
            character

        data.Box =
            box

    end

    --==================================================
    -- NAME / HEALTH / DISTANCE
    --==================================================

    if Config.Names
        or Config.Health
        or Config.Distance then

        local head =
            character:FindFirstChild(
                "Head"
            )

        if head then

            local billboard =
                Instance.new(
                    "BillboardGui"
                )

            billboard.Name =
                "RivalsHub_Info"

            billboard.Adornee =
                head

            billboard.Size =
                UDim2.fromOffset(
                    180,
                    65
                )

            billboard.StudsOffset =
                Vector3.new(
                    0,
                    3,
                    0
                )

            billboard.AlwaysOnTop = true

            billboard.Parent =
                character

            local Info =
                Instance.new("TextLabel")

            Info.Name =
                "Info"

            Info.Size =
                UDim2.fromScale(
                    1,
                    1
                )

            Info.BackgroundTransparency =
                1

            Info.TextColor3 =
                Colors.Text

            Info.TextStrokeTransparency =
                0.35

            Info.TextSize = 10

            Info.Font =
                Enum.Font.GothamBold

            Info.TextYAlignment =
                Enum.TextYAlignment.Center

            Info.Parent =
                billboard

            data.Billboard =
                billboard

            data.Info =
                Info

        end

    end

    ESPObjects[player] =
        data

end

--==================================================
-- UPDATE ESP
--==================================================

local function UpdateESP(player)

    if player == LocalPlayer then
        return
    end

    -- MASTER ESP SWITCH.
    -- If it is OFF, everything gets removed.
    if not Config.ESP then

        RemoveESP(player)

        return

    end

    local character =
        GetCharacter(player)

    if not character then

        RemoveESP(player)

        return

    end

    local humanoid =
        character:FindFirstChildOfClass(
            "Humanoid"
        )

    if not humanoid
        or humanoid.Health <= 0 then

        RemoveESP(player)

        return

    end

    local data =
        ESPObjects[player]

    if not data then

        CreateESP(player)

        data =
            ESPObjects[player]

    end

    if not data then
        return
    end

    --==================================================
    -- MODEL ESP STATE
    --==================================================

    if Config.ModelESP then

        if not data.Highlight then

            local highlight =
                Instance.new("Highlight")

            highlight.Name =
                "RivalsHub_ModelESP"

            highlight.Adornee =
                character

            highlight.FillColor =
                Colors.Blue

            highlight.OutlineColor =
                Colors.BlueSoft

            highlight.FillTransparency =
                0.78

            highlight.OutlineTransparency =
                0.15

            highlight.DepthMode =
                Enum.HighlightDepthMode.AlwaysOnTop

            highlight.Parent =
                character

            data.Highlight =
                highlight

        else

            data.Highlight.Adornee =
                character

        end

    elseif data.Highlight then

        data.Highlight:Destroy()
        data.Highlight = nil

    end

    --==================================================
    -- BOX STATE
    --==================================================

    if Config.Box then

        if not data.Box then

            local root =
                character:FindFirstChild(
                    "HumanoidRootPart"
                )

            if root then

                local box =
                    Instance.new(
                        "BoxHandleAdornment"
                    )

                box.Name =
                    "RivalsHub_Box"

                box.Adornee =
                    root

                box.AlwaysOnTop = true

                box.ZIndex = 5

                box.Transparency = 0.45

                box.Color3 =
                    Colors.Blue

                box.Size =
                    Vector3.new(
                        4,
                        6,
                        2
                    )

                box.Parent =
                    character

                data.Box =
                    box

            end

        end

    elseif data.Box then

        data.Box:Destroy()
        data.Box = nil

    end

    --==================================================
    -- INFO
    --==================================================

    local needsInfo =
        Config.Names
        or Config.Health
        or Config.Distance

    if not needsInfo then

        if data.Billboard then
            data.Billboard:Destroy()
        end

        data.Billboard = nil
        data.Info = nil

        return

    end

    local head =
        character:FindFirstChild(
            "Head"
        )

    if not head then
        return
    end

    if not data.Billboard
        or not data.Billboard.Parent then

        local billboard =
            Instance.new(
                "BillboardGui"
            )

        billboard.Name =
            "RivalsHub_Info"

        billboard.Adornee =
            head

        billboard.Size =
            UDim2.fromOffset(
                180,
                65
            )

        billboard.StudsOffset =
            Vector3.new(
                0,
                3,
                0
            )

        billboard.AlwaysOnTop = true

        billboard.Parent =
            character

        local Info =
            Instance.new("TextLabel")

        Info.Name =
            "Info"

        Info.Size =
            UDim2.fromScale(
                1,
                1
            )

        Info.BackgroundTransparency =
            1

        Info.TextColor3 =
            Colors.Text

        Info.TextStrokeTransparency =
            0.35

        Info.TextSize = 10

        Info.Font =
            Enum.Font.GothamBold

        Info.TextYAlignment =
            Enum.TextYAlignment.Center

        Info.Parent =
            billboard

        data.Billboard =
            billboard

        data.Info =
            Info

    end

    if data.Billboard then

        data.Billboard.Adornee =
            head

    end

    if data.Info then

        local lines = {}

        if Config.Names then

            table.insert(
                lines,
                player.DisplayName
            )

        end

        if Config.Health then

            table.insert(
                lines,
                "HP: "
                .. math.floor(
                    humanoid.Health
                )
                .. "/"
                .. math.floor(
                    humanoid.MaxHealth
                )
            )

        end

        if Config.Distance then

            local localRoot =
                GetRoot(LocalPlayer)

            local enemyRoot =
                GetRoot(player)

            if localRoot
                and enemyRoot then

                local distance =
                    (
                        localRoot.Position -
                        enemyRoot.Position
                    ).Magnitude

                table.insert(
                    lines,
                    "Distance: "
                    .. math.floor(
                        distance
                    )
                    .. "m"
                )

            end

        end

        data.Info.Text =
            table.concat(
                lines,
                "\n"
            )

    end

end

--==================================================
-- ESP LOOP
--==================================================

local ESPConnection

ESPConnection =
    RunService.RenderStepped:Connect(
        function()

            if not ScreenGui.Parent then
                return
            end

            -- HARD OFF.
            -- No ESP objects remain.
            if not Config.ESP then

                if next(ESPObjects) then
                    RemoveAllESP()
                end

                return

            end

            for _, player in ipairs(
                Players:GetPlayers()
            ) do

                if player ~= LocalPlayer then

                    UpdateESP(player)

                end

            end

        end
    )

--==================================================
-- PLAYER CONNECTIONS
--==================================================

local PlayerConnections = {}

local function ConnectPlayer(player)

    if player == LocalPlayer then
        return
    end

    PlayerConnections[player] =
        PlayerConnections[player]
        or {}

    table.insert(
        PlayerConnections[player],
        player.CharacterAdded:Connect(
            function()

                RemoveESP(player)

                task.wait(0.5)

                if Config.ESP then
                    CreateESP(player)
                end

            end
        )
    )

end

for _, player in ipairs(
    Players:GetPlayers()
) do

    ConnectPlayer(player)

end

Players.PlayerAdded:Connect(
    ConnectPlayer
)

Players.PlayerRemoving:Connect(
    function(player)

        RemoveESP(player)

        local connections =
            PlayerConnections[player]

        if connections then

            for _, connection in ipairs(
                connections
            ) do

                pcall(function()
                    connection:Disconnect()
                end)

            end

        end

        PlayerConnections[player] = nil

    end
)

--==================================================
-- MOVEMENT
--==================================================

local function UpdateMovement()

    local character =
        LocalPlayer.Character

    if not character then
        return
    end

    local humanoid =
        character:FindFirstChildOfClass(
            "Humanoid"
        )

    if not humanoid then
        return
    end

    if Config.Speed then

        humanoid.WalkSpeed =
            tonumber(
                Config.SpeedValue
            ) or 16

    else

        humanoid.WalkSpeed = 16

    end

    if Config.Jump then

        humanoid.UseJumpPower = true

        humanoid.JumpPower =
            tonumber(
                Config.JumpPower
            ) or 50

    else

        humanoid.UseJumpPower = true
        humanoid.JumpPower = 50

    end

end

--==================================================
-- NOCLIP
--==================================================

RunService.Stepped:Connect(
    function()

        if not Config.Noclip then
            return
        end

        local character =
            LocalPlayer.Character

        if not character then
            return
        end

        for _, object in ipairs(
            character:GetDescendants()
        ) do

            if object:IsA("BasePart") then
                object.CanCollide = false
            end

        end

    end
)

--==================================================
-- MOVEMENT LOOP
--==================================================

RunService.Heartbeat:Connect(
    function()

        if not ScreenGui.Parent then
            return
        end

        UpdateMovement()

    end
)

--==================================================
-- FOV LOOP
--==================================================

RunService.RenderStepped:Connect(
    function()

        if not ScreenGui.Parent then
            return
        end

        UpdateFOV()

    end
)

--==================================================
-- AIM ASSIST
--==================================================

local AimBindName =
    "RivalsHub_AimAssist"

pcall(function()

    RunService:UnbindFromRenderStep(
        AimBindName
    )

end)

RunService:BindToRenderStep(
    AimBindName,
    Enum.RenderPriority.Camera.Value + 1,
    function(deltaTime)

        if not ScreenGui.Parent then
            return
        end

        if not Config.AimAssist then
            return
        end

        local target =
            GetClosestTarget()

        if target then

            AimAtTarget(
                target,
                deltaTime
            )

        end

    end
)

--==================================================
-- CONFIG LIVE UPDATE
--==================================================

local LastESPState =
    Config.ESP

local LastModelESP =
    Config.ModelESP

local LastBox =
    Config.Box

local LastNames =
    Config.Names

local LastHealth =
    Config.Health

local LastDistance =
    Config.Distance

RunService.Heartbeat:Connect(
    function()

        if not ScreenGui.Parent then
            return
        end

        if LastESPState ~= Config.ESP then

            LastESPState =
                Config.ESP

            if not Config.ESP then
                RemoveAllESP()
            end

        end

        if Config.ESP
            and (
                LastModelESP ~= Config.ModelESP
                or LastBox ~= Config.Box
                or LastNames ~= Config.Names
                or LastHealth ~= Config.Health
                or LastDistance ~= Config.Distance
            ) then

            LastModelESP =
                Config.ModelESP

            LastBox =
                Config.Box

            LastNames =
                Config.Names

            LastHealth =
                Config.Health

            LastDistance =
                Config.Distance

            RemoveAllESP()

        end

    end
)

--==================================================
-- RESPAWN MOVEMENT RESET
--==================================================

LocalPlayer.CharacterAdded:Connect(
    function(character)

        task.wait(0.35)

        local humanoid =
            character:FindFirstChildOfClass(
                "Humanoid"
            )

        if humanoid then
            UpdateMovement()
        end

    end
)

--==================================================
-- CLEANUP
--==================================================

local CleanedUp = false

local function Cleanup()

    if CleanedUp then
        return
    end

    CleanedUp = true

    BackgroundAnimationRunning =
        false

    pcall(function()

        RunService:UnbindFromRenderStep(
            AimBindName
        )

    end)

    if FOVCircle then

        pcall(function()
            FOVCircle:Remove()
        end)

        FOVCircle = nil

    end

    RemoveAllESP()

    for player, connections in pairs(
        PlayerConnections
    ) do

        for _, connection in ipairs(
            connections
        ) do

            pcall(function()
                connection:Disconnect()
            end)

        end

        PlayerConnections[player] =
            nil

    end

    local character =
        LocalPlayer.Character

    if character then

        local humanoid =
            character:FindFirstChildOfClass(
                "Humanoid"
            )

        if humanoid then

            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50

        end

    end

end
