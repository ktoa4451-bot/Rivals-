--==================================================
-- RIVALS HUB v1.0
-- CLEAN UI REBUILD
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
    SquareBox = false,
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
    Background = Color3.fromRGB(12, 12, 14),
    Panel = Color3.fromRGB(17, 17, 20),
    Card = Color3.fromRGB(23, 23, 27),
    CardHover = Color3.fromRGB(31, 31, 36),

    Menu = Color3.fromRGB(45, 105, 245),
    MenuDark = Color3.fromRGB(20, 60, 145),

    Text = Color3.fromRGB(245, 245, 247),
    SubText = Color3.fromRGB(155, 155, 162),
    Muted = Color3.fromRGB(105, 105, 112),

    Border = Color3.fromRGB(55, 55, 62),

    On = Color3.fromRGB(45, 105, 245),
    Off = Color3.fromRGB(48, 48, 55),

    Ally = Color3.fromRGB(75, 145, 255),
    Enemy = Color3.fromRGB(255, 65, 65)
}

--==================================================
-- DESTROY OLD GUI
--==================================================

pcall(function()
    local old1 = CoreGui:FindFirstChild("NeutralizationHub")

    if old1 then
        old1:Destroy()
    end

    local old2 = CoreGui:FindFirstChild("LunarHub")

    if old2 then
        old2:Destroy()
    end
end)

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
        UDim.new(
            0,
            radius or 10
        )

    corner.Parent = object

    return corner
end

local function Stroke(
    object,
    color,
    thickness,
    transparency
)
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

local function Tween(
    object,
    info,
    properties
)
    local tween =
        TweenService:Create(
            object,
            info,
            properties
        )

    tween:Play()

    return tween
end

local function FastTween(
    object,
    properties,
    duration
)
    return Tween(
        object,
        TweenInfo.new(
            duration or 0.2,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        properties
    )
end

--==================================================
-- SCREEN GUI
--==================================================

local ScreenGui = New(
    "ScreenGui",
    {
        Name = "NeutralizationHub",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        ZIndexBehavior =
            Enum.ZIndexBehavior.Sibling
    }
)

pcall(function()
    ScreenGui.Parent = CoreGui
end)

if not ScreenGui.Parent then
    ScreenGui.Parent =
        LocalPlayer:WaitForChild(
            "PlayerGui"
        )
end

--==================================================
-- MAIN
--==================================================

local Main = New(
    "Frame",
    {
        Name = "Main",

        Size =
            UDim2.fromOffset(
                570,
                365
            ),

        Position =
            UDim2.new(
                0.5,
                -285,
                0.5,
                -182
            ),

        BackgroundColor3 =
            Colors.Background,

        BorderSizePixel = 0,

        ClipsDescendants = true,

        ZIndex = 10
    },
    ScreenGui
)

Corner(Main, 20)

Stroke(
    Main,
    Colors.Menu,
    1.5,
    0.15
)

local MainScale = New(
    "UIScale",
    {
        Scale = 0.78
    },
    Main
)

--==================================================
-- ANIMATED BACKGROUND
--==================================================

local Background = New(
    "Frame",
    {
        Name = "AnimatedBackground",

        Size =
            UDim2.fromScale(
                1,
                1
            ),

        BackgroundColor3 =
            Colors.Background,

        BorderSizePixel = 0,

        ClipsDescendants = true,

        ZIndex = 10
    },
    Main
)

Corner(Background, 20)

local Glow1 = New(
    "Frame",
    {
        Size =
            UDim2.fromOffset(
                260,
                260
            ),

        Position =
            UDim2.fromOffset(
                -120,
                -130
            ),

        BackgroundColor3 =
            Colors.MenuDark,

        BackgroundTransparency =
            0.72,

        BorderSizePixel = 0,

        ZIndex = 11
    },
    Background
)

Corner(Glow1, 999)

local Glow2 = New(
    "Frame",
    {
        Size =
            UDim2.fromOffset(
                240,
                240
            ),

        Position =
            UDim2.new(
                1,
                -100,
                1,
                -90
            ),

        BackgroundColor3 =
            Colors.Menu,

        BackgroundTransparency =
            0.84,

        BorderSizePixel = 0,

        ZIndex = 11
    },
    Background
)

Corner(Glow2, 999)

local Glow3 = New(
    "Frame",
    {
        Size =
            UDim2.fromOffset(
                150,
                150
            ),

        Position =
            UDim2.new(
                0.55,
                0,
                -70,
                0
            ),

        BackgroundColor3 =
            Colors.Menu,

        BackgroundTransparency =
            0.90,

        BorderSizePixel = 0,

        ZIndex = 11
    },
    Background
)

Corner(Glow3, 999)

task.spawn(function()

    while Main.Parent do

        FastTween(
            Glow1,
            {
                Position =
                    UDim2.fromOffset(
                        -45,
                        -75
                    ),

                BackgroundTransparency =
                    0.80
            },
            2.5
        )

        FastTween(
            Glow2,
            {
                Position =
                    UDim2.new(
                        1,
                        -165,
                        1,
                        -155
                    ),

                BackgroundTransparency =
                    0.90
            },
            2.5
        )

        FastTween(
            Glow3,
            {
                Position =
                    UDim2.new(
                        0.35,
                        0,
                        0,
                        35
                    ),

                BackgroundTransparency =
                    0.84
            },
            2.5
        )

        task.wait(2.5)

        FastTween(
            Glow1,
            {
                Position =
                    UDim2.fromOffset(
                        -120,
                        -130
                    ),

                BackgroundTransparency =
                    0.72
            },
            2.5
        )

        FastTween(
            Glow2,
            {
                Position =
                    UDim2.new(
                        1,
                        -100,
                        1,
                        -90
                    ),

                BackgroundTransparency =
                    0.84
            },
            2.5
        )

        FastTween(
            Glow3,
            {
                Position =
                    UDim2.new(
                        0.55,
                        0,
                        -70,
                        0
                    ),

                BackgroundTransparency =
                    0.90
            },
            2.5
        )

        task.wait(2.5)

    end

end)

--==================================================
-- TOP BAR
--==================================================

local TopBar = New(
    "Frame",
    {
        Name = "TopBar",

        Size =
            UDim2.new(
                1,
                -20,
                0,
                64
            ),

        Position =
            UDim2.fromOffset(
                10,
                10
            ),

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        ZIndex = 20
    },
    Main
)

--==================================================
-- LOGO
--==================================================

local Logo = New(
    "Frame",
    {
        Size =
            UDim2.fromOffset(
                50,
                50
            ),

        Position =
            UDim2.fromOffset(
                4,
                4
            ),

        BackgroundColor3 =
            Colors.Menu,

        BorderSizePixel = 0,

        ZIndex = 21
    },
    TopBar
)

Corner(Logo, 16)

Stroke(
    Logo,
    Colors.Menu,
    1,
    0.1
)

local LogoText = New(
    "TextLabel",
    {
        Size =
            UDim2.fromScale(
                1,
                1
            ),

        BackgroundTransparency = 1,

        Text = "N",

        TextColor3 =
            Colors.Text,

        TextSize = 23,

        Font =
            Enum.Font.GothamBold,

        ZIndex = 22
    },
    Logo
)

--==================================================
-- TITLE
--==================================================

local Title = New(
    "TextLabel",
    {
        Size =
            UDim2.new(
                1,
                -190,
                0,
                27
            ),

        Position =
            UDim2.fromOffset(
                66,
                4
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

        ZIndex = 21
    },
    TopBar
)

local Version = New(
    "TextLabel",
    {
        Size =
            UDim2.new(
                1,
                -190,
                0,
                18
            ),

        Position =
            UDim2.fromOffset(
                67,
                32
            ),

        BackgroundTransparency = 1,

        Text = Config.Version,

        TextColor3 =
            Colors.Menu,

        TextSize = 11,

        Font =
            Enum.Font.GothamSemibold,

        TextXAlignment =
            Enum.TextXAlignment.Left,

        ZIndex = 21
    },
    TopBar
)

--==================================================
-- MINIMIZE BUTTON
--==================================================

local MinimizeButton = New(
    "TextButton",
    {
        Size =
            UDim2.fromOffset(
                42,
                42
            ),

        Position =
            UDim2.new(
                1,
                -94,
                0,
                8
            ),

        BackgroundColor3 =
            Colors.Card,

        BorderSizePixel = 0,

        Text = "—",

        TextColor3 =
            Colors.Text,

        TextSize = 22,

        Font =
            Enum.Font.GothamBold,

        AutoButtonColor = false,

        ZIndex = 25
    },
    TopBar
)

Corner(
    MinimizeButton,
    13
)

Stroke(
    MinimizeButton,
    Colors.Border,
    1,
    0.15
)

--==================================================
-- CLOSE BUTTON
--==================================================

local CloseButton = New(
    "TextButton",
    {
        Size =
            UDim2.fromOffset(
                42,
                42
            ),

        Position =
            UDim2.new(
                1,
                -46,
                0,
                8
            ),

        BackgroundColor3 =
            Colors.Card,

        BorderSizePixel = 0,

        Text = "×",

        TextColor3 =
            Colors.Text,

        TextSize = 21,

        Font =
            Enum.Font.GothamBold,

        AutoButtonColor = false,

        ZIndex = 25
    },
    TopBar
)

Corner(
    CloseButton,
    13
)

Stroke(
    CloseButton,
    Colors.Border,
    1,
    0.15
)

--==================================================
-- BUTTON HOVER
--==================================================

local function ButtonHover(
    button,
    normal,
    hover
)

    button.MouseEnter:Connect(
        function()

            FastTween(
                button,
                {
                    BackgroundColor3 =
                        hover,

                    Size =
                        UDim2.fromOffset(
                            button.Size.X.Offset + 2,
                            button.Size.Y.Offset + 2
                        )
                },
                0.16
            )

        end
    )

    button.MouseLeave:Connect(
        function()

            FastTween(
                button,
                {
                    BackgroundColor3 =
                        normal,

                    Size =
                        UDim2.fromOffset(
                            button.Size.X.Offset - 2,
                            button.Size.Y.Offset - 2
                        )
                },
                0.16
            )

        end
    )

end

ButtonHover(
    MinimizeButton,
    Colors.Card,
    Colors.CardHover
)

ButtonHover(
    CloseButton,
    Colors.Card,
    Color3.fromRGB(
        55,
        75,
        125
    )
)

--==================================================
-- BODY
--==================================================

local Body = New(
    "Frame",
    {
        Name = "Body",

        Size =
            UDim2.new(
                1,
                -20,
                1,
                -88
            ),

        Position =
            UDim2.fromOffset(
                10,
                78
            ),

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        ZIndex = 20
    },
    Main
)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = New(
    "Frame",
    {
        Name = "Sidebar",

        Size =
            UDim2.new(
                0,
                165,
                1,
                0
            ),

        Position =
            UDim2.fromOffset(
                0,
                0
            ),

        BackgroundColor3 =
            Colors.Panel,

        BorderSizePixel = 0,

        ZIndex = 21
    },
    Body
)

Corner(
    Sidebar,
    16
)

Stroke(
    Sidebar,
    Colors.Border,
    1,
    0.35
)

local SidebarTitle = New(
    "TextLabel",
    {
        Size =
            UDim2.new(
                1,
                -24,
                0,
                25
            ),

        Position =
            UDim2.fromOffset(
                12,
                10
            ),

        BackgroundTransparency = 1,

        Text = "CATEGORIES",

        TextColor3 =
            Colors.Muted,

        TextSize = 10,

        Font =
            Enum.Font.GothamBold,

        TextXAlignment =
            Enum.TextXAlignment.Left,

        ZIndex = 22
    },
    Sidebar
)

local CategoryHolder = New(
    "Frame",
    {
        Size =
            UDim2.new(
                1,
                -16,
                1,
                -48
            ),

        Position =
            UDim2.fromOffset(
                8,
                40
            ),

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        ZIndex = 22
    },
    Sidebar
)

New(
    "UIListLayout",
    {
        Padding =
            UDim.new(
                0,
                8
            ),

        SortOrder =
            Enum.SortOrder.LayoutOrder
    },
    CategoryHolder
)

--==================================================
-- CONTENT
--==================================================

local Content = New(
    "Frame",
    {
        Name = "Content",

        Size =
            UDim2.new(
                1,
                -175,
                1,
                0
            ),

        Position =
            UDim2.fromOffset(
                175,
                0
            ),

        BackgroundColor3 =
            Colors.Panel,

        BorderSizePixel = 0,

        ClipsDescendants = true,

        ZIndex = 21
    },
    Body
)

Corner(
    Content,
    16
)

Stroke(
    Content,
    Colors.Border,
    1,
    0.35
)

--==================================================
-- PAGE HEADER
--==================================================

local PageHeader = New(
    "Frame",
    {
        Size =
            UDim2.new(
                1,
                -28,
                0,
                58
            ),

        Position =
            UDim2.fromOffset(
                14,
                12
            ),

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        ZIndex = 23
    },
    Content
)

local PageTitle = New(
    "TextLabel",
    {
        Size =
            UDim2.new(
                1,
                -10,
                0,
                28
            ),

        Position =
            UDim2.fromOffset(
                2,
                0
            ),

        BackgroundTransparency = 1,

        Text = "Combat",

        TextColor3 =
            Colors.Text,

        TextSize = 20,

        Font =
            Enum.Font.GothamBold,

        TextXAlignment =
            Enum.TextXAlignment.Left,

        ZIndex = 24
    },
    PageHeader
)

local PageDescription = New(
    "TextLabel",
    {
        Size =
            UDim2.new(
                1,
                -10,
                0,
                20
            ),

        Position =
            UDim2.fromOffset(
                2,
                31
            ),

        BackgroundTransparency = 1,

        Text =
            "Aim and combat functions",

        TextColor3 =
            Colors.SubText,

        TextSize = 11,

        Font =
            Enum.Font.Gotham,

        TextXAlignment =
            Enum.TextXAlignment.Left,

        ZIndex = 24
    },
    PageHeader
)

--==================================================
-- PAGES
--==================================================

local Pages = {}

local function CreatePage(name)

    local page = New(
        "ScrollingFrame",
        {
            Name = name,

            Size =
                UDim2.new(
                    1,
                    -28,
                    1,
                    -80
                ),

            Position =
                UDim2.fromOffset(
                    14,
                    72
                ),

            BackgroundTransparency = 1,

            BorderSizePixel = 0,

            ScrollBarThickness = 3,

            ScrollBarImageColor3 =
                Colors.Menu,

            CanvasSize =
                UDim2.new(
                    0,
                    0,
                    0,
                    0
                ),

            AutomaticCanvasSize =
                Enum.AutomaticSize.Y,

            ScrollingDirection =
                Enum.ScrollingDirection.Y,

            Visible = false,

            ClipsDescendants = true,

            ZIndex = 23
        },
        Content
    )

    Corner(page, 10)

    New(
        "UIPadding",
        {
            PaddingTop =
                UDim.new(0, 2),

            PaddingBottom =
                UDim.new(0, 12),

            PaddingLeft =
                UDim.new(0, 2),

            PaddingRight =
                UDim.new(0, 5)
        },
        page
    )

    New(
        "UIListLayout",
        {
            Padding =
                UDim.new(0, 9),

            SortOrder =
                Enum.SortOrder.LayoutOrder
        },
        page
    )

    Pages[name] = page

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

--==================================================
-- CATEGORY BUTTONS
--==================================================

local CategoryButtons = {}

local function CreateCategory(
    name,
    order
)

    local button = New(
        "TextButton",
        {
            Name =
                name .. "Button",

            Size =
                UDim2.new(
                    1,
                    0,
                    0,
                    48
                ),

            BackgroundColor3 =
                Colors.Card,

            BackgroundTransparency = 1,

            BorderSizePixel = 0,

            Text = "",

            AutoButtonColor = false,

            LayoutOrder = order,

            ZIndex = 23
        },
        CategoryHolder
    )

    Corner(button, 13)

    local Accent = New(
        "Frame",
        {
            Size =
                UDim2.fromOffset(
                    4,
                    26
                ),

            Position =
                UDim2.fromOffset(
                    7,
                    11
                ),

            BackgroundColor3 =
                Colors.Menu,

            BackgroundTransparency = 1,

            BorderSizePixel = 0,

            ZIndex = 24
        },
        button
    )

    Corner(Accent, 999)

    local Label = New(
        "TextLabel",
        {
            Size =
                UDim2.new(
                    1,
                    -28,
                    1,
                    0
                ),

            Position =
                UDim2.fromOffset(
                    20,
                    0
                ),

            BackgroundTransparency = 1,

            Text = name,

            TextColor3 =
                Colors.SubText,

            TextSize = 12,

            Font =
                Enum.Font.GothamSemibold,

            TextXAlignment =
                Enum.TextXAlignment.Left,

            ZIndex = 24
        },
        button
    )

    CategoryButtons[name] = {
        Button = button,
        Label = Label,
        Accent = Accent
    }

    return button
end

CreateCategory("Combat", 1)
CreateCategory("Visuals", 2)
CreateCategory("Movement", 3)
CreateCategory("Settings", 4)

--==================================================
-- PAGE DESCRIPTIONS
--==================================================

local PageDescriptions = {

    Combat =
        "Aim and combat functions",

    Visuals =
        "ESP and visual settings",

    Movement =
        "Movement and player settings",

    Settings =
        "Hub information and configuration"
}

local CurrentPage = nil

--==================================================
-- CATEGORY VISUAL
--==================================================

local function SetCategoryVisual(name)

    for category, data in pairs(
        CategoryButtons
    ) do

        if category == name then

            FastTween(
                data.Button,
                {
                    BackgroundColor3 =
                        Colors.MenuDark,

                    BackgroundTransparency =
                        0.05
                },
                0.22
            )

            FastTween(
                data.Label,
                {
                    TextColor3 =
                        Colors.Text
                },
                0.18
            )

            FastTween(
                data.Accent,
                {
                    BackgroundTransparency = 0
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
                        1
                },
                0.22
            )

            FastTween(
                data.Label,
                {
                    TextColor3 =
                        Colors.SubText
                },
                0.18
            )

            FastTween(
                data.Accent,
                {
                    BackgroundTransparency = 1
                },
                0.18
            )

        end

    end
end

--==================================================
-- COMBAT PAGE
--==================================================

CreateSection(
    CombatPage,
    "Combat",
    "Aim and targeting functions"
)

CreateToggle(
    CombatPage,
    "Aim Assist",
    "Automatically aims toward the closest enemy",
    "AimAssist"
)

CreateToggle(
    CombatPage,
    "Visible Only",
    "Ignore targets hidden behind objects",
    "VisibleOnly"
)

CreateToggle(
    CombatPage,
    "Aim FOV",
    "Limit targeting to the FOV circle",
    "AimFOV"
)

CreateValue(
    CombatPage,
    "FOV Size",
    "Size of the centered aim FOV",
    "FOVSize",
    25,
    500,
    5
)

CreateValue(
    CombatPage,
    "Smoothness",
    "Camera movement smoothing",
    "Smoothness",
    0.05,
    0.50,
    0.01
)

CreateSelector(
    CombatPage,
    "Target Part",
    "Body part selected by Aim Assist",
    "TargetPart",
    {
        "Head",
        "Body",
        "Random Part"
    }
)

--==================================================
-- VISUALS PAGE
--==================================================

CreateSection(
    VisualsPage,
    "Visuals",
    "ESP and player information"
)

CreateToggle(
    VisualsPage,
    "ESP",
    "Enable player ESP",
    "ESP"
)

CreateToggle(
    VisualsPage,
    "Model ESP",
    "Highlight player models",
    "ModelESP"
)

CreateToggle(
    VisualsPage,
    "Box",
    "Show a box around players",
    "SquareBox"
)

CreateToggle(
    VisualsPage,
    "Names",
    "Show player names",
    "Names"
)

CreateToggle(
    VisualsPage,
    "Health",
    "Show player health",
    "Health"
)

CreateToggle(
    VisualsPage,
    "Distance",
    "Show distance to players",
    "Distance"
)

--==================================================
-- MOVEMENT PAGE
--==================================================

CreateSection(
    MovementPage,
    "Movement",
    "Movement and player controls"
)

CreateToggle(
    MovementPage,
    "Speed",
    "Change player movement speed",
    "Speed"
)

CreateValue(
    MovementPage,
    "Speed Value",
    "Movement speed",
    "SpeedValue",
    16,
    100,
    1
)

CreateToggle(
    MovementPage,
    "Jump",
    "Change jump power",
    "Jump"
)

CreateValue(
    MovementPage,
    "Jump Power",
    "Player jump power",
    "JumpPower",
    50,
    150,
    5
)

CreateToggle(
    MovementPage,
    "Noclip",
    "Walk through physical objects",
    "Noclip"
)

--==================================================
-- SETTINGS PAGE
--==================================================

CreateSection(
    SettingsPage,
    "Settings",
    "Rivals Hub information"
)

local VersionCard = New(
    "TextLabel",
    {
        Size =
            UDim2.new(
                1,
                -2,
                0,
                52
            ),

        BackgroundColor3 =
            Colors.Card,

        BorderSizePixel = 0,

        Text =
            "Version: "
            .. Config.Version,

        TextColor3 =
            Colors.Text,

        TextSize = 11,

        Font =
            Enum.Font.GothamSemibold,

        TextXAlignment =
            Enum.TextXAlignment.Left,

        TextYAlignment =
            Enum.TextYAlignment.Center,

        ZIndex = 25
    },
    SettingsPage
)

Corner(
    VersionCard,
    12
)

Stroke(
    VersionCard,
    Colors.Border,
    1,
    0.5
)

local CreatorCard = New(
    "TextLabel",
    {
        Size =
            UDim2.new(
                1,
                -2,
                0,
                52
            ),

        BackgroundColor3 =
            Colors.Card,

        BorderSizePixel = 0,

        Text =
            "Creator: "
            .. Config.Creator,

        TextColor3 =
            Colors.Text,

        TextSize = 11,

        Font =
            Enum.Font.GothamSemibold,

        TextXAlignment =
            Enum.TextXAlignment.Left,

        TextYAlignment =
            Enum.TextYAlignment.Center,

        ZIndex = 25
    },
    SettingsPage
)

Corner(
    CreatorCard,
    12
)

Stroke(
    CreatorCard,
    Colors.Border,
    1,
    0.5
)

--==================================================
-- TELEGRAM
--==================================================

CreateSection(
    SettingsPage,
    "Telegram",
    "Lunar Hub community"
)

local TelegramButton = New(
    "TextButton",
    {
        Size =
            UDim2.new(
                1,
                -2,
                0,
                50
            ),

        BackgroundColor3 =
            Colors.Menu,

        BorderSizePixel = 0,

        Text =
            "Telegram  •  @lunarhub_script",

        TextColor3 =
            Colors.Text,

        TextSize = 11,

        Font =
            Enum.Font.GothamSemibold,

        AutoButtonColor = false,

        ZIndex = 25
    },
    SettingsPage
)

Corner(
    TelegramButton,
    12
)

Stroke(
    TelegramButton,
    Colors.Border,
    1,
    0.2
)

TelegramButton.MouseEnter:Connect(
    function()

        FastTween(
            TelegramButton,
            {
                BackgroundColor3 =
                    Colors.MenuDark
            },
            0.15
        )

    end
)

TelegramButton.MouseLeave:Connect(
    function()

        FastTween(
            TelegramButton,
            {
                BackgroundColor3 =
                    Colors.Menu
            },
            0.15
        )

    end
)

TelegramButton.MouseButton1Click:Connect(
    function()

        local url =
            "https://t.me/lunarhub_script"

        pcall(
            function()

                if setclipboard then
                    setclipboard(url)
                end

            end
        )

        TelegramButton.Text =
            "Telegram link copied!"

        task.delay(
            1.5,
            function()

                if TelegramButton.Parent then

                    TelegramButton.Text =
                        "Telegram  •  @lunarhub_script"

                end

            end
        )

    end
)

--==================================================
-- STATUS
--==================================================

local StatusCard = New(
    "Frame",
    {
        Size =
            UDim2.new(
                1,
                -2,
                0,
                58
            ),

        BackgroundColor3 =
            Colors.Card,

        BorderSizePixel = 0,

        ZIndex = 25
    },
    SettingsPage
)

Corner(
    StatusCard,
    12
)

Stroke(
    StatusCard,
    Colors.Border,
    1,
    0.5
)

local StatusDot = New(
    "Frame",
    {
        Size =
            UDim2.fromOffset(
                10,
                10
            ),

        Position =
            UDim2.fromOffset(
                14,
                24
            ),

        BackgroundColor3 =
            Color3.fromRGB(
                75,
                220,
                110
            ),

        BorderSizePixel = 0,

        ZIndex = 27
    },
    StatusCard
)

Corner(
    StatusDot,
    999
)

local StatusTitle = New(
    "TextLabel",
    {
        Size =
            UDim2.new(
                1,
                -45,
                0,
                20
            ),

        Position =
            UDim2.fromOffset(
                32,
                8
            ),

        BackgroundTransparency = 1,

        Text = "Status",

        TextColor3 =
            Colors.Text,

        TextSize = 11,

        Font =
            Enum.Font.GothamSemibold,

        TextXAlignment =
            Enum.TextXAlignment.Left,

        ZIndex = 27
    },
    StatusCard
)

local StatusText = New(
    "TextLabel",
    {
        Size =
            UDim2.new(
                1,
                -45,
                0,
                18
            ),

        Position =
            UDim2.fromOffset(
                32,
                29
            ),

        BackgroundTransparency = 1,

        Text =
            "Rivals Hub is running",

        TextColor3 =
            Colors.SubText,

        TextSize = 9,

        Font =
            Enum.Font.Gotham,

        TextXAlignment =
            Enum.TextXAlignment.Left,

        ZIndex = 27
    },
    StatusCard
)

--==================================================
-- PAGE SWITCH
--==================================================

local function SwitchPage(name)

    local newPage =
        Pages[name]

    if not newPage then
        return
    end

    if CurrentPage == name then
        return
    end

    local oldPage =
        CurrentPage
        and Pages[CurrentPage]
        or nil

    CurrentPage = name

    PageTitle.Text =
        name

    PageDescription.Text =
        PageDescriptions[name]

    SetCategoryVisual(name)

    newPage.Position =
        UDim2.fromOffset(
            35,
            72
        )

    newPage.Visible = true

    Tween(
        newPage,
        TweenInfo.new(
            0.30,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        {
            Position =
                UDim2.fromOffset(
                    14,
                    72
                )
        }
    )

    if oldPage
        and oldPage ~= newPage then

        Tween(
            oldPage,
            TweenInfo.new(
                0.20,
                Enum.EasingStyle.Quint,
                Enum.EasingDirection.In
            ),
            {
                Position =
                    UDim2.fromOffset(
                        -20,
                        72
                    )
            }
        )

        task.delay(
            0.21,
            function()

                if oldPage.Parent
                    and CurrentPage ~= oldPage.Name then

                    oldPage.Visible = false

                    oldPage.Position =
                        UDim2.fromOffset(
                            14,
                            72
                        )

                end

            end
        )

    end

end

--==================================================
-- CATEGORY CLICKS
--==================================================

for name, data in pairs(
    CategoryButtons
) do

    data.Button.MouseButton1Click:Connect(
        function()
            SwitchPage(name)
        end
    )

end

--==================================================
-- INITIAL PAGE
--==================================================

SwitchPage("Combat")

--==================================================
-- END PAGES BLOCK
--==================================================

--==================================================
-- RIVALS HUB v1.0
-- PART 3/4
-- WINDOW CONTROLS + AIM + ESP + MOVEMENT
--==================================================

--==================================================
-- FLOATING RESTORE BUTTON
--==================================================

local FloatingButton = New("TextButton", {
    Name = "Rivals_Floating",
    Parent = ScreenGui,
    Size = UDim2.fromOffset(40, 40),
    Position = UDim2.new(0, 20, 0.5, -20),
    BackgroundColor3 = Colors.Background,
    BackgroundTransparency = 0.05,
    BorderSizePixel = 0,
    Text = "R",
    TextColor3 = Colors.Text,
    TextSize = 19,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = false,
    Visible = false
})

local FloatingCorner = New("UICorner", {
    CornerRadius = UDim.new(1, 0),
    Parent = FloatingButton
})

local FloatingStroke = New("UIStroke", {
    Color = Colors.Menu,
    Thickness = 1.5,
    Transparency = 0.15,
    Parent = FloatingButton
})

local FloatingScale = New("UIScale", {
    Scale = 1,
    Parent = FloatingButton
})

-- Floating button hover
FloatingButton.MouseEnter:Connect(function()
    Tween(FloatingScale, {
        Scale = 1.08
    }, 0.15)
end)

FloatingButton.MouseLeave:Connect(function()
    Tween(FloatingScale, {
        Scale = 1
    }, 0.15)
end)

--==================================================
-- WINDOW STATE
--==================================================

local IsMinimized = false
local IsClosed = false

local function SetWindowVisible(visible)
    TopBar.Visible = visible
    Body.Visible = visible
end

local function MinimizeMenu()
    if IsMinimized or IsClosed then
        return
    end

    IsMinimized = true

    -- Hide only the actual menu contents.
    -- Background/Glow stay alive for a smooth animation.
    local objects = {
        TopBar,
        Body,
        Sidebar,
        Content,
        PageHeader,
        Pages
    }

    for _, object in ipairs(objects) do
        if object then
            object.Visible = false
        end
    end

    FloatingButton.Visible = true

    FloatingButton.Position = UDim2.new(
        0,
        Main.Position.X.Offset + Main.Size.X.Offset / 2 - 20,
        0,
        Main.Position.Y.Offset + Main.Size.Y.Offset / 2 - 20
    )

    FloatingScale.Scale = 0.7

    Tween(FloatingScale, {
        Scale = 1
    }, 0.25, Enum.EasingStyle.Back)

    Tween(Background, {
        BackgroundTransparency = 0.35
    }, 0.2)

    Tween(Glow, {
        ImageTransparency = 0.15
    }, 0.2)
end

local function RestoreMenu()
    if not IsMinimized or IsClosed then
        return
    end

    IsMinimized = false

    FloatingScale.Scale = 0.8

    Tween(FloatingScale, {
        Scale = 0
    }, 0.18)

    task.delay(0.12, function()
        FloatingButton.Visible = false

        TopBar.Visible = true
        Body.Visible = true
        Sidebar.Visible = true
        Content.Visible = true
        PageHeader.Visible = true
        Pages.Visible = true

        Tween(Background, {
            BackgroundTransparency = 0.08
        }, 0.2)

        Tween(Glow, {
            ImageTransparency = 0.35
        }, 0.2)
    end)
end

local function CloseMenu()
    if IsClosed then
        return
    end

    IsClosed = true

    Tween(MainScale, {
        Scale = 0.85
    }, 0.2, Enum.EasingStyle.Quad)

    Tween(Main, {
        BackgroundTransparency = 1
    }, 0.2)

    Tween(Glow, {
        ImageTransparency = 1
    }, 0.2)

    task.delay(0.2, function()
        ScreenGui.Enabled = false
    end)
end

local function ReopenMenu()
    if not IsClosed then
        return
    end

    IsClosed = false
    ScreenGui.Enabled = true

    MainScale.Scale = 0.85
    Main.BackgroundTransparency = 1
    Glow.ImageTransparency = 1

    Tween(MainScale, {
        Scale = 1
    }, 0.3, Enum.EasingStyle.Back)

    Tween(Main, {
        BackgroundTransparency = 0
    }, 0.25)

    Tween(Glow, {
        ImageTransparency = 0.35
    }, 0.25)
end

--==================================================
-- TOPBAR BUTTONS
--==================================================

MinimizeButton.MouseButton1Click:Connect(function()
    MinimizeMenu()
end)

CloseButton.MouseButton1Click:Connect(function()
    CloseMenu()
end)

FloatingButton.MouseButton1Click:Connect(function()
    RestoreMenu()
end)

--==================================================
-- FOV CIRCLE
--==================================================

local FOVCircle = New("Frame", {
    Name = "AimFOV",
    Parent = ScreenGui,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(Config.FOVSize * 2, Config.FOVSize * 2),
    BackgroundTransparency = 1,
    Visible = false
})

local FOVCorner = New("UICorner", {
    CornerRadius = UDim.new(1, 0),
    Parent = FOVCircle
})

local FOVStroke = New("UIStroke", {
    Color = Colors.Menu,
    Thickness = 1.5,
    Transparency = 0.15,
    Parent = FOVCircle
})

local function UpdateFOV()
    if not FOVCircle then
        return
    end

    FOVCircle.Size = UDim2.fromOffset(
        Config.FOVSize * 2,
        Config.FOVSize * 2
    )

    FOVCircle.Position = UDim2.fromScale(0.5, 0.5)
end

local function UpdateFOVVisibility()
    if not FOVCircle then
        return
    end

    FOVCircle.Visible =
        Config.AimFOV == true
        and Config.AimAssist == true
        and not IsMinimized
        and not IsClosed
end

UpdateFOV()

--==================================================
-- CAMERA CENTER
--==================================================

local function GetScreenCenter()
    local camera = workspace.CurrentCamera

    if not camera then
        return Vector2.new(0, 0)
    end

    local viewport = camera.ViewportSize

    return Vector2.new(
        viewport.X / 2,
        viewport.Y / 2
    )
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
    end

    if Config.TargetPart == "Body" then
        return character:FindFirstChild("HumanoidRootPart")
            or character:FindFirstChild("UpperTorso")
            or character:FindFirstChild("Torso")
    end

    if Config.TargetPart == "Random Part" then
        local parts = {}

        for _, object in ipairs(character:GetChildren()) do
            if object:IsA("BasePart") then
                table.insert(parts, object)
            end
        end

        if #parts > 0 then
            return parts[math.random(1, #parts)]
        end
    end

    return character:FindFirstChild("Head")
        or character:FindFirstChild("HumanoidRootPart")
end

--==================================================
-- PLAYER CHECKS
--==================================================

local function IsAlive(player)
    if not player then
        return false
    end

    local character = player.Character

    if not character then
        return false
    end

    local humanoid = character:FindFirstChildOfClass("Humanoid")

    return humanoid ~= nil
        and humanoid.Health > 0
end

local function IsFriendly(player)
    if not player then
        return true
    end

    if LocalPlayer.Team ~= nil
        and player.Team ~= nil
        and LocalPlayer.Team == player.Team then

        return true
    end

    return false
end

local function IsVisible(character, part)
    if not Config.VisibleOnly then
        return true
    end

    local camera = workspace.CurrentCamera

    if not camera or not part then
        return false
    end

    local origin = camera.CFrame.Position
    local direction = part.Position - origin

    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {
        LocalPlayer.Character,
        character
    }

    local result = workspace:Raycast(
        origin,
        direction,
        params
    )

    return result == nil
end

--==================================================
-- FIND BEST TARGET
--==================================================

local function GetBestTarget()
    local camera = workspace.CurrentCamera

    if not camera then
        return nil
    end

    local center = GetScreenCenter()
    local bestTarget = nil
    local bestDistance = math.huge

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer
            and IsAlive(player)
            and not IsFriendly(player) then

            local character = player.Character
            local part = GetTargetPart(character)

            if part and IsVisible(character, part) then
                local screenPosition, onScreen =
                    camera:WorldToViewportPoint(part.Position)

                if onScreen then
                    local screenPoint = Vector2.new(
                        screenPosition.X,
                        screenPosition.Y
                    )

                    local distance =
                        (screenPoint - center).Magnitude

                    local insideFOV =
                        (not Config.AimFOV)
                        or distance <= Config.FOVSize

                    if insideFOV and distance < bestDistance then
                        bestDistance = distance
                        bestTarget = part
                    end
                end
            end
        end
    end

    return bestTarget
end

--==================================================
-- AIM ASSIST
--==================================================

local AimConnection = nil

local function StartAimAssist()
    if AimConnection then
        return
    end

    AimConnection = RunService.RenderStepped:Connect(function()
        if IsClosed or IsMinimized then
            return
        end

        if not Config.AimAssist then
            return
        end

        local camera = workspace.CurrentCamera

        if not camera then
            return
        end

        local target = GetBestTarget()

        if not target then
            return
        end

        local targetPosition = target.Position
        local cameraPosition = camera.CFrame.Position

        local desiredCFrame =
            CFrame.lookAt(
                cameraPosition,
                targetPosition
            )

        local smoothness = math.clamp(
            Config.Smoothness,
            0.01,
            1
        )

        camera.CFrame =
            camera.CFrame:Lerp(
                desiredCFrame,
                smoothness
            )
    end)
end

local function StopAimAssist()
    if AimConnection then
        AimConnection:Disconnect()
        AimConnection = nil
    end
end

StartAimAssist()

--==================================================
-- ESP
--==================================================

local ESPObjects = {}

local function RemoveESP(player)
    local data = ESPObjects[player]

    if not data then
        return
    end

    if data.Highlight then
        data.Highlight:Destroy()
    end

    if data.Box then
        data.Box:Destroy()
    end

    if data.Name then
        data.Name:Destroy()
    end

    ESPObjects[player] = nil
end

local function CreateESP(player)
    if player == LocalPlayer then
        return
    end

    if ESPObjects[player] then
        return
    end

    local box = New("BoxHandleAdornment", {
        Name = "RivalsESPBox",
        Parent = CoreGui,
        Size = Vector3.new(4, 6, 2),
        Color3 = Colors.Menu,
        Transparency = 0.35,
        AlwaysOnTop = true,
        ZIndex = 5,
        Visible = false
    })

    local highlight = New("Highlight", {
        Name = "RivalsESPHighlight",
        Parent = CoreGui,
        FillColor = Colors.Menu,
        FillTransparency = 0.75,
        OutlineColor = Colors.Menu,
        OutlineTransparency = 0,
        Enabled = false
    })

    ESPObjects[player] = {
        Box = box,
        Highlight = highlight
    }
end

for _, player in ipairs(Players:GetPlayers()) do
    CreateESP(player)
end

Players.PlayerAdded:Connect(function(player)
    CreateESP(player)
end)

Players.PlayerRemoving:Connect(function(player)
    RemoveESP(player)
end)

local function UpdateESP()
    for player, data in pairs(ESPObjects) do
        if not Config.ESP then
            data.Box.Visible = false
            data.Highlight.Enabled = false

            continue
        end

        if not IsAlive(player) then
            data.Box.Visible = false
            data.Highlight.Enabled = false

            continue
        end

        if IsFriendly(player) then
            data.Box.Visible = false
            data.Highlight.Enabled = false

            continue
        end

        local character = player.Character

        if not character then
            data.Box.Visible = false
            data.Highlight.Enabled = false

            continue
        end

        local root =
            character:FindFirstChild("HumanoidRootPart")
            or character:FindFirstChild("UpperTorso")
            or character:FindFirstChild("Torso")

        if not root then
            data.Box.Visible = false
            data.Highlight.Enabled = false

            continue
        end

        data.Box.Adornee = root
        data.Box.Visible = Config.SquareBox == true

        data.Highlight.Adornee = character
        data.Highlight.Enabled = Config.ModelESP == true
    end
end

RunService.RenderStepped:Connect(function()
    UpdateESP()
end)

--==================================================
-- MOVEMENT
--==================================================

local OriginalMovement = {}

local function SaveOriginalMovement(humanoid)
    if not humanoid then
        return
    end

    if OriginalMovement[humanoid] then
        return
    end

    OriginalMovement[humanoid] = {
        WalkSpeed = humanoid.WalkSpeed,
        UseJumpPower = humanoid.UseJumpPower,
        JumpPower = humanoid.JumpPower,
        JumpHeight = humanoid.JumpHeight
    }
end

local function RestoreMovement(humanoid)
    local original = OriginalMovement[humanoid]

    if not original then
        return
    end

    humanoid.WalkSpeed = original.WalkSpeed
    humanoid.UseJumpPower = original.UseJumpPower
    humanoid.JumpPower = original.JumpPower
    humanoid.JumpHeight = original.JumpHeight
end

local function UpdateMovement()
    local character = LocalPlayer.Character

    if not character then
        return
    end

    local humanoid =
        character:FindFirstChildOfClass("Humanoid")

    if not humanoid then
        return
    end

    SaveOriginalMovement(humanoid)

    if Config.Speed then
        humanoid.WalkSpeed = Config.SpeedValue
    else
        humanoid.WalkSpeed =
            OriginalMovement[humanoid].WalkSpeed
    end

    if Config.Jump then
        humanoid.UseJumpPower = true
        humanoid.JumpPower = Config.JumpPower
    else
        RestoreMovement(humanoid)
    end
end

LocalPlayer.CharacterAdded:Connect(function(character)
    task.wait(0.5)

    local humanoid =
        character:FindFirstChildOfClass("Humanoid")

    if humanoid then
        SaveOriginalMovement(humanoid)
        UpdateMovement()
    end
end)

RunService.Heartbeat:Connect(function()
    UpdateMovement()
end)

--==================================================
-- NOCLIP
--==================================================

RunService.Stepped:Connect(function()
    if not Config.Noclip then
        return
    end

    local character = LocalPlayer.Character

    if not character then
        return
    end

    for _, object in ipairs(character:GetDescendants()) do
        if object:IsA("BasePart") then
            object.CanCollide = false
        end
    end
end)

--==================================================
-- FOV UPDATE LOOP
--==================================================

RunService.RenderStepped:Connect(function()
    UpdateFOV()
    UpdateFOVVisibility()
end)

--==================================================
-- CONFIG CHANGE CONNECTIONS
--==================================================

task.spawn(function()
    while task.wait(0.1) do
        if IsClosed then
            break
        end

        UpdateFOV()
        UpdateFOVVisibility()
        UpdateMovement()
    end
end)

--==================================================
-- END PART 3/4
--==================================================

--==================================================
-- RIVALS HUB v1.0
-- PART 4/4
-- FINAL ANIMATIONS + DRAG + STARTUP
--==================================================

--==================================================
-- DRAG SYSTEM
--==================================================

local UserInputService = game:GetService("UserInputService")

local Dragging = false
local DragStart = nil
local StartPosition = nil

local function UpdateDrag(input)
    if not DragStart or not StartPosition then
        return
    end

    local delta = input.Position - DragStart

    Main.Position = UDim2.new(
        StartPosition.X.Scale,
        StartPosition.X.Offset + delta.X,
        StartPosition.Y.Scale,
        StartPosition.Y.Offset + delta.Y
    )
end

local function StartDrag(input)
    if IsMinimized or IsClosed then
        return
    end

    Dragging = true
    DragStart = input.Position
    StartPosition = Main.Position
end

local function StopDrag()
    Dragging = false
    DragStart = nil
    StartPosition = nil
end

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        StartDrag(input)
    end
end)

TopBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        StopDrag()
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
-- BUTTON HOVER ANIMATIONS
--==================================================

local function AddButtonAnimation(button)
    if not button then
        return
    end

    local scale = button:FindFirstChildOfClass("UIScale")

    if not scale then
        scale = New("UIScale", {
            Scale = 1,
            Parent = button
        })
    end

    button.MouseEnter:Connect(function()
        Tween(scale, {
            Scale = 1.04
        }, 0.12)
    end)

    button.MouseLeave:Connect(function()
        Tween(scale, {
            Scale = 1
        }, 0.12)
    end)

    button.MouseButton1Down:Connect(function()
        Tween(scale, {
            Scale = 0.96
        }, 0.08)
    end)

    button.MouseButton1Up:Connect(function()
        Tween(scale, {
            Scale = 1.04
        }, 0.08)
    end)
end

AddButtonAnimation(MinimizeButton)
AddButtonAnimation(CloseButton)
AddButtonAnimation(FloatingButton)

for _, button in pairs(CategoryButtons) do
    AddButtonAnimation(button)
end

--==================================================
-- TOGGLE CALLBACKS
--==================================================

local function RefreshFeatures()
    UpdateFOV()
    UpdateFOVVisibility()
    UpdateMovement()
    UpdateESP()
end

--==================================================
-- INITIAL FEATURE STATE
--==================================================

task.spawn(function()
    task.wait(0.2)

    RefreshFeatures()

    if Config.AimAssist then
        StartAimAssist()
    else
        StopAimAssist()
    end
end)

--==================================================
-- FEATURE STATE MONITOR
--==================================================

local LastAimAssist = Config.AimAssist
local LastESP = Config.ESP
local LastSpeed = Config.Speed
local LastJump = Config.Jump
local LastNoclip = Config.Noclip
local LastAimFOV = Config.AimFOV

RunService.RenderStepped:Connect(function()
    -- Aim Assist
    if Config.AimAssist ~= LastAimAssist then
        LastAimAssist = Config.AimAssist

        if Config.AimAssist then
            StartAimAssist()
        else
            StopAimAssist()
        end

        UpdateFOVVisibility()
    end

    -- ESP
    if Config.ESP ~= LastESP then
        LastESP = Config.ESP

        if not Config.ESP then
            for _, data in pairs(ESPObjects) do
                if data.Box then
                    data.Box.Visible = false
                end

                if data.Highlight then
                    data.Highlight.Enabled = false
                end
            end
        end

        UpdateESP()
    end

    -- Speed
    if Config.Speed ~= LastSpeed then
        LastSpeed = Config.Speed
        UpdateMovement()
    end

    -- Jump
    if Config.Jump ~= LastJump then
        LastJump = Config.Jump
        UpdateMovement()
    end

    -- Noclip
    if Config.Noclip ~= LastNoclip then
        LastNoclip = Config.Noclip
    end

    -- Aim FOV
    if Config.AimFOV ~= LastAimFOV then
        LastAimFOV = Config.AimFOV
        UpdateFOVVisibility()
    end
end)

--==================================================
-- FOV CENTER UPDATE
--==================================================

workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    task.wait()

    UpdateFOV()
end)

RunService.RenderStepped:Connect(function()
    if not FOVCircle then
        return
    end

    local camera = workspace.CurrentCamera

    if not camera then
        return
    end

    local viewport = camera.ViewportSize

    FOVCircle.Position = UDim2.fromOffset(
        viewport.X / 2,
        viewport.Y / 2
    )
end)

--==================================================
-- CHARACTER CLEANUP
--==================================================

LocalPlayer.CharacterRemoving:Connect(function(character)
    local humanoid =
        character:FindFirstChildOfClass("Humanoid")

    if humanoid then
        OriginalMovement[humanoid] = nil
    end
end)

--==================================================
-- SETTINGS STATUS
--==================================================

task.spawn(function()
    while task.wait(1) do
        if IsClosed then
            break
        end

        if StatusLabel then
            StatusLabel.Text = "● Rivals Hub is running"
        end
    end
end)

--==================================================
-- STARTUP ANIMATION
--==================================================

ScreenGui.Enabled = true

MainScale.Scale = 0.82
Main.BackgroundTransparency = 1
Glow.ImageTransparency = 1

if TopBar then
    TopBar.BackgroundTransparency = 1
end

if Body then
    Body.BackgroundTransparency = 1
end

task.wait(0.05)

Tween(MainScale, {
    Scale = 1
}, 0.45, Enum.EasingStyle.Back)

Tween(Main, {
    BackgroundTransparency = 0
}, 0.35)

Tween(Glow, {
    ImageTransparency = 0.35
}, 0.4)

task.delay(0.08, function()
    if TopBar then
        Tween(TopBar, {
            BackgroundTransparency = 0
        }, 0.25)
    end
end)

task.delay(0.12, function()
    if Body then
        Tween(Body, {
            BackgroundTransparency = 0
        }, 0.3)
    end
end)

--==================================================
-- FINAL SAFETY
--==================================================

UpdateFOV()
UpdateFOVVisibility()
UpdateMovement()
UpdateESP()

--==================================================
-- RIVALS HUB READY
--==================================================

print("Rivals Hub v1.0 loaded successfully.")

--==================================================
-- END PART 4/4
--==================================================
