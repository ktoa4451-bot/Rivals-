--========================================================
-- RIVALS HUB 2.1
-- PART 1/4
-- CLEAN UI CORE
--========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--========================================================
-- CLEAN OLD GUI
--========================================================

pcall(function()
    local Old = PlayerGui:FindFirstChild("RivalsHub")

    if Old then
        Old:Destroy()
    end
end)

--========================================================
-- CONFIG
--========================================================

local Config = {

    -- Combat
    AimAssist = false,
    SilentAim = false,
    TargetPart = "Head",
    SilentAimFOV = 250,
    SilentAimFOVCircle = false,
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
    MenuDestroyed = false,
    SmoothAnimations = true,
    BackgroundAnimation = true,
    UIScale = 0.82
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

local TopBar
local Body
local Sidebar
local Content

local PageTitle
local PageDescription

local Background
local BackgroundLights = {}

local Pages = {}
local CategoryButtons = {}

--========================================================
-- CONNECTION MANAGER
--========================================================

local function Connect(Signal, Callback)

    local Connection =
        Signal:Connect(Callback)

    table.insert(
        Connections,
        Connection
    )

    return Connection
end

local function DisconnectAll()

    for _, Connection in ipairs(Connections) do

        pcall(function()
            Connection:Disconnect()
        end)

    end

    table.clear(Connections)

end

--========================================================
-- TWEEN
--========================================================

local function Tween(
    Object,
    Properties,
    Duration,
    Style,
    Direction
)

    if not Object
        or not Object.Parent then

        return nil
    end

    if Config.SmoothAnimations == false then

        for Property, Value in pairs(Properties) do
            Object[Property] = Value
        end

        return nil
    end

    local Info =
        TweenInfo.new(
            Duration or 0.25,
            Style or Enum.EasingStyle.Quart,
            Direction or Enum.EasingDirection.Out
        )

    local TweenObject =
        TweenService:Create(
            Object,
            Info,
            Properties
        )

    TweenObject:Play()

    return TweenObject

end

--========================================================
-- SCREEN GUI
--========================================================

local ScreenGui =
    Instance.new("ScreenGui")

ScreenGui.Name = "RivalsHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999
ScreenGui.ZIndexBehavior =
    Enum.ZIndexBehavior.Sibling

ScreenGui.Parent = PlayerGui

--========================================================
-- HOLDER
--========================================================

Holder =
    Instance.new("Frame")

Holder.Name = "Holder"

Holder.AnchorPoint =
    Vector2.new(0.5, 0.5)

Holder.Position =
    UDim2.fromScale(
        0.5,
        0.5
    )

Holder.Size =
    UDim2.fromOffset(
        720,
        470
    )

Holder.BackgroundTransparency = 1
Holder.BorderSizePixel = 0

Holder.Parent = ScreenGui

--========================================================
-- UI SCALE
--========================================================

local UIScale =
    Instance.new("UIScale")

UIScale.Scale =
    Config.UIScale

UIScale.Parent = Holder

--========================================================
-- MAIN
--========================================================

Main =
    Instance.new("Frame")

Main.Name = "Main"

Main.Size =
    UDim2.fromScale(
        1,
        1
    )

Main.BackgroundColor3 =
    Colors.Background

Main.BackgroundTransparency = 0

Main.BorderSizePixel = 0

Main.ClipsDescendants = true

Main.Parent = Holder

--========================================================
-- MAIN CORNER
--========================================================

local MainCorner =
    Instance.new("UICorner")

MainCorner.CornerRadius =
    UDim.new(
        0,
        22
    )

MainCorner.Parent = Main

--========================================================
-- MAIN STROKE
--========================================================

local MainStroke =
    Instance.new("UIStroke")

MainStroke.Color =
    Colors.Accent

MainStroke.Thickness = 1.2
MainStroke.Transparency = 0.30

MainStroke.Parent = Main

--========================================================
-- BACKGROUND
--========================================================

Background =
    Instance.new("Frame")

Background.Name =
    "AnimatedBackground"

Background.Size =
    UDim2.fromScale(
        1,
        1
    )

Background.Position =
    UDim2.fromScale(
        0,
        0
    )

Background.BackgroundTransparency = 1
Background.BorderSizePixel = 0
Background.ClipsDescendants = true
Background.ZIndex = 1

Background.Parent = Main

local BackgroundCorner =
    Instance.new("UICorner")

BackgroundCorner.CornerRadius =
    UDim.new(
        0,
        22
    )

BackgroundCorner.Parent =
    Background

--========================================================
-- BACKGROUND LIGHT
--========================================================

local function CreateLight(
    StartPosition,
    Size,
    Transparency
)

    local Light =
        Instance.new("Frame")

    Light.Name = "BackgroundLight"

    Light.AnchorPoint =
        Vector2.new(
            0.5,
            0.5
        )

    Light.Position =
        StartPosition

    Light.Size =
        Size

    Light.BackgroundColor3 =
        Colors.Accent

    Light.BackgroundTransparency =
        Transparency

    Light.BorderSizePixel = 0

    Light.ZIndex = 1

    Light.Parent =
        Background

    local Corner =
        Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(
            1,
            0
        )

    Corner.Parent =
        Light

    table.insert(
        BackgroundLights,
        {
            Object = Light,
            Start = StartPosition
        }
    )

    return Light

end

CreateLight(
    UDim2.fromScale(
        0.12,
        0.18
    ),
    UDim2.fromOffset(
        300,
        300
    ),
    0.91
)

CreateLight(
    UDim2.fromScale(
        0.84,
        0.27
    ),
    UDim2.fromOffset(
        340,
        340
    ),
    0.93
)

CreateLight(
    UDim2.fromScale(
        0.56,
        0.88
    ),
    UDim2.fromOffset(
        310,
        310
    ),
    0.94
)

CreateLight(
    UDim2.fromScale(
        0.18,
        0.78
    ),
    UDim2.fromOffset(
        230,
        230
    ),
    0.95
)

--========================================================
-- STABLE BACKGROUND ANIMATION
--========================================================

local BackgroundTime = 0

Connect(
    RunService.RenderStepped,
    function(DeltaTime)

        if Config.MenuDestroyed then
            return
        end

        if not Config.BackgroundAnimation then
            return
        end

        BackgroundTime += DeltaTime

        for Index, Data in ipairs(
            BackgroundLights
        ) do

            local XOffset =
                math.sin(
                    BackgroundTime *
                    (0.18 + Index * 0.025)
                ) *
                0.035

            local YOffset =
                math.cos(
                    BackgroundTime *
                    (0.15 + Index * 0.020)
                ) *
                0.030

            local Start =
                Data.Start

            Data.Object.Position =
                UDim2.fromScale(
                    Start.X.Scale + XOffset,
                    Start.Y.Scale + YOffset
                )

        end

    end
)

--========================================================
-- TOP BAR
--========================================================

TopBar =
    Instance.new("Frame")

TopBar.Name =
    "TopBar"

TopBar.Size =
    UDim2.new(
        1,
        0,
        0,
        70
    )

TopBar.BackgroundTransparency = 1
TopBar.BorderSizePixel = 0

TopBar.ZIndex = 20

TopBar.Parent = Main

--========================================================
-- LOGO CONTAINER
--========================================================

local LogoContainer =
    Instance.new("Frame")

LogoContainer.Name =
    "LogoContainer"

LogoContainer.AnchorPoint =
    Vector2.new(
        0,
        0.5
    )

LogoContainer.Position =
    UDim2.new(
        0,
        18,
        0.5,
        0
    )

LogoContainer.Size =
    UDim2.fromOffset(
        44,
        44
    )

LogoContainer.BackgroundColor3 =
    Colors.Card

LogoContainer.BackgroundTransparency =
    0.35

LogoContainer.BorderSizePixel = 0

LogoContainer.ZIndex = 22

LogoContainer.Parent = TopBar

local LogoCorner =
    Instance.new("UICorner")

LogoCorner.CornerRadius =
    UDim.new(
        1,
        0
    )

LogoCorner.Parent =
    LogoContainer

local LogoStroke =
    Instance.new("UIStroke")

LogoStroke.Color =
    Colors.Accent

LogoStroke.Thickness = 1
LogoStroke.Transparency = 0.45

LogoStroke.Parent =
    LogoContainer

--========================================================
-- LOGO
--========================================================

local Logo =
    Instance.new("TextLabel")

Logo.Name = "Logo"

Logo.Size =
    UDim2.fromScale(
        1,
        1
    )

Logo.BackgroundTransparency = 1

Logo.Font =
    Enum.Font.GothamBold

Logo.Text = "R"

Logo.TextColor3 =
    Colors.Accent

Logo.TextSize = 24

Logo.ZIndex = 23

Logo.Parent =
    LogoContainer

--========================================================
-- LOGO ANIMATION
--========================================================

Connect(
    RunService.RenderStepped,
    function()

        if Config.MenuDestroyed then
            return
        end

        local Pulse =
            (
                math.sin(
                    os.clock() * 2
                ) + 1
            ) / 2

        Logo.TextTransparency =
            0.05 + Pulse * 0.10

        LogoStroke.Transparency =
            0.25 + Pulse * 0.25

        LogoContainer.Rotation =
            math.sin(
                os.clock() * 0.8
            ) * 2

    end
)

--========================================================
-- TITLE
--========================================================

local Title =
    Instance.new("TextLabel")

Title.Name = "Title"

Title.BackgroundTransparency = 1

Title.Position =
    UDim2.fromOffset(
        74,
        12
    )

Title.Size =
    UDim2.fromOffset(
        230,
        25
    )

Title.Font =
    Enum.Font.GothamBold

Title.Text =
    "RIVALS HUB"

Title.TextColor3 =
    Colors.White

Title.TextSize = 17

Title.TextXAlignment =
    Enum.TextXAlignment.Left

Title.ZIndex = 22

Title.Parent =
    TopBar

--========================================================
-- VERSION
--========================================================

local Version =
    Instance.new("TextLabel")

Version.Name =
    "Version"

Version.BackgroundTransparency = 1

Version.Position =
    UDim2.fromOffset(
        74,
        37
    )

Version.Size =
    UDim2.fromOffset(
        150,
        18
    )

Version.Font =
    Enum.Font.GothamMedium

Version.Text =
    "v2.1"

Version.TextColor3 =
    Colors.Muted

Version.TextSize = 10

Version.TextXAlignment =
    Enum.TextXAlignment.Left

Version.ZIndex = 22

Version.Parent =
    TopBar

--========================================================
-- TOP BUTTON
--========================================================

local function CreateTopButton(
    Text,
    Offset
)

    local Button =
        Instance.new("TextButton")

    Button.Name =
        "TopButton"

    Button.AnchorPoint =
        Vector2.new(
            1,
            0.5
        )

    Button.Position =
        UDim2.new(
            1,
            Offset,
            0.5,
            0
        )

    Button.Size =
        UDim2.fromOffset(
            34,
            34
        )

    Button.BackgroundColor3 =
        Colors.Card

    Button.BackgroundTransparency =
        0.12

    Button.BorderSizePixel = 0

    Button.AutoButtonColor = false

    Button.Font =
        Enum.Font.GothamBold

    Button.Text =
        Text

    Button.TextColor3 =
        Colors.White

    Button.TextSize = 18

    Button.ZIndex = 25

    Button.Parent =
        TopBar

    local Corner =
        Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(
            1,
            0
        )

    Corner.Parent =
        Button

    local Stroke =
        Instance.new("UIStroke")

    Stroke.Color =
        Colors.Accent

    Stroke.Thickness = 1

    Stroke.Transparency = 0.75

    Stroke.Parent =
        Button

    Connect(
        Button.MouseEnter,
        function()

            Tween(
                Button,
                {
                    BackgroundColor3 =
                        Colors.AccentDark,
                    BackgroundTransparency = 0
                },
                0.14
            )

        end
    )

    Connect(
        Button.MouseLeave,
        function()

            Tween(
                Button,
                {
                    BackgroundColor3 =
                        Colors.Card,
                    BackgroundTransparency = 0.12
                },
                0.14
            )

        end
    )

    return Button

end

--========================================================
-- WINDOW BUTTONS
--========================================================

local CloseButton =
    CreateTopButton(
        "×",
        -12
    )

local MinimizeButton =
    CreateTopButton(
        "—",
        -52
    )

--========================================================
-- BODY
--========================================================

Body =
    Instance.new("Frame")

Body.Name = "Body"

Body.Position =
    UDim2.fromOffset(
        0,
        70
    )

Body.Size =
    UDim2.new(
        1,
        0,
        1,
        -70
    )

Body.BackgroundTransparency = 1
Body.BorderSizePixel = 0

Body.ZIndex = 10

Body.Parent =
    Main

--========================================================
-- SIDEBAR
--========================================================

Sidebar =
    Instance.new("Frame")

Sidebar.Name =
    "Sidebar"

Sidebar.Size =
    UDim2.new(
        0,
        175,
        1,
        0
    )

Sidebar.BackgroundTransparency = 1
Sidebar.BorderSizePixel = 0

Sidebar.ZIndex = 11

Sidebar.Parent =
    Body

local SidebarPadding =
    Instance.new("UIPadding")

SidebarPadding.PaddingTop =
    UDim.new(
        0,
        12
    )

SidebarPadding.PaddingLeft =
    UDim.new(
        0,
        12
    )

SidebarPadding.PaddingRight =
    UDim.new(
        0,
        12
    )

SidebarPadding.Parent =
    Sidebar

local SidebarLayout =
    Instance.new("UIListLayout")

SidebarLayout.Padding =
    UDim.new(
        0,
        8
    )

SidebarLayout.SortOrder =
    Enum.SortOrder.LayoutOrder

SidebarLayout.Parent =
    Sidebar

--========================================================
-- CONTENT
--========================================================

Content =
    Instance.new("Frame")

Content.Name =
    "Content"

Content.Position =
    UDim2.new(
        0,
        175,
        0,
        0
    )

Content.Size =
    UDim2.new(
        1,
        -175,
        1,
        0
    )

Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0

Content.ClipsDescendants = true

Content.ZIndex = 11

Content.Parent =
    Body

--========================================================
-- PAGE HEADER
--========================================================

local PageHeader =
    Instance.new("Frame")

PageHeader.Name =
    "PageHeader"

PageHeader.Position =
    UDim2.fromOffset(
        20,
        12
    )

PageHeader.Size =
    UDim2.new(
        1,
        -40,
        0,
        50
    )

PageHeader.BackgroundTransparency = 1
PageHeader.BorderSizePixel = 0

PageHeader.ZIndex = 12

PageHeader.Parent =
    Content

PageTitle =
    Instance.new("TextLabel")

PageTitle.Name =
    "PageTitle"

PageTitle.BackgroundTransparency = 1

PageTitle.Size =
    UDim2.new(
        1,
        0,
        0,
        25
    )

PageTitle.Font =
    Enum.Font.GothamBold

PageTitle.Text =
    "Combat"

PageTitle.TextColor3 =
    Colors.White

PageTitle.TextSize = 19

PageTitle.TextXAlignment =
    Enum.TextXAlignment.Left

PageTitle.ZIndex = 13

PageTitle.Parent =
    PageHeader

PageDescription =
    Instance.new("TextLabel")

PageDescription.Name =
    "PageDescription"

PageDescription.Position =
    UDim2.fromOffset(
        0,
        27
    )

PageDescription.Size =
    UDim2.new(
        1,
        0,
        0,
        18
    )

PageDescription.BackgroundTransparency = 1

PageDescription.Font =
    Enum.Font.GothamMedium

PageDescription.Text =
    "Combat features"

PageDescription.TextColor3 =
    Colors.SubText

PageDescription.TextSize = 10

PageDescription.TextXAlignment =
    Enum.TextXAlignment.Left

PageDescription.ZIndex = 13

PageDescription.Parent =
    PageHeader

--========================================================
-- CREATE PAGE / UI COMPONENTS
-- RIVALS HUB 2.1
--========================================================

local function CreatePage(Name)
    local Page = Pages[Name]

    if not Page then
        return nil
    end

    return Page
end

local function CreateSection(Parent, Title)
    local Section = Instance.new("Frame")
    Section.Name = Title .. "Section"
    Section.BackgroundTransparency = 1
    Section.Size = UDim2.new(1, -20, 0, 36)
    Section.Parent = Parent

    local Label = Instance.new("TextLabel")
    Label.Name = "SectionTitle"
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 2, 0, 4)
    Label.Size = UDim2.new(1, -4, 0, 28)
    Label.Font = Enum.Font.GothamBold
    Label.Text = Title
    Label.TextColor3 = Colors.White
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Section

    return Section
end

local function CreateCard(Parent, Height)
    local Card = Instance.new("Frame")
    Card.Name = "Card"
    Card.BackgroundColor3 = Colors.Card
    Card.BorderSizePixel = 0
    Card.Size = UDim2.new(1, -20, 0, Height or 48)
    Card.Parent = Parent

    AddCorner(Card, 12)
    AddStroke(Card, Colors.Stroke, 0.65, 1)

    return Card
end

local function CreateToggle(Parent, Title, Description, ConfigName, Order, Callback)
    local Card = CreateCard(Parent, 54)

    Card.LayoutOrder = Order or 1

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 14, 0, 7)
    TitleLabel.Size = UDim2.new(1, -70, 0, 19)
    TitleLabel.Font = Enum.Font.GothamSemibold
    TitleLabel.Text = Title
    TitleLabel.TextColor3 = Colors.White
    TitleLabel.TextSize = 13
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = Card

    local DescLabel = Instance.new("TextLabel")
    DescLabel.BackgroundTransparency = 1
    DescLabel.Position = UDim2.new(0, 14, 0, 27)
    DescLabel.Size = UDim2.new(1, -70, 0, 18)
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.Text = Description or ""
    DescLabel.TextColor3 = Colors.SubText
    DescLabel.TextSize = 10
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.TextTruncate = Enum.TextTruncate.AtEnd
    DescLabel.Parent = Card

    local Button = Instance.new("TextButton")
    Button.Name = "Toggle"
    Button.AutoButtonColor = false
    Button.BackgroundColor3 = Config[ConfigName] and Colors.Accent or Colors.Panel
    Button.BorderSizePixel = 0
    Button.Position = UDim2.new(1, -48, 0.5, -11)
    Button.Size = UDim2.fromOffset(34, 22)
    Button.Text = ""
    Button.Parent = Card

    AddCorner(Button, 11)
    AddStroke(Button, Colors.Stroke, 0.55, 1)

    local Knob = Instance.new("Frame")
    Knob.Name = "Knob"
    Knob.BackgroundColor3 = Colors.White
    Knob.BorderSizePixel = 0
    Knob.Size = UDim2.fromOffset(16, 16)
    Knob.Position = Config[ConfigName]
        and UDim2.new(1, -19, 0.5, -8)
        or UDim2.new(0, 3, 0.5, -8)
    Knob.Parent = Button

    AddCorner(Knob, 8)

    local function Update(Value)
        Config[ConfigName] = Value

        Tween(Button, {
            BackgroundColor3 = Value and Colors.Accent or Colors.Panel
        }, 0.18)

        Tween(Knob, {
            Position = Value
                and UDim2.new(1, -19, 0.5, -8)
                or UDim2.new(0, 3, 0.5, -8)
        }, 0.18)

        if Callback then
            task.spawn(function()
                Callback(Value)
            end)
        end
    end

    Button.MouseButton1Click:Connect(function()
        Update(not Config[ConfigName])
    end)

    return {
        Frame = Card,
        Button = Button,
        Set = Update
    }
end

local function CreateDropdown(Parent, Title, Description, ConfigName, Values, Order, Callback)
    local Card = CreateCard(Parent, 58)
    Card.LayoutOrder = Order or 1

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 14, 0, 7)
    TitleLabel.Size = UDim2.new(0.45, 0, 0, 18)
    TitleLabel.Font = Enum.Font.GothamSemibold
    TitleLabel.Text = Title
    TitleLabel.TextColor3 = Colors.White
    TitleLabel.TextSize = 13
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = Card

    local DescLabel = Instance.new("TextLabel")
    DescLabel.BackgroundTransparency = 1
    DescLabel.Position = UDim2.new(0, 14, 0, 27)
    DescLabel.Size = UDim2.new(0.48, 0, 0, 18)
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.Text = Description or ""
    DescLabel.TextColor3 = Colors.SubText
    DescLabel.TextSize = 10
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.TextTruncate = Enum.TextTruncate.AtEnd
    DescLabel.Parent = Card

    local Drop = Instance.new("TextButton")
    Drop.Name = "Dropdown"
    Drop.AutoButtonColor = false
    Drop.BackgroundColor3 = Colors.Panel
    Drop.BorderSizePixel = 0
    Drop.Position = UDim2.new(1, -150, 0.5, -15)
    Drop.Size = UDim2.fromOffset(136, 30)
    Drop.Font = Enum.Font.GothamSemibold
    Drop.TextColor3 = Colors.White
    Drop.TextSize = 11
    Drop.Text = tostring(Config[ConfigName])
    Drop.TextXAlignment = Enum.TextXAlignment.Center
    Drop.Parent = Card

    AddCorner(Drop, 9)
    AddStroke(Drop, Colors.Stroke, 0.55, 1)

    local Popup = Instance.new("Frame")
    Popup.Name = "DropdownPopup"
    Popup.Visible = false
    Popup.BackgroundColor3 = Colors.Panel
    Popup.BorderSizePixel = 0
    Popup.Position = UDim2.new(1, -150, 1, 4)
    Popup.Size = UDim2.fromOffset(136, 0)
    Popup.ZIndex = 50
    Popup.Parent = Card

    AddCorner(Popup, 9)
    AddStroke(Popup, Colors.Stroke, 0.45, 1)

    local List = Instance.new("UIListLayout")
    List.Padding = UDim.new(0, 2)
    List.HorizontalAlignment = Enum.HorizontalAlignment.Center
    List.SortOrder = Enum.SortOrder.LayoutOrder
    List.Parent = Popup

    local Padding = Instance.new("UIPadding")
    Padding.PaddingTop = UDim.new(0, 5)
    Padding.PaddingBottom = UDim.new(0, 5)
    Padding.Parent = Popup

    local Open = false

    local function Refresh()
        for _, Child in ipairs(Popup:GetChildren()) do
            if Child:IsA("TextButton") then
                Child:Destroy()
            end
        end

        for Index, Value in ipairs(Values) do
            local Option = Instance.new("TextButton")
            Option.Name = "Option"
            Option.AutoButtonColor = false
            Option.BackgroundColor3 = Colors.Card
            Option.BorderSizePixel = 0
            Option.Size = UDim2.new(1, -10, 0, 28)
            Option.Font = Enum.Font.Gotham
            Option.Text = tostring(Value)
            Option.TextColor3 = Colors.White
            Option.TextSize = 11
            Option.LayoutOrder = Index
            Option.ZIndex = 51
            Option.Parent = Popup

            AddCorner(Option, 7)

            Option.MouseEnter:Connect(function()
                Tween(Option, {
                    BackgroundColor3 = Colors.AccentDark
                }, 0.12)
            end)

            Option.MouseLeave:Connect(function()
                Tween(Option, {
                    BackgroundColor3 = Colors.Card
                }, 0.12)
            end)

            Option.MouseButton1Click:Connect(function()
                Config[ConfigName] = Value
                Drop.Text = tostring(Value)

                if Callback then
                    task.spawn(function()
                        Callback(Value)
                    end)
                end

                Open = false

                Tween(Popup, {
                    Size = UDim2.new(0, 136, 0, 0)
                }, 0.16)

                task.delay(0.17, function()
                    if not Open then
                        Popup.Visible = false
                    end
                end)
            end)
        end
    end

    Drop.MouseButton1Click:Connect(function()
        Open = not Open

        if Open then
            Refresh()

            Popup.Visible = true

            local Height = math.min(#Values * 30 + 10, 150)

            Tween(Popup, {
                Size = UDim2.fromOffset(136, Height)
            }, 0.18)
        else
            Tween(Popup, {
                Size = UDim2.fromOffset(136, 0)
            }, 0.16)

            task.delay(0.17, function()
                if not Open then
                    Popup.Visible = false
                end
            end)
        end
    end)

    return {
        Frame = Card,
        Button = Drop
    }
end

local function CreateSlider(Parent, Title, Description, ConfigName, Min, Max, Order, Callback)
    local Card = CreateCard(Parent, 68)
    Card.LayoutOrder = Order or 1

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 14, 0, 7)
    TitleLabel.Size = UDim2.new(1, -70, 0, 18)
    TitleLabel.Font = Enum.Font.GothamSemibold
    TitleLabel.Text = Title
    TitleLabel.TextColor3 = Colors.White
    TitleLabel.TextSize = 13
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = Card

    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Position = UDim2.new(1, -55, 0, 7)
    ValueLabel.Size = UDim2.fromOffset(40, 18)
    ValueLabel.Font = Enum.Font.GothamSemibold
    ValueLabel.Text = tostring(Config[ConfigName])
    ValueLabel.TextColor3 = Colors.Accent
    ValueLabel.TextSize = 11
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValueLabel.Parent = Card

    local DescLabel = Instance.new("TextLabel")
    DescLabel.BackgroundTransparency = 1
    DescLabel.Position = UDim2.new(0, 14, 0, 26)
    DescLabel.Size = UDim2.new(1, -28, 0, 15)
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.Text = Description or ""
    DescLabel.TextColor3 = Colors.SubText
    DescLabel.TextSize = 10
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.TextTruncate = Enum.TextTruncate.AtEnd
    DescLabel.Parent = Card

    local Bar = Instance.new("Frame")
    Bar.BackgroundColor3 = Colors.Panel
    Bar.BorderSizePixel = 0
    Bar.Position = UDim2.new(0, 14, 1, -16)
    Bar.Size = UDim2.new(1, -28, 0, 5)
    Bar.Parent = Card

    AddCorner(Bar, 4)

    local Fill = Instance.new("Frame")
    Fill.BackgroundColor3 = Colors.Accent
    Fill.BorderSizePixel = 0
    Fill.Size = UDim2.new(0, 0, 1, 0)
    Fill.Parent = Bar

    AddCorner(Fill, 4)

    local function SetValue(Value)
        Value = math.clamp(Value, Min, Max)

        Config[ConfigName] = Value
        ValueLabel.Text = tostring(math.floor(Value))

        local Alpha = (Value - Min) / (Max - Min)

        Tween(Fill, {
            Size = UDim2.new(Alpha, 0, 1, 0)
        }, 0.12)

        if Callback then
            task.spawn(function()
                Callback(Value)
            end)
        end
    end

    local Dragging = false

    local function UpdateFromX(X)
        local Alpha = math.clamp(
            (X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X,
            0,
            1
        )

        SetValue(Min + (Max - Min) * Alpha)
    end

    Bar.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            UpdateFromX(Input.Position.X)
        end
    end)

    UserInputService.InputChanged:Connect(function(Input)
        if Dragging then
            if Input.UserInputType == Enum.UserInputType.MouseMovement
            or Input.UserInputType == Enum.UserInputType.Touch then
                UpdateFromX(Input.Position.X)
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = false
        end
    end)

    SetValue(Config[ConfigName])

    return {
        Frame = Card,
        Set = SetValue
    }
end

local function CreateInfoCard(Parent, Title, Description, Order)
    local Card = CreateCard(Parent, 62)
    Card.LayoutOrder = Order or 1

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 14, 0, 9)
    TitleLabel.Size = UDim2.new(1, -28, 0, 20)
    TitleLabel.Font = Enum.Font.GothamSemibold
    TitleLabel.Text = Title
    TitleLabel.TextColor3 = Colors.White
    TitleLabel.TextSize = 13
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = Card

    local DescLabel = Instance.new("TextLabel")
    DescLabel.BackgroundTransparency = 1
    DescLabel.Position = UDim2.new(0, 14, 0, 31)
    DescLabel.Size = UDim2.new(1, -28, 0, 22)
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.Text = Description
    DescLabel.TextColor3 = Colors.SubText
    DescLabel.TextSize = 10
    DescLabel.TextWrapped = true
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.Parent = Card

    return Card
end

--========================================================
-- CREATE PAGES
--========================================================

local CombatPage = CreatePage("Combat")
local VisualsPage = CreatePage("Visuals")
local MovementPage = CreatePage("Movement")
local SettingsPage = CreatePage("Settings")

--========================================================
-- PAGE SCROLL SETTINGS
--========================================================

for _, Page in pairs(Pages) do
    if Page:IsA("ScrollingFrame") then
        Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Page.CanvasSize = UDim2.new(0, 0, 0, 0)
        Page.ScrollBarThickness = 3
        Page.ScrollBarImageColor3 = Colors.Accent
        Page.ScrollBarImageTransparency = 0.25
    end
end

--========================================================
-- COMBAT PAGE
--========================================================

CreateSection(CombatPage, "Aim")

CreateToggle(
    CombatPage,
    "Aim Assist",
    "Smoothly aims toward a valid target.",
    "AimAssist",
    10,
    function(State)
        Config.AimAssist = State
    end
)

CreateToggle(
    CombatPage,
    "Silent Aim",
    "Client-side target selection foundation.",
    "SilentAim",
    20,
    function(State)
        Config.SilentAim = State
    end
)

CreateDropdown(
    CombatPage,
    "Target Part",
    "Select the preferred target body part.",
    "TargetPart",
    {
        "Head",
        "HumanoidRootPart",
        "UpperTorso",
        "LowerTorso"
    },
    30
)

CreateToggle(
    CombatPage,
    "Visible Only",
    "Only select targets visible to the camera.",
    "VisibleOnly",
    40
)

CreateToggle(
    CombatPage,
    "Team Check",
    "Ignore players on the same team.",
    "TeamCheck",
    50
)

CreateSlider(
    CombatPage,
    "Silent Aim FOV",
    "Maximum target selection radius.",
    "SilentAimFOV",
    50,
    1000,
    60
)

CreateToggle(
    CombatPage,
    "FOV Circle",
    "Display the current aim radius.",
    "SilentAimFOVCircle",
    70
)

CreateInfoCard(
    CombatPage,
    "Combat",
    "Aim controls are separated from the visual and movement systems.",
    80
)

--========================================================
-- VISUALS PAGE
--========================================================

CreateSection(VisualsPage, "ESP")

CreateToggle(
    VisualsPage,
    "ESP",
    "Enable the player visual system.",
    "ESP",
    10
)

CreateToggle(
    VisualsPage,
    "Box ESP",
    "Draw a 2D box around visible players.",
    "BoxESP",
    20
)

CreateToggle(
    VisualsPage,
    "Name ESP",
    "Display player names above their character.",
    "NameESP",
    30
)

CreateToggle(
    VisualsPage,
    "Health ESP",
    "Display player health.",
    "HealthESP",
    40
)

CreateToggle(
    VisualsPage,
    "Distance ESP",
    "Display distance from your character.",
    "DistanceESP",
    50
)

CreateInfoCard(
    VisualsPage,
    "Visuals",
    "ESP elements are handled independently so each visual can be enabled or disabled.",
    60
)

--========================================================
-- MOVEMENT PAGE
--========================================================

CreateSection(MovementPage, "Movement")

CreateToggle(
    MovementPage,
    "Speed",
    "Change the local character walk speed.",
    "Speed",
    10
)

CreateSlider(
    MovementPage,
    "Speed Value",
    "Select the desired walk speed.",
    "SpeedValue",
    20,
    16,
    150,
    20
)

CreateToggle(
    MovementPage,
    "Jump",
    "Change the local character jump power.",
    "Jump",
    30
)

CreateSlider(
    MovementPage,
    "Jump Value",
    "Select the desired jump power.",
    "JumpValue",
    20,
    50,
    150,
    40
)

CreateToggle(
    MovementPage,
    "Noclip",
    "Disable local character collisions.",
    "Noclip",
    50
)

--========================================================
-- SETTINGS PAGE
--========================================================

CreateSection(SettingsPage, "Interface")

CreateToggle(
    SettingsPage,
    "Smooth Animations",
    "Enable smooth interface transitions.",
    "SmoothAnimations",
    10,
    function(State)
        Config.SmoothAnimations = State
    end
)

CreateToggle(
    SettingsPage,
    "Animated Background",
    "Enable the smooth moving background.",
    "BackgroundAnimation",
    20,
    function(State)
        Config.BackgroundAnimation = State
    end
)

CreateInfoCard(
    SettingsPage,
    "Rivals Hub 2.1",
    "Clean interface build with independent Combat, Visuals, Movement and Settings systems.",
    30
)

--========================================================
-- CHARACTER REFERENCES
--========================================================

local function GetCharacter()
    return LocalPlayer.Character
end

local function GetHumanoid()
    local Character = GetCharacter()

    if not Character then
        return nil
    end

    return Character:FindFirstChildOfClass("Humanoid")
end

local function GetRoot()
    local Character = GetCharacter()

    if not Character then
        return nil
    end

    return Character:FindFirstChild("HumanoidRootPart")
end

--========================================================
-- MOVEMENT SYSTEM
--========================================================

local function ApplyMovement()
    local Humanoid = GetHumanoid()

    if not Humanoid then
        return
    end

    if Config.Speed then
        Humanoid.WalkSpeed = Config.SpeedValue
    else
        Humanoid.WalkSpeed = 16
    end

    if Config.Jump then
        Humanoid.UseJumpPower = true
        Humanoid.JumpPower = Config.JumpValue
    else
        Humanoid.UseJumpPower = true
        Humanoid.JumpPower = 50
    end
end

Connect(
    RunService.Heartbeat,
    function()
        ApplyMovement()

        local Character = GetCharacter()

        if Config.Noclip and Character then
            for _, Object in ipairs(Character:GetDescendants()) do
                if Object:IsA("BasePart") then
                    Object.CanCollide = false
                end
            end
        end
    end
)

--========================================================
-- CHARACTER RESPAWN SUPPORT
--========================================================

Connect(
    LocalPlayer.CharacterAdded,
    function()
        task.wait(0.5)
        ApplyMovement()
    end
)

--========================================================
-- AIM TARGET SYSTEM
--========================================================

local Camera = workspace.CurrentCamera

local function GetCharacter()
    return LocalPlayer.Character
end

local function GetHumanoid()
    local Character = GetCharacter()

    if not Character then
        return nil
    end

    return Character:FindFirstChildOfClass("Humanoid")
end

local function GetRoot()
    local Character = GetCharacter()

    if not Character then
        return nil
    end

    return Character:FindFirstChild("HumanoidRootPart")
end

local function IsAlive(Player)
    if not Player then
        return false
    end

    local Character = Player.Character

    if not Character then
        return false
    end

    local Humanoid = Character:FindFirstChildOfClass("Humanoid")

    return Humanoid ~= nil and Humanoid.Health > 0
end

local function IsValidTarget(Player)
    if Player == LocalPlayer then
        return false
    end

    if not IsAlive(Player) then
        return false
    end

    if Config.TeamCheck then
        if LocalPlayer.Team ~= nil
        and Player.Team ~= nil
        and LocalPlayer.Team == Player.Team then
            return false
        end
    end

    return true
end

local function GetTargetPart(Player)
    if not Player or not Player.Character then
        return nil
    end

    local Character = Player.Character

    local PreferredPart =
        Character:FindFirstChild(Config.TargetPart)

    if PreferredPart and PreferredPart:IsA("BasePart") then
        return PreferredPart
    end

    return Character:FindFirstChild("HumanoidRootPart")
        or Character:FindFirstChild("Head")
end

local function IsVisible(Part, Character)
    if not Part or not Character then
        return false
    end

    Camera = workspace.CurrentCamera

    if not Camera then
        return false
    end

    local Origin = Camera.CFrame.Position
    local Direction = Part.Position - Origin

    local Params = RaycastParams.new()

    Params.FilterType = Enum.RaycastFilterType.Exclude
    Params.FilterDescendantsInstances = {
        LocalPlayer.Character,
        Character
    }

    local Result = workspace:Raycast(
        Origin,
        Direction,
        Params
    )

    return Result == nil
end

local function GetClosestTarget()
    Camera = workspace.CurrentCamera

    if not Camera then
        return nil
    end

    local Viewport = Camera.ViewportSize

    local Center = Vector2.new(
        Viewport.X / 2,
        Viewport.Y / 2
    )

    local ClosestPlayer = nil
    local ClosestDistance = Config.SilentAimFOV

    for _, Player in ipairs(Players:GetPlayers()) do
        if IsValidTarget(Player) then

            local Part = GetTargetPart(Player)

            if Part then

                local ScreenPosition, OnScreen =
                    Camera:WorldToViewportPoint(
                        Part.Position
                    )

                if OnScreen then

                    local ScreenPoint = Vector2.new(
                        ScreenPosition.X,
                        ScreenPosition.Y
                    )

                    local Distance =
                        (ScreenPoint - Center).Magnitude

                    if Distance < ClosestDistance then

                        if not Config.VisibleOnly
                        or IsVisible(
                            Part,
                            Player.Character
                        ) then

                            ClosestDistance = Distance
                            ClosestPlayer = Player
                        end
                    end
                end
            end
        end
    end

    return ClosestPlayer
end

--========================================================
-- AIM ASSIST FOUNDATION
--========================================================

local CurrentTarget = nil

Connect(
    RunService.RenderStepped,
    function()
        if not Config.AimAssist then
            CurrentTarget = nil
            return
        end

        CurrentTarget = GetClosestTarget()
    end
)

--========================================================
-- FOV CIRCLE
--========================================================

local FOVCircle = nil

pcall(function()
    if Drawing and Drawing.new then
        FOVCircle = Drawing.new("Circle")

        FOVCircle.Visible = false
        FOVCircle.Radius = Config.SilentAimFOV
        FOVCircle.Thickness = 1.5
        FOVCircle.NumSides = 64
        FOVCircle.Filled = false
        FOVCircle.Transparency = 0.8
        FOVCircle.Color = Colors.Accent
    end
end)

Connect(
    RunService.RenderStepped,
    function()
        Camera = workspace.CurrentCamera

        if not Camera then
            return
        end

        if FOVCircle then

            local Viewport = Camera.ViewportSize

            FOVCircle.Position = Vector2.new(
                Viewport.X / 2,
                Viewport.Y / 2
            )

            FOVCircle.Radius =
                Config.SilentAimFOV

            FOVCircle.Visible =
                Config.SilentAim
                and Config.SilentAimFOVCircle
        end
    end
)

--========================================================
-- MOVEMENT SYSTEM
--========================================================

local function ApplyMovement()
    local Humanoid = GetHumanoid()

    if not Humanoid then
        return
    end

    if Config.Speed then
        Humanoid.WalkSpeed =
            Config.SpeedValue
    else
        Humanoid.WalkSpeed = 16
    end

    Humanoid.UseJumpPower = true

    if Config.Jump then
        Humanoid.JumpPower =
            Config.JumpValue
    else
        Humanoid.JumpPower = 50
    end
end

Connect(
    RunService.Heartbeat,
    function()

        ApplyMovement()

        local Character =
            GetCharacter()

        if Config.Noclip
        and Character then

            for _, Object in ipairs(
                Character:GetDescendants()
            ) do

                if Object:IsA("BasePart") then
                    Object.CanCollide = false
                end
            end
        end
    end
)

--========================================================
-- CHARACTER RESPAWN
--========================================================

Connect(
    LocalPlayer.CharacterAdded,
    function()
        task.wait(0.5)

        ApplyMovement()
    end
)

--========================================================
-- CLEANUP
--========================================================

Connect(
    Gui.Destroying,
    function()

        if FOVCircle then
            pcall(function()
                FOVCircle:Remove()
            end)
        end

    end
)

--========================================================
-- FINAL STATE
--========================================================

task.defer(function()

    ApplyMovement()

    if Config.MenuOpen then

        Holder.Visible = true
        MiniButton.Visible = false

    else

        Holder.Visible = false
        MiniButton.Visible = true

    end

end)

print("[Rivals Hub 2.1] Loaded successfully.")

--========================================================
-- END OF RIVALS HUB 2.1
--========================================================

