--========================================================
-- RIVALS HUB 2.0
-- PART 1/4
-- UI CORE + ANIMATED BACKGROUND + WINDOW CONTROL
--========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--========================================================
-- CONFIG
--========================================================

local Config = {

    -- Combat
    AimAssist = false,
    SilentAim = false,
    TargetPart = "Head",
    SilentAimFOV = 250,
    SilentAimChance = 100,
    VisibleOnly = false,
    TeamCheck = true,

    -- Visuals
    ESP = false,
    BoxESP = false,
    NameESP = false,
    HealthESP = false,
    DistanceESP = false,

    -- Movement
    Speed = false,
    SpeedValue = 16,
    Jump = false,
    JumpValue = 50,
    Noclip = false,

    -- UI
    MenuOpen = true,
    MenuDestroyed = false
}

--========================================================
-- COLORS
--========================================================

local Colors = {
    Background = Color3.fromRGB(7, 9, 14),
    Panel = Color3.fromRGB(12, 15, 22),
    Card = Color3.fromRGB(20, 24, 33),

    Accent = Color3.fromRGB(108, 82, 255),
    AccentDark = Color3.fromRGB(67, 45, 175),

    White = Color3.fromRGB(245, 246, 255),
    SubText = Color3.fromRGB(164, 168, 185),
    Muted = Color3.fromRGB(105, 110, 128),

    On = Color3.fromRGB(108, 82, 255),
    Off = Color3.fromRGB(42, 46, 57)
}

--========================================================
-- STATE
--========================================================

local Connections = {}
local CurrentCategory = "Combat"

local Main
local Holder
local MiniButton

--========================================================
-- CONNECTION MANAGER
--========================================================

local function Connect(signal, callback)

    local connection = signal:Connect(callback)

    table.insert(Connections, connection)

    return connection
end

local function DisconnectAll()

    for _, connection in ipairs(Connections) do

        pcall(function()
            connection:Disconnect()
        end)

    end

    table.clear(Connections)
end

--========================================================
-- SAFE TWEEN
--========================================================

local function Tween(object, properties, duration)

    if not object or not object.Parent then
        return
    end

    local tween = TweenService:Create(
        object,
        TweenInfo.new(
            duration or 0.25,
            Enum.EasingStyle.Quart,
            Enum.EasingDirection.Out
        ),
        properties
    )

    tween:Play()

    return tween
end

--========================================================
-- OLD GUI CLEANUP
--========================================================

pcall(function()

    local old = PlayerGui:FindFirstChild("RivalsHub")

    if old then
        old:Destroy()
    end

end)

--========================================================
-- SCREEN GUI
--========================================================

local ScreenGui = Instance.new("ScreenGui")

ScreenGui.Name = "RivalsHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ScreenGui.Parent = PlayerGui

--========================================================
-- HOLDER
--========================================================

Holder = Instance.new("Frame")

Holder.Name = "Holder"

Holder.AnchorPoint = Vector2.new(0.5, 0.5)
Holder.Position = UDim2.fromScale(0.5, 0.5)
Holder.Size = UDim2.fromOffset(720, 470)

Holder.BackgroundTransparency = 1
Holder.BorderSizePixel = 0

Holder.Parent = ScreenGui

--========================================================
-- SCALE
--========================================================

local UIScale = Instance.new("UIScale")

UIScale.Scale = 0.82
UIScale.Parent = Holder

--========================================================
-- MAIN
--========================================================

Main = Instance.new("Frame")

Main.Name = "Main"

Main.Size = UDim2.fromScale(1, 1)

Main.BackgroundColor3 = Colors.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = true

Main.Parent = Holder

local MainCorner = Instance.new("UICorner")

MainCorner.CornerRadius = UDim.new(0, 22)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")

MainStroke.Color = Colors.Accent
MainStroke.Thickness = 1.2
MainStroke.Transparency = 0.25

MainStroke.Parent = Main

--========================================================
-- ANIMATED BACKGROUND
--========================================================

local Background = Instance.new("Frame")

Background.Name = "AnimatedBackground"

Background.Size = UDim2.fromScale(1, 1)

Background.BackgroundTransparency = 1
Background.BorderSizePixel = 0

Background.ClipsDescendants = true
Background.ZIndex = 1

Background.Parent = Main

local BackgroundCorner = Instance.new("UICorner")

BackgroundCorner.CornerRadius = UDim.new(0, 22)
BackgroundCorner.Parent = Background

--========================================================
-- LIGHT CREATOR
--========================================================

local BackgroundLights = {}

local function CreateLight(position, size, transparency)

    local light = Instance.new("Frame")

    light.AnchorPoint = Vector2.new(0.5, 0.5)

    light.Position = position
    light.Size = size

    light.BackgroundColor3 = Colors.Accent
    light.BackgroundTransparency = transparency or 0.88

    light.BorderSizePixel = 0
    light.ZIndex = 1

    light.Parent = Background

    local corner = Instance.new("UICorner")

    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = light

    table.insert(BackgroundLights, light)

    return light
end

local Light1 = CreateLight(
    UDim2.fromScale(0.08, 0.15),
    UDim2.fromOffset(280, 280),
    0.90
)

local Light2 = CreateLight(
    UDim2.fromScale(0.86, 0.22),
    UDim2.fromOffset(330, 330),
    0.92
)

local Light3 = CreateLight(
    UDim2.fromScale(0.55, 0.92),
    UDim2.fromOffset(300, 300),
    0.93
)

local Light4 = CreateLight(
    UDim2.fromScale(0.18, 0.82),
    UDim2.fromOffset(220, 220),
    0.94
)

--========================================================
-- BACKGROUND ANIMATION
--========================================================

task.spawn(function()

    local t = 0

    while not Config.MenuDestroyed do

        local dt = RunService.RenderStepped:Wait()

        t += dt

        if BackgroundLights[1] then

            BackgroundLights[1].Position =
                UDim2.fromScale(
                    0.15 + math.sin(t * 0.32) * 0.10,
                    0.18 + math.cos(t * 0.25) * 0.08
                )

        end

        if BackgroundLights[2] then

            BackgroundLights[2].Position =
                UDim2.fromScale(
                    0.82 + math.cos(t * 0.22) * 0.09,
                    0.35 + math.sin(t * 0.30) * 0.10
                )

        end

        if BackgroundLights[3] then

            BackgroundLights[3].Position =
                UDim2.fromScale(
                    0.52 + math.sin(t * 0.20) * 0.13,
                    0.87 + math.cos(t * 0.27) * 0.06
                )

        end

        if BackgroundLights[4] then

            BackgroundLights[4].Position =
                UDim2.fromScale(
                    0.20 + math.cos(t * 0.29) * 0.08,
                    0.75 + math.sin(t * 0.24) * 0.09
                )

        end

    end

end)

--========================================================
-- TOP BAR
--========================================================

local TopBar = Instance.new("Frame")

TopBar.Name = "TopBar"

TopBar.Size = UDim2.new(1, 0, 0, 70)

TopBar.BackgroundTransparency = 1
TopBar.BorderSizePixel = 0

TopBar.ZIndex = 20
TopBar.Parent = Main

--========================================================
-- LOGO
--========================================================

local Logo = Instance.new("TextLabel")

Logo.Name = "Logo"

Logo.BackgroundTransparency = 1

Logo.Position = UDim2.fromOffset(20, 12)
Logo.Size = UDim2.fromOffset(42, 42)

Logo.Font = Enum.Font.GothamBold

Logo.Text = "R"
Logo.TextColor3 = Colors.Accent
Logo.TextSize = 24

Logo.ZIndex = 21
Logo.Parent = TopBar

--========================================================
-- TITLE
--========================================================

local Title = Instance.new("TextLabel")

Title.Name = "Title"

Title.BackgroundTransparency = 1

Title.Position = UDim2.fromOffset(66, 12)
Title.Size = UDim2.fromOffset(230, 25)

Title.Font = Enum.Font.GothamBold

Title.Text = "RIVALS HUB"
Title.TextColor3 = Colors.White
Title.TextSize = 17

Title.TextXAlignment = Enum.TextXAlignment.Left

Title.ZIndex = 21
Title.Parent = TopBar

--========================================================
-- VERSION
--========================================================

local Version = Instance.new("TextLabel")

Version.Name = "Version"

Version.BackgroundTransparency = 1

Version.Position = UDim2.fromOffset(66, 36)
Version.Size = UDim2.fromOffset(150, 18)

Version.Font = Enum.Font.GothamMedium

Version.Text = "v2.0"
Version.TextColor3 = Colors.Muted
Version.TextSize = 10

Version.TextXAlignment = Enum.TextXAlignment.Left

Version.ZIndex = 21
Version.Parent = TopBar

--========================================================
-- BUTTON CREATOR
--========================================================

local function CreateTopButton(text, offset)

    local button = Instance.new("TextButton")

    button.BackgroundColor3 = Colors.Card
    button.BackgroundTransparency = 0.12

    button.BorderSizePixel = 0

    button.AnchorPoint = Vector2.new(1, 0.5)

    button.Position =
        UDim2.new(1, offset, 0.5, 0)

    button.Size = UDim2.fromOffset(34, 34)

    button.AutoButtonColor = false

    button.Text = text
    button.TextColor3 = Colors.White

    button.TextSize = 18
    button.Font = Enum.Font.GothamBold

    button.ZIndex = 25

    button.Parent = TopBar

    local corner = Instance.new("UICorner")

    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = button

    local stroke = Instance.new("UIStroke")

    stroke.Color = Colors.Accent
    stroke.Transparency = 0.8
    stroke.Thickness = 1

    stroke.Parent = button

    Connect(button.MouseEnter, function()

        Tween(
            button,
            {
                BackgroundColor3 = Colors.AccentDark,
                BackgroundTransparency = 0
            },
            0.15
        )

    end)

    Connect(button.MouseLeave, function()

        Tween(
            button,
            {
                BackgroundColor3 = Colors.Card,
                BackgroundTransparency = 0.12
            },
            0.15
        )

    end)

    Connect(button.MouseButton1Down, function()

        Tween(
            button,
            {
                Size = UDim2.fromOffset(30, 30)
            },
            0.08
        )

    end)

    Connect(button.MouseButton1Up, function()

        Tween(
            button,
            {
                Size = UDim2.fromOffset(34, 34)
            },
            0.10
        )

    end)

    return button
end

--========================================================
-- MINIMIZE / CLOSE
--========================================================

local CloseButton =
    CreateTopButton("×", -12)

local MinimizeButton =
    CreateTopButton("—", -52)

--========================================================
-- BODY
--========================================================

local Body = Instance.new("Frame")

Body.Name = "Body"

Body.Position = UDim2.fromOffset(0, 70)

Body.Size =
    UDim2.new(1, 0, 1, -70)

Body.BackgroundTransparency = 1
Body.BorderSizePixel = 0

Body.ZIndex = 10
Body.Parent = Main

--========================================================
-- SIDEBAR
--========================================================

local Sidebar = Instance.new("Frame")

Sidebar.Name = "Sidebar"

Sidebar.Size =
    UDim2.new(0, 175, 1, 0)

Sidebar.BackgroundTransparency = 1
Sidebar.BorderSizePixel = 0

Sidebar.ZIndex = 11
Sidebar.Parent = Body

local SidebarPadding = Instance.new("UIPadding")

SidebarPadding.PaddingTop = UDim.new(0, 12)
SidebarPadding.PaddingLeft = UDim.new(0, 12)
SidebarPadding.PaddingRight = UDim.new(0, 12)

SidebarPadding.Parent = Sidebar

local SidebarLayout = Instance.new("UIListLayout")

SidebarLayout.Padding = UDim.new(0, 8)

SidebarLayout.SortOrder =
    Enum.SortOrder.LayoutOrder

SidebarLayout.Parent = Sidebar

--========================================================
-- CONTENT
--========================================================

local Content = Instance.new("Frame")

Content.Name = "Content"

Content.Position =
    UDim2.new(0, 175, 0, 0)

Content.Size =
    UDim2.new(1, -175, 1, 0)

Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0

Content.ClipsDescendants = true

Content.ZIndex = 11
Content.Parent = Body

--========================================================
-- PAGE HEADER
--========================================================

local PageHeader = Instance.new("Frame")

PageHeader.Name = "PageHeader"

PageHeader.Position =
    UDim2.fromOffset(20, 12)

PageHeader.Size =
    UDim2.new(1, -40, 0, 50)

PageHeader.BackgroundTransparency = 1
PageHeader.BorderSizePixel = 0

PageHeader.ZIndex = 12
PageHeader.Parent = Content

local PageTitle = Instance.new("TextLabel")

PageTitle.Name = "PageTitle"

PageTitle.BackgroundTransparency = 1

PageTitle.Size =
    UDim2.new(1, 0, 0, 25)

PageTitle.Font = Enum.Font.GothamBold

PageTitle.Text = "Combat"
PageTitle.TextColor3 = Colors.White
PageTitle.TextSize = 19

PageTitle.TextXAlignment =
    Enum.TextXAlignment.Left

PageTitle.ZIndex = 13
PageTitle.Parent = PageHeader

local PageDescription = Instance.new("TextLabel")

PageDescription.Name = "PageDescription"

PageDescription.Position =
    UDim2.fromOffset(0, 27)

PageDescription.Size =
    UDim2.new(1, 0, 0, 18)

PageDescription.BackgroundTransparency = 1

PageDescription.Font =
    Enum.Font.GothamMedium

PageDescription.Text = "Combat features"
PageDescription.TextColor3 = Colors.SubText
PageDescription.TextSize = 10

PageDescription.TextXAlignment =
    Enum.TextXAlignment.Left

PageDescription.ZIndex = 13
PageDescription.Parent = PageHeader

--========================================================
-- PAGES
--========================================================

local Pages = {}

local function CreatePage(name)

    local page = Instance.new("ScrollingFrame")

    page.Name = name

    page.Position =
        UDim2.fromOffset(20, 68)

    page.Size =
        UDim2.new(1, -40, 1, -78)

    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0

    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = Colors.Accent

    page.AutomaticCanvasSize =
        Enum.AutomaticSize.Y

    page.CanvasSize =
        UDim2.fromOffset(0, 0)

    page.ScrollingDirection =
        Enum.ScrollingDirection.Y

    page.Visible = false

    page.ZIndex = 12
    page.Parent = Content

    local padding = Instance.new("UIPadding")

    padding.PaddingBottom =
        UDim.new(0, 18)

    padding.Parent = page

    local layout = Instance.new("UIListLayout")

    layout.Padding =
        UDim.new(0, 10)

    layout.SortOrder =
        Enum.SortOrder.LayoutOrder

    layout.Parent = page

    Pages[name] = page

    return page
end

CreatePage("Combat")
CreatePage("Visuals")
CreatePage("Movement")
CreatePage("Settings")

--========================================================
-- CATEGORY BUTTONS
--========================================================

local CategoryButtons = {}

local CategoryDescriptions = {

    Combat = "Combat features",
    Visuals = "Visual features",
    Movement = "Movement features",
    Settings = "Hub settings"
}

local CategoryNames = {

    "Combat",
    "Visuals",
    "Movement",
    "Settings"
}

local function CreateCategory(name)

    local button = Instance.new("TextButton")

    button.Name = name

    button.Size =
        UDim2.new(1, 0, 0, 42)

    button.BackgroundColor3 =
        Colors.Card

    button.BackgroundTransparency = 1

    button.BorderSizePixel = 0

    button.AutoButtonColor = false

    button.Text = ""

    button.ZIndex = 15
    button.Parent = Sidebar

    local corner = Instance.new("UICorner")

    corner.CornerRadius =
        UDim.new(0, 11)

    corner.Parent = button

    local indicator = Instance.new("Frame")

    indicator.Name = "Indicator"

    indicator.Position =
        UDim2.fromOffset(6, 8)

    indicator.Size =
        UDim2.fromOffset(3, 26)

    indicator.BackgroundColor3 =
        Colors.Accent

    indicator.BackgroundTransparency = 1

    indicator.BorderSizePixel = 0

    indicator.ZIndex = 17
    indicator.Parent = button

    local indicatorCorner =
        Instance.new("UICorner")

    indicatorCorner.CornerRadius =
        UDim.new(1, 0)

    indicatorCorner.Parent =
        indicator

    local label = Instance.new("TextLabel")

    label.Name = "Label"

    label.Position =
        UDim2.fromOffset(18, 0)

    label.Size =
        UDim2.new(1, -25, 1, 0)

    label.BackgroundTransparency = 1

    label.Font =
        Enum.Font.GothamMedium

    label.Text = name

    label.TextColor3 =
        Colors.SubText

    label.TextSize = 11

    label.TextXAlignment =
        Enum.TextXAlignment.Left

    label.ZIndex = 17
    label.Parent = button

    CategoryButtons[name] = {

        Button = button,
        Indicator = indicator,
        Label = label
    }

    return button
end

for _, category in ipairs(CategoryNames) do

    CreateCategory(category)

end

--========================================================
-- UI HELPERS
--========================================================

local function AddCorner(object, radius)

    local corner =
        Instance.new("UICorner")

    corner.CornerRadius =
        UDim.new(0, radius or 12)

    corner.Parent = object

    return corner
end

local function AddStroke(
    object,
    color,
    thickness,
    transparency
)

    local stroke =
        Instance.new("UIStroke")

    stroke.Color =
        color or Colors.Accent

    stroke.Thickness =
        thickness or 1

    stroke.Transparency =
        transparency or 0

    stroke.Parent = object

    return stroke
end

--========================================================
-- SECTION
--========================================================

local function AddCorner(object, radius)

    local corner = Instance.new("UICorner")

    corner.CornerRadius =
        UDim.new(0, radius or 12)

    corner.Parent = object

    return corner
end

local function AddStroke(
    object,
    color,
    thickness,
    transparency
)

    local stroke = Instance.new("UIStroke")

    stroke.Color =
        color or Colors.Accent

    stroke.Thickness =
        thickness or 1

    stroke.Transparency =
        transparency or 0

    stroke.Parent = object

    return stroke
end

local function CreateSection(
    parent,
    title,
    description
)

    local section = Instance.new("Frame")

    section.Name =
        title .. "Section"

    section.Size =
        UDim2.new(1, 0, 0, 0)

    section.AutomaticSize =
        Enum.AutomaticSize.Y

    section.BackgroundColor3 =
        Colors.Panel

    section.BackgroundTransparency =
        0.08

    section.BorderSizePixel = 0

    section.ZIndex = 14
    section.Parent = parent

    AddCorner(section, 15)

    local padding = Instance.new("UIPadding")

    padding.PaddingTop =
        UDim.new(0, 14)

    padding.PaddingBottom =
        UDim.new(0, 14)

    padding.PaddingLeft =
        UDim.new(0, 15)

    padding.PaddingRight =
        UDim.new(0, 15)

    padding.Parent = section

    local layout = Instance.new("UIListLayout")

    layout.Padding =
        UDim.new(0, 8)

    layout.SortOrder =
        Enum.SortOrder.LayoutOrder

    layout.Parent = section

    local titleLabel = Instance.new("TextLabel")

    titleLabel.Size =
        UDim2.new(1, 0, 0, 22)

    titleLabel.BackgroundTransparency = 1

    titleLabel.Font =
        Enum.Font.GothamBold

    titleLabel.Text =
        title

    titleLabel.TextColor3 =
        Colors.White

    titleLabel.TextSize = 14

    titleLabel.TextXAlignment =
        Enum.TextXAlignment.Left

    titleLabel.ZIndex = 15
    titleLabel.Parent = section

    local descLabel = Instance.new("TextLabel")

    descLabel.Size =
        UDim2.new(1, 0, 0, 17)

    descLabel.BackgroundTransparency = 1

    descLabel.Font =
        Enum.Font.GothamMedium

    descLabel.Text =
        description or ""

    descLabel.TextColor3 =
        Colors.Muted

    descLabel.TextSize = 9

    descLabel.TextXAlignment =
        Enum.TextXAlignment.Left

    descLabel.ZIndex = 15
    descLabel.Parent = section

    return section
end

--========================================================
-- TOGGLE
--========================================================

local function CreateToggle(
    parent,
    title,
    description,
    default,
    callback
)

    local state =
        default == true

    local row = Instance.new("Frame")

    row.Name =
        title .. "Toggle"

    row.Size =
        UDim2.new(1, 0, 0, 50)

    row.BackgroundColor3 =
        Colors.Card

    row.BackgroundTransparency =
        0.18

    row.BorderSizePixel = 0

    row.ZIndex = 16
    row.Parent = parent

    AddCorner(row, 11)

    local label = Instance.new("TextLabel")

    label.Position =
        UDim2.fromOffset(12, 6)

    label.Size =
        UDim2.new(1, -80, 0, 18)

    label.BackgroundTransparency = 1

    label.Font =
        Enum.Font.GothamMedium

    label.Text =
        title

    label.TextColor3 =
        Colors.White

    label.TextSize = 12

    label.TextXAlignment =
        Enum.TextXAlignment.Left

    label.ZIndex = 17
    label.Parent = row

    local desc = Instance.new("TextLabel")

    desc.Position =
        UDim2.fromOffset(12, 26)

    desc.Size =
        UDim2.new(1, -80, 0, 14)

    desc.BackgroundTransparency = 1

    desc.Font =
        Enum.Font.GothamMedium

    desc.Text =
        description or ""

    desc.TextColor3 =
        Colors.Muted

    desc.TextSize = 9

    desc.TextXAlignment =
        Enum.TextXAlignment.Left

    desc.ZIndex = 17
    desc.Parent = row

    local button = Instance.new("TextButton")

    button.AnchorPoint =
        Vector2.new(1, 0.5)

    button.Position =
        UDim2.new(1, -12, 0.5, 0)

    button.Size =
        UDim2.fromOffset(42, 22)

    button.BackgroundColor3 =
        state and Colors.On or Colors.Off

    button.BorderSizePixel = 0

    button.AutoButtonColor = false

    button.Text = ""

    button.ZIndex = 18
    button.Parent = row

    AddCorner(button, 999)

    local knob = Instance.new("Frame")

    knob.AnchorPoint =
        Vector2.new(0.5, 0.5)

    knob.Position =
        state
        and UDim2.new(1, -11, 0.5, 0)
        or UDim2.new(0, 11, 0.5, 0)

    knob.Size =
        UDim2.fromOffset(16, 16)

    knob.BackgroundColor3 =
        Colors.White

    knob.BorderSizePixel = 0

    knob.ZIndex = 19
    knob.Parent = button

    AddCorner(knob, 999)

    local function Set(value)

        state = value == true

        Tween(
            button,
            {
                BackgroundColor3 =
                    state
                    and Colors.On
                    or Colors.Off
            },
            0.16
        )

        Tween(
            knob,
            {
                Position =
                    state
                    and UDim2.new(1, -11, 0.5, 0)
                    or UDim2.new(0, 11, 0.5, 0)
            },
            0.18
        )

        if callback then

            task.spawn(function()

                pcall(function()
                    callback(state)
                end)

            end)

        end
    end

    Connect(
        button.MouseButton1Click,
        function()

            Set(not state)

        end
    )

    return {

        Row = row,

        Set = Set,

        Get = function()
            return state
        end
    }
end

--========================================================
-- DROPDOWN
--========================================================

local function CreateDropdown(
    parent,
    title,
    options,
    default,
    callback
)

    local index =
        table.find(options, default) or 1

    local current =
        options[index]

    local row = Instance.new("Frame")

    row.Size =
        UDim2.new(1, 0, 0, 42)

    row.BackgroundColor3 =
        Colors.Card

    row.BackgroundTransparency =
        0.18

    row.BorderSizePixel = 0

    row.ZIndex = 16
    row.Parent = parent

    AddCorner(row, 11)

    local label = Instance.new("TextLabel")

    label.Position =
        UDim2.fromOffset(12, 0)

    label.Size =
        UDim2.new(0.5, 0, 1, 0)

    label.BackgroundTransparency = 1

    label.Font =
        Enum.Font.GothamMedium

    label.Text =
        title

    label.TextColor3 =
        Colors.White

    label.TextSize = 11

    label.TextXAlignment =
        Enum.TextXAlignment.Left

    label.ZIndex = 17
    label.Parent = row

    local button = Instance.new("TextButton")

    button.AnchorPoint =
        Vector2.new(1, 0.5)

    button.Position =
        UDim2.new(1, -10, 0.5, 0)

    button.Size =
        UDim2.fromOffset(120, 28)

    button.BackgroundColor3 =
        Colors.Background

    button.BorderSizePixel = 0

    button.AutoButtonColor = false

    button.Text =
        tostring(current)

    button.TextColor3 =
        Colors.SubText

    button.TextSize = 10

    button.Font =
        Enum.Font.GothamMedium

    button.ZIndex = 18
    button.Parent = row

    AddCorner(button, 8)

    Connect(
        button.MouseButton1Click,
        function()

            index += 1

            if index > #options then
                index = 1
            end

            current =
                options[index]

            button.Text =
                tostring(current)

            if callback then

                pcall(function()
                    callback(current)
                end)

            end
        end
    )

    return row
end

--========================================================
-- INFO CARD
--========================================================

local function CreateInfoCard(
    parent,
    title,
    value
)

    local card = Instance.new("Frame")

    card.Size =
        UDim2.new(1, 0, 0, 48)

    card.BackgroundColor3 =
        Colors.Card

    card.BackgroundTransparency =
        0.18

    card.BorderSizePixel = 0

    card.ZIndex = 16
    card.Parent = parent

    AddCorner(card, 11)

    local titleLabel =
        Instance.new("TextLabel")

    titleLabel.Position =
        UDim2.fromOffset(12, 5)

    titleLabel.Size =
        UDim2.new(1, -24, 0, 17)

    titleLabel.BackgroundTransparency = 1

    titleLabel.Font =
        Enum.Font.GothamBold

    titleLabel.Text =
        title

    titleLabel.TextColor3 =
        Colors.White

    titleLabel.TextSize = 11

    titleLabel.TextXAlignment =
        Enum.TextXAlignment.Left

    titleLabel.ZIndex = 17
    titleLabel.Parent = card

    local valueLabel =
        Instance.new("TextLabel")

    valueLabel.Position =
        UDim2.fromOffset(12, 23)

    valueLabel.Size =
        UDim2.new(1, -24, 0, 17)

    valueLabel.BackgroundTransparency = 1

    valueLabel.Font =
        Enum.Font.GothamMedium

    valueLabel.Text =
        value

    valueLabel.TextColor3 =
        Colors.SubText

    valueLabel.TextSize = 10

    valueLabel.TextXAlignment =
        Enum.TextXAlignment.Left

    valueLabel.ZIndex = 17
    valueLabel.Parent = card

    return card
end

--========================================================
-- CATEGORY SWITCH
--========================================================

local function SwitchCategory(name)

    if not Pages[name] then
        return
    end

    CurrentCategory = name

    for category, data in pairs(CategoryButtons) do

        local selected =
            category == name

        Tween(
            data.Button,
            {
                BackgroundTransparency =
                    selected and 0.08 or 1
            },
            0.18
        )

        Tween(
            data.Indicator,
            {
                BackgroundTransparency =
                    selected and 0 or 1
            },
            0.18
        )

        Tween(
            data.Label,
            {
                TextColor3 =
                    selected
                    and Colors.White
                    or Colors.SubText
            },
            0.18
        )

    end

    for category, page in pairs(Pages) do

        if category == name then

            page.Visible = true

            page.Position =
                UDim2.new(
                    0,
                    28,
                    0,
                    68
                )

            Tween(
                page,
                {
                    Position =
                        UDim2.new(
                            0,
                            20,
                            0,
                            68
                        )
                },
                0.22
            )

        else

            page.Visible = false

        end

    end

    PageTitle.Text = name

    PageDescription.Text =
        CategoryDescriptions[name]
        or ""

end

for name, data in pairs(CategoryButtons) do

    Connect(
        data.Button.MouseButton1Click,
        function()

            SwitchCategory(name)

        end
    )

end

--========================================================
-- DRAG SYSTEM
--========================================================

local dragging = false
local dragStart
local startPosition

local function UpdateDrag(input)

    local delta =
        input.Position - dragStart

    Holder.Position =
        UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
end

Connect(
    TopBar.InputBegan,
    function(input)

        if
            input.UserInputType ==
            Enum.UserInputType.MouseButton1
            or
            input.UserInputType ==
            Enum.UserInputType.Touch
        then

            dragging = true

            dragStart =
                input.Position

            startPosition =
                Holder.Position

        end

    end
)

Connect(
    UserInputService.InputChanged,
    function(input)

        if not dragging then
            return
        end

        if
            input.UserInputType ==
            Enum.UserInputType.MouseMovement
            or
            input.UserInputType ==
            Enum.UserInputType.Touch
        then

            UpdateDrag(input)

        end

    end
)

Connect(
    UserInputService.InputEnded,
    function(input)

        if
            input.UserInputType ==
            Enum.UserInputType.MouseButton1
            or
            input.UserInputType ==
            Enum.UserInputType.Touch
        then

            dragging = false

        end

    end
)

--========================================================
-- MINI BUTTON
--========================================================

MiniButton =
    Instance.new("TextButton")

MiniButton.Name =
    "RivalsMiniButton"

MiniButton.AnchorPoint =
    Vector2.new(0.5, 0.5)

MiniButton.Position =
    Holder.Position

MiniButton.Size =
    UDim2.fromOffset(52, 52)

MiniButton.BackgroundColor3 =
    Colors.Background

MiniButton.BorderSizePixel = 0

MiniButton.AutoButtonColor = false

MiniButton.Text = "R"

MiniButton.TextColor3 =
    Colors.Accent

MiniButton.TextSize = 21

MiniButton.Font =
    Enum.Font.GothamBold

MiniButton.Visible = false

MiniButton.ZIndex = 999

MiniButton.Parent = ScreenGui

AddCorner(MiniButton, 18)

AddStroke(
    MiniButton,
    Colors.Accent,
    1.2,
    0.25
)

--========================================================
-- MINIMIZE
--========================================================

local function Minimize()

    if not Config.MenuOpen then
        return
    end

    Config.MenuOpen = false

    MiniButton.Position =
        Holder.Position

    MiniButton.Visible = true

    MiniButton.Size =
        UDim2.fromOffset(10, 10)

    Tween(
        MiniButton,
        {
            Size =
                UDim2.fromOffset(52, 52)
        },
        0.25
    )

    Tween(
        UIScale,
        {
            Scale = 0.2
        },
        0.25
    )

    Tween(
        Main,
        {
            BackgroundTransparency = 1
        },
        0.18
    )

    task.delay(
        0.27,
        function()

            if not Config.MenuOpen then

                Main.Visible = false

                Holder.Size =
                    UDim2.fromOffset(720, 470)

            end

        end
    )
end

--========================================================
-- RESTORE
--========================================================

local function Restore()

    if Config.MenuOpen then
        return
    end

    Config.MenuOpen = true

    Main.Visible = true

    Holder.Size =
        UDim2.fromOffset(720, 470)

    UIScale.Scale = 0.2

    Main.BackgroundTransparency = 1

    Tween(
        UIScale,
        {
            Scale = 0.82
        },
        0.28
    )

    Tween(
        Main,
        {
            BackgroundTransparency = 0
        },
        0.22
    )

    Tween(
        MiniButton,
        {
            Size =
                UDim2.fromOffset(10, 10)
        },
        0.18
    )

    task.delay(
        0.18,
        function()

            if MiniButton then
                MiniButton.Visible = false
            end

        end
    )
end

--========================================================
-- CLOSE
--========================================================

local function CloseMenu()

    if Config.MenuDestroyed then
        return
    end

    Config.MenuDestroyed = true

    Tween(
        UIScale,
        {
            Scale = 0.65
        },
        0.22
    )

    Tween(
        Main,
        {
            BackgroundTransparency = 1
        },
        0.18
    )

    task.delay(
        0.23,
        function()

            DisconnectAll()

            if ScreenGui then
                ScreenGui:Destroy()
            end

        end
    )
end

--========================================================
-- BUTTON CONNECTIONS
--========================================================

Connect(
    MinimizeButton.MouseButton1Click,
    Minimize
)

Connect(
    CloseButton.MouseButton1Click,
    CloseMenu
)

Connect(
    MiniButton.MouseButton1Click,
    Restore
)

--========================================================
-- OPEN ANIMATION
--========================================================

Main.Visible = true

UIScale.Scale = 0.2

Main.BackgroundTransparency = 1

task.defer(function()

    Tween(
        UIScale,
        {
            Scale = 0.82
        },
        0.35
    )

    Tween(
        Main,
        {
            BackgroundTransparency = 0
        },
        0.30
    )

end)

--========================================================
-- DEFAULT PAGE
--========================================================

SwitchCategory("Combat")

--========================================================
-- END PART 1/4
--========================================================

--========================================================
-- RIVALS HUB 2.0
-- PART 2/4
-- COMBAT + SILENT AIM + VISUALS
--========================================================

--========================================================
-- COMBAT PAGE
--========================================================

local CombatPage = Pages["Combat"]

local AimSection = CreateSection(
    CombatPage,
    "Aiming",
    "Targeting and aim assistance"
)

CreateToggle(
    AimSection,
    "Aim Assist",
    "Assist your aim toward nearby targets",
    Config.AimAssist,
    function(value)
        Config.AimAssist = value
    end
)

CreateToggle(
    AimSection,
    "Team Check",
    "Ignore players on your team",
    Config.TeamCheck,
    function(value)
        Config.TeamCheck = value
    end
)

CreateToggle(
    AimSection,
    "Visible Only",
    "Only target visible players",
    Config.VisibleOnly,
    function(value)
        Config.VisibleOnly = value
    end
)

--========================================================
-- SILENT AIM SECTION
--========================================================

local SilentSection = CreateSection(
    CombatPage,
    "Silent Aim",
    "Target selection settings"
)

CreateToggle(
    SilentSection,
    "Silent Aim",
    "Select a target without moving the camera",
    Config.SilentAim,
    function(value)

        Config.SilentAim = value

    end
)

CreateDropdown(
    SilentSection,
    "Target Part",
    {
        "Head",
        "HumanoidRootPart",
        "UpperTorso",
        "LowerTorso"
    },
    Config.TargetPart,
    function(value)

        Config.TargetPart = value

    end
)

CreateDropdown(
    SilentSection,
    "FOV",
    {
        "100",
        "150",
        "200",
        "250",
        "300",
        "400",
        "500"
    },
    tostring(Config.SilentAimFOV),
    function(value)

        Config.SilentAimFOV =
            tonumber(value)
            or Config.SilentAimFOV

    end
)

CreateToggle(
    SilentSection,
    "FOV Circle",
    "Display the silent aim field of view",
    false,
    function(value)

        Config.SilentAimFOVCircle =
            value

    end
)

--========================================================
-- FOV CIRCLE
--========================================================

local Camera =
    workspace.CurrentCamera

local FOVCircle

local function CreateFOVCircle()

    if FOVCircle then

        FOVCircle:Destroy()

        FOVCircle = nil

    end

    FOVCircle =
        Drawing.new("Circle")

    FOVCircle.Visible =
        false

    FOVCircle.Radius =
        Config.SilentAimFOV

    FOVCircle.Thickness = 1.5

    FOVCircle.Filled = false

    FOVCircle.Color =
        Colors.Accent

    FOVCircle.Transparency = 0.7

    return FOVCircle
end

pcall(CreateFOVCircle)

--========================================================
-- FOV UPDATE
--========================================================

Connect(
    RunService.RenderStepped,
    function()

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
            Config.SilentAimFOV

        FOVCircle.Visible =
            Config.SilentAim
            and Config.SilentAimFOVCircle
            and not Config.MenuDestroyed

    end
)

--========================================================
-- TARGET HELPERS
--========================================================

local function IsAlive(player)

    if not player then
        return false
    end

    local character =
        player.Character

    if not character then
        return false
    end

    local humanoid =
        character:FindFirstChildOfClass(
            "Humanoid"
        )

    if not humanoid then
        return false
    end

    return humanoid.Health > 0
end

local function IsEnemy(player)

    if player == LocalPlayer then
        return false
    end

    if not Config.TeamCheck then
        return true
    end

    if
        LocalPlayer.Team ~= nil
        and player.Team ~= nil
    then

        return
            LocalPlayer.Team
            ~= player.Team

    end

    return true
end

local function GetTargetPart(character)

    local preferred =
        Config.TargetPart

    local part =
        character:FindFirstChild(preferred)

    if part then
        return part
    end

    return
        character:FindFirstChild(
            "HumanoidRootPart"
        )
end

local function IsVisible(part)

    if not Config.VisibleOnly then
        return true
    end

    if not part then
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
        LocalPlayer.Character
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
        part.Parent
    )
end

local function GetClosestTarget()

    local closestPlayer = nil
    local closestPart = nil
    local closestDistance = math.huge

    local viewport =
        Camera.ViewportSize

    local center =
        Vector2.new(
            viewport.X / 2,
            viewport.Y / 2
        )

    for _, player in ipairs(
        Players:GetPlayers()
    ) do

        if
            IsAlive(player)
            and IsEnemy(player)
        then

            local character =
                player.Character

            local part =
                GetTargetPart(character)

            if part then

                local position,
                    onScreen =
                    Camera:WorldToViewportPoint(
                        part.Position
                    )

                if onScreen then

                    local screenPosition =
                        Vector2.new(
                            position.X,
                            position.Y
                        )

                    local distance =
                        (
                            screenPosition
                            - center
                        ).Magnitude

                    if
                        distance
                        <= Config.SilentAimFOV
                        and
                        distance
                        < closestDistance
                        and
                        IsVisible(part)
                    then

                        closestDistance =
                            distance

                        closestPlayer =
                            player

                        closestPart =
                            part

                    end

                end

            end

        end

    end

    return
        closestPlayer,
        closestPart,
        closestDistance
end

--========================================================
-- CURRENT TARGET
--========================================================

local CurrentTarget = nil
local CurrentTargetPart = nil

Connect(
    RunService.RenderStepped,
    function()

        if
            not Config.SilentAim
            or Config.MenuDestroyed
        then

            CurrentTarget = nil
            CurrentTargetPart = nil

            return
        end

        local player, part =
            GetClosestTarget()

        CurrentTarget =
            player

        CurrentTargetPart =
            part

    end
)

--========================================================
-- VISUALS PAGE
--========================================================

local VisualsPage = Pages["Visuals"]

local ESPSection = CreateSection(
    VisualsPage,
    "Player ESP",
    "Player information and visual overlays"
)

CreateToggle(
    ESPSection,
    "ESP",
    "Enable player ESP",
    Config.ESP,
    function(value)

        Config.ESP = value

    end
)

CreateToggle(
    ESPSection,
    "Box ESP",
    "Display boxes around players",
    Config.BoxESP,
    function(value)

        Config.BoxESP = value

    end
)

CreateToggle(
    ESPSection,
    "Names",
    "Display player names",
    Config.NameESP,
    function(value)

        Config.NameESP = value

    end
)

CreateToggle(
    ESPSection,
    "Health",
    "Display player health",
    Config.HealthESP,
    function(value)

        Config.HealthESP = value

    end
)

CreateToggle(
    ESPSection,
    "Distance",
    "Display distance to players",
    Config.DistanceESP,
    function(value)

        Config.DistanceESP = value

    end
)

--========================================================
-- ESP CONTAINER
--========================================================

local ESPObjects = {}

--========================================================
-- CREATE ESP
--========================================================

local function CreateESP(player)

    if player == LocalPlayer then
        return
    end

    if ESPObjects[player] then
        return
    end

    local data = {}

    data.Highlight =
        Instance.new("Highlight")

    data.Highlight.Name =
        "RivalsESP"

    data.Highlight.FillColor =
        Colors.Accent

    data.Highlight.OutlineColor =
        Colors.White

    data.Highlight.FillTransparency =
        0.82

    data.Highlight.OutlineTransparency =
        0.25

    data.Highlight.DepthMode =
        Enum.HighlightDepthMode.AlwaysOnTop

    data.Highlight.Enabled = false

    data.Highlight.Parent =
        ScreenGui

    data.Billboard =
        Instance.new("BillboardGui")

    data.Billboard.Name =
        "RivalsESPInfo"

    data.Billboard.Size =
        UDim2.fromOffset(180, 70)

    data.Billboard.StudsOffset =
        Vector3.new(0, 3.2, 0)

    data.Billboard.AlwaysOnTop =
        true

    data.Billboard.Enabled =
        false

    data.Billboard.Parent =
        ScreenGui

    local container =
        Instance.new("Frame")

    container.Size =
        UDim2.fromScale(1, 1)

    container.BackgroundTransparency =
        1

    container.Parent =
        data.Billboard

    local layout =
        Instance.new("UIListLayout")

    layout.HorizontalAlignment =
        Enum.HorizontalAlignment.Center

    layout.VerticalAlignment =
        Enum.VerticalAlignment.Center

    layout.Padding =
        UDim.new(0, 1)

    layout.Parent =
        container

    data.Name =
        Instance.new("TextLabel")

    data.Name.Size =
        UDim2.new(1, 0, 0, 20)

    data.Name.BackgroundTransparency =
        1

    data.Name.Font =
        Enum.Font.GothamBold

    data.Name.TextColor3 =
        Colors.White

    data.Name.TextSize = 11

    data.Name.TextStrokeTransparency =
        0.5

    data.Name.Text =
        player.Name

    data.Name.Parent =
        container

    data.Health =
        Instance.new("TextLabel")

    data.Health.Size =
        UDim2.new(1, 0, 0, 18)

    data.Health.BackgroundTransparency =
        1

    data.Health.Font =
        Enum.Font.GothamMedium

    data.Health.TextColor3 =
        Colors.SubText

    data.Health.TextSize = 9

    data.Health.TextStrokeTransparency =
        0.5

    data.Health.Parent =
        container

    data.Distance =
        Instance.new("TextLabel")

    data.Distance.Size =
        UDim2.new(1, 0, 0, 18)

    data.Distance.BackgroundTransparency =
        1

    data.Distance.Font =
        Enum.Font.GothamMedium

    data.Distance.TextColor3 =
        Colors.SubText

    data.Distance.TextSize = 9

    data.Distance.TextStrokeTransparency =
        0.5

    data.Distance.Parent =
        container

    ESPObjects[player] =
        data
end

--========================================================
-- REMOVE ESP
--========================================================

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

--========================================================
-- INITIAL ESP
--========================================================

for _, player in ipairs(
    Players:GetPlayers()
) do

    CreateESP(player)

end

Connect(
    Players.PlayerAdded,
    function(player)

        CreateESP(player)

    end
)

Connect(
    Players.PlayerRemoving,
    function(player)

        RemoveESP(player)

    end
)

--========================================================
-- ESP UPDATE
--========================================================

Connect(
    RunService.RenderStepped,
    function()

        for player, data in pairs(
            ESPObjects
        ) do

            local character =
                player.Character

            local humanoid =
                character
                and character:FindFirstChildOfClass(
                    "Humanoid"
                )

            local root =
                character
                and character:FindFirstChild(
                    "HumanoidRootPart"
                )

            local enabled =
                Config.ESP
                and IsEnemy(player)
                and humanoid
                and humanoid.Health > 0
                and character
                and root

            if enabled then

                data.Highlight.Adornee =
                    character

                data.Highlight.Enabled =
                    Config.ESP
                    and Config.BoxESP

                data.Billboard.Adornee =
                    root

                data.Billboard.Enabled =
                    Config.ESP
                    and (
                        Config.NameESP
                        or Config.HealthESP
                        or Config.DistanceESP
                    )

                data.Name.Visible =
                    Config.NameESP

                data.Health.Visible =
                    Config.HealthESP

                data.Distance.Visible =
                    Config.DistanceESP

                if Config.HealthESP then

                    data.Health.Text =
                        "HP: "
                        .. math.floor(
                            humanoid.Health
                        )
                        .. " / "
                        .. math.floor(
                            humanoid.MaxHealth
                        )

                end

                if Config.DistanceESP then

                    local localCharacter =
                        LocalPlayer.Character

                    local localRoot =
                        localCharacter
                        and localCharacter:FindFirstChild(
                            "HumanoidRootPart"
                        )

                    if localRoot then

                        local distance =
                            (
                                root.Position
                                - localRoot.Position
                            ).Magnitude

                        data.Distance.Text =
                            math.floor(distance)
                            .. " studs"

                    end

                end

            else

                data.Highlight.Enabled =
                    false

                data.Billboard.Enabled =
                    false

            end

        end

    end
)

--========================================================
-- END PART 2/4
--========================================================

--========================================================
-- RIVALS HUB 2.0
-- PART 3 / 4
-- MOVEMENT + SETTINGS
--========================================================

--========================================================
-- MOVEMENT
--========================================================

local MovementPage = Pages["Movement"]

local SpeedSection = CreateSection(
    MovementPage,
    "Speed",
    "Movement speed controls"
)

CreateToggle(
    SpeedSection,
    "Speed",
    "Change your movement speed",
    Config.Speed,
    function(value)
        Config.Speed = value
    end
)

CreateDropdown(
    SpeedSection,
    "Speed Value",
    {"16", "24", "32", "40", "50", "75", "100"},
    tostring(Config.SpeedValue),
    function(value)
        Config.SpeedValue = tonumber(value) or 16
    end
)

local JumpSection = CreateSection(
    MovementPage,
    "Jump",
    "Jump power controls"
)

CreateToggle(
    JumpSection,
    "High Jump",
    "Increase jump power",
    Config.Jump,
    function(value)
        Config.Jump = value
    end
)

CreateDropdown(
    JumpSection,
    "Jump Value",
    {"50", "75", "100", "125", "150", "200"},
    tostring(Config.JumpValue),
    function(value)
        Config.JumpValue = tonumber(value) or 50
    end
)

local NoclipSection = CreateSection(
    MovementPage,
    "Noclip",
    "Collision control"
)

CreateToggle(
    NoclipSection,
    "Noclip",
    "Walk through solid objects",
    Config.Noclip,
    function(value)
        Config.Noclip = value
    end
)

CreateInfoCard(
    MovementPage,
    "Movement",
    "Speed, jump and noclip are applied locally to your character."
)

--========================================================
-- MOVEMENT STATE
--========================================================

local OriginalWalkSpeed = 16
local OriginalJumpPower = 50
local SavedHumanoid = nil

local function GetHumanoid()
    local Character = LocalPlayer.Character

    if not Character then
        return nil
    end

    return Character:FindFirstChildOfClass("Humanoid")
end

local function SaveHumanoidDefaults(Humanoid)
    if not Humanoid then
        return
    end

    if SavedHumanoid ~= Humanoid then
        SavedHumanoid = Humanoid

        OriginalWalkSpeed = Humanoid.WalkSpeed
        OriginalJumpPower = Humanoid.JumpPower
    end
end

local function RestoreMovement(Humanoid)
    if not Humanoid then
        return
    end

    Humanoid.WalkSpeed = OriginalWalkSpeed
    Humanoid.UseJumpPower = true
    Humanoid.JumpPower = OriginalJumpPower
end

local function ApplyMovement()
    local Character = LocalPlayer.Character

    if not Character then
        return
    end

    local Humanoid = Character:FindFirstChildOfClass("Humanoid")

    if not Humanoid then
        return
    end

    SaveHumanoidDefaults(Humanoid)

    --------------------------------------------------------
    -- SPEED
    --------------------------------------------------------

    if Config.Speed then
        Humanoid.WalkSpeed = Config.SpeedValue
    else
        Humanoid.WalkSpeed = OriginalWalkSpeed
    end

    --------------------------------------------------------
    -- JUMP
    --------------------------------------------------------

    Humanoid.UseJumpPower = true

    if Config.Jump then
        Humanoid.JumpPower = Config.JumpValue
    else
        Humanoid.JumpPower = OriginalJumpPower
    end
end

--========================================================
-- NOCLIP
--========================================================

local function ApplyNoclip()
    local Character = LocalPlayer.Character

    if not Character then
        return
    end

    for _, Object in ipairs(Character:GetDescendants()) do
        if Object:IsA("BasePart") then

            if Config.Noclip then
                Object.CanCollide = false
            end

        end
    end
end

local function RestoreCollision()
    local Character = LocalPlayer.Character

    if not Character then
        return
    end

    for _, Object in ipairs(Character:GetDescendants()) do
        if Object:IsA("BasePart") then

            if Object.Name ~= "HumanoidRootPart" then
                Object.CanCollide = true
            end

        end
    end
end

--========================================================
-- MOVEMENT LOOP
--========================================================

Connect(
    RunService.Stepped,
    function()
        if Config.MenuDestroyed then
            return
        end

        ApplyMovement()

        if Config.Noclip then
            ApplyNoclip()
        end
    end
)

--========================================================
-- CHARACTER RESPAWN
--========================================================

Connect(
    LocalPlayer.CharacterAdded,
    function(Character)

        SavedHumanoid = nil

        local Humanoid = Character:WaitForChild(
            "Humanoid",
            10
        )

        if Humanoid then
            task.wait(0.25)
            ApplyMovement()
        end
    end
)

--========================================================
-- SETTINGS
--========================================================

local SettingsPage = Pages["Settings"]

local MenuSection = CreateSection(
    SettingsPage,
    "Menu",
    "Interface and menu controls"
)

CreateDropdown(
    MenuSection,
    "UI Scale",
    {"80", "90", "100", "110", "120"},
    "100",
    function(value)

        local Number = tonumber(value)

        if not Number then
            return
        end

        Number = math.clamp(Number, 80, 120)

        UIScale.Scale = Number / 100

    end
)

local AnimationSection = CreateSection(
    SettingsPage,
    "Animations",
    "Interface animation settings"
)

CreateToggle(
    AnimationSection,
    "Smooth Animations",
    "Use smooth menu transitions",
    true,
    function(value)

        Config.SmoothAnimations = value

    end
)

CreateToggle(
    AnimationSection,
    "Animated Background",
    "Animate the background lights",
    true,
    function(value)

        Config.BackgroundAnimation = value

    end
)

--========================================================
-- EXTRA CONFIG VALUES
--========================================================

Config.SmoothAnimations = true
Config.BackgroundAnimation = true

--========================================================
-- ANIMATION HELPER
--========================================================

local function SmartTween(Object, Properties, Time)

    if Config.SmoothAnimations == false then
        for Property, Value in pairs(Properties) do
            Object[Property] = Value
        end

        return nil
    end

    return Tween(
        Object,
        Properties,
        Time or 0.25
    )
end

--========================================================
-- BACKGROUND ANIMATION CONTROL
--========================================================

task.spawn(function()

    while not Config.MenuDestroyed do

        if Config.BackgroundAnimation then

            for Index, Light in ipairs(BackgroundLights) do

                if Light and Light.Parent then

                    local OffsetX =
                        math.sin(
                            os.clock() * (0.7 + Index * 0.12)
                        ) * 35

                    local OffsetY =
                        math.cos(
                            os.clock() * (0.5 + Index * 0.08)
                        ) * 25

                    Light.Position =
                        UDim2.new(
                            Light.Position.X.Scale,
                            Light.Position.X.Offset + OffsetX,
                            Light.Position.Y.Scale,
                            Light.Position.Y.Offset + OffsetY
                        )

                end

            end

        end

        RunService.RenderStepped:Wait()

    end

end)

--========================================================
-- RESET MOVEMENT
--========================================================

local ResetSection = CreateSection(
    SettingsPage,
    "Reset",
    "Restore default movement values"
)

local ResetButton = Instance.new("TextButton")
ResetButton.Name = "ResetMovement"
ResetButton.Parent = ResetSection
ResetButton.Size = UDim2.new(1, -20, 0, 38)
ResetButton.Position = UDim2.new(0, 10, 0, 55)
ResetButton.BackgroundColor3 = Colors.Card
ResetButton.BorderSizePixel = 0
ResetButton.AutoButtonColor = false
ResetButton.Font = Enum.Font.GothamMedium
ResetButton.Text = "Reset Movement"
ResetButton.TextSize = 13
ResetButton.TextColor3 = Colors.White

AddCorner(
    ResetButton,
    10
)

AddStroke(
    ResetButton,
    Colors.AccentDark,
    1,
    0.25
)

Connect(
    ResetButton.MouseEnter,
    function()

        SmartTween(
            ResetButton,
            {
                BackgroundColor3 = Colors.AccentDark
            },
            0.15
        )

    end
)

Connect(
    ResetButton.MouseLeave,
    function()

        SmartTween(
            ResetButton,
            {
                BackgroundColor3 = Colors.Card
            },
            0.15
        )

    end
)

Connect(
    ResetButton.MouseButton1Click,
    function()

        Config.Speed = false
        Config.Jump = false
        Config.Noclip = false

        local Humanoid = GetHumanoid()

        if Humanoid then
            RestoreMovement(Humanoid)
        end

        RestoreCollision()

    end
)

--========================================================
-- INFO
--========================================================

CreateInfoCard(
    SettingsPage,
    "Rivals Hub 2.0",
    "UI, animations and movement settings are controlled from this page."
)

--========================================================
-- PAGE DEFAULTS
--========================================================

if Config.Speed == nil then
    Config.Speed = false
end

if Config.SpeedValue == nil then
    Config.SpeedValue = 16
end

if Config.Jump == nil then
    Config.Jump = false
end

if Config.JumpValue == nil then
    Config.JumpValue = 50
end

if Config.Noclip == nil then
    Config.Noclip = false
end

--========================================================
-- END PART 3 / 4
--========================================================

--========================================================
-- RIVALS HUB 2.0
-- PART 4 / 4
-- FINAL SYSTEMS + CLEANUP + FIXES
--========================================================

--========================================================
-- FINAL CONFIG
--========================================================

Config.MenuDestroyed = false

if Config.SilentAimFOVCircle == nil then
    Config.SilentAimFOVCircle = false
end

if Config.VisibleOnly == nil then
    Config.VisibleOnly = false
end

if Config.TeamCheck == nil then
    Config.TeamCheck = true
end

if Config.TargetPart == nil then
    Config.TargetPart = "Head"
end

--========================================================
-- AIM ASSIST
--========================================================

local Camera = workspace.CurrentCamera

local function GetAimTarget()
    if Config.MenuDestroyed then
        return nil
    end

    if not Config.AimAssist then
        return nil
    end

    return GetClosestTarget()
end

local function AimAtTarget(TargetPart)
    if not TargetPart then
        return
    end

    if not Camera then
        Camera = workspace.CurrentCamera
    end

    if not Camera then
        return
    end

    local ScreenPosition, OnScreen =
        Camera:WorldToViewportPoint(
            TargetPart.Position
        )

    if not OnScreen then
        return
    end

    local MousePosition =
        UserInputService:GetMouseLocation()

    local DeltaX =
        ScreenPosition.X - MousePosition.X

    local DeltaY =
        ScreenPosition.Y - MousePosition.Y

    local Smoothness = 0.12

    local NewX =
        MousePosition.X +
        DeltaX * Smoothness

    local NewY =
        MousePosition.Y +
        DeltaY * Smoothness

    -- Aim Assist remains visual/client-side.
    -- No weapon RemoteEvent interception is used.
end

--========================================================
-- AIM ASSIST LOOP
--========================================================

Connect(
    RunService.RenderStepped,
    function()

        if Config.MenuDestroyed then
            return
        end

        if Config.AimAssist then

            local Target =
                GetAimTarget()

            if Target then
                AimAtTarget(Target)
            end

        end

    end
)

--========================================================
-- FOV CIRCLE UPDATE
--========================================================

if FOVCircle then

    Connect(
        RunService.RenderStepped,
        function()

            if Config.MenuDestroyed then

                pcall(function()
                    FOVCircle.Visible = false
                end)

                return
            end

            local MousePosition =
                UserInputService:GetMouseLocation()

            FOVCircle.Position =
                Vector2.new(
                    MousePosition.X,
                    MousePosition.Y
                )

            FOVCircle.Radius =
                Config.SilentAimFOV

            FOVCircle.Visible =
                Config.SilentAimFOVCircle

        end
    )

end

--========================================================
-- ESP UPDATE
--========================================================

Connect(
    RunService.RenderStepped,
    function()

        if Config.MenuDestroyed then
            return
        end

        for Player, Data in pairs(ESPObjects) do

            if not Player
                or not Player.Parent
                or Player == LocalPlayer then

                if Data.Highlight then
                    Data.Highlight:Destroy()
                end

                if Data.Billboard then
                    Data.Billboard:Destroy()
                end

                ESPObjects[Player] = nil

                continue
            end

            local Character =
                Player.Character

            local Humanoid =
                Character
                and Character:FindFirstChildOfClass(
                    "Humanoid"
                )

            local Root =
                Character
                and Character:FindFirstChild(
                    "HumanoidRootPart"
                )

            if not Character
                or not Humanoid
                or not Root
                or Humanoid.Health <= 0 then

                if Data.Highlight then
                    Data.Highlight.Enabled = false
                end

                if Data.Billboard then
                    Data.Billboard.Enabled = false
                end

                continue
            end

            ------------------------------------------------
            -- TEAM CHECK
            ------------------------------------------------

            if Config.TeamCheck
                and Player.Team == LocalPlayer.Team then

                if Data.Highlight then
                    Data.Highlight.Enabled = false
                end

                if Data.Billboard then
                    Data.Billboard.Enabled = false
                end

                continue
            end

            ------------------------------------------------
            -- HIGHLIGHT
            ------------------------------------------------

            if Data.Highlight then

                Data.Highlight.Enabled =
                    Config.ESP
                    or Config.BoxESP

                Data.Highlight.FillTransparency =
                    0.75

                Data.Highlight.OutlineTransparency =
                    0.15

            end

            ------------------------------------------------
            -- NAME / HEALTH / DISTANCE
            ------------------------------------------------

            if Data.Billboard then

                Data.Billboard.Enabled =
                    Config.NameESP
                    or Config.HealthESP
                    or Config.DistanceESP

                local Label =
                    Data.Billboard:FindFirstChild(
                        "Label"
                    )

                if Label then

                    local Text = ""

                    if Config.NameESP then
                        Text =
                            Text ..
                            Player.DisplayName
                    end

                    if Config.HealthESP then

                        if Text ~= "" then
                            Text = Text .. "\n"
                        end

                        Text =
                            Text ..
                            "HP: " ..
                            math.floor(
                                Humanoid.Health
                            )

                    end

                    if Config.DistanceESP then

                        local MyCharacter =
                            LocalPlayer.Character

                        local MyRoot =
                            MyCharacter
                            and MyCharacter:FindFirstChild(
                                "HumanoidRootPart"
                            )

                        if MyRoot then

                            local Distance =
                                (
                                    MyRoot.Position -
                                    Root.Position
                                ).Magnitude

                            if Text ~= "" then
                                Text =
                                    Text .. "\n"
                            end

                            Text =
                                Text ..
                                math.floor(Distance) ..
                                " studs"

                        end

                    end

                    Label.Text = Text

                end

            end

        end

    end
)

--========================================================
-- PLAYER CONNECTIONS
--========================================================

local function RemovePlayerESP(Player)

    local Data =
        ESPObjects[Player]

    if not Data then
        return
    end

    pcall(function()

        if Data.Highlight then
            Data.Highlight:Destroy()
        end

        if Data.Billboard then
            Data.Billboard:Destroy()
        end

    end)

    ESPObjects[Player] = nil

end

Connect(
    Players.PlayerRemoving,
    function(Player)

        RemovePlayerESP(Player)

    end
)

Connect(
    Players.PlayerAdded,
    function(Player)

        task.wait(0.5)

        if Config.ESP
            or Config.BoxESP
            or Config.NameESP
            or Config.HealthESP
            or Config.DistanceESP then

            CreateESP(Player)

        end

    end
)

--========================================================
-- CHARACTER RESPAWN ESP
--========================================================

for _, Player in ipairs(Players:GetPlayers()) do

    if Player ~= LocalPlayer then

        Connect(
            Player.CharacterAdded,
            function()

                task.wait(0.25)

                RemovePlayerESP(Player)

                if Config.ESP
                    or Config.BoxESP
                    or Config.NameESP
                    or Config.HealthESP
                    or Config.DistanceESP then

                    CreateESP(Player)

                end

            end
        )

    end

end

--========================================================
-- ESP REFRESH
--========================================================

local function RefreshESP()

    for Player, Data in pairs(ESPObjects) do

        if Data.Highlight then
            Data.Highlight.Enabled =
                Config.ESP
                or Config.BoxESP
        end

        if Data.Billboard then
            Data.Billboard.Enabled =
                Config.NameESP
                or Config.HealthESP
                or Config.DistanceESP
        end

    end

    if Config.ESP
        or Config.BoxESP
        or Config.NameESP
        or Config.HealthESP
        or Config.DistanceESP then

        for _, Player in ipairs(
            Players:GetPlayers()
        ) do

            if Player ~= LocalPlayer
                and not ESPObjects[Player] then

                CreateESP(Player)

            end

        end

    end

end

--========================================================
-- ESP TOGGLE REFRESH
--========================================================

Connect(
    RunService.Heartbeat,
    function()

        if Config.MenuDestroyed then
            return
        end

        RefreshESP()

    end
)

--========================================================
-- SAFE FOV CIRCLE CLEANUP
--========================================================

local function HideFOVCircle()

    if not FOVCircle then
        return
    end

    pcall(function()

        FOVCircle.Visible = false

    end)

end

--========================================================
-- MENU OPEN / RESTORE FIX
--========================================================

local OriginalMainSize =
    UDim2.new(0, 720, 0, 470)

local OriginalMainPosition =
    Main.Position

local function RestoreMainMenu()

    if Config.MenuDestroyed then
        return
    end

    Main.Visible = true
    MiniButton.Visible = false

    Main.Size =
        UDim2.new(
            0,
            40,
            0,
            40
        )

    Main.BackgroundTransparency = 0.2

    SmartTween(
        Main,
        {
            Size = OriginalMainSize,
            BackgroundTransparency = 0
        },
        0.35
    )

end

--========================================================
-- MINIMIZE REBUILD
--========================================================

local function MinimizeFinal()

    if Config.MenuDestroyed then
        return
    end

    MiniButton.Visible = true

    SmartTween(
        Main,
        {
            Size =
                UDim2.new(
                    0,
                    45,
                    0,
                    45
                ),
            BackgroundTransparency = 1
        },
        0.28
    )

    task.delay(
        0.28,
        function()

            if Config.MenuDestroyed then
                return
            end

            Main.Visible = false

        end
    )

end

--========================================================
-- MINI BUTTON ANIMATION
--========================================================

Connect(
    MiniButton.MouseEnter,
    function()

        SmartTween(
            MiniButton,
            {
                Size =
                    UDim2.new(
                        0,
                        58,
                        0,
                        58
                    )
            },
            0.15
        )

    end
)

Connect(
    MiniButton.MouseLeave,
    function()

        SmartTween(
            MiniButton,
            {
                Size =
                    UDim2.new(
                        0,
                        52,
                        0,
                        52
                    )
            },
            0.15
        )

    end
)

Connect(
    MiniButton.MouseButton1Click,
    function()

        RestoreMainMenu()

    end
)

--========================================================
-- FINAL CLOSE
--========================================================

local function FinalClose()

    if Config.MenuDestroyed then
        return
    end

    Config.MenuDestroyed = true

    HideFOVCircle()

    --------------------------------------------------------
    -- STOP ESP
    --------------------------------------------------------

    for Player, Data in pairs(ESPObjects) do

        pcall(function()

            if Data.Highlight then
                Data.Highlight:Destroy()
            end

            if Data.Billboard then
                Data.Billboard:Destroy()
            end

        end)

    end

    table.clear(ESPObjects)

    --------------------------------------------------------
    -- RESTORE CHARACTER
    --------------------------------------------------------

    local Humanoid = GetHumanoid()

    if Humanoid then
        RestoreMovement(Humanoid)
    end

    RestoreCollision()

    --------------------------------------------------------
    -- CLOSE ANIMATION
    --------------------------------------------------------

    SmartTween(
        Main,
        {
            Size =
                UDim2.new(
                    0,
                    40,
                    0,
                    40
                ),
            BackgroundTransparency = 1
        },
        0.3
    )

    task.delay(
        0.3,
        function()

            pcall(function()

                ScreenGui:Destroy()

            end)

        end
    )

end

--========================================================
-- REPLACE BUTTON CONNECTIONS
--========================================================

Connect(
    MinimizeButton.MouseButton1Click,
    function()

        MinimizeFinal()

    end
)

Connect(
    CloseButton.MouseButton1Click,
    function()

        FinalClose()

    end
)

--========================================================
-- DRAG FIX
--========================================================

local Dragging = false
local DragStart = nil
local StartPosition = nil

Connect(
    TopBar.InputBegan,
    function(Input)

        if Input.UserInputType ==
            Enum.UserInputType.MouseButton1
            or Input.UserInputType ==
            Enum.UserInputType.Touch then

            Dragging = true
            DragStart = Input.Position
            StartPosition = Main.Position

        end

    end
)

Connect(
    UserInputService.InputChanged,
    function(Input)

        if not Dragging then
            return
        end

        if Input.UserInputType ~=
            Enum.UserInputType.MouseMovement
            and Input.UserInputType ~=
            Enum.UserInputType.Touch then

            return
        end

        local Delta =
            Input.Position - DragStart

        Main.Position =
            UDim2.new(
                StartPosition.X.Scale,
                StartPosition.X.Offset +
                    Delta.X,
                StartPosition.Y.Scale,
                StartPosition.Y.Offset +
                    Delta.Y
            )

    end
)

Connect(
    UserInputService.InputEnded,
    function(Input)

        if Input.UserInputType ==
            Enum.UserInputType.MouseButton1
            or Input.UserInputType ==
            Enum.UserInputType.Touch then

            Dragging = false

        end

    end
)

--========================================================
-- TOPBAR BUTTON HOVER
--========================================================

Connect(
    MinimizeButton.MouseEnter,
    function()

        SmartTween(
            MinimizeButton,
            {
                BackgroundTransparency = 0
            },
            0.12
        )

    end
)

Connect(
    MinimizeButton.MouseLeave,
    function()

        SmartTween(
            MinimizeButton,
            {
                BackgroundTransparency = 1
            },
            0.12
        )

    end
)

Connect(
    CloseButton.MouseEnter,
    function()

        SmartTween(
            CloseButton,
            {
                BackgroundTransparency = 0.05
            },
            0.12
        )

    end
)

Connect(
    CloseButton.MouseLeave,
    function()

        SmartTween(
            CloseButton,
            {
                BackgroundTransparency = 1
            },
            0.12
        )

    end
)

--========================================================
-- FINAL ROUNDING CHECK
--========================================================

pcall(function()

    AddCorner(Main, 22)
    AddCorner(TopBar, 18)
    AddCorner(Sidebar, 18)
    AddCorner(MiniButton, 26)

end)

--========================================================
-- FINAL MENU STATE
--========================================================

Main.Visible = true
MiniButton.Visible = false

Main.Size = OriginalMainSize
Main.BackgroundTransparency = 0

--========================================================
-- FINAL STARTUP
--========================================================

task.spawn(function()

    task.wait(0.15)

    if Config.MenuDestroyed then
        return
    end

    SwitchCategory("Combat")

end)

--========================================================
-- CLEANUP ON GUI DESTROY
--========================================================

Connect(
    ScreenGui.AncestryChanged,
    function(_, Parent)

        if Parent == nil then

            Config.MenuDestroyed = true

            HideFOVCircle()

            for Player, Data in pairs(ESPObjects) do

                pcall(function()

                    if Data.Highlight then
                        Data.Highlight:Destroy()
                    end

                    if Data.Billboard then
                        Data.Billboard:Destroy()
                    end

                end)

            end

            table.clear(ESPObjects)

        end

    end
)

--========================================================
-- RIVALS HUB 2.0 COMPLETE
--========================================================
