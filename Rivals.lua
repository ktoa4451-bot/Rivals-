--========================================================
-- RIVALS HUB
-- FUNCTIONAL REBUILD
-- PART 1/4
--========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

--========================================================
-- CONFIG
--========================================================

local Config = {
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
    Speed = false,

    -- Movement
    SpeedEnabled = false,
    SpeedValue = 16,
    Jump = false,
    JumpPower = 50,
    Noclip = false,

    -- Silent Aim UI
    SilentAim = false,
    SilentAimPart = "Head",
    SilentAimChance = 100,
    SilentAimFOV = 250
}

--========================================================
-- COLORS
--========================================================

local Colors = {
    Background = Color3.fromRGB(8, 10, 15),
    Panel = Color3.fromRGB(13, 16, 23),
    Card = Color3.fromRGB(20, 24, 33),

    Accent = Color3.fromRGB(80, 145, 255),
    AccentDark = Color3.fromRGB(45, 95, 190),

    White = Color3.fromRGB(245, 247, 255),
    SubText = Color3.fromRGB(160, 168, 185),
    Muted = Color3.fromRGB(105, 112, 128),

    On = Color3.fromRGB(80, 145, 255),
    Off = Color3.fromRGB(45, 49, 60)
}

--========================================================
-- STATE
--========================================================

local Destroyed = false
local MenuOpen = true
local CurrentCategory = "Combat"

local Connections = {}
local ESPObjects = {}

local SavedMenuPosition

--========================================================
-- CONNECTION MANAGEMENT
--========================================================

local function Connect(Signal, Function)
    local Connection = Signal:Connect(Function)
    table.insert(Connections, Connection)
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
-- SAFE TWEEN
--========================================================

local function Tween(Object, Properties, Duration, Style, Direction)
    if not Object or not Object.Parent then
        return
    end

    local Info = TweenInfo.new(
        Duration or 0.25,
        Style or Enum.EasingStyle.Quart,
        Direction or Enum.EasingDirection.Out
    )

    local Animation = TweenService:Create(
        Object,
        Info,
        Properties
    )

    Animation:Play()

    return Animation
end

--========================================================
-- OLD GUI CLEANUP
--========================================================

pcall(function()
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")

    if PlayerGui then
        local Old = PlayerGui:FindFirstChild("RivalsHub")

        if Old then
            Old:Destroy()
        end
    end
end)

pcall(function()
    local CoreGui = game:GetService("CoreGui")

    for _, Name in ipairs({
        "RivalsHub",
        "NeutralizationHub",
        "LunarHub"
    }) do
        local Old = CoreGui:FindFirstChild(Name)

        if Old then
            Old:Destroy()
        end
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
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

--========================================================
-- HOLDER
--========================================================

local Holder = Instance.new("Frame")
Holder.Name = "Holder"
Holder.AnchorPoint = Vector2.new(0.5, 0.5)
Holder.Position = UDim2.fromScale(0.5, 0.5)
Holder.Size = UDim2.fromOffset(720, 470)
Holder.BackgroundTransparency = 1
Holder.BorderSizePixel = 0
Holder.Parent = ScreenGui

SavedMenuPosition = Holder.Position

--========================================================
-- SCALE
--========================================================

local UIScale = Instance.new("UIScale")
UIScale.Scale = 0.84
UIScale.Parent = Holder

--========================================================
-- MAIN
--========================================================

local Main = Instance.new("Frame")
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
MainStroke.Thickness = 1
MainStroke.Transparency = 0.25
MainStroke.Parent = Main

--========================================================
-- BACKGROUND
--========================================================

local Background = Instance.new("Frame")
Background.Name = "AnimatedBackground"
Background.Size = UDim2.fromScale(1, 1)
Background.BackgroundTransparency = 1
Background.BorderSizePixel = 0
Background.ClipsDescendants = true
Background.ZIndex = 0
Background.Parent = Main

local BackgroundCorner = Instance.new("UICorner")
BackgroundCorner.CornerRadius = UDim.new(0, 22)
BackgroundCorner.Parent = Background

local function CreateLight(Position, Size)
    local Light = Instance.new("Frame")
    Light.AnchorPoint = Vector2.new(0.5, 0.5)
    Light.Position = Position
    Light.Size = Size
    Light.BackgroundColor3 = Colors.Accent
    Light.BackgroundTransparency = 0.88
    Light.BorderSizePixel = 0
    Light.ZIndex = 0
    Light.Parent = Background

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(1, 0)
    Corner.Parent = Light

    return Light
end

local Light1 = CreateLight(
    UDim2.fromScale(0.15, 0.2),
    UDim2.fromOffset(280, 280)
)

local Light2 = CreateLight(
    UDim2.fromScale(0.82, 0.65),
    UDim2.fromOffset(320, 320)
)

local Light3 = CreateLight(
    UDim2.fromScale(0.45, 0.9),
    UDim2.fromOffset(240, 240)
)

--========================================================
-- TOP BAR
--========================================================

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 70)
TopBar.BackgroundTransparency = 1
TopBar.BorderSizePixel = 0
TopBar.ZIndex = 10
TopBar.Parent = Main

local Logo = Instance.new("TextLabel")
Logo.Name = "Logo"
Logo.BackgroundTransparency = 1
Logo.Position = UDim2.fromOffset(22, 12)
Logo.Size = UDim2.fromOffset(44, 44)
Logo.Font = Enum.Font.GothamBold
Logo.Text = "R"
Logo.TextColor3 = Colors.Accent
Logo.TextSize = 25
Logo.ZIndex = 11
Logo.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.BackgroundTransparency = 1
Title.Position = UDim2.fromOffset(70, 13)
Title.Size = UDim2.fromOffset(220, 25)
Title.Font = Enum.Font.GothamBold
Title.Text = "RIVALS HUB"
Title.TextColor3 = Colors.White
Title.TextSize = 17
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 11
Title.Parent = TopBar

local Version = Instance.new("TextLabel")
Version.Name = "Version"
Version.BackgroundTransparency = 1
Version.Position = UDim2.fromOffset(70, 37)
Version.Size = UDim2.fromOffset(150, 18)
Version.Font = Enum.Font.GothamMedium
Version.Text = "v1.0"
Version.TextColor3 = Colors.Muted
Version.TextSize = 11
Version.TextXAlignment = Enum.TextXAlignment.Left
Version.ZIndex = 11
Version.Parent = TopBar

--========================================================
-- MINIMIZE
--========================================================

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "Minimize"
MinimizeButton.AnchorPoint = Vector2.new(1, 0.5)
MinimizeButton.Position = UDim2.new(1, -52, 0.5, 0)
MinimizeButton.Size = UDim2.fromOffset(34, 34)
MinimizeButton.BackgroundColor3 = Colors.Card
MinimizeButton.BackgroundTransparency = 0.15
MinimizeButton.BorderSizePixel = 0
MinimizeButton.AutoButtonColor = false
MinimizeButton.Text = "—"
MinimizeButton.TextColor3 = Colors.White
MinimizeButton.TextSize = 18
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.ZIndex = 12
MinimizeButton.Parent = TopBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(1, 0)
MinCorner.Parent = MinimizeButton

--========================================================
-- CLOSE
--========================================================

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "Close"
CloseButton.AnchorPoint = Vector2.new(1, 0.5)
CloseButton.Position = UDim2.new(1, -12, 0.5, 0)
CloseButton.Size = UDim2.fromOffset(34, 34)
CloseButton.BackgroundColor3 = Colors.Card
CloseButton.BackgroundTransparency = 0.15
CloseButton.BorderSizePixel = 0
CloseButton.AutoButtonColor = false
CloseButton.Text = "×"
CloseButton.TextColor3 = Colors.White
CloseButton.TextSize = 20
CloseButton.Font = Enum.Font.GothamBold
CloseButton.ZIndex = 12
CloseButton.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

--========================================================
-- BODY
--========================================================

local Body = Instance.new("Frame")
Body.Name = "Body"
Body.Position = UDim2.fromOffset(0, 70)
Body.Size = UDim2.new(1, 0, 1, -70)
Body.BackgroundTransparency = 1
Body.BorderSizePixel = 0
Body.ZIndex = 5
Body.Parent = Main

--========================================================
-- SIDEBAR
--========================================================

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 175, 1, 0)
Sidebar.BackgroundTransparency = 1
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 6
Sidebar.Parent = Body

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 12)
SidebarPadding.PaddingLeft = UDim.new(0, 11)
SidebarPadding.PaddingRight = UDim.new(0, 11)
SidebarPadding.Parent = Sidebar

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Padding = UDim.new(0, 8)
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Parent = Sidebar

--========================================================
-- CONTENT
--========================================================

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Position = UDim2.new(0, 175, 0, 0)
Content.Size = UDim2.new(1, -175, 1, 0)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ClipsDescendants = true
Content.ZIndex = 6
Content.Parent = Body

--========================================================
-- HEADER
--========================================================

local PageHeader = Instance.new("Frame")
PageHeader.Name = "PageHeader"
PageHeader.Position = UDim2.fromOffset(20, 12)
PageHeader.Size = UDim2.new(1, -40, 0, 50)
PageHeader.BackgroundTransparency = 1
PageHeader.BorderSizePixel = 0
PageHeader.ZIndex = 7
PageHeader.Parent = Content

local PageTitle = Instance.new("TextLabel")
PageTitle.Name = "PageTitle"
PageTitle.BackgroundTransparency = 1
PageTitle.Size = UDim2.new(1, 0, 0, 26)
PageTitle.Font = Enum.Font.GothamBold
PageTitle.Text = "Combat"
PageTitle.TextColor3 = Colors.White
PageTitle.TextSize = 19
PageTitle.TextXAlignment = Enum.TextXAlignment.Left
PageTitle.ZIndex = 8
PageTitle.Parent = PageHeader

local PageDescription = Instance.new("TextLabel")
PageDescription.Name = "PageDescription"
PageDescription.Position = UDim2.fromOffset(0, 27)
PageDescription.Size = UDim2.new(1, 0, 0, 20)
PageDescription.BackgroundTransparency = 1
PageDescription.Font = Enum.Font.GothamMedium
PageDescription.Text = "Combat features"
PageDescription.TextColor3 = Colors.SubText
PageDescription.TextSize = 11
PageDescription.TextXAlignment = Enum.TextXAlignment.Left
PageDescription.ZIndex = 8
PageDescription.Parent = PageHeader

--========================================================
-- PAGES
--========================================================

local Pages = {}

local function CreatePage(Name)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = Name
    Page.Position = UDim2.new(0, 20, 0, 68)
    Page.Size = UDim2.new(1, -40, 1, -78)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = Colors.Accent
    Page.CanvasSize = UDim2.fromOffset(0, 0)
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.ScrollingDirection = Enum.ScrollingDirection.Y
    Page.Visible = false
    Page.ZIndex = 7
    Page.Parent = Content

    local Padding = Instance.new("UIPadding")
    Padding.PaddingBottom = UDim.new(0, 18)
    Padding.Parent = Page

    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 10)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = Page

    Pages[Name] = Page

    return Page
end

CreatePage("Combat")
CreatePage("Visuals")
CreatePage("Movement")
CreatePage("Settings")

--========================================================
-- PAGE DESCRIPTIONS
--========================================================

local PageDescriptions = {
    Combat = "Combat features",
    Visuals = "Player visual features",
    Movement = "Movement features",
    Settings = "Hub information"
}

local CategoryOrder = {
    "Combat",
    "Visuals",
    "Movement",
    "Settings"
}

--========================================================
-- UI HELPERS
--========================================================

local function AddCorner(Object, Radius)
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, Radius or 12)
    Corner.Parent = Object
    return Corner
end

local function AddStroke(Object, Color, Thickness, Transparency)
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color or Colors.Accent
    Stroke.Thickness = Thickness or 1
    Stroke.Transparency = Transparency or 0
    Stroke.Parent = Object
    return Stroke
end

local function CreateSection(Parent, TitleText, DescriptionText)

    local Section = Instance.new("Frame")
    Section.Name = TitleText .. "Section"
    Section.Size = UDim2.new(1, 0, 0, 0)
    Section.AutomaticSize = Enum.AutomaticSize.Y
    Section.BackgroundColor3 = Colors.Panel
    Section.BackgroundTransparency = 0.08
    Section.BorderSizePixel = 0
    Section.ZIndex = 8
    Section.Parent = Parent

    AddCorner(Section, 15)

    local Padding = Instance.new("UIPadding")
    Padding.PaddingTop = UDim.new(0, 14)
    Padding.PaddingBottom = UDim.new(0, 14)
    Padding.PaddingLeft = UDim.new(0, 15)
    Padding.PaddingRight = UDim.new(0, 15)
    Padding.Parent = Section

    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 8)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = Section

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, 0, 0, 22)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.Text = TitleText
    Title.TextColor3 = Colors.White
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.ZIndex = 9
    Title.Parent = Section

    local Description = Instance.new("TextLabel")
    Description.Name = "Description"
    Description.Size = UDim2.new(1, 0, 0, 18)
    Description.BackgroundTransparency = 1
    Description.Font = Enum.Font.GothamMedium
    Description.Text = DescriptionText or ""
    Description.TextColor3 = Colors.Muted
    Description.TextSize = 10
    Description.TextXAlignment = Enum.TextXAlignment.Left
    Description.ZIndex = 9
    Description.Parent = Section

    return Section
end

--========================================================
-- TOGGLE
--========================================================

local function CreateToggle(
    Parent,
    TitleText,
    DescriptionText,
    Default,
    Callback
)

    local Row = Instance.new("Frame")
    Row.Name = TitleText .. "Toggle"
    Row.Size = UDim2.new(1, 0, 0, 48)
    Row.BackgroundColor3 = Colors.Card
    Row.BackgroundTransparency = 0.18
    Row.BorderSizePixel = 0
    Row.ZIndex = 10
    Row.Parent = Parent

    AddCorner(Row, 11)

    local Label = Instance.new("TextLabel")
    Label.Position = UDim2.fromOffset(12, 6)
    Label.Size = UDim2.new(1, -80, 0, 18)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.GothamMedium
    Label.Text = TitleText
    Label.TextColor3 = Colors.White
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.ZIndex = 11
    Label.Parent = Row

    local Description = Instance.new("TextLabel")
    Description.Position = UDim2.fromOffset(12, 25)
    Description.Size = UDim2.new(1, -80, 0, 15)
    Description.BackgroundTransparency = 1
    Description.Font = Enum.Font.GothamMedium
    Description.Text = DescriptionText or ""
    Description.TextColor3 = Colors.Muted
    Description.TextSize = 9
    Description.TextXAlignment = Enum.TextXAlignment.Left
    Description.ZIndex = 11
    Description.Parent = Row

    local Button = Instance.new("TextButton")
    Button.AnchorPoint = Vector2.new(1, 0.5)
    Button.Position = UDim2.new(1, -12, 0.5, 0)
    Button.Size = UDim2.fromOffset(42, 22)
    Button.BackgroundColor3 =
        Default and Colors.On or Colors.Off
    Button.BorderSizePixel = 0
    Button.AutoButtonColor = false
    Button.Text = ""
    Button.ZIndex = 12
    Button.Parent = Row

    AddCorner(Button, 999)

    local Knob = Instance.new("Frame")
    Knob.AnchorPoint = Vector2.new(0.5, 0.5)
    Knob.Position = Default
        and UDim2.new(1, -11, 0.5, 0)
        or UDim2.new(0, 11, 0.5, 0)
    Knob.Size = UDim2.fromOffset(16, 16)
    Knob.BackgroundColor3 = Colors.White
    Knob.BorderSizePixel = 0
    Knob.ZIndex = 13
    Knob.Parent = Button

    AddCorner(Knob, 999)

    local State = Default

    local function SetState(Value)
        State = Value

        Tween(
            Button,
            {
                BackgroundColor3 =
                    State and Colors.On or Colors.Off
            },
            0.16
        )

        Tween(
            Knob,
            {
                Position =
                    State
                    and UDim2.new(1, -11, 0.5, 0)
                    or UDim2.new(0, 11, 0.5, 0)
            },
            0.18
        )

        if Callback then
            task.spawn(function()
                Callback(State)
            end)
        end
    end

    Connect(Button.MouseButton1Click, function()
        SetState(not State)
    end)

    return {
        Row = Row,
        Button = Button,
        Set = SetState,
        Get = function()
            return State
        end
    }
end

--========================================================
-- INFO CARD
--========================================================

local function CreateInfoCard(
    Parent,
    TitleText,
    ValueText
)

    local Card = Instance.new("Frame")
    Card.Name = TitleText .. "Info"
    Card.Size = UDim2.new(1, 0, 0, 48)
    Card.BackgroundColor3 = Colors.Card
    Card.BackgroundTransparency = 0.18
    Card.BorderSizePixel = 0
    Card.ZIndex = 10
    Card.Parent = Parent

    AddCorner(Card, 11)

    local Title = Instance.new("TextLabel")
    Title.Position = UDim2.fromOffset(12, 5)
    Title.Size = UDim2.new(1, -24, 0, 17)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.Text = TitleText
    Title.TextColor3 = Colors.White
    Title.TextSize = 11
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.ZIndex = 11
    Title.Parent = Card

    local Value = Instance.new("TextLabel")
    Value.Position = UDim2.fromOffset(12, 23)
    Value.Size = UDim2.new(1, -24, 0, 17)
    Value.BackgroundTransparency = 1
    Value.Font = Enum.Font.GothamMedium
    Value.Text = ValueText
    Value.TextColor3 = Colors.SubText
    Value.TextSize = 10
    Value.TextXAlignment = Enum.TextXAlignment.Left
    Value.ZIndex = 11
    Value.Parent = Card

    return Card
end

--========================================================
-- DROPDOWN
--========================================================

local function CreateDropdown(
    Parent,
    TitleText,
    Options,
    Default,
    Callback
)

    local Current = Default

    local Row = Instance.new("Frame")
    Row.Name = TitleText .. "Dropdown"
    Row.Size = UDim2.new(1, 0, 0, 42)
    Row.BackgroundColor3 = Colors.Card
    Row.BackgroundTransparency = 0.18
    Row.BorderSizePixel = 0
    Row.ZIndex = 10
    Row.Parent = Parent

    AddCorner(Row, 11)

    local Label = Instance.new("TextLabel")
    Label.Position = UDim2.fromOffset(12, 0)
    Label.Size = UDim2.new(0.5, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.GothamMedium
    Label.Text = TitleText
    Label.TextColor3 = Colors.White
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.ZIndex = 11
    Label.Parent = Row

    local Button = Instance.new("TextButton")
    Button.AnchorPoint = Vector2.new(1, 0.5)
    Button.Position = UDim2.new(1, -10, 0.5, 0)
    Button.Size = UDim2.fromOffset(120, 28)
    Button.BackgroundColor3 = Colors.Background
    Button.BorderSizePixel = 0
    Button.AutoButtonColor = false
    Button.Text = tostring(Current)
    Button.TextColor3 = Colors.SubText
    Button.TextSize = 10
    Button.Font = Enum.Font.GothamMedium
    Button.ZIndex = 12
    Button.Parent = Row

    AddCorner(Button, 8)

    local Index = table.find(
        Options,
        Current
    ) or 1

    Connect(
        Button.MouseButton1Click,
        function()

            Index += 1

            if Index > #Options then
                Index = 1
            end

            Current = Options[Index]

            Button.Text =
                tostring(Current)

            if Callback then
                Callback(Current)
            end
        end
    )

    return {
        Row = Row,

        Set = function(Value)

            if table.find(
                Options,
                Value
            ) then

                Current = Value
                Button.Text =
                    tostring(Value)

                if Callback then
                    Callback(Value)
                end
            end
        end,

        Get = function()
            return Current
        end
    }
end

--========================================================
-- CATEGORY SWITCHING
--========================================================

local CategoryButtons = {}

local function SetCategoryActive(Name)

    for CategoryName, Button in pairs(
        CategoryButtons
    ) do

        local Active =
            CategoryName == Name

        Tween(
            Button,
            {
                BackgroundColor3 =
                    Active
                    and Colors.Accent
                    or Colors.Card,

                BackgroundTransparency =
                    Active
                    and 0
                    or 0.25
            },
            0.18
        )

        local Label =
            Button:FindFirstChild("Label")

        if Label then
            Tween(
                Label,
                {
                    TextColor3 =
                        Active
                        and Colors.White
                        or Colors.SubText
                },
                0.18
            )
        end
    end
end

--========================================================
-- PAGE SWITCH
--========================================================

local SwitchingPage = false

local function SwitchPage(Name)

    if Destroyed then
        return
    end

    if SwitchingPage then
        return
    end

    if CurrentCategory == Name then
        return
    end

    local NewPage =
        Pages[Name]

    local OldPage =
        Pages[CurrentCategory]

    if not NewPage or not OldPage then
        return
    end

    SwitchingPage = true

    local OldIndex =
        table.find(
            CategoryOrder,
            CurrentCategory
        ) or 1

    local NewIndex =
        table.find(
            CategoryOrder,
            Name
        ) or 1

    local Direction =
        NewIndex > OldIndex
        and 1
        or -1

    NewPage.Position =
        UDim2.new(
            Direction,
            0,
            0,
            0
        )

    NewPage.Visible = true

    PageTitle.Text = Name
    PageDescription.Text =
        PageDescriptions[Name]
        or ""

    Tween(
        OldPage,
        {
            Position = UDim2.new(
                -Direction,
                0,
                0,
                0
            )
        },
        0.28,
        Enum.EasingStyle.Quart,
        Enum.EasingDirection.InOut
    )

    Tween(
        NewPage,
        {
            Position = UDim2.new(
                0,
                0,
                0,
                0
            )
        },
        0.32,
        Enum.EasingStyle.Quart,
        Enum.EasingDirection.InOut
    )

    SetCategoryActive(Name)

    task.delay(
        0.34,
        function()

            if Destroyed then
                return
            end

            OldPage.Visible = false

            OldPage.Position =
                UDim2.new(
                    0,
                    0,
                    0,
                    0
                )

            CurrentCategory = Name
            SwitchingPage = false
        end
    )
end

--========================================================
-- CREATE CATEGORY
--========================================================

local function CreateCategory(Name)

    local Button = Instance.new(
        "TextButton"
    )

    Button.Name =
        Name .. "Category"

    Button.Size =
        UDim2.new(
            1,
            -22,
            0,
            42
        )

    Button.BackgroundColor3 =
        Colors.Card

    Button.BackgroundTransparency = 0.25
    Button.BorderSizePixel = 0
    Button.AutoButtonColor = false
    Button.Text = ""
    Button.ZIndex = 8
    Button.Parent = Sidebar

    AddCorner(
        Button,
        12
    )

    local Label = Instance.new(
        "TextLabel"
    )

    Label.Name = "Label"
    Label.Position =
        UDim2.fromOffset(
            14,
            0
        )

    Label.Size =
        UDim2.new(
            1,
            -20,
            1,
            0
        )

    Label.BackgroundTransparency = 1
    Label.Font =
        Enum.Font.GothamMedium

    Label.Text = Name
    Label.TextSize = 13
    Label.TextColor3 =
        Colors.SubText

    Label.TextXAlignment =
        Enum.TextXAlignment.Left

    Label.ZIndex = 9
    Label.Parent = Button

    Connect(
        Button.MouseEnter,
        function()

            if CurrentCategory ~= Name then

                Tween(
                    Button,
                    {
                        BackgroundTransparency = 0.08
                    },
                    0.12
                )
            end
        end
    )

    Connect(
        Button.MouseLeave,
        function()

            if CurrentCategory ~= Name then

                Tween(
                    Button,
                    {
                        BackgroundTransparency = 0.25
                    },
                    0.12
                )
            end
        end
    )

    Connect(
        Button.MouseButton1Click,
        function()
            SwitchPage(Name)
        end
    )

    CategoryButtons[Name] =
        Button

    return Button
end

--========================================================
-- BUILD CATEGORIES
--========================================================

CreateCategory("Combat")
CreateCategory("Visuals")
CreateCategory("Movement")
CreateCategory("Settings")

SetCategoryActive("Combat")

Pages.Combat.Visible = true
Pages.Visuals.Visible = false
Pages.Movement.Visible = false
Pages.Settings.Visible = false

PageTitle.Text = "Combat"
PageDescription.Text =
    PageDescriptions.Combat

--========================================================
-- END PART 1/4
--========================================================

        --========================================================
-- PART 2/4 — COMBAT
-- Продолжение сразу после PART 1
--========================================================

--========================================================
-- COMBAT PAGE
--========================================================

local CombatPage = Pages.Combat

local AimSection = CreateSection(
    CombatPage,
    "AIM ASSIST",
    18
)

local AimToggle = CreateToggle(
    CombatPage,
    "Aim Assist",
    "Camera assistance toward the closest valid target",
    55,
    function(Value)
        Config.AimAssist = Value
    end
)

local VisibleToggle = CreateToggle(
    CombatPage,
    "Visible Only",
    "Only target players that can be seen",
    115,
    function(Value)
        Config.VisibleOnly = Value
    end
)

local AimFOVToggle = CreateToggle(
    CombatPage,
    "Aim FOV",
    "Limit target selection to the FOV circle",
    175,
    function(Value)
        Config.AimFOV = Value
    end
)

local FOVNumber = CreateNumber(
    CombatPage,
    "FOV Size",
    "Aim FOV radius",
    235,
    50,
    800,
    25,
    Config.FOVSize,
    function(Value)
        Config.FOVSize = Value
    end
)

local SmoothNumber = CreateNumber(
    CombatPage,
    "Smoothness",
    "Camera movement smoothness",
    295,
    0.01,
    1,
    0.01,
    Config.Smoothness,
    function(Value)
        Config.Smoothness = Value
    end
)

local TargetDropdown = CreateDropdown(
    CombatPage,
    "Target Part",
    "Body part used for aiming",
    355,
    {
        "Head",
        "HumanoidRootPart",
        "UpperTorso"
    },
    Config.TargetPart,
    function(Value)
        Config.TargetPart = Value
    end
)

--========================================================
-- AIM FUNCTIONS
--========================================================

local function GetCharacter()
    return LocalPlayer.Character
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

    if Part and Part:IsA("BasePart") then
        return Part
    end

    return Character:FindFirstChild("Head")
        or Character:FindFirstChild("HumanoidRootPart")
        or Character:FindFirstChild("UpperTorso")
end

local function IsAlive(Player)
    if not Player or Player == LocalPlayer then
        return false
    end

    local Character = Player.Character
    local Humanoid = GetHumanoid(Character)

    if not Character or not Humanoid then
        return false
    end

    return Humanoid.Health > 0
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
    local Direction = TargetPart.Position - Origin

    local Params = RaycastParams.new()
    Params.FilterType = Enum.RaycastFilterType.Exclude
    Params.FilterDescendantsInstances = {
        LocalPlayer.Character
    }

    local Result = workspace:Raycast(
        Origin,
        Direction,
        Params
    )

    if not Result then
        return true
    end

    return Result.Instance:IsDescendantOf(TargetPart.Parent)
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

    local BestPart = nil
    local BestDistance = math.huge

    for _, Player in ipairs(Players:GetPlayers()) do
        if not IsAlive(Player) then
            continue
        end

        local Character = Player.Character
        local TargetPart = GetTargetPart(Character)

        if not TargetPart then
            continue
        end

        if not IsVisible(TargetPart) then
            continue
        end

        local ScreenPosition, OnScreen =
            Camera:WorldToViewportPoint(TargetPart.Position)

        if not OnScreen then
            continue
        end

        local Distance = (
            Vector2.new(
                ScreenPosition.X,
                ScreenPosition.Y
            ) - Center
        ).Magnitude

        if Config.AimFOV and Distance > Config.FOVSize then
            continue
        end

        if Distance < BestDistance then
            BestDistance = Distance
            BestPart = TargetPart
        end
    end

    return BestPart
end

--========================================================
-- FOV CIRCLE
--========================================================

local FOVCircle = Instance.new("Frame")
FOVCircle.Name = "AimFOV"
FOVCircle.AnchorPoint = Vector2.new(0.5, 0.5)
FOVCircle.Position = UDim2.fromScale(0.5, 0.5)
FOVCircle.Size = UDim2.fromOffset(
    Config.FOVSize * 2,
    Config.FOVSize * 2
)
FOVCircle.BackgroundTransparency = 1
FOVCircle.BorderSizePixel = 0
FOVCircle.Visible = false
FOVCircle.ZIndex = 100
FOVCircle.Parent = ScreenGui

AddCorner(FOVCircle, 999)

local FOVStroke = Instance.new("UIStroke")
FOVStroke.Thickness = 1.5
FOVStroke.Transparency = 0.15
FOVStroke.Color = Colors.Accent
FOVStroke.Parent = FOVCircle

--========================================================
-- FOV UPDATE
--========================================================

Connect(
    RunService.RenderStepped,
    function()
        if Destroyed then
            return
        end

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
            Config.FOVSize * 2,
            Config.FOVSize * 2
        )

        FOVCircle.Visible =
            Config.AimFOV
            and MenuOpen
            and not Destroyed
    end
)

--========================================================
-- AIM ASSIST LOOP
--========================================================

local AimConnection

AimConnection = RunService:BindToRenderStep(
    "RivalsHub_AimAssist",
    Enum.RenderPriority.Camera.Value + 1,
    function()
        if Destroyed then
            return
        end

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

        local CurrentCFrame = Camera.CFrame

        local DesiredCFrame = CFrame.lookAt(
            CurrentCFrame.Position,
            Target.Position
        )

        local Alpha = math.clamp(
            Config.Smoothness,
            0.01,
            1
        )

        Camera.CFrame =
            CurrentCFrame:Lerp(
                DesiredCFrame,
                Alpha
            )
    end
)

--========================================================
-- SILENT AIM — UI ONLY
--========================================================

local SilentSection = CreateSection(
    CombatPage,
    "SILENT AIM",
    425
)

local SilentToggle = CreateToggle(
    CombatPage,
    "Silent Aim",
    "Silent Aim interface",
    470,
    function(Value)
        Config.SilentAim = Value
    end
)

local SilentPartDropdown = CreateDropdown(
    CombatPage,
    "Silent Aim Part",
    "Preferred target part",
    530,
    {
        "Head",
        "HumanoidRootPart",
        "UpperTorso"
    },
    Config.SilentAimPart,
    function(Value)
        Config.SilentAimPart = Value
    end
)

local SilentChanceNumber = CreateNumber(
    CombatPage,
    "Hit Chance",
    "Silent Aim chance",
    590,
    0,
    100,
    5,
    Config.SilentAimChance,
    function(Value)
        Config.SilentAimChance = Value
    end
)

--========================================================
-- CLEANUP AIM
--========================================================

Connect(
    LocalPlayer.CharacterAdded,
    function()
        task.wait(0.2)

        if Destroyed then
            return
        end
    end
)

--========================================================
-- END PART 2/4
--========================================================

--========================================================
-- PART 3/4 — VISUALS + MOVEMENT
-- Продолжение сразу после PART 2
--========================================================

--========================================================
-- VISUALS PAGE
--========================================================

local VisualsPage = Pages.Visuals

local ESPSection = CreateSection(
    VisualsPage,
    "ESP",
    18
)

local ESPToggle = CreateToggle(
    VisualsPage,
    "ESP",
    "Enable player ESP",
    55,
    function(Value)
        Config.ESP = Value
    end
)

local ModelToggle = CreateToggle(
    VisualsPage,
    "Model ESP",
    "Highlight player characters",
    115,
    function(Value)
        Config.ModelESP = Value
    end
)

local BoxToggle = CreateToggle(
    VisualsPage,
    "Box",
    "Display a box around players",
    175,
    function(Value)
        Config.Box = Value
    end
)

local NamesToggle = CreateToggle(
    VisualsPage,
    "Names",
    "Display player names",
    235,
    function(Value)
        Config.Names = Value
    end
)

local HealthToggle = CreateToggle(
    VisualsPage,
    "Health",
    "Display player health",
    295,
    function(Value)
        Config.Health = Value
    end
)

local DistanceToggle = CreateToggle(
    VisualsPage,
    "Distance",
    "Display player distance",
    355,
    function(Value)
        Config.Distance = Value
    end
)

--========================================================
-- ESP HELPERS
--========================================================

local function RemoveESP(Player)
    local Data = ESPObjects[Player]

    if not Data then
        return
    end

    for _, Object in pairs(Data) do
        if typeof(Object) == "Instance" then
            pcall(function()
                Object:Destroy()
            end)
        elseif type(Object) == "table" then
            for _, SubObject in pairs(Object) do
                if typeof(SubObject) == "Instance" then
                    pcall(function()
                        SubObject:Destroy()
                    end)
                end
            end
        end
    end

    ESPObjects[Player] = nil
end

local function ClearESP()
    for Player in pairs(ESPObjects) do
        RemoveESP(Player)
    end

    table.clear(ESPObjects)
end

local function CreateESP(Player)
    if Player == LocalPlayer then
        return
    end

    if ESPObjects[Player] then
        return
    end

    local Character = Player.Character

    if not Character then
        return
    end

    local Root =
        Character:FindFirstChild("HumanoidRootPart")
        or Character:FindFirstChild("UpperTorso")
        or Character:FindFirstChild("Torso")

    local Head = Character:FindFirstChild("Head")

    if not Root or not Head then
        return
    end

    local Data = {}

    --====================================================
    -- HIGHLIGHT / MODEL ESP
    --====================================================

    if Config.ModelESP then
        local Highlight = Instance.new("Highlight")

        Highlight.Name = "RivalsHub_ModelESP"
        Highlight.Adornee = Character
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        Highlight.FillTransparency = 0.72
        Highlight.OutlineTransparency = 0.1
        Highlight.FillColor = Colors.Accent
        Highlight.OutlineColor = Colors.Accent

        Highlight.Parent = Character

        Data.Highlight = Highlight
    end

    --====================================================
    -- BILLBOARD
    --====================================================

    if Config.Names
        or Config.Health
        or Config.Distance then

        local Billboard = Instance.new("BillboardGui")

        Billboard.Name = "RivalsHub_Info"
        Billboard.Adornee = Head
        Billboard.Size = UDim2.fromOffset(180, 70)
        Billboard.StudsOffset = Vector3.new(0, 2.8, 0)
        Billboard.AlwaysOnTop = true
        Billboard.Parent = Head

        local Label = Instance.new("TextLabel")

        Label.Name = "Info"
        Label.BackgroundTransparency = 1
        Label.Size = UDim2.fromScale(1, 1)
        Label.Font = Enum.Font.GothamMedium
        Label.TextSize = 12
        Label.TextColor3 = Colors.Text
        Label.TextStrokeTransparency = 0.5
        Label.TextWrapped = true
        Label.Parent = Billboard

        Data.Billboard = Billboard
        Data.Label = Label
    end

    --====================================================
    -- BOX
    --====================================================

    if Config.Box then
        local Box = Instance.new("BillboardGui")

        Box.Name = "RivalsHub_Box"
        Box.Adornee = Root
        Box.Size = UDim2.fromOffset(80, 110)
        Box.AlwaysOnTop = true
        Box.Parent = Root

        local Frame = Instance.new("Frame")

        Frame.BackgroundTransparency = 1
        Frame.Size = UDim2.fromScale(1, 1)
        Frame.Parent = Box

        AddCorner(Frame, 6)

        local Stroke = Instance.new("UIStroke")

        Stroke.Thickness = 1.5
        Stroke.Color = Colors.Accent
        Stroke.Transparency = 0.1
        Stroke.Parent = Frame

        Data.Box = Box
        Data.BoxFrame = Frame
    end

    ESPObjects[Player] = Data
end

--========================================================
-- ESP UPDATE
--========================================================

local function UpdateESP()
    if Destroyed then
        ClearESP()
        return
    end

    if not Config.ESP then
        ClearESP()
        return
    end

    for _, Player in ipairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer then

            local Character = Player.Character

            if not Character then
                RemoveESP(Player)
                continue
            end

            local Humanoid =
                Character:FindFirstChildOfClass("Humanoid")

            if not Humanoid or Humanoid.Health <= 0 then
                RemoveESP(Player)
                continue
            end

            if not ESPObjects[Player] then
                CreateESP(Player)
            end

            local Data = ESPObjects[Player]

            if Data then
                -- Rebuild when options change.
                local HighlightWanted = Config.ModelESP
                local BoxWanted = Config.Box
                local InfoWanted =
                    Config.Names
                    or Config.Health
                    or Config.Distance

                if HighlightWanted ~= (Data.Highlight ~= nil)
                    or BoxWanted ~= (Data.Box ~= nil)
                    or InfoWanted ~= (Data.Billboard ~= nil) then

                    RemoveESP(Player)
                    CreateESP(Player)
                    Data = ESPObjects[Player]
                end

                if Data and Data.Label then
                    local Text = {}

                    if Config.Names then
                        table.insert(
                            Text,
                            Player.DisplayName
                        )
                    end

                    if Config.Health then
                        table.insert(
                            Text,
                            "HP: "
                            .. math.floor(Humanoid.Health)
                            .. "/"
                            .. math.floor(Humanoid.MaxHealth)
                        )
                    end

                    if Config.Distance then
                        local Camera =
                            workspace.CurrentCamera

                        local Root =
                            Character:FindFirstChild(
                                "HumanoidRootPart"
                            )

                        if Camera and Root then
                            local Distance =
                                (
                                    Camera.CFrame.Position
                                    - Root.Position
                                ).Magnitude

                            table.insert(
                                Text,
                                math.floor(Distance) .. " studs"
                            )
                        end
                    end

                    Data.Label.Text =
                        table.concat(Text, "\n")
                end
            end
        end
    end
end

Connect(
    RunService.RenderStepped,
    function()
        UpdateESP()
    end
)

--========================================================
-- PLAYER ESP CONNECTIONS
--========================================================

for _, Player in ipairs(Players:GetPlayers()) do
    if Player ~= LocalPlayer then

        Connect(
            Player.CharacterAdded,
            function()
                RemoveESP(Player)

                if Config.ESP then
                    task.wait(0.2)
                    CreateESP(Player)
                end
            end
        )

        Connect(
            Player.CharacterRemoving,
            function()
                RemoveESP(Player)
            end
        )
    end
end

Connect(
    Players.PlayerAdded,
    function(Player)

        Connect(
            Player.CharacterAdded,
            function()
                RemoveESP(Player)

                if Config.ESP then
                    task.wait(0.2)
                    CreateESP(Player)
                end
            end
        )

        Connect(
            Player.CharacterRemoving,
            function()
                RemoveESP(Player)
            end
        )
    end
)

Connect(
    Players.PlayerRemoving,
    function(Player)
        RemoveESP(Player)
    end
)

--========================================================
-- MOVEMENT PAGE
--========================================================

local MovementPage = Pages.Movement

local MovementSection = CreateSection(
    MovementPage,
    "MOVEMENT",
    18
)

local SpeedToggle = CreateToggle(
    MovementPage,
    "Speed",
    "Change your walking speed",
    55,
    function(Value)
        Config.SpeedEnabled = Value
    end
)

local SpeedNumber = CreateNumber(
    MovementPage,
    "Speed Value",
    "Walking speed",
    115,
    1,
    100,
    1,
    Config.SpeedValue,
    function(Value)
        Config.SpeedValue = Value
    end
)

local JumpToggle = CreateToggle(
    MovementPage,
    "Jump",
    "Change your jump power",
    175,
    function(Value)
        Config.Jump = Value
    end
)

local JumpNumber = CreateNumber(
    MovementPage,
    "Jump Power",
    "Jump power value",
    235,
    1,
    200,
    5,
    Config.JumpPower,
    function(Value)
        Config.JumpPower = Value
    end
)

local NoclipToggle = CreateToggle(
    MovementPage,
    "Noclip",
    "Disable character collisions",
    295,
    function(Value)
        Config.Noclip = Value
    end
)

local MovementInfo = CreateInfoCard(
    MovementPage,
    "MOVEMENT INFO",
    "Speed, Jump and Noclip are applied locally and are restored when disabled.",
    355
)

--========================================================
-- MOVEMENT FUNCTIONS
--========================================================

local function ApplyMovementSettings()
    if Destroyed then
        return
    end

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
        Humanoid.UseJumpPower = true
        Humanoid.JumpPower = 50
    end
end

Connect(
    RunService.Heartbeat,
    function()
        ApplyMovementSettings()

        local Character = LocalPlayer.Character

        if not Character then
            return
        end

        if Config.Noclip then
            for _, Object in ipairs(Character:GetDescendants()) do
                if Object:IsA("BasePart") then
                    Object.CanCollide = false
                end
            end
        else
            for _, Object in ipairs(Character:GetDescendants()) do
                if Object:IsA("BasePart") then
                    if Object.Name ~= "HumanoidRootPart" then
                        Object.CanCollide = true
                    end
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
    function(Character)
        task.wait(0.25)

        if Destroyed then
            return
        end

        local Humanoid =
            Character:FindFirstChildOfClass("Humanoid")

        if Humanoid then
            ApplyMovementSettings()
        end
    end
)

--========================================================
-- END PART 3/4
--========================================================

--========================================================
-- PART 4/4 — ANIMATIONS + MINIMIZE + CLOSE + DRAG
-- Продолжение сразу после PART 3
--========================================================

--========================================================
-- CATEGORY ANIMATIONS
--========================================================

local PageBusy = false

local function AnimatePage(NewPage)
    if PageBusy or Destroyed then
        return
    end

    if not NewPage then
        return
    end

    PageBusy = true

    local OldPage = nil

    for _, Page in pairs(Pages) do
        if Page.Visible then
            OldPage = Page
            break
        end
    end

    if OldPage == NewPage then
        PageBusy = false
        return
    end

    local Direction = 1

    if CurrentCategory == "Settings" then
        Direction = -1
    end

    NewPage.Position = UDim2.new(
        Direction,
        Direction == 1 and 35 or -35,
        0,
        0
    )

    NewPage.Visible = true

    if OldPage then
        Tween(
            OldPage,
            {
                Position = UDim2.new(
                    -Direction,
                    Direction == 1 and -35 or 35,
                    0,
                    0
                )
            },
            0.18,
            Enum.EasingStyle.Quint
        )
    end

    Tween(
        NewPage,
        {
            Position = UDim2.new(0, 0, 0, 0)
        },
        0.22,
        Enum.EasingStyle.Quint
    )

    task.delay(0.23, function()
        if Destroyed then
            return
        end

        if OldPage and OldPage ~= NewPage then
            OldPage.Visible = false
            OldPage.Position =
                UDim2.new(0, 0, 0, 0)
        end

        PageBusy = false
    end)
end

local function SelectCategory(Category)
    if Destroyed or PageBusy then
        return
    end

    if not Pages[Category] then
        return
    end

    if CurrentCategory == Category then
        return
    end

    local Previous = CurrentCategory
    CurrentCategory = Category

    local Button = CategoryButtons[Category]

    if Button then
        for Name, OtherButton in pairs(CategoryButtons) do
            local Selected =
                Name == Category

            Tween(
                OtherButton,
                {
                    BackgroundTransparency =
                        Selected and 0.08 or 1
                },
                0.16,
                Enum.EasingStyle.Quint
            )

            local Accent =
                OtherButton:FindFirstChild("Accent")

            if Accent then
                Tween(
                    Accent,
                    {
                        BackgroundTransparency =
                            Selected and 0 or 1
                    },
                    0.16,
                    Enum.EasingStyle.Quint
                )
            end
        end
    end

    local Title =
        PageDescriptions[Category]

    if PageTitle then
        Tween(
            PageTitle,
            {
                TextTransparency = 1
            },
            0.08
        )

        task.delay(0.08, function()
            if Destroyed then
                return
            end

            PageTitle.Text = Category

            Tween(
                PageTitle,
                {
                    TextTransparency = 0
                },
                0.14
            )
        end)
    end

    if PageDescription then
        Tween(
            PageDescription,
            {
                TextTransparency = 1
            },
            0.08
        )

        task.delay(0.08, function()
            if Destroyed then
                return
            end

            PageDescription.Text =
                Title or ""

            Tween(
                PageDescription,
                {
                    TextTransparency = 0
                },
                0.14
            )
        end)
    end

    AnimatePage(Pages[Category])
end

for Category, Button in pairs(CategoryButtons) do
    Connect(
        Button.MouseButton1Click,
        function()
            SelectCategory(Category)
        end
    )
end

--========================================================
-- INITIAL CATEGORY
--========================================================

for Name, Page in pairs(Pages) do
    Page.Visible = Name == "Combat"
    Page.Position = UDim2.new(0, 0, 0, 0)
end

CurrentCategory = "Combat"

if CategoryButtons.Combat then
    CategoryButtons.Combat.BackgroundTransparency = 0.08

    local Accent =
        CategoryButtons.Combat:FindFirstChild("Accent")

    if Accent then
        Accent.BackgroundTransparency = 0
    end
end

--========================================================
-- BACKGROUND ANIMATION
--========================================================

local BackgroundObjects = {}

for _, Object in ipairs(Main:GetDescendants()) do
    if Object:IsA("Frame")
        and Object.Name == "BackgroundLight" then

        table.insert(
            BackgroundObjects,
            Object
        )
    end
end

Connect(
    RunService.RenderStepped,
    function()
        if Destroyed then
            return
        end

        local Time = os.clock()

        for Index, Object in ipairs(BackgroundObjects) do
            if Object and Object.Parent then
                local Offset =
                    math.sin(
                        Time * 0.7
                        + Index * 1.7
                    ) * 12

                Object.Position =
                    UDim2.new(
                        Object.Position.X.Scale,
                        Offset,
                        Object.Position.Y.Scale,
                        Object.Position.Y.Offset
                    )
            end
        end
    end
)

--========================================================
-- OPEN / CLOSE ANIMATION STATE
--========================================================

local OriginalSize = Holder.Size
local OriginalPosition = Holder.Position

local function ShowMenu()
    if Destroyed or MenuOpen then
        return
    end

    MenuOpen = true

    if SavedMenuPosition then
        Holder.Position = SavedMenuPosition
    else
        Holder.Position = OriginalPosition
    end

    Holder.Visible = true

    Holder.Size = UDim2.fromOffset(650, 0)

    Tween(
        Holder,
        {
            Size = OriginalSize
        },
        0.38,
        Enum.EasingStyle.Back
    )

    task.delay(0.1, function()
        if Destroyed then
            return
        end

        Tween(
            Main,
            {
                BackgroundTransparency = 0
            },
            0.18
        )
    end)
end

--========================================================
-- FLOATING R BUTTON
--========================================================

local FloatingButton = Instance.new("TextButton")

FloatingButton.Name = "FloatingR"
FloatingButton.AnchorPoint =
    Vector2.new(0.5, 0.5)

FloatingButton.Size =
    UDim2.fromOffset(44, 44)

FloatingButton.Position =
    UDim2.new(0.5, 0, 0.5, 0)

FloatingButton.BackgroundColor3 =
    Colors.Background

FloatingButton.BackgroundTransparency = 0.04

FloatingButton.BorderSizePixel = 0

FloatingButton.Text = "R"

FloatingButton.TextColor3 =
    Colors.Text

FloatingButton.TextSize = 18

FloatingButton.Font =
    Enum.Font.GothamBold

FloatingButton.AutoButtonColor = false

FloatingButton.Visible = false

FloatingButton.ZIndex = 500

FloatingButton.Parent = ScreenGui

AddCorner(FloatingButton, 999)
AddStroke(
    FloatingButton,
    Colors.Accent,
    1.4,
    0.15
)

--========================================================
-- FLOATING BUTTON HOVER
--========================================================

Connect(
    FloatingButton.MouseEnter,
    function()
        if Destroyed then
            return
        end

        Tween(
            FloatingButton,
            {
                Size = UDim2.fromOffset(48, 48)
            },
            0.16,
            Enum.EasingStyle.Quint
        )
    end
)

Connect(
    FloatingButton.MouseLeave,
    function()
        if Destroyed then
            return
        end

        Tween(
            FloatingButton,
            {
                Size = UDim2.fromOffset(44, 44)
            },
            0.16,
            Enum.EasingStyle.Quint
        )
    end
)

--========================================================
-- MINIMIZE
--========================================================

local function MinimizeMenu()
    if Destroyed or not MenuOpen then
        return
    end

    MenuOpen = false

    SavedMenuPosition = Holder.Position

    FOVCircle.Visible = false

    local Position =
        Holder.AbsolutePosition

    local Size =
        Holder.AbsoluteSize

    local Center =
        Position + Size / 2

    FloatingButton.Position =
        UDim2.fromOffset(
            Center.X,
            Center.Y
        )

    FloatingButton.Size =
        UDim2.fromOffset(44, 44)

    FloatingButton.Visible = true

    Tween(
        Holder,
        {
            Size = UDim2.fromOffset(650, 0)
        },
        0.28,
        Enum.EasingStyle.Quint
    )

    task.delay(0.28, function()
        if Destroyed then
            return
        end

        Holder.Visible = false
    end)

    Tween(
        FloatingButton,
        {
            Size = UDim2.fromOffset(44, 44)
        },
        0.2,
        Enum.EasingStyle.Back
    )
end

Connect(
    MinimizeButton.MouseButton1Click,
    function()
        MinimizeMenu()
    end
)

Connect(
    FloatingButton.MouseButton1Click,
    function()
        ShowMenu()
        FloatingButton.Visible = false
    end
)

--========================================================
-- CLOSE / DELETE EVERYTHING
--========================================================

local function DestroyHub()
    if Destroyed then
        return
    end

    Destroyed = true
    MenuOpen = false

    -- Stop Aim Assist
    pcall(function()
        RunService:UnbindFromRenderStep(
            "RivalsHub_AimAssist"
        )
    end)

    -- Remove ESP
    pcall(function()
        ClearESP()
    end)

    -- Disconnect all normal connections
    DisconnectAll()

    -- Restore character movement
    pcall(function()
        local Character =
            LocalPlayer.Character

        if Character then
            local Humanoid =
                Character:FindFirstChildOfClass(
                    "Humanoid"
                )

            if Humanoid then
                Humanoid.WalkSpeed = 16
                Humanoid.UseJumpPower = true
                Humanoid.JumpPower = 50
            end

            for _, Object in ipairs(
                Character:GetDescendants()
            ) do
                if Object:IsA("BasePart") then
                    if Object.Name ~= "HumanoidRootPart" then
                        Object.CanCollide = true
                    end
                end
            end
        end
    end)

    -- Remove FOV
    pcall(function()
        FOVCircle:Destroy()
    end)

    -- Remove floating button
    pcall(function()
        FloatingButton:Destroy()
    end)

    -- Remove GUI completely
    pcall(function()
        ScreenGui:Destroy()
    end)
end

Connect(
    CloseButton.MouseButton1Click,
    function()
        DestroyHub()
    end
)

--========================================================
-- CLOSE BUTTON HOVER
--========================================================

Connect(
    CloseButton.MouseEnter,
    function()
        if Destroyed then
            return
        end

        Tween(
            CloseButton,
            {
                BackgroundTransparency = 0.72
            },
            0.12
        )
    end
)

Connect(
    CloseButton.MouseLeave,
    function()
        if Destroyed then
            return
        end

        Tween(
            CloseButton,
            {
                BackgroundTransparency = 1
            },
            0.12
        )
    end
)

--========================================================
-- MINIMIZE BUTTON HOVER
--========================================================

Connect(
    MinimizeButton.MouseEnter,
    function()
        if Destroyed then
            return
        end

        Tween(
            MinimizeButton,
            {
                BackgroundTransparency = 0.72
            },
            0.12
        )
    end
)

Connect(
    MinimizeButton.MouseLeave,
    function()
        if Destroyed then
            return
        end

        Tween(
            MinimizeButton,
            {
                BackgroundTransparency = 1
            },
            0.12
        )
    end
)

--========================================================
-- DRAGGING
--========================================================

local Dragging = false
local DragStart
local StartPosition

local function UpdateDrag(Input)
    if not Dragging then
        return
    end

    local Delta =
        Input.Position - DragStart

    Holder.Position =
        UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
end

Connect(
    TopBar.InputBegan,
    function(Input)
        if Destroyed then
            return
        end

        if Input.UserInputType ==
            Enum.UserInputType.MouseButton1
            or Input.UserInputType ==
            Enum.UserInputType.Touch then

            Dragging = true
            DragStart = Input.Position
            StartPosition = Holder.Position
        end
    end
)

Connect(
    UserInputService.InputChanged,
    function(Input)
        if not Dragging then
            return
        end

        if Input.UserInputType ==
            Enum.UserInputType.MouseMovement
            or Input.UserInputType ==
            Enum.UserInputType.Touch then

            UpdateDrag(Input)
        end
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
            SavedMenuPosition = Holder.Position
        end
    end
)

--========================================================
-- FLOATING R DRAG
--========================================================

local FloatingDragging = false
local FloatingDragStart
local FloatingStartPosition

Connect(
    FloatingButton.InputBegan,
    function(Input)
        if Destroyed then
            return
        end

        if Input.UserInputType ==
            Enum.UserInputType.MouseButton1
            or Input.UserInputType ==
            Enum.UserInputType.Touch then

            FloatingDragging = true
            FloatingDragStart = Input.Position
            FloatingStartPosition =
                FloatingButton.Position
        end
    end
)

Connect(
    UserInputService.InputChanged,
    function(Input)
        if not FloatingDragging then
            return
        end

        if Input.UserInputType ==
            Enum.UserInputType.MouseMovement
            or Input.UserInputType ==
            Enum.UserInputType.Touch then

            local Delta =
                Input.Position
                - FloatingDragStart

            FloatingButton.Position =
                UDim2.new(
                    FloatingStartPosition.X.Scale,
                    FloatingStartPosition.X.Offset
                        + Delta.X,
                    FloatingStartPosition.Y.Scale,
                    FloatingStartPosition.Y.Offset
                        + Delta.Y
                )
        end
    end
)

Connect(
    UserInputService.InputEnded,
    function(Input)
        if Input.UserInputType ==
            Enum.UserInputType.MouseButton1
            or Input.UserInputType ==
            Enum.UserInputType.Touch then

            FloatingDragging = false
        end
    end
)

--========================================================
-- OPEN ANIMATION
--========================================================

Holder.Size =
    UDim2.fromOffset(650, 0)

task.delay(0.05, function()
    if Destroyed then
        return
    end

    Tween(
        Holder,
        {
            Size = OriginalSize
        },
        0.45,
        Enum.EasingStyle.Back
    )
end)

--========================================================
-- FINAL SAFETY
--========================================================

Connect(
    ScreenGui.AncestryChanged,
    function(_, Parent)
        if not Parent then
            Destroyed = true

            pcall(function()
                RunService:UnbindFromRenderStep(
                    "RivalsHub_AimAssist"
                )
            end)

            pcall(function()
                ClearESP()
            end)

            DisconnectAll()
        end
    end
)

--========================================================
-- FINAL INITIALIZATION
--========================================================

MenuOpen = true
SavedMenuPosition = Holder.Position

FOVCircle.Visible =
    Config.AimFOV
    and MenuOpen

print("Rivals Hub loaded successfully.")

--========================================================
-- END PART 4/4
--========================================================
