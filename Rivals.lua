--========================================================
-- RIVALS HUB v1.0
-- PART 1/4
-- UI / MENU / ANIMATED BACKGROUND
--========================================================

--========================================================
-- SERVICES
--========================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--========================================================
-- CONFIG
--========================================================

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
    Noclip = false,

    -- Silent Aim UI settings
    SilentAim = false,
    SilentAimPart = "Head",
    SilentAimChance = 100,
    SilentAimFOV = 250
}

--========================================================
-- COLORS
--========================================================

local Colors = {
    Background = Color3.fromRGB(10, 11, 14),
    Panel = Color3.fromRGB(16, 17, 21),
    Card = Color3.fromRGB(22, 23, 28),
    CardHover = Color3.fromRGB(30, 31, 38),

    Accent = Color3.fromRGB(65, 125, 255),
    AccentDark = Color3.fromRGB(35, 75, 170),

    Text = Color3.fromRGB(245, 246, 250),
    SubText = Color3.fromRGB(155, 158, 168),
    Muted = Color3.fromRGB(95, 98, 108),

    Border = Color3.fromRGB(48, 51, 61),

    On = Color3.fromRGB(65, 125, 255),
    Off = Color3.fromRGB(47, 48, 56)
}

--========================================================
-- REMOVE OLD MENU
--========================================================

pcall(function()
    local old = PlayerGui:FindFirstChild("RivalsHub")

    if old then
        old:Destroy()
    end
end)

pcall(function()
    local core = game:GetService("CoreGui")

    for _, name in ipairs({
        "RivalsHub",
        "NeutralizationHub",
        "LunarHub"
    }) do
        local old = core:FindFirstChild(name)

        if old then
            old:Destroy()
        end
    end
end)

--========================================================
-- HELPERS
--========================================================

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
    corner.CornerRadius = UDim.new(0, radius or 10)
    corner.Parent = object
    return corner
end

local function Stroke(object, color, thickness, transparency)
    local stroke = Instance.new("UIStroke")

    stroke.Color = color or Colors.Border
    stroke.Thickness = thickness or 1
    stroke.Transparency = transparency or 0

    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = object

    return stroke
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
            duration or 0.2,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        properties
    )
end

--========================================================
-- SCREEN GUI
--========================================================

local ScreenGui = New("ScreenGui", {
    Name = "RivalsHub",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 999
}, PlayerGui)

--========================================================
-- MAIN HOLDER
--========================================================

local Holder = New("Frame", {
    Name = "Holder",

    Size = UDim2.fromOffset(720, 470),

    Position = UDim2.new(
        0.5,
        -360,
        0.5,
        -235
    ),

    BackgroundTransparency = 1,
    BorderSizePixel = 0,

    ZIndex = 10
}, ScreenGui)

local HolderScale = New("UIScale", {
    Scale = 0.84
}, Holder)

--========================================================
-- MAIN
--========================================================

local Main = New("Frame", {
    Name = "Main",

    Size = UDim2.fromScale(1, 1),
    Position = UDim2.fromScale(0, 0),

    BackgroundColor3 = Colors.Background,
    BackgroundTransparency = 0,

    BorderSizePixel = 0,

    ClipsDescendants = true,

    ZIndex = 10
}, Holder)

Corner(Main, 22)
Stroke(Main, Colors.Accent, 1.5, 0.35)

--========================================================
-- ANIMATED BACKGROUND
--========================================================

local Background = New("Frame", {
    Name = "AnimatedBackground",

    Size = UDim2.fromScale(1, 1),
    Position = UDim2.fromScale(0, 0),

    BackgroundColor3 = Colors.Background,

    BackgroundTransparency = 0,

    BorderSizePixel = 0,

    ClipsDescendants = true,

    ZIndex = 11
}, Main)

Corner(Background, 22)

--========================================================
-- BACKGROUND LIGHT 1
--========================================================

local Light1 = New("Frame", {
    Size = UDim2.fromOffset(320, 320),

    Position = UDim2.fromOffset(
        -170,
        -170
    ),

    BackgroundColor3 = Colors.AccentDark,
    BackgroundTransparency = 0.82,

    BorderSizePixel = 0,

    ZIndex = 12
}, Background)

Corner(Light1, 999)

--========================================================
-- BACKGROUND LIGHT 2
--========================================================

local Light2 = New("Frame", {
    Size = UDim2.fromOffset(280, 280),

    Position = UDim2.new(
        1,
        -100,
        1,
        -110
    ),

    BackgroundColor3 = Colors.Accent,
    BackgroundTransparency = 0.88,

    BorderSizePixel = 0,

    ZIndex = 12
}, Background)

Corner(Light2, 999)

--========================================================
-- BACKGROUND LIGHT 3
--========================================================

local Light3 = New("Frame", {
    Size = UDim2.fromOffset(210, 210),

    Position = UDim2.new(
        0.55,
        0,
        -100,
        0
    ),

    BackgroundColor3 = Colors.Accent,
    BackgroundTransparency = 0.92,

    BorderSizePixel = 0,

    ZIndex = 12
}, Background)

Corner(Light3, 999)

--========================================================
-- BACKGROUND ANIMATION
--========================================================

local BackgroundRunning = true

task.spawn(function()
    while BackgroundRunning and Main.Parent do

        FastTween(
            Light1,
            {
                Position = UDim2.fromOffset(
                    -60,
                    -80
                ),

                BackgroundTransparency = 0.88
            },
            3
        )

        FastTween(
            Light2,
            {
                Position = UDim2.new(
                    1,
                    -190,
                    1,
                    -180
                ),

                BackgroundTransparency = 0.93
            },
            3
        )

        FastTween(
            Light3,
            {
                Position = UDim2.new(
                    0.35,
                    0,
                    0,
                    45
                ),

                BackgroundTransparency = 0.86
            },
            3
        )

        task.wait(3)

        FastTween(
            Light1,
            {
                Position = UDim2.fromOffset(
                    -170,
                    -170
                ),

                BackgroundTransparency = 0.82
            },
            3
        )

        FastTween(
            Light2,
            {
                Position = UDim2.new(
                    1,
                    -100,
                    1,
                    -110
                ),

                BackgroundTransparency = 0.88
            },
            3
        )

        FastTween(
            Light3,
            {
                Position = UDim2.new(
                    0.55,
                    0,
                    -100,
                    0
                ),

                BackgroundTransparency = 0.92
            },
            3
        )

        task.wait(3)
    end
end)

--========================================================
-- TOP BAR
--========================================================

local TopBar = New("Frame", {
    Name = "TopBar",

    Size = UDim2.new(
        1,
        -24,
        0,
        70
    ),

    Position = UDim2.fromOffset(
        12,
        10
    ),

    BackgroundTransparency = 1,
    BorderSizePixel = 0,

    ZIndex = 20
}, Main)

--========================================================
-- LOGO
--========================================================

local LogoHolder = New("Frame", {
    Size = UDim2.fromOffset(
        52,
        52
    ),

    Position = UDim2.fromOffset(
        5,
        5
    ),

    BackgroundColor3 = Colors.Accent,

    BorderSizePixel = 0,

    ZIndex = 21
}, TopBar)

Corner(LogoHolder, 16)
Stroke(
    LogoHolder,
    Colors.Accent,
    1,
    0.15
)

local Logo = New("TextLabel", {
    Size = UDim2.fromScale(
        1,
        1
    ),

    BackgroundTransparency = 1,

    Text = "R",

    TextColor3 = Colors.Text,

    TextSize = 25,

    Font = Enum.Font.GothamBold,

    ZIndex = 22
}, LogoHolder)

--========================================================
-- TITLE
--========================================================

local Title = New("TextLabel", {
    Size = UDim2.new(
        1,
        -190,
        0,
        28
    ),

    Position = UDim2.fromOffset(
        70,
        5
    ),

    BackgroundTransparency = 1,

    Text = "RIVALS HUB",

    TextColor3 = Colors.Text,

    TextSize = 20,

    Font = Enum.Font.GothamBold,

    TextXAlignment = Enum.TextXAlignment.Left,

    ZIndex = 21
}, TopBar)

--========================================================
-- VERSION
--========================================================

local Version = New("TextLabel", {
    Size = UDim2.new(
        1,
        -190,
        0,
        18
    ),

    Position = UDim2.fromOffset(
        71,
        34
    ),

    BackgroundTransparency = 1,

    Text = Config.Version,

    TextColor3 = Colors.Accent,

    TextSize = 11,

    Font = Enum.Font.GothamSemibold,

    TextXAlignment = Enum.TextXAlignment.Left,

    ZIndex = 21
}, TopBar)

--========================================================
-- MINIMIZE
--========================================================

local MinimizeButton = New("TextButton", {
    Size = UDim2.fromOffset(
        42,
        42
    ),

    Position = UDim2.new(
        1,
        -94,
        0,
        8
    ),

    BackgroundColor3 = Colors.Card,

    BorderSizePixel = 0,

    Text = "—",

    TextColor3 = Colors.Text,

    TextSize = 22,

    Font = Enum.Font.GothamBold,

    AutoButtonColor = false,

    ZIndex = 25
}, TopBar)

Corner(MinimizeButton, 13)
Stroke(
    MinimizeButton,
    Colors.Border,
    1,
    0.15
)

--========================================================
-- CLOSE
--========================================================

local CloseButton = New("TextButton", {
    Size = UDim2.fromOffset(
        42,
        42
    ),

    Position = UDim2.new(
        1,
        -46,
        0,
        8
    ),

    BackgroundColor3 = Colors.Card,

    BorderSizePixel = 0,

    Text = "×",

    TextColor3 = Colors.Text,

    TextSize = 21,

    Font = Enum.Font.GothamBold,

    AutoButtonColor = false,

    ZIndex = 25
}, TopBar)

Corner(CloseButton, 13)
Stroke(
    CloseButton,
    Colors.Border,
    1,
    0.15
)

--========================================================
-- BODY
--========================================================

local Body = New("Frame", {
    Name = "Body",

    Size = UDim2.new(
        1,
        -24,
        1,
        -92
    ),

    Position = UDim2.fromOffset(
        12,
        80
    ),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ZIndex = 20
}, Main)

--========================================================
-- SIDEBAR
--========================================================

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

    BackgroundColor3 = Colors.Panel,

    BorderSizePixel = 0,

    ZIndex = 21
}, Body)

Corner(Sidebar, 17)
Stroke(
    Sidebar,
    Colors.Border,
    1,
    0.35
)

--========================================================
-- SIDEBAR TITLE
--========================================================

local SidebarTitle = New("TextLabel", {
    Size = UDim2.new(
        1,
        -24,
        0,
        22
    ),

    Position = UDim2.fromOffset(
        12,
        12
    ),

    BackgroundTransparency = 1,

    Text = "CATEGORIES",

    TextColor3 = Colors.Muted,

    TextSize = 10,

    Font = Enum.Font.GothamBold,

    TextXAlignment = Enum.TextXAlignment.Left,

    ZIndex = 22
}, Sidebar)

--========================================================
-- CATEGORY HOLDER
--========================================================

local CategoryHolder = New("Frame", {
    Size = UDim2.new(
        1,
        -16,
        1,
        -50
    ),

    Position = UDim2.fromOffset(
        8,
        43
    ),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ZIndex = 22
}, Sidebar)

New("UIListLayout", {
    Padding = UDim.new(
        0,
        8
    ),

    SortOrder = Enum.SortOrder.LayoutOrder
}, CategoryHolder)

--========================================================
-- CONTENT
--========================================================

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

    BackgroundColor3 = Colors.Panel,

    BorderSizePixel = 0,

    ClipsDescendants = true,

    ZIndex = 21
}, Body)

Corner(Content, 17)
Stroke(
    Content,
    Colors.Border,
    1,
    0.35
)

--========================================================
-- PAGE HEADER
--========================================================

local PageHeader = New("Frame", {
    Size = UDim2.new(
        1,
        -28,
        0,
        58
    ),

    Position = UDim2.fromOffset(
        14,
        12
    ),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ZIndex = 23
}, Content)

local PageTitle = New("TextLabel", {
    Size = UDim2.new(
        1,
        -10,
        0,
        28
    ),

    Position = UDim2.fromOffset(
        2,
        0
    ),

    BackgroundTransparency = 1,

    Text = "Combat",

    TextColor3 = Colors.Text,

    TextSize = 20,

    Font = Enum.Font.GothamBold,

    TextXAlignment = Enum.TextXAlignment.Left,

    ZIndex = 24
}, PageHeader)

local PageDescription = New("TextLabel", {
    Size = UDim2.new(
        1,
        -10,
        0,
        20
    ),

    Position = UDim2.fromOffset(
        2,
        31
    ),

    BackgroundTransparency = 1,

    Text = "Aim and combat functions",

    TextColor3 = Colors.SubText,

    TextSize = 11,

    Font = Enum.Font.Gotham,

    TextXAlignment = Enum.TextXAlignment.Left,

    ZIndex = 24
}, PageHeader)

--========================================================
-- PAGES
--========================================================

local Pages = {}

local function CreatePage(name)
    local page = New("ScrollingFrame", {
        Name = name,

        Size = UDim2.new(
            1,
            -28,
            1,
            -80
        ),

        Position = UDim2.fromOffset(
            14,
            72
        ),

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        ScrollBarThickness = 3,

        ScrollBarImageColor3 = Colors.Accent,

        CanvasSize = UDim2.new(
            0,
            0,
            0,
            0
        ),

        AutomaticCanvasSize = Enum.AutomaticSize.Y,

        ScrollingDirection =
            Enum.ScrollingDirection.Y,

        Visible = false,

        ClipsDescendants = true,

        ZIndex = 23
    }, Content)

    New("UIPadding", {
        PaddingTop = UDim.new(0, 2),
        PaddingBottom = UDim.new(0, 12),
        PaddingLeft = UDim.new(0, 2),
        PaddingRight = UDim.new(0, 5)
    }, page)

    New("UIListLayout", {
        Padding = UDim.new(0, 9),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, page)

    Pages[name] = page

    return page
end

local CombatPage = CreatePage("Combat")
local VisualsPage = CreatePage("Visuals")
local MovementPage = CreatePage("Movement")
local SettingsPage = CreatePage("Settings")

--========================================================
-- CATEGORY BUTTONS
--========================================================

local CategoryButtons = {}

local function CreateCategory(name, order)
    local button = New("TextButton", {
        Name = name .. "Button",

        Size = UDim2.new(
            1,
            0,
            0,
            48
        ),

        BackgroundColor3 = Colors.Card,

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        Text = "",

        AutoButtonColor = false,

        LayoutOrder = order,

        ZIndex = 23
    }, CategoryHolder)

    Corner(button, 13)

    local Accent = New("Frame", {
        Size = UDim2.fromOffset(
            4,
            26
        ),

        Position = UDim2.fromOffset(
            7,
            11
        ),

        BackgroundColor3 = Colors.Accent,

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        ZIndex = 24
    }, button)

    Corner(Accent, 999)

    local Label = New("TextLabel", {
        Size = UDim2.new(
            1,
            -28,
            1,
            0
        ),

        Position = UDim2.fromOffset(
            20,
            0
        ),

        BackgroundTransparency = 1,

        Text = name,

        TextColor3 = Colors.SubText,

        TextSize = 12,

        Font = Enum.Font.GothamSemibold,

        TextXAlignment =
            Enum.TextXAlignment.Left,

        ZIndex = 24
    }, button)

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

--========================================================
-- PAGE DATA
--========================================================

local PageDescriptions = {
    Combat = "Aim and combat functions",
    Visuals = "ESP and visual settings",
    Movement = "Movement and player settings",
    Settings = "Hub information and configuration"
}

local CategoryOrder = {
    "Combat",
    "Visuals",
    "Movement",
    "Settings"
}

local CurrentCategory = "Combat"
local SwitchingPage = false

--========================================================
-- CATEGORY: VISUALS
--========================================================

local VisualsPage = Pages.Visuals

local VisualsSection = CreateSection(
    VisualsPage,
    "Visuals",
    "Player ESP and visual options"
)

local ESPToggle = CreateToggle(
    VisualsSection,
    "ESP",
    "Enable player ESP",
    Config.ESP,
    function(value)
        Config.ESP = value

        if not value then
            ClearESP()
        end

        UpdateESP()
    end
)

local ModelESP = CreateToggle(
    VisualsSection,
    "Model ESP",
    "Highlight player characters",
    Config.ModelESP,
    function(value)
        Config.ModelESP = value
        UpdateESP()
    end
)

local BoxToggle = CreateToggle(
    VisualsSection,
    "Box",
    "Display a box around players",
    Config.Box,
    function(value)
        Config.Box = value
        UpdateESP()
    end
)

local NamesToggle = CreateToggle(
    VisualsSection,
    "Names",
    "Display player names",
    Config.Names,
    function(value)
        Config.Names = value
        UpdateESP()
    end
)

local HealthToggle = CreateToggle(
    VisualsSection,
    "Health",
    "Display player health",
    Config.Health,
    function(value)
        Config.Health = value
        UpdateESP()
    end
)

local DistanceToggle = CreateToggle(
    VisualsSection,
    "Distance",
    "Display player distance",
    Config.Distance,
    function(value)
        Config.Distance = value
        UpdateESP()
    end
)

local SpeedToggle = CreateToggle(
    VisualsSection,
    "Speed",
    "Display player movement speed",
    Config.Speed,
    function(value)
        Config.Speed = value
        UpdateESP()
    end
)

--========================================================
-- CATEGORY: MOVEMENT
--========================================================

local MovementPage = Pages.Movement

local MovementSection = CreateSection(
    MovementPage,
    "Movement",
    "Movement and character options"
)

local SpeedToggleMovement = CreateToggle(
    MovementSection,
    "Speed",
    "Enable custom walk speed",
    false,
    function(value)
        Config.SpeedEnabled = value

        local Character = LocalPlayer.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

        if Humanoid then
            if value then
                Humanoid.WalkSpeed = Config.SpeedValue
            else
                Humanoid.WalkSpeed = 16
            end
        end
    end
)

local SpeedValue = CreateNumber(
    MovementSection,
    "Speed Value",
    Config.SpeedValue,
    1,
    100,
    1,
    function(value)
        Config.SpeedValue = value

        if Config.SpeedEnabled then
            local Character = LocalPlayer.Character
            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

            if Humanoid then
                Humanoid.WalkSpeed = value
            end
        end
    end
)

local JumpToggle = CreateToggle(
    MovementSection,
    "Jump",
    "Enable custom jump power",
    Config.Jump,
    function(value)
        Config.Jump = value

        local Character = LocalPlayer.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

        if Humanoid then
            if value then
                Humanoid.UseJumpPower = true
                Humanoid.JumpPower = Config.JumpPower
            else
                Humanoid.JumpPower = 50
            end
        end
    end
)

local JumpValue = CreateNumber(
    MovementSection,
    "Jump Power",
    Config.JumpPower,
    1,
    150,
    1,
    function(value)
        Config.JumpPower = value

        if Config.Jump then
            local Character = LocalPlayer.Character
            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

            if Humanoid then
                Humanoid.UseJumpPower = true
                Humanoid.JumpPower = value
            end
        end
    end
)

local NoclipToggle = CreateToggle(
    MovementSection,
    "Noclip",
    "Disable character collisions",
    Config.Noclip,
    function(value)
        Config.Noclip = value
    end
)

--========================================================
-- CATEGORY: SETTINGS
--========================================================

local SettingsPage = Pages.Settings

local SettingsSection = CreateSection(
    SettingsPage,
    "Settings",
    "Information about this hub"
)

local VersionCard = CreateInfoCard(
    SettingsSection,
    "Version",
    Config.Version
)

local CreatorCard = CreateInfoCard(
    SettingsSection,
    "Creator",
    Config.Creator
)

local TelegramCard = CreateInfoCard(
    SettingsSection,
    "Telegram",
    "@lunarhub_script"
)

local StatusCard = CreateInfoCard(
    SettingsSection,
    "Status",
    "Rivals Hub is running"
)

--========================================================
-- CATEGORY BUTTONS
--========================================================

local CategoryButtons = {}

local function SetCategoryActive(Name)
    for CategoryName, Button in pairs(CategoryButtons) do
        local Active = CategoryName == Name

        Tween(
            Button,
            {
                BackgroundColor3 = Active and Colors.Accent or Colors.Card,
                BackgroundTransparency = Active and 0 or 0.25
            },
            0.18
        )

        local Label = Button:FindFirstChild("Label")

        if Label then
            Tween(
                Label,
                {
                    TextColor3 = Active and Colors.White or Colors.SubText
                },
                0.18
            )
        end
    end
end

local function CreateCategory(Name)
    local Button = New(
        "TextButton",
        Sidebar,
        {
            Name = Name .. "Category",
            Size = UDim2.new(1, -22, 0, 42),
            BackgroundColor3 = Colors.Card,
            BackgroundTransparency = 0.25,
            BorderSizePixel = 0,
            AutoButtonColor = false,
            Text = ""
        }
    )

    Corner(Button, 12)

    local Label = New(
        "TextLabel",
        Button,
        {
            Name = "Label",
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(14, 0),
            Size = UDim2.new(1, -20, 1, 0),
            Font = Enum.Font.GothamMedium,
            Text = Name,
            TextSize = 14,
            TextColor3 = Colors.SubText,
            TextXAlignment = Enum.TextXAlignment.Left
        }
    )

    Button.MouseEnter:Connect(function()
        if CurrentCategory ~= Name then
            Tween(
                Button,
                {
                    BackgroundTransparency = 0.08
                },
                0.12
            )
        end
    end)

    Button.MouseLeave:Connect(function()
        if CurrentCategory ~= Name then
            Tween(
                Button,
                {
                    BackgroundTransparency = 0.25
                },
                0.12
            )
        end
    end)

    Button.MouseButton1Click:Connect(function()
        if CurrentCategory == Name or SwitchingPage then
            return
        end

        SwitchPage(Name)
    end)

    CategoryButtons[Name] = Button

    return Button
end

CreateCategory("Combat")
CreateCategory("Visuals")
CreateCategory("Movement")
CreateCategory("Settings")

SetCategoryActive(CurrentCategory)

--========================================================
-- PAGE SWITCH ANIMATION
--========================================================

local function GetPageOffset(Direction)
    if Direction == "Left" then
        return UDim2.new(-1, 0, 0, 0)
    else
        return UDim2.new(1, 0, 0, 0)
    end
end

function SwitchPage(Name)
    if SwitchingPage then
        return
    end

    if not Pages[Name] then
        return
    end

    if CurrentCategory == Name then
        return
    end

    SwitchingPage = true

    local OldName = CurrentCategory
    local OldPage = Pages[OldName]
    local NewPage = Pages[Name]

    local OldIndex = table.find(CategoryOrder, OldName) or 1
    local NewIndex = table.find(CategoryOrder, Name) or 1

    local Direction

    if NewIndex > OldIndex then
        Direction = "Left"
    else
        Direction = "Right"
    end

    local OldTarget = GetPageOffset(Direction)

    if Direction == "Left" then
        NewPage.Position = UDim2.new(1, 0, 0, 0)
    else
        NewPage.Position = UDim2.new(-1, 0, 0, 0)
    end

    NewPage.Visible = true

    Tween(
        OldPage,
        {
            Position = OldTarget
        },
        0.28
    )

    Tween(
        NewPage,
        {
            Position = UDim2.new(0, 0, 0, 0)
        },
        0.32
    )

    SetCategoryActive(Name)

    task.delay(0.32, function()
        if OldPage and OldPage ~= NewPage then
            OldPage.Visible = false
            OldPage.Position = UDim2.new(0, 0, 0, 0)
        end

        CurrentCategory = Name
        SwitchingPage = false
    end)
end

--========================================================
-- INITIAL PAGE
--========================================================

for Name, Page in pairs(Pages) do
    Page.Visible = Name == CurrentCategory
    Page.Position = UDim2.new(0, 0, 0, 0)
end

--========================================================
-- END PART 1/4
--========================================================

--========================================================
-- PART 2/4
-- COMBAT + AIM ASSIST + FOV
--========================================================

--========================================================
-- COMBAT PAGE
--========================================================

local CombatSection = CreateSection(
    Pages.Combat,
    "Aim Assist",
    "Target players automatically inside the selected FOV"
)

local AimToggle = CreateToggle(
    CombatSection,
    "Aim Assist",
    "Smoothly aim toward the closest valid player",
    Config.AimAssist,
    function(value)
        Config.AimAssist = value
    end
)

local VisibleToggle = CreateToggle(
    CombatSection,
    "Visible Only",
    "Only target players visible from the camera",
    Config.VisibleOnly,
    function(value)
        Config.VisibleOnly = value
    end
)

local AimFOVToggle = CreateToggle(
    CombatSection,
    "Aim FOV",
    "Limit aiming to the FOV circle",
    Config.AimFOV,
    function(value)
        Config.AimFOV = value
    end
)

local FOVNumber = CreateNumber(
    CombatSection,
    "FOV Size",
    Config.FOVSize,
    50,
    800,
    10,
    function(value)
        Config.FOVSize = value
    end
)

local SmoothNumber = CreateNumber(
    CombatSection,
    "Smoothness",
    math.floor(Config.Smoothness * 100),
    1,
    100,
    1,
    function(value)
        Config.Smoothness = value / 100
    end
)

local TargetButton = CreateDropdown(
    CombatSection,
    "Target Part",
    {
        "Head",
        "HumanoidRootPart"
    },
    Config.TargetPart,
    function(value)
        Config.TargetPart = value
    end
)

--========================================================
-- AIM FOV VISUAL
--========================================================

local FOVCircle = New(
    "Frame",
    ScreenGui,
    {
        Name = "AimFOV",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(Config.FOVSize, Config.FOVSize),
        BackgroundTransparency = 1,
        Visible = false,
        ZIndex = 1
    }
)

Corner(FOVCircle, 999)

local FOVStroke = Stroke(
    FOVCircle,
    Colors.Accent,
    1.5,
    0.15
)

local FOVCenter = New(
    "Frame",
    FOVCircle,
    {
        Name = "Center",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(3, 3),
        BackgroundColor3 = Colors.Accent,
        BorderSizePixel = 0
    }
)

Corner(FOVCenter, 999)

--========================================================
-- FOV UPDATE
--========================================================

local function UpdateFOV()
    local Camera = workspace.CurrentCamera

    if not Camera then
        return
    end

    local Viewport = Camera.ViewportSize

    FOVCircle.Position = UDim2.fromOffset(
        Viewport.X / 2,
        Viewport.Y / 2
    )

    FOVCircle.Size = UDim2.fromOffset(
        Config.FOVSize,
        Config.FOVSize
    )

    FOVCircle.Visible =
        Config.AimAssist
        and Config.AimFOV
        and Main.Visible
end

RunService.RenderStepped:Connect(function()
    UpdateFOV()
end)

--========================================================
-- TARGET FUNCTIONS
--========================================================

local function GetCharacter(Player)
    if not Player then
        return nil
    end

    return Player.Character
end

local function GetHumanoid(Character)
    if not Character then
        return nil
    end

    return Character:FindFirstChildOfClass("Humanoid")
end

local function GetTargetPart(Character)
    if not Character then
        return nil
    end

    local Part = Character:FindFirstChild(Config.TargetPart)

    if not Part then
        Part = Character:FindFirstChild("Head")
    end

    return Part
end

local function IsAlive(Player)
    local Character = GetCharacter(Player)
    local Humanoid = GetHumanoid(Character)

    return Character
        and Humanoid
        and Humanoid.Health > 0
end

local function IsVisible(TargetPart)
    if not Config.VisibleOnly then
        return true
    end

    local Camera = workspace.CurrentCamera

    if not Camera or not TargetPart then
        return false
    end

    local Origin = Camera.CFrame.Position

    local Direction =
        TargetPart.Position - Origin

    local Params = RaycastParams.new()

    Params.FilterType = Enum.RaycastFilterType.Exclude
    Params.FilterDescendantsInstances = {
        LocalPlayer.Character
    }

    Params.IgnoreWater = true

    local Result = workspace:Raycast(
        Origin,
        Direction,
        Params
    )

    if not Result then
        return true
    end

    return Result.Instance:IsDescendantOf(
        TargetPart.Parent
    )
end

local function GetClosestTarget()
    local Camera = workspace.CurrentCamera

    if not Camera then
        return nil
    end

    local Viewport = Camera.ViewportSize

    local Center = Vector2.new(
        Viewport.X / 2,
        Viewport.Y / 2
    )

    local BestPlayer = nil
    local BestDistance = math.huge

    for _, Player in ipairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer and IsAlive(Player) then

            local Character = Player.Character
            local TargetPart = GetTargetPart(Character)

            if TargetPart then

                local ScreenPosition, OnScreen =
                    Camera:WorldToViewportPoint(
                        TargetPart.Position
                    )

                if OnScreen and ScreenPosition.Z > 0 then

                    local ScreenPoint = Vector2.new(
                        ScreenPosition.X,
                        ScreenPosition.Y
                    )

                    local Distance =
                        (ScreenPoint - Center).Magnitude

                    local Allowed =
                        (not Config.AimFOV)
                        or Distance <= (Config.FOVSize / 2)

                    if Allowed and IsVisible(TargetPart) then
                        if Distance < BestDistance then
                            BestDistance = Distance
                            BestPlayer = Player
                        end
                    end
                end
            end
        end
    end

    return BestPlayer
end

--========================================================
-- AIM ASSIST
--========================================================

local AimConnectionName = "RivalsHub_AimAssist"

pcall(function()
    RunService:UnbindFromRenderStep(AimConnectionName)
end)

RunService:BindToRenderStep(
    AimConnectionName,
    Enum.RenderPriority.Camera.Value + 1,
    function()
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
        local TargetPart = GetTargetPart(Character)

        if not TargetPart then
            return
        end

        local CameraPosition = Camera.CFrame.Position

        local Desired =
            CFrame.lookAt(
                CameraPosition,
                TargetPart.Position
            )

        local Alpha = math.clamp(
            Config.Smoothness,
            0.01,
            1
        )

        Camera.CFrame =
            Camera.CFrame:Lerp(
                Desired,
                Alpha
            )
    end
)

--========================================================
-- SILENT AIM UI
--========================================================

local SilentSection = CreateSection(
    Pages.Combat,
    "Silent Aim",
    "Silent Aim settings"
)

local SilentToggle = CreateToggle(
    SilentSection,
    "Silent Aim",
    "Enable Silent Aim settings",
    Config.SilentAim,
    function(value)
        Config.SilentAim = value
    end
)

local SilentPart = CreateDropdown(
    SilentSection,
    "Target Part",
    {
        "Head",
        "HumanoidRootPart"
    },
    Config.SilentAimPart,
    function(value)
        Config.SilentAimPart = value
    end
)

local SilentChance = CreateNumber(
    SilentSection,
    "Chance",
    Config.SilentAimChance,
    1,
    100,
    1,
    function(value)
        Config.SilentAimChance = value
    end
)

local SilentFOV = CreateNumber(
    SilentSection,
    "FOV",
    Config.SilentAimFOV,
    50,
    800,
    10,
    function(value)
        Config.SilentAimFOV = value
    end
)

--========================================================
-- COMBAT STATUS
--========================================================

local CombatStatus = CreateInfoCard(
    Pages.Combat,
    "Status",
    "Aim Assist ready"
)

--========================================================
-- END PART 2/4
--========================================================

--========================================================
-- PART 3/4
-- ESP + MOVEMENT LOGIC + CHARACTER HANDLING
--========================================================

--========================================================
-- ESP STORAGE
--========================================================

local ESPObjects = {}

--========================================================
-- CLEAR ESP
--========================================================

function ClearESP()
    for Player, Objects in pairs(ESPObjects) do
        if Objects then
            for _, Object in pairs(Objects) do
                if typeof(Object) == "Instance" then
                    pcall(function()
                        Object:Destroy()
                    end)
                end
            end
        end

        ESPObjects[Player] = nil
    end
end

--========================================================
-- CREATE ESP
--========================================================

local function CreateESP(Player)
    if Player == LocalPlayer then
        return
    end

    if ESPObjects[Player] then
        return
    end

    local Objects = {}

    local Highlight = Instance.new("Highlight")
    Highlight.Name = "RivalsHub_ESP"
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Highlight.FillTransparency = 0.65
    Highlight.OutlineTransparency = 0
    Highlight.FillColor = Colors.Accent
    Highlight.OutlineColor = Colors.White
    Highlight.Enabled = Config.ESP and Config.ModelESP

    Objects.Highlight = Highlight

    local Billboard = Instance.new("BillboardGui")
    Billboard.Name = "RivalsHub_Info"
    Billboard.Size = UDim2.fromOffset(180, 70)
    Billboard.StudsOffset = Vector3.new(0, 3.2, 0)
    Billboard.AlwaysOnTop = true
    Billboard.Enabled = Config.ESP
    Billboard.ResetOnSpawn = false

    local Holder = Instance.new("Frame")
    Holder.Size = UDim2.fromScale(1, 1)
    Holder.BackgroundTransparency = 1
    Holder.Parent = Billboard

    local NameLabel = Instance.new("TextLabel")
    NameLabel.Name = "Name"
    NameLabel.Position = UDim2.fromOffset(0, 0)
    NameLabel.Size = UDim2.new(1, 0, 0, 20)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextSize = 13
    NameLabel.TextColor3 = Colors.White
    NameLabel.TextStrokeTransparency = 0.5
    NameLabel.Text = Player.DisplayName
    NameLabel.Parent = Holder

    local HealthLabel = Instance.new("TextLabel")
    HealthLabel.Name = "Health"
    HealthLabel.Position = UDim2.fromOffset(0, 21)
    HealthLabel.Size = UDim2.new(1, 0, 0, 18)
    HealthLabel.BackgroundTransparency = 1
    HealthLabel.Font = Enum.Font.GothamMedium
    HealthLabel.TextSize = 12
    HealthLabel.TextColor3 = Colors.White
    HealthLabel.TextStrokeTransparency = 0.5
    HealthLabel.Parent = Holder

    local DistanceLabel = Instance.new("TextLabel")
    DistanceLabel.Name = "Distance"
    DistanceLabel.Position = UDim2.fromOffset(0, 40)
    DistanceLabel.Size = UDim2.new(1, 0, 0, 18)
    DistanceLabel.BackgroundTransparency = 1
    DistanceLabel.Font = Enum.Font.GothamMedium
    DistanceLabel.TextSize = 11
    DistanceLabel.TextColor3 = Colors.SubText
    DistanceLabel.TextStrokeTransparency = 0.5
    DistanceLabel.Parent = Holder

    Objects.Billboard = Billboard
    Objects.NameLabel = NameLabel
    Objects.HealthLabel = HealthLabel
    Objects.DistanceLabel = DistanceLabel

    ESPObjects[Player] = Objects

    local function Attach(Character)
        if not Character then
            return
        end

        if Objects.Highlight then
            Objects.Highlight.Adornee = Character
            Objects.Highlight.Parent = Character
        end

        if Objects.Billboard then
            Objects.Billboard.Adornee =
                Character:FindFirstChild("Head")
                or Character:FindFirstChild("HumanoidRootPart")

            Objects.Billboard.Parent = Character
        end
    end

    if Player.Character then
        Attach(Player.Character)
    end

    Objects.Attach = Attach
end

--========================================================
-- REMOVE PLAYER ESP
--========================================================

local function RemoveESP(Player)
    local Objects = ESPObjects[Player]

    if not Objects then
        return
    end

    for _, Object in pairs(Objects) do
        if typeof(Object) == "Instance" then
            pcall(function()
                Object:Destroy()
            end)
        end
    end

    ESPObjects[Player] = nil
end

--========================================================
-- UPDATE ESP
--========================================================

function UpdateESP()
    if not Config.ESP then
        ClearESP()
        return
    end

    for _, Player in ipairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer then
            CreateESP(Player)
        end
    end
end

--========================================================
-- ESP PLAYER EVENTS
--========================================================

Players.PlayerAdded:Connect(function(Player)
    if Player == LocalPlayer then
        return
    end

    Player.CharacterAdded:Connect(function(Character)
        task.wait(0.15)

        local Objects = ESPObjects[Player]

        if Objects and Objects.Attach then
            Objects.Attach(Character)
        elseif Config.ESP then
            CreateESP(Player)
        end
    end)

    if Config.ESP then
        CreateESP(Player)
    end
end)

Players.PlayerRemoving:Connect(function(Player)
    RemoveESP(Player)
end)

for _, Player in ipairs(Players:GetPlayers()) do
    if Player ~= LocalPlayer then

        Player.CharacterAdded:Connect(function(Character)
            task.wait(0.15)

            local Objects = ESPObjects[Player]

            if Objects and Objects.Attach then
                Objects.Attach(Character)
            elseif Config.ESP then
                CreateESP(Player)
            end
        end)

        if Config.ESP then
            CreateESP(Player)
        end
    end
end

--========================================================
-- ESP UPDATE LOOP
--========================================================

RunService.RenderStepped:Connect(function()

    if not Config.ESP then
        return
    end

    local LocalCharacter = LocalPlayer.Character
    local LocalRoot =
        LocalCharacter
        and LocalCharacter:FindFirstChild("HumanoidRootPart")

    for Player, Objects in pairs(ESPObjects) do

        if not Player.Parent then
            RemoveESP(Player)
            continue
        end

        local Character = Player.Character
        local Humanoid = Character
            and Character:FindFirstChildOfClass("Humanoid")

        local Root =
            Character
            and Character:FindFirstChild("HumanoidRootPart")

        if not Character or not Humanoid or not Root then
            if Objects.Billboard then
                Objects.Billboard.Enabled = false
            end

            if Objects.Highlight then
                Objects.Highlight.Enabled = false
            end

            continue
        end

        -- Model ESP
        if Objects.Highlight then
            Objects.Highlight.Adornee = Character
            Objects.Highlight.Enabled =
                Config.ESP and Config.ModelESP
        end

        -- Billboard
        if Objects.Billboard then
            Objects.Billboard.Adornee =
                Character:FindFirstChild("Head")
                or Root

            Objects.Billboard.Enabled =
                Config.ESP
                and (
                    Config.Names
                    or Config.Health
                    or Config.Distance
                    or Config.Speed
                )
        end

        if Objects.NameLabel then
            Objects.NameLabel.Visible = Config.Names
            Objects.NameLabel.Text =
                Player.DisplayName
                .. "  ["
                .. Player.Name
                .. "]"
        end

        if Objects.HealthLabel then
            Objects.HealthLabel.Visible = Config.Health

            local Health = math.max(
                0,
                math.floor(Humanoid.Health)
            )

            local MaxHealth = math.max(
                1,
                math.floor(Humanoid.MaxHealth)
            )

            Objects.HealthLabel.Text =
                "HP: "
                .. Health
                .. " / "
                .. MaxHealth
        end

        if Objects.DistanceLabel then

            local DistanceText = ""

            if Config.Distance and LocalRoot then
                local Distance =
                    (Root.Position - LocalRoot.Position).Magnitude

                DistanceText =
                    math.floor(Distance)
                    .. " studs"
            end

            if Config.Speed then
                local Velocity =
                    Root.AssemblyLinearVelocity

                local Speed =
                    Vector3.new(
                        Velocity.X,
                        0,
                        Velocity.Z
                    ).Magnitude

                if DistanceText ~= "" then
                    DistanceText =
                        DistanceText
                        .. "  |  "
                end

                DistanceText =
                    DistanceText
                    .. "Speed: "
                    .. math.floor(Speed)
            end

            Objects.DistanceLabel.Text = DistanceText

            Objects.DistanceLabel.Visible =
                Config.Distance or Config.Speed
        end
    end
end)

--========================================================
-- MOVEMENT
--========================================================

Config.SpeedEnabled = false

local function ApplyMovementSettings()
    local Character = LocalPlayer.Character

    if not Character then
        return
    end

    local Humanoid =
        Character:FindFirstChildOfClass("Humanoid")

    if not Humanoid then
        return
    end

    if Config.SpeedEnabled then
        Humanoid.WalkSpeed = Config.SpeedValue
    else
        Humanoid.WalkSpeed = 16
    end

    if Config.Jump then
        Humanoid.UseJumpPower = true
        Humanoid.JumpPower = Config.JumpPower
    else
        Humanoid.JumpPower = 50
    end
end

--========================================================
-- CHARACTER RESPAWN
--========================================================

LocalPlayer.CharacterAdded:Connect(function(Character)

    local Humanoid =
        Character:WaitForChild(
            "Humanoid",
            5
        )

    if Humanoid then
        task.wait(0.1)
        ApplyMovementSettings()
    end
end)

--========================================================
-- NOCLIP
--========================================================

RunService.Stepped:Connect(function()

    if not Config.Noclip then
        return
    end

    local Character = LocalPlayer.Character

    if not Character then
        return
    end

    for _, Object in ipairs(Character:GetDescendants()) do
        if Object:IsA("BasePart") then
            Object.CanCollide = false
        end
    end
end)

--========================================================
-- SPEED / JUMP SAFETY LOOP
--========================================================

RunService.Heartbeat:Connect(function()

    local Character = LocalPlayer.Character

    if not Character then
        return
    end

    local Humanoid =
        Character:FindFirstChildOfClass("Humanoid")

    if not Humanoid then
        return
    end

    if Config.SpeedEnabled then
        if Humanoid.WalkSpeed ~= Config.SpeedValue then
            Humanoid.WalkSpeed = Config.SpeedValue
        end
    end

    if Config.Jump then
        Humanoid.UseJumpPower = true

        if Humanoid.JumpPower ~= Config.JumpPower then
            Humanoid.JumpPower = Config.JumpPower
        end
    end
end)

--========================================================
-- END PART 3/4
--========================================================

--========================================================
-- PART 4/4
-- ANIMATIONS + MINIMIZE + CLOSE + FINAL
--========================================================

--========================================================
-- MENU POSITION
--========================================================

local SavedPosition = Holder.Position

local MenuOpen = true
local Closing = false

--========================================================
-- FLOATING R BUTTON
--========================================================

local FloatingButton = New(
    "TextButton",
    ScreenGui,
    {
        Name = "FloatingR",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = SavedPosition,
        Size = UDim2.fromOffset(54, 54),
        BackgroundColor3 = Colors.Panel,
        BackgroundTransparency = 0.04,
        BorderSizePixel = 0,
        AutoButtonColor = false,
        Text = "R",
        TextColor3 = Colors.White,
        TextSize = 22,
        Font = Enum.Font.GothamBold,
        Visible = false,
        ZIndex = 100
    }
)

Corner(FloatingButton, 999)

local FloatingStroke = Stroke(
    FloatingButton,
    Colors.Accent,
    1.5,
    0.15
)

--========================================================
-- FLOATING BUTTON HOVER
--========================================================

FloatingButton.MouseEnter:Connect(function()
    Tween(
        FloatingButton,
        {
            Size = UDim2.fromOffset(60, 60),
            BackgroundColor3 = Colors.Card
        },
        0.16
    )

    Tween(
        FloatingStroke,
        {
            Transparency = 0
        },
        0.16
    )
end)

FloatingButton.MouseLeave:Connect(function()
    Tween(
        FloatingButton,
        {
            Size = UDim2.fromOffset(54, 54),
            BackgroundColor3 = Colors.Panel
        },
        0.16
    )

    Tween(
        FloatingStroke,
        {
            Transparency = 0.15
        },
        0.16
    )
end)

--========================================================
-- MINIMIZE
--========================================================

local function MinimizeMenu()
    if not MenuOpen or Closing then
        return
    end

    MenuOpen = false

    SavedPosition = Holder.Position

    FloatingButton.Position = SavedPosition
    FloatingButton.Visible = true
    FloatingButton.Size = UDim2.fromOffset(20, 20)
    FloatingButton.TextTransparency = 1

    Tween(
        Main,
        {
            Size = UDim2.fromOffset(80, 80),
            BackgroundTransparency = 1
        },
        0.30
    )

    Tween(
        Holder,
        {
            Size = UDim2.fromOffset(80, 80)
        },
        0.30
    )

    Tween(
        FloatingButton,
        {
            Size = UDim2.fromOffset(54, 54)
        },
        0.34
    )

    task.delay(0.16, function()
        Tween(
            FloatingButton,
            {
                TextTransparency = 0
            },
            0.18
        )
    end)

    task.delay(0.31, function()
        Main.Visible = false
        Holder.Size = UDim2.fromOffset(80, 80)
    end)
end

--========================================================
-- RESTORE
--========================================================

local function RestoreMenu()
    if MenuOpen or Closing then
        return
    end

    MenuOpen = true

    Holder.Position = SavedPosition
    Holder.Size = UDim2.fromOffset(80, 80)

    Main.Visible = true
    Main.Size = UDim2.fromOffset(80, 80)
    Main.BackgroundTransparency = 1

    FloatingButton.Visible = false

    Tween(
        Holder,
        {
            Size = UDim2.fromOffset(720, 470)
        },
        0.38
    )

    Tween(
        Main,
        {
            Size = UDim2.fromOffset(720, 470),
            BackgroundTransparency = 0
        },
        0.42
    )
end

FloatingButton.MouseButton1Click:Connect(function()
    RestoreMenu()
end)

--========================================================
-- MINIMIZE BUTTON
--========================================================

MinimizeButton.MouseButton1Click:Connect(function()
    MinimizeMenu()
end)

--========================================================
-- CLOSE BUTTON
--========================================================

CloseButton.MouseButton1Click:Connect(function()

    if Closing then
        return
    end

    Closing = true
    MenuOpen = false

    FOVCircle.Visible = false

    Tween(
        Main,
        {
            Size = UDim2.fromOffset(80, 80),
            BackgroundTransparency = 1
        },
        0.25
    )

    Tween(
        Holder,
        {
            Size = UDim2.fromOffset(80, 80)
        },
        0.25
    )

    task.delay(0.27, function()

        pcall(function()
            RunService:UnbindFromRenderStep(
                "RivalsHub_AimAssist"
            )
        end)

        ClearESP()

        ScreenGui:Destroy()

    end)
end)

--========================================================
-- DRAGGING
--========================================================

local Dragging = false
local DragStart
local StartPosition

local function BeginDrag(Input)

    if Closing or not MenuOpen then
        return
    end

    Dragging = true
    DragStart = Input.Position
    StartPosition = Holder.Position

    Input.Changed:Connect(function()
        if Input.UserInputState == Enum.UserInputState.End then
            Dragging = false
        end
    end)
end

local function UpdateDrag(Input)

    if not Dragging then
        return
    end

    local Delta =
        Input.Position - DragStart

    local NewX =
        StartPosition.X.Offset + Delta.X

    local NewY =
        StartPosition.Y.Offset + Delta.Y

    Holder.Position = UDim2.new(
        StartPosition.X.Scale,
        NewX,
        StartPosition.Y.Scale,
        NewY
    )

    SavedPosition = Holder.Position
end

TopBar.InputBegan:Connect(function(Input)

    if Input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or Input.UserInputType ==
        Enum.UserInputType.Touch then

        BeginDrag(Input)
    end
end)

UserInputService.InputChanged:Connect(function(Input)

    if Input.UserInputType ==
        Enum.UserInputType.MouseMovement
        or Input.UserInputType ==
        Enum.UserInputType.Touch then

        UpdateDrag(Input)
    end
end)

--========================================================
-- FLOATING BUTTON DRAGGING
--========================================================

local FloatingDragging = false
local FloatingStart
local FloatingPosition

FloatingButton.InputBegan:Connect(function(Input)

    if Input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or Input.UserInputType ==
        Enum.UserInputType.Touch then

        FloatingDragging = true
        FloatingStart = Input.Position
        FloatingPosition = FloatingButton.Position

        Input.Changed:Connect(function()
            if Input.UserInputState ==
                Enum.UserInputState.End then

                FloatingDragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(Input)

    if not FloatingDragging then
        return
    end

    if Input.UserInputType ==
        Enum.UserInputType.MouseMovement
        or Input.UserInputType ==
        Enum.UserInputType.Touch then

        local Delta =
            Input.Position - FloatingStart

        FloatingButton.Position = UDim2.new(
            FloatingPosition.X.Scale,
            FloatingPosition.X.Offset + Delta.X,
            FloatingPosition.Y.Scale,
            FloatingPosition.Y.Offset + Delta.Y
        )

        SavedPosition =
            FloatingButton.Position
    end
end)

--========================================================
-- BACKGROUND ANIMATION
--========================================================

task.spawn(function()

    local A = BackgroundLight1
    local B = BackgroundLight2
    local C = BackgroundLight3

    while ScreenGui.Parent and not Closing do

        Tween(
            A,
            {
                Position = UDim2.new(
                    0.12,
                    0,
                    0.18,
                    0
                ),
                BackgroundTransparency = 0.72
            },
            2.5
        )

        Tween(
            B,
            {
                Position = UDim2.new(
                    0.76,
                    0,
                    0.62,
                    0
                ),
                BackgroundTransparency = 0.78
            },
            2.5
        )

        Tween(
            C,
            {
                Position = UDim2.new(
                    0.48,
                    0,
                    0.78,
                    0
                ),
                BackgroundTransparency = 0.84
            },
            2.5
        )

        task.wait(2.5)

        Tween(
            A,
            {
                Position = UDim2.new(
                    0.28,
                    0,
                    0.52,
                    0
                ),
                BackgroundTransparency = 0.82
            },
            2.5
        )

        Tween(
            B,
            {
                Position = UDim2.new(
                    0.58,
                    0,
                    0.18,
                    0
                ),
                BackgroundTransparency = 0.72
            },
            2.5
        )

        Tween(
            C,
            {
                Position = UDim2.new(
                    0.18,
                    0,
                    0.70,
                    0
                ),
                BackgroundTransparency = 0.80
            },
            2.5
        )

        task.wait(2.5)
    end
end)

--========================================================
-- BUTTON PRESS ANIMATION
--========================================================

local function AddPressAnimation(Button)

    if not Button or not Button:IsA("GuiButton") then
        return
    end

    Button.MouseButton1Down:Connect(function()

        Tween(
            Button,
            {
                Size = Button.Size - UDim2.fromOffset(2, 2)
            },
            0.08
        )
    end)

    Button.MouseButton1Up:Connect(function()

        Tween(
            Button,
            {
                Size = Button.Size + UDim2.fromOffset(2, 2)
            },
            0.08
        )
    end)
end

for _, Object in ipairs(Main:GetDescendants()) do
    if Object:IsA("TextButton") then
        AddPressAnimation(Object)
    end
end

--========================================================
-- RESPAWN SAFETY
--========================================================

LocalPlayer.CharacterAdded:Connect(function()

    task.wait(0.5)

    if Closing then
        return
    end

    ApplyMovementSettings()

    if Config.ESP then
        UpdateESP()
    end
end)

--========================================================
-- INITIALIZATION
--========================================================

CurrentCategory = "Combat"

for Name, Page in pairs(Pages) do
    Page.Visible = Name == "Combat"
    Page.Position = UDim2.new(0, 0, 0, 0)
end

SetCategoryActive("Combat")

Main.Visible = true
Holder.Visible = true
FloatingButton.Visible = false

FOVCircle.Visible = false

UpdateESP()
ApplyMovementSettings()

--========================================================
-- OPEN ANIMATION
--========================================================

do
    local OriginalSize = Holder.Size

    Holder.Size = UDim2.fromOffset(40, 40)

    Main.BackgroundTransparency = 1

    task.wait(0.05)

    Tween(
        Holder,
        {
            Size = OriginalSize
        },
        0.42
    )

    Tween(
        Main,
        {
            BackgroundTransparency = 0
        },
        0.38
    )
end

--========================================================
-- FINAL
--========================================================

print("Rivals Hub loaded successfully.")

--========================================================
-- END PART 4/4
--========================================================
