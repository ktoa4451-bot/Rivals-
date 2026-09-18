--// ============================================================
--// RIVALS HUB
--// CLEAN BUILD
--// PART 1A/3
--// ============================================================

--// ============================================================
--// SERVICES
--// ============================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

--// ============================================================
--// CONFIG
--// ============================================================

local Config = {

    --// Interface
    AnimationTime = 0.35,
    Animations = true,

    BackgroundEffects = true,
    ShowStatus = true,

    --// Colors
    Background = Color3.fromRGB(
        8,
        8,
        14
    ),

    Panel = Color3.fromRGB(
        12,
        12,
        20
    ),

    Panel2 = Color3.fromRGB(
        18,
        18,
        28
    ),

    Accent = Color3.fromRGB(
        150,
        85,
        255
    ),

    Text = Color3.fromRGB(
        245,
        245,
        250
    ),

    Muted = Color3.fromRGB(
        145,
        145,
        160
    ),

    --// Combat
    AimAssist = false,
    TeamCheck = true,
    VisibleOnly = false,

    TargetPart = "Head",
    AimFOV = 150,

    --// Visuals
    ESP = false,
    ESPNames = true,
    ESPDistance = true,
    ESPHealth = true,

    VisualTeamCheck = true,

    FOVCircle = false,
    FOVSize = 150,
    FOVThickness = 2,

    --// Movement
    SpeedEnabled = false,
    Speed = 18,

    JumpEnabled = false,
    Jump = 50,

    InfiniteJump = false,
    Noclip = false,
    AutoSprint = false,

    --// Runtime
    Destroyed = false
}

--// ============================================================
--// REMOVE OLD HUB
--// ============================================================

pcall(function()

    local Old =
        game:GetService("CoreGui"):FindFirstChild(
            "RivalsHub"
        )

    if Old then
        Old:Destroy()
    end
end)

--// ============================================================
--// HELPER FUNCTIONS
--// ============================================================

local function AddCorner(Object, Radius)

    local Corner =
        Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(
            0,
            Radius
        )

    Corner.Parent = Object

    return Corner
end

local function AddStroke(
    Object,
    Color,
    Thickness,
    Transparency
)

    local Stroke =
        Instance.new("UIStroke")

    Stroke.Color =
        Color or Config.Accent

    Stroke.Thickness =
        Thickness or 1

    Stroke.Transparency =
        Transparency or 0

    Stroke.ApplyStrokeMode =
        Enum.ApplyStrokeMode.Border

    Stroke.Parent =
        Object

    return Stroke
end

local function AddPadding(
    Object,
    Left,
    Right,
    Top,
    Bottom
)

    local Padding =
        Instance.new("UIPadding")

    Padding.PaddingLeft =
        UDim.new(
            0,
            Left or 0
        )

    Padding.PaddingRight =
        UDim.new(
            0,
            Right or 0
        )

    Padding.PaddingTop =
        UDim.new(
            0,
            Top or 0
        )

    Padding.PaddingBottom =
        UDim.new(
            0,
            Bottom or 0
        )

    Padding.Parent =
        Object

    return Padding
end

local function Tween(
    Object,
    Time,
    Properties,
    Style,
    Direction
)

    if not Config.Animations then

        for Property, Value in pairs(
            Properties
        ) do

            Object[Property] = Value
        end

        return nil
    end

    local Info =
        TweenInfo.new(
            Time or Config.AnimationTime,
            Style or Enum.EasingStyle.Quint,
            Direction or Enum.EasingDirection.Out
        )

    local Animation =
        TweenService:Create(
            Object,
            Info,
            Properties
        )

    Animation:Play()

    return Animation
end

local function New(
    ClassName,
    Parent,
    Properties
)

    local Object =
        Instance.new(ClassName)

    for Property, Value in pairs(
        Properties or {}
    ) do

        pcall(function()
            Object[Property] = Value
        end)
    end

    Object.Parent =
        Parent

    return Object
end

local function Label(
    Parent,
    Text,
    Size,
    Position,
    TextSize,
    Color
)

    return New(
        "TextLabel",
        Parent,
        {
            Size =
                Size or UDim2.fromScale(
                    1,
                    1
                ),

            Position =
                Position or UDim2.fromOffset(
                    0,
                    0
                ),

            BackgroundTransparency = 1,

            Text = Text or "",

            TextColor3 =
                Color or Config.Text,

            TextSize =
                TextSize or 11,

            Font =
                Enum.Font.GothamSemibold,

            TextXAlignment =
                Enum.TextXAlignment.Left,

            TextYAlignment =
                Enum.TextYAlignment.Center,

            ZIndex = 10
        }
    )
end

--// ============================================================
--// END PART 1A/3
--// ============================================================

--// ============================================================
--// SCREEN GUI
--// ============================================================

local ScreenGui =
    Instance.new("ScreenGui")

ScreenGui.Name =
    "RivalsHub"

ScreenGui.ResetOnSpawn =
    false

ScreenGui.IgnoreGuiInset =
    true

ScreenGui.ZIndexBehavior =
    Enum.ZIndexBehavior.Sibling

ScreenGui.DisplayOrder =
    999999

ScreenGui.Parent =
    game:GetService("CoreGui")

--// ============================================================
--// MAIN HOLDER
--// ============================================================

local Holder =
    New(
        "Frame",
        ScreenGui,
        {
            Name = "Holder",

            AnchorPoint =
                Vector2.new(
                    0.5,
                    0.5
                ),

            Position =
                UDim2.fromScale(
                    0.5,
                    0.5
                ),

            Size =
                UDim2.fromOffset(
                    650,
                    455
                ),

            BackgroundColor3 =
                Config.Background,

            BorderSizePixel = 0,

            ZIndex = 5
        }
    )

AddCorner(
    Holder,
    18
)

local HolderStroke =
    AddStroke(
        Holder,
        Config.Accent,
        1.5,
        0.25
    )

--// ============================================================
--// SCALE
--// ============================================================

local UIScale =
    Instance.new("UIScale")

UIScale.Scale =
    1

UIScale.Parent =
    Holder

--// ============================================================
--// BACKGROUND
--// ============================================================

local Background =
    New(
        "Frame",
        Holder,
        {
            Name = "Background",

            Size =
                UDim2.fromScale(
                    1,
                    1
                ),

            BackgroundColor3 =
                Color3.fromRGB(
                    5,
                    5,
                    10
                ),

            BorderSizePixel = 0,

            ClipsDescendants = true,

            ZIndex = 6
        }
    )

AddCorner(
    Background,
    18
)

--// ============================================================
--// ANIMATED PURPLE LINES
--// ============================================================

local BackgroundLines = {}

for I = 1, 9 do

    local Line =
        New(
            "Frame",
            Background,
            {
                Name =
                    "Line_" .. I,

                AnchorPoint =
                    Vector2.new(
                        0.5,
                        0.5
                    ),

                Position =
                    UDim2.new(
                        -0.15 + (
                            I * 0.14
                        ),
                        0,
                        0.5,
                        0
                    ),

                Size =
                    UDim2.new(
                        0,
                        2,
                        1.6,
                        0
                    ),

                Rotation = 25,

                BackgroundColor3 =
                    Config.Accent,

                BackgroundTransparency =
                    0.88,

                BorderSizePixel = 0,

                ZIndex = 7
            }
        )

    AddCorner(
        Line,
        999
    )

    table.insert(
        BackgroundLines,
        Line
    )
end

--// ============================================================
--// SOFT GLOW
--// ============================================================

for I = 1, 4 do

    local Glow =
        New(
            "Frame",
            Background,
            {
                Name =
                    "Glow_" .. I,

                AnchorPoint =
                    Vector2.new(
                        0.5,
                        0.5
                    ),

                Position =
                    UDim2.new(
                        I * 0.25,
                        0,
                        0.25 + (
                            (I % 2) * 0.35
                        ),
                        0
                    ),

                Size =
                    UDim2.fromOffset(
                        180,
                        180
                    ),

                BackgroundColor3 =
                    Config.Accent,

                BackgroundTransparency =
                    0.97,

                BorderSizePixel = 0,

                ZIndex = 7
            }
        )

    AddCorner(
        Glow,
        999
    )
end

--// ============================================================
--// BACKGROUND ANIMATION
--// ============================================================

task.spawn(function()

    local Offset = 0

    while ScreenGui.Parent
        and not Config.Destroyed do

        if Config.BackgroundEffects then

            Offset += 0.0025

            for I, Line in ipairs(
                BackgroundLines
            ) do

                local Base =
                    -0.15 + (
                        I * 0.14
                    )

                local X =
                    Base
                    + math.sin(
                        Offset * 2
                        + I
                    ) * 0.035

                Line.Position =
                    UDim2.new(
                        X,
                        0,
                        0.5,
                        0
                    )

                Line.BackgroundColor3 =
                    Config.Accent
            end
        end

        task.wait(
            0.03
        )
    end
end)

--// ============================================================
--// MAIN CONTENT
--// ============================================================

local Main =
    New(
        "Frame",
        Holder,
        {
            Name = "Main",

            Size =
                UDim2.fromScale(
                    1,
                    1
                ),

            BackgroundTransparency =
                1,

            BorderSizePixel = 0,

            ZIndex = 20
        }
    )

--// ============================================================
--// TOP BAR
--// ============================================================

local TopBar =
    New(
        "Frame",
        Main,
        {
            Name = "TopBar",

            Position =
                UDim2.fromOffset(
                    8,
                    8
                ),

            Size =
                UDim2.new(
                    1,
                    -16,
                    0,
                    62
                ),

            BackgroundColor3 =
                Config.Panel,

            BackgroundTransparency =
                0.08,

            BorderSizePixel = 0,

            ZIndex = 25
        }
    )

AddCorner(
    TopBar,
    13
)

AddStroke(
    TopBar,
    Config.Accent,
    1,
    0.75
)

--// ============================================================
--// LOGO
--// ============================================================

local Logo =
    New(
        "TextButton",
        TopBar,
        {
            Name = "Logo",

            Position =
                UDim2.fromOffset(
                    9,
                    9
                ),

            Size =
                UDim2.fromOffset(
                    44,
                    44
                ),

            BackgroundColor3 =
                Config.Accent,

            BorderSizePixel = 0,

            Text = "R",

            TextColor3 =
                Color3.fromRGB(
                    255,
                    255,
                    255
                ),

            TextSize = 19,

            Font =
                Enum.Font.GothamBold,

            AutoButtonColor = false,

            ZIndex = 30
        }
    )

AddCorner(
    Logo,
    11
)

--// ============================================================
--// TITLE
--// ============================================================

local Title =
    Label(
        TopBar,
        "RIVALS HUB",
        UDim2.new(
            1,
            -190,
            0,
            25
        ),
        UDim2.fromOffset(
            66,
            8
        ),
        14,
        Config.Text
    )

Title.Font =
    Enum.Font.GothamBold

Title.ZIndex =
    30

local Subtitle =
    Label(
        TopBar,
        "Clean competitive interface",
        UDim2.new(
            1,
            -190,
            0,
            18
        ),
        UDim2.fromOffset(
            67,
            31
        ),
        8,
        Config.Muted
    )

Subtitle.ZIndex =
    30

--// ============================================================
--// STATUS
--// ============================================================

local StatusDot =
    New(
        "Frame",
        TopBar,
        {
            Position =
                UDim2.new(
                    1,
                    -142,
                    0,
                    18
                ),

            Size =
                UDim2.fromOffset(
                    7,
                    7
                ),

            BackgroundColor3 =
                Config.Accent,

            BorderSizePixel = 0,

            ZIndex = 31
        }
    )

AddCorner(
    StatusDot,
    999
)

local StatusText =
    Label(
        TopBar,
        "ONLINE",
        UDim2.fromOffset(
            55,
            20
        ),
        UDim2.new(
            1,
            -130,
            0,
            12
        ),
        8,
        Config.Muted
    )

StatusText.TextXAlignment =
    Enum.TextXAlignment.Right

StatusText.ZIndex =
    31

--// ============================================================
--// MINIMIZE
--// ============================================================

local MinimizeButton =
    New(
        "TextButton",
        TopBar,
        {
            Name = "Minimize",

            AnchorPoint =
                Vector2.new(
                    1,
                    0.5
                ),

            Position =
                UDim2.new(
                    1,
                    -45,
                    0.5,
                    0
                ),

            Size =
                UDim2.fromOffset(
                    28,
                    28
                ),

            BackgroundColor3 =
                Color3.fromRGB(
                    30,
                    30,
                    42
                ),

            BorderSizePixel = 0,

            Text = "—",

            TextColor3 =
                Config.Muted,

            TextSize = 13,

            Font =
                Enum.Font.GothamBold,

            AutoButtonColor = false,

            ZIndex = 31
        }
    )

AddCorner(
    MinimizeButton,
    8
)

--// ============================================================
--// CLOSE
--// ============================================================

local CloseButton =
    New(
        "TextButton",
        TopBar,
        {
            Name = "Close",

            AnchorPoint =
                Vector2.new(
                    1,
                    0.5
                ),

            Position =
                UDim2.new(
                    1,
                    -10,
                    0.5,
                    0
                ),

            Size =
                UDim2.fromOffset(
                    28,
                    28
                ),

            BackgroundColor3 =
                Color3.fromRGB(
                    45,
                    25,
                    38
                ),

            BorderSizePixel = 0,

            Text = "×",

            TextColor3 =
                Color3.fromRGB(
                    255,
                    170,
                    190
                ),

            TextSize = 16,

            Font =
                Enum.Font.GothamBold,

            AutoButtonColor = false,

            ZIndex = 31
        }
    )

AddCorner(
    CloseButton,
    8
)

--// ============================================================
--// END PART 1B/3
--// ============================================================

--========================================================--
-- RIVALS HUB
-- PART 1C/3
-- BODY + SIDEBAR + PAGE SYSTEM
--========================================================--

--// BODY
local Body = New("Frame", {
    Name = "Body",
    Parent = Main,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 8, 0, 78),
    Size = UDim2.new(1, -16, 1, -86),
    ZIndex = 5
})

--========================================================--
-- SIDEBAR
--========================================================--

local Sidebar = New("Frame", {
    Name = "Sidebar",
    Parent = Body,
    BackgroundColor3 = Config.Colors.Panel,
    BackgroundTransparency = 0.08,
    Size = UDim2.new(0, 145, 1, 0),
    Position = UDim2.new(0, 0, 0, 0),
    ZIndex = 6
})

AddCorner(Sidebar, 14)
AddStroke(Sidebar, Config.Colors.Panel2, 1, 0.25)

local SidebarTitle = Label(
    Sidebar,
    "CATEGORIES",
    UDim2.new(1, -24, 0, 22),
    UDim2.new(0, 12, 0, 12),
    Config.Colors.Muted,
    Enum.Font.GothamBold,
    11
)

SidebarTitle.ZIndex = 7

local PageButtonsHolder = New("Frame", {
    Name = "PageButtonsHolder",
    Parent = Sidebar,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 8, 0, 43),
    Size = UDim2.new(1, -16, 1, -51),
    ZIndex = 7
})

local PageLayout = New("UIListLayout", {
    Parent = PageButtonsHolder,
    FillDirection = Enum.FillDirection.Vertical,
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    VerticalAlignment = Enum.VerticalAlignment.Top,
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 7)
})

--========================================================--
-- PAGE HOLDER
--========================================================--

local PageHolder = New("Frame", {
    Name = "PageHolder",
    Parent = Body,
    BackgroundColor3 = Config.Colors.Panel,
    BackgroundTransparency = 0.08,
    Position = UDim2.new(0, 153, 0, 0),
    Size = UDim2.new(1, -153, 1, 0),
    ZIndex = 6
})

AddCorner(PageHolder, 14)
AddStroke(PageHolder, Config.Colors.Panel2, 1, 0.25)

--========================================================--
-- PAGE DATA
--========================================================--

local Pages = {}
local PageButtons = {}
local Components = {}

local CurrentPage = nil

--========================================================--
-- CREATE PAGE
--========================================================--

local function CreatePage(Name, Order)
    --// PAGE BUTTON
    local Button = New("TextButton", {
        Name = Name .. "Button",
        Parent = PageButtonsHolder,
        BackgroundColor3 = Config.Colors.Panel2,
        BackgroundTransparency = 0.35,
        Size = UDim2.new(1, 0, 0, 38),
        AutoButtonColor = false,
        Text = "",
        LayoutOrder = Order,
        ZIndex = 8
    })

    AddCorner(Button, 10)
    AddStroke(Button, Config.Colors.Panel2, 1, 0.45)

    local Indicator = New("Frame", {
        Name = "Indicator",
        Parent = Button,
        BackgroundColor3 = Config.Colors.Accent,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 6, 0.5, -9),
        Size = UDim2.new(0, 3, 0, 18),
        ZIndex = 9
    })

    AddCorner(Indicator, 3)

    local ButtonText = Label(
        Button,
        Name,
        UDim2.new(1, -28, 1, 0),
        UDim2.new(0, 18, 0, 0),
        Config.Colors.Muted,
        Enum.Font.GothamMedium,
        12
    )

    ButtonText.TextXAlignment = Enum.TextXAlignment.Left
    ButtonText.ZIndex = 9

    --// PAGE
    local Page = New("ScrollingFrame", {
        Name = Name .. "Page",
        Parent = PageHolder,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 1, 0),
        BorderSizePixel = 0,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Config.Colors.Accent,
        ScrollBarImageTransparency = 0.25,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Visible = false,
        ZIndex = 7
    })

    local PagePadding = New("UIPadding", {
        Parent = Page,
        PaddingTop = UDim.new(0, 14),
        PaddingBottom = UDim.new(0, 14),
        PaddingLeft = UDim.new(0, 14),
        PaddingRight = UDim.new(0, 14)
    })

    local PageList = New("UIListLayout", {
        Parent = Page,
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 10)
    })

    Pages[Name] = Page
    PageButtons[Name] = {
        Button = Button,
        Text = ButtonText,
        Indicator = Indicator
    }

    --// PAGE SWITCH
    Button.MouseButton1Click:Connect(function()
        if Config.Runtime.Destroyed then
            return
        end

        if CurrentPage == Name then
            return
        end

        local PreviousPage = CurrentPage

        if PreviousPage and Pages[PreviousPage] then
            Pages[PreviousPage].Visible = false

            local PreviousButton = PageButtons[PreviousPage]

            if PreviousButton then
                Tween(
                    PreviousButton.Button,
                    {
                        BackgroundTransparency = 0.35
                    },
                    0.18
                )

                Tween(
                    PreviousButton.Text,
                    {
                        TextColor3 = Config.Colors.Muted
                    },
                    0.18
                )

                Tween(
                    PreviousButton.Indicator,
                    {
                        BackgroundTransparency = 1
                    },
                    0.18
                )
            end
        end

        CurrentPage = Name

        Page.Visible = true

        Tween(
            Button,
            {
                BackgroundTransparency = 0.05
            },
            0.18
        )

        Tween(
            ButtonText,
            {
                TextColor3 = Config.Colors.Text
            },
            0.18
        )

        Tween(
            Indicator,
            {
                BackgroundTransparency = 0
            },
            0.18
        )
    end)

    return Page
end

--========================================================--
-- CREATE ALL PAGES
--========================================================--

local CombatPage = CreatePage("Combat", 1)
local VisualsPage = CreatePage("Visuals", 2)
local MovementPage = CreatePage("Movement", 3)
local SettingsPage = CreatePage("Settings", 4)

--========================================================--
-- DEFAULT PAGE
--========================================================--

CurrentPage = "Combat"

CombatPage.Visible = true

do
    local ButtonData = PageButtons.Combat

    ButtonData.Button.BackgroundTransparency = 0.05
    ButtonData.Text.TextColor3 = Config.Colors.Text
    ButtonData.Indicator.BackgroundTransparency = 0
end

--========================================================--
-- PAGE TABLES
--========================================================--

local PageInfo = {
    Combat = {
        Title = "Combat",
        Description = "Aim and combat assistance"
    },

    Visuals = {
        Title = "Visuals",
        Description = "Player information and visual overlays"
    },

    Movement = {
        Title = "Movement",
        Description = "Movement and mobility controls"
    },

    Settings = {
        Title = "Settings",
        Description = "Interface and script settings"
    }
}

--========================================================--
-- END PART 1C/3
--========================================================--

--========================================================--
-- RIVALS HUB
-- PART 2A/3
-- UI COMPONENTS + COMBAT
--========================================================--

--========================================================--
-- PAGE HEADER
--========================================================--

local function CreatePageHeader(Page, Title, Description)
    local HolderFrame = New("Frame", {
        Name = "PageHeader",
        Parent = Page,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 54),
        ZIndex = 8
    })

    local TitleLabel = Label(
        HolderFrame,
        Title,
        UDim2.new(1, -10, 0, 26),
        UDim2.new(0, 2, 0, 0),
        Config.Colors.Text,
        Enum.Font.GothamBold,
        20
    )

    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.ZIndex = 9

    local DescriptionLabel = Label(
        HolderFrame,
        Description,
        UDim2.new(1, -10, 0, 20),
        UDim2.new(0, 2, 0, 29),
        Config.Colors.Muted,
        Enum.Font.Gotham,
        11
    )

    DescriptionLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescriptionLabel.ZIndex = 9

    return HolderFrame
end

--========================================================--
-- SECTION
--========================================================--

local function CreateSection(Page, Title, Description)
    local Section = New("Frame", {
        Name = "Section_" .. Title:gsub("%s+", ""),
        Parent = Page,
        BackgroundColor3 = Config.Colors.Panel2,
        BackgroundTransparency = 0.18,
        Size = UDim2.new(1, 0, 0, 54),
        AutomaticSize = Enum.AutomaticSize.Y,
        ZIndex = 8
    })

    AddCorner(Section, 11)
    AddStroke(Section, Config.Colors.Panel2, 1, 0.2)

    New("UIPadding", {
        Parent = Section,
        PaddingTop = UDim.new(0, 11),
        PaddingBottom = UDim.new(0, 11),
        PaddingLeft = UDim.new(0, 12),
        PaddingRight = UDim.new(0, 12)
    })

    New("UIListLayout", {
        Parent = Section,
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 7)
    })

    local Header = New("Frame", {
        Name = "Header",
        Parent = Section,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, Description and 43 or 25),
        LayoutOrder = 1,
        ZIndex = 9
    })

    local SectionTitle = Label(
        Header,
        Title,
        UDim2.new(1, 0, 0, 22),
        UDim2.new(0, 0, 0, 0),
        Config.Colors.Text,
        Enum.Font.GothamBold,
        13
    )

    SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    SectionTitle.ZIndex = 10

    if Description then
        local SectionDescription = Label(
            Header,
            Description,
            UDim2.new(1, 0, 0, 17),
            UDim2.new(0, 0, 0, 23),
            Config.Colors.Muted,
            Enum.Font.Gotham,
            10
        )

        SectionDescription.TextXAlignment = Enum.TextXAlignment.Left
        SectionDescription.ZIndex = 10
    end

    return Section
end

--========================================================--
-- TOGGLE
--========================================================--

local function CreateToggle(Page, Name, Description, Default, Callback)
    local Row = New("Frame", {
        Name = "Toggle_" .. Name:gsub("%s+", ""),
        Parent = Page,
        BackgroundColor3 = Config.Colors.Panel,
        BackgroundTransparency = 0.25,
        Size = UDim2.new(1, 0, 0, Description and 58 or 44),
        LayoutOrder = 10,
        ZIndex = 9
    })

    AddCorner(Row, 9)

    local TextHolder = New("Frame", {
        Name = "TextHolder",
        Parent = Row,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 7),
        Size = UDim2.new(1, -75, 1, -14),
        ZIndex = 10
    })

    local Title = Label(
        TextHolder,
        Name,
        UDim2.new(1, 0, 0, 20),
        UDim2.new(0, 0, 0, 0),
        Config.Colors.Text,
        Enum.Font.GothamMedium,
        12
    )

    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.ZIndex = 11

    if Description then
        local Desc = Label(
            TextHolder,
            Description,
            UDim2.new(1, 0, 0, 25),
            UDim2.new(0, 0, 0, 20),
            Config.Colors.Muted,
            Enum.Font.Gotham,
            9
        )

        Desc.TextXAlignment = Enum.TextXAlignment.Left
        Desc.TextWrapped = true
        Desc.ZIndex = 11
    end

    local ToggleButton = New("TextButton", {
        Name = "Button",
        Parent = Row,
        BackgroundColor3 = Config.Colors.Panel2,
        Position = UDim2.new(1, -52, 0.5, -11),
        Size = UDim2.fromOffset(40, 22),
        Text = "",
        AutoButtonColor = false,
        ZIndex = 11
    })

    AddCorner(ToggleButton, 11)

    local Knob = New("Frame", {
        Name = "Knob",
        Parent = ToggleButton,
        BackgroundColor3 = Config.Colors.Muted,
        Position = UDim2.new(0, 3, 0.5, -8),
        Size = UDim2.fromOffset(16, 16),
        ZIndex = 12
    })

    AddCorner(Knob, 8)

    local State = Default == true

    local function Update(Value, Instant)
        State = Value == true

        local TargetBackground
        local TargetKnob

        if State then
            TargetBackground = Config.Colors.Accent
            TargetKnob = UDim2.new(1, -19, 0.5, -8)
        else
            TargetBackground = Config.Colors.Panel2
            TargetKnob = UDim2.new(0, 3, 0.5, -8)
        end

        if Instant or not Config.UI.Animations then
            ToggleButton.BackgroundColor3 = TargetBackground
            Knob.Position = TargetKnob
        else
            Tween(
                ToggleButton,
                {
                    BackgroundColor3 = TargetBackground
                },
                0.18
            )

            Tween(
                Knob,
                {
                    Position = TargetKnob
                },
                0.18
            )
        end

        if Callback then
            Callback(State)
        end
    end

    ToggleButton.MouseButton1Click:Connect(function()
        Update(not State, false)
    end)

    Components[Name] = {
        Type = "Toggle",
        Object = Row,
        Button = ToggleButton,

        Get = function()
            return State
        end,

        Set = function(Value)
            Update(Value, false)
        end
    }

    Update(State, true)

    return Row
end

--========================================================--
-- SLIDER
--========================================================--

local function CreateSlider(
    Page,
    Name,
    Description,
    Minimum,
    Maximum,
    Default,
    Callback
)
    local Row = New("Frame", {
        Name = "Slider_" .. Name:gsub("%s+", ""),
        Parent = Page,
        BackgroundColor3 = Config.Colors.Panel,
        BackgroundTransparency = 0.25,
        Size = UDim2.new(1, 0, 0, Description and 76 or 62),
        LayoutOrder = 20,
        ZIndex = 9
    })

    AddCorner(Row, 9)

    local Title = Label(
        Row,
        Name,
        UDim2.new(1, -75, 0, 20),
        UDim2.new(0, 12, 0, 8),
        Config.Colors.Text,
        Enum.Font.GothamMedium,
        12
    )

    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.ZIndex = 10

    local ValueLabel = Label(
        Row,
        tostring(Default),
        UDim2.new(0, 55, 0, 20),
        UDim2.new(1, -67, 0, 8),
        Config.Colors.Accent,
        Enum.Font.GothamBold,
        11
    )

    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValueLabel.ZIndex = 10

    if Description then
        local Desc = Label(
            Row,
            Description,
            UDim2.new(1, -24, 0, 17),
            UDim2.new(0, 12, 0, 28),
            Config.Colors.Muted,
            Enum.Font.Gotham,
            9
        )

        Desc.TextXAlignment = Enum.TextXAlignment.Left
        Desc.ZIndex = 10
    end

    local SliderBack = New("Frame", {
        Name = "SliderBack",
        Parent = Row,
        BackgroundColor3 = Config.Colors.Panel2,
        Position = UDim2.new(0, 12, 1, -22),
        Size = UDim2.new(1, -24, 0, 6),
        ZIndex = 10
    })

    AddCorner(SliderBack, 4)

    local Fill = New("Frame", {
        Name = "Fill",
        Parent = SliderBack,
        BackgroundColor3 = Config.Colors.Accent,
        Size = UDim2.new(0, 0, 1, 0),
        ZIndex = 11
    })

    AddCorner(Fill, 4)

    local SliderButton = New("TextButton", {
        Name = "Input",
        Parent = Row,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 1, 0),
        Text = "",
        AutoButtonColor = false,
        ZIndex = 12
    })

    local Value = math.clamp(
        Default,
        Minimum,
        Maximum
    )

    local Dragging = false

    local function SetValue(NewValue, Fire)
        Value = math.clamp(
            math.floor(NewValue + 0.5),
            Minimum,
            Maximum
        )

        local Alpha = 0

        if Maximum ~= Minimum then
            Alpha =
                (Value - Minimum)
                / (Maximum - Minimum)
        end

        Fill.Size =
            UDim2.new(
                Alpha,
                0,
                1,
                0
            )

        ValueLabel.Text = tostring(Value)

        if Fire and Callback then
            Callback(Value)
        end
    end

    local function FromInput(Input)
        local X = Input.Position.X
        local StartX =
            SliderBack.AbsolutePosition.X

        local Width =
            SliderBack.AbsoluteSize.X

        if Width <= 0 then
            return
        end

        local Alpha =
            math.clamp(
                (X - StartX) / Width,
                0,
                1
            )

        SetValue(
            Minimum
            + ((Maximum - Minimum) * Alpha),
            true
        )
    end

    SliderButton.InputBegan:Connect(function(Input)
        if Input.UserInputType
            == Enum.UserInputType.MouseButton1
            or Input.UserInputType
            == Enum.UserInputType.Touch then

            Dragging = true
            FromInput(Input)
        end
    end)

    UserInputService.InputChanged:Connect(function(Input)
        if not Dragging then
            return
        end

        if Input.UserInputType
            == Enum.UserInputType.MouseMovement
            or Input.UserInputType
            == Enum.UserInputType.Touch then

            FromInput(Input)
        end
    end)

    UserInputService.InputEnded:Connect(function(Input)
        if Input.UserInputType
            == Enum.UserInputType.MouseButton1
            or Input.UserInputType
            == Enum.UserInputType.Touch then

            Dragging = false
        end
    end)

    Components[Name] = {
        Type = "Slider",
        Object = Row,

        Get = function()
            return Value
        end,

        Set = function(NewValue)
            SetValue(NewValue, true)
        end
    }

    SetValue(Value, false)

    return Row
end

--========================================================--
-- BUTTON
--========================================================--

local function CreateButton(Page, Name, Description, Callback)
    local Row = New("Frame", {
        Name = "Button_" .. Name:gsub("%s+", ""),
        Parent = Page,
        BackgroundColor3 = Config.Colors.Panel,
        BackgroundTransparency = 0.25,
        Size = UDim2.new(1, 0, 0, Description and 58 or 44),
        LayoutOrder = 30,
        ZIndex = 9
    })

    AddCorner(Row, 9)

    local TextHolder = New("Frame", {
        Parent = Row,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 6),
        Size = UDim2.new(1, -125, 1, -12),
        ZIndex = 10
    })

    local Title = Label(
        TextHolder,
        Name,
        UDim2.new(1, 0, 0, 20),
        UDim2.new(0, 0, 0, 0),
        Config.Colors.Text,
        Enum.Font.GothamMedium,
        12
    )

    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.ZIndex = 11

    if Description then
        local Desc = Label(
            TextHolder,
            Description,
            UDim2.new(1, 0, 0, 20),
            UDim2.new(0, 0, 0, 20),
            Config.Colors.Muted,
            Enum.Font.Gotham,
            9
        )

        Desc.TextXAlignment = Enum.TextXAlignment.Left
        Desc.ZIndex = 11
    end

    local Button = New("TextButton", {
        Name = "Action",
        Parent = Row,
        BackgroundColor3 = Config.Colors.Accent,
        BackgroundTransparency = 0.1,
        Position = UDim2.new(1, -105, 0.5, -14),
        Size = UDim2.fromOffset(93, 28),
        Text = "Execute",
        TextColor3 = Config.Colors.Text,
        TextSize = 10,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false,
        ZIndex = 11
    })

    AddCorner(Button, 8)

    Button.MouseButton1Click:Connect(function()
        if Callback then
            Callback()
        end
    end)

    Components[Name] = {
        Type = "Button",
        Object = Row,
        Button = Button
    }

    return Row
end

--========================================================--
-- INFO CARD
--========================================================--

local function CreateInfo(Page, Title, Description)
    local Card = New("Frame", {
        Name = "Info",
        Parent = Page,
        BackgroundColor3 = Config.Colors.Panel,
        BackgroundTransparency = 0.15,
        Size = UDim2.new(1, 0, 0, 64),
        LayoutOrder = 0,
        ZIndex = 9
    })

    AddCorner(Card, 9)
    AddStroke(
        Card,
        Config.Colors.Accent,
        1,
        0.75
    )

    local AccentBar = New("Frame", {
        Parent = Card,
        BackgroundColor3 = Config.Colors.Accent,
        Position = UDim2.new(0, 0, 0, 8),
        Size = UDim2.new(0, 3, 1, -16),
        ZIndex = 10
    })

    AddCorner(AccentBar, 2)

    local T = Label(
        Card,
        Title,
        UDim2.new(1, -28, 0, 20),
        UDim2.new(0, 14, 0, 9),
        Config.Colors.Text,
        Enum.Font.GothamBold,
        12
    )

    T.TextXAlignment = Enum.TextXAlignment.Left
    T.ZIndex = 11

    local D = Label(
        Card,
        Description,
        UDim2.new(1, -28, 0, 27),
        UDim2.new(0, 14, 0, 30),
        Config.Colors.Muted,
        Enum.Font.Gotham,
        9
    )

    D.TextXAlignment = Enum.TextXAlignment.Left
    D.TextWrapped = true
    D.ZIndex = 11

    return Card
end

--========================================================--
-- COMBAT PAGE
--========================================================--

CreatePageHeader(
    CombatPage,
    PageInfo.Combat.Title,
    PageInfo.Combat.Description
)

CreateInfo(
    CombatPage,
    "Combat Assistance",
    "Configure the optional local combat assistance features below."
)

CreateSection(
    CombatPage,
    "Aim Assist",
    "Smooth camera assistance for nearby targets."
)

CreateToggle(
    CombatPage,
    "Aim Assist",
    "Move the camera toward a valid target.",
    Config.Combat.AimAssist,
    function(Value)
        Config.Combat.AimAssist = Value
    end
)

CreateToggle(
    CombatPage,
    "Team Check",
    "Ignore players on the same team.",
    Config.Combat.TeamCheck,
    function(Value)
        Config.Combat.TeamCheck = Value
    end
)

CreateToggle(
    CombatPage,
    "Visible Only",
    "Only use targets visible from the camera.",
    Config.Combat.VisibleOnly,
    function(Value)
        Config.Combat.VisibleOnly = Value
    end
)

CreateSlider(
    CombatPage,
    "Aim FOV",
    "Maximum screen distance used for target selection.",
    25,
    500,
    Config.Combat.AimFOV,
    function(Value)
        Config.Combat.AimFOV = Value
    end
)

CreateSection(
    CombatPage,
    "Target",
    "Choose the target body part."
)

CreateButton(
    CombatPage,
    "Target Part",
    "Current target: " .. Config.Combat.TargetPart,
    function()
        if Config.Combat.TargetPart == "Head" then
            Config.Combat.TargetPart =
                "HumanoidRootPart"
        else
            Config.Combat.TargetPart = "Head"
        end

        local Component =
            Components["Target Part"]

        if Component and Component.Object then
            local TextHolder =
                Component.Object:FindFirstChild(
                    "TextHolder"
                )

            if TextHolder then
                local Text =
                    TextHolder:FindFirstChildOfClass(
                        "TextLabel"
                    )

                if Text then
                    Text.Text =
                        "Target Part: "
                        .. Config.Combat.TargetPart
                end
            end
        end
    end
)

--========================================================--
-- END PART 2A/3
--========================================================--

--========================================================--
-- RIVALS HUB
-- PART 2B/3
-- VISUALS + MOVEMENT + SETTINGS
--========================================================--

--========================================================--
-- VISUALS PAGE
--========================================================--

CreatePageHeader(
    VisualsPage,
    PageInfo.Visuals.Title,
    PageInfo.Visuals.Description
)

CreateInfo(
    VisualsPage,
    "Player Visuals",
    "Display useful information around other players."
)

CreateSection(
    VisualsPage,
    "ESP",
    "Configure player highlights and information."
)

CreateToggle(
    VisualsPage,
    "ESP",
    "Highlight valid players through the map.",
    Config.Visuals.ESP,
    function(Value)
        Config.Visuals.ESP = Value
    end
)

CreateToggle(
    VisualsPage,
    "ESP Names",
    "Display player names.",
    Config.Visuals.ESPNames,
    function(Value)
        Config.Visuals.ESPNames = Value
    end
)

CreateToggle(
    VisualsPage,
    "ESP Distance",
    "Display distance from your character.",
    Config.Visuals.ESPDistance,
    function(Value)
        Config.Visuals.ESPDistance = Value
    end
)

CreateToggle(
    VisualsPage,
    "ESP Health",
    "Display current player health.",
    Config.Visuals.ESPHealth,
    function(Value)
        Config.Visuals.ESPHealth = Value
    end
)

CreateToggle(
    VisualsPage,
    "Visual Team Check",
    "Ignore teammates in visual features.",
    Config.Visuals.VisualTeamCheck,
    function(Value)
        Config.Visuals.VisualTeamCheck = Value
    end
)

CreateSection(
    VisualsPage,
    "FOV Circle",
    "Show the current aim selection radius."
)

CreateToggle(
    VisualsPage,
    "FOV Circle",
    "Draw a circle around the center of the screen.",
    Config.Visuals.FOVCircle,
    function(Value)
        Config.Visuals.FOVCircle = Value
    end
)

CreateSlider(
    VisualsPage,
    "FOV Size",
    "Change the size of the FOV circle.",
    25,
    500,
    Config.Visuals.FOVSize,
    function(Value)
        Config.Visuals.FOVSize = Value
    end
)

CreateSlider(
    VisualsPage,
    "FOV Thickness",
    "Change the circle line thickness.",
    1,
    6,
    Config.Visuals.FOVThickness,
    function(Value)
        Config.Visuals.FOVThickness = Value
    end
)

--========================================================--
-- MOVEMENT PAGE
--========================================================--

CreatePageHeader(
    MovementPage,
    PageInfo.Movement.Title,
    PageInfo.Movement.Description
)

CreateInfo(
    MovementPage,
    "Movement Controls",
    "Local movement options and mobility settings."
)

CreateSection(
    MovementPage,
    "WalkSpeed",
    "Change your local character movement speed."
)

CreateToggle(
    MovementPage,
    "Speed",
    "Enable custom WalkSpeed.",
    Config.Movement.SpeedEnabled,
    function(Value)
        Config.Movement.SpeedEnabled = Value
    end
)

CreateSlider(
    MovementPage,
    "Speed Value",
    "Custom WalkSpeed value.",
    8,
    100,
    Config.Movement.Speed,
    function(Value)
        Config.Movement.Speed = Value
    end
)

CreateSection(
    MovementPage,
    "Jump",
    "Change your local jump height."
)

CreateToggle(
    MovementPage,
    "Jump",
    "Enable custom JumpPower.",
    Config.Movement.JumpEnabled,
    function(Value)
        Config.Movement.JumpEnabled = Value
    end
)

CreateSlider(
    MovementPage,
    "Jump Value",
    "Custom JumpPower value.",
    25,
    150,
    Config.Movement.Jump,
    function(Value)
        Config.Movement.Jump = Value
    end
)

CreateToggle(
    MovementPage,
    "Infinite Jump",
    "Allow jumping while airborne.",
    Config.Movement.InfiniteJump,
    function(Value)
        Config.Movement.InfiniteJump = Value
    end
)

CreateToggle(
    MovementPage,
    "Noclip",
    "Disable local character collisions.",
    Config.Movement.Noclip,
    function(Value)
        Config.Movement.Noclip = Value
    end
)

CreateToggle(
    MovementPage,
    "Auto Sprint",
    "Automatically sprint while moving.",
    Config.Movement.AutoSprint,
    function(Value)
        Config.Movement.AutoSprint = Value
    end
)

--========================================================--
-- SETTINGS PAGE
--========================================================--

CreatePageHeader(
    SettingsPage,
    PageInfo.Settings.Title,
    PageInfo.Settings.Description
)

CreateInfo(
    SettingsPage,
    "Interface Settings",
    "Customize the behavior of the Rivals Hub interface."
)

CreateSection(
    SettingsPage,
    "Animation",
    "Control interface animations."
)

CreateToggle(
    SettingsPage,
    "Animations",
    "Enable menu and control animations.",
    Config.UI.Animations,
    function(Value)
        Config.UI.Animations = Value
    end
)

CreateToggle(
    SettingsPage,
    "Background Effects",
    "Enable the animated purple background.",
    Config.UI.BackgroundEffects,
    function(Value)
        Config.UI.BackgroundEffects = Value
    end
)

CreateToggle(
    SettingsPage,
    "Status Display",
    "Show the ONLINE status in the top bar.",
    Config.UI.ShowStatus,
    function(Value)
        Config.UI.ShowStatus = Value

        StatusDot.Visible = Value
        StatusText.Visible = Value
    end
)

CreateSection(
    SettingsPage,
    "Interface Actions",
    "Quick controls for the menu."
)

CreateButton(
    SettingsPage,
    "Reset Position",
    "Move the menu back to the center of the screen.",
    function()
        Tween(
            Holder,
            {
                Position = UDim2.new(0.5, 0, 0.5, 0)
            },
            Config.UI.AnimationTime
        )
    end
)

--========================================================--
-- PAGE SCROLL UPDATE
--========================================================--

local function RefreshPageCanvas(Page)
    if not Page then
        return
    end

    task.defer(function()
        local Layout = Page:FindFirstChildOfClass(
            "UIListLayout"
        )

        if Layout then
            Page.CanvasSize = UDim2.new(
                0,
                0,
                0,
                Layout.AbsoluteContentSize.Y + 30
            )
        end
    end)
end

RefreshPageCanvas(CombatPage)
RefreshPageCanvas(VisualsPage)
RefreshPageCanvas(MovementPage)
RefreshPageCanvas(SettingsPage)

--========================================================--
-- END PART 2B/3
--========================================================--

--========================================================--
-- RIVALS HUB
-- PART 2C/3
-- AIM + ESP + MOVEMENT + DRAG + MINIMIZE + CLOSE
--========================================================--

--========================================================--
-- FOV CIRCLE
--========================================================--

local FOVCircle = New("Frame", {
    Name = "FOVCircle",
    Parent = ScreenGui,
    BackgroundTransparency = 1,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.fromOffset(
        Config.Visuals.FOVSize,
        Config.Visuals.FOVSize
    ),
    Visible = false,
    ZIndex = 999
})

AddCorner(FOVCircle, 999)

local FOVStroke = AddStroke(
    FOVCircle,
    Config.Colors.Accent,
    Config.Visuals.FOVThickness,
    0.15
)

--========================================================--
-- CHARACTER HELPERS
--========================================================--

local function GetCharacter(Player)
    if not Player then
        return nil
    end

    local Character = Player.Character

    if not Character then
        return nil
    end

    local Humanoid =
        Character:FindFirstChildOfClass("Humanoid")

    if not Humanoid or Humanoid.Health <= 0 then
        return nil
    end

    return Character, Humanoid
end

local function IsTeammate(Player)
    if not Player or Player == LocalPlayer then
        return false
    end

    if LocalPlayer.Team ~= nil
        and Player.Team ~= nil then

        return LocalPlayer.Team == Player.Team
    end

    return false
end

local function GetTargetPart(Character)
    if not Character then
        return nil
    end

    local Part =
        Character:FindFirstChild(
            Config.Combat.TargetPart
        )

    if Part then
        return Part
    end

    return Character:FindFirstChild("Head")
        or Character:FindFirstChild("HumanoidRootPart")
end

local function IsVisible(TargetPart)
    if not TargetPart then
        return false
    end

    local Camera = workspace.CurrentCamera

    if not Camera then
        return false
    end

    local Character = LocalPlayer.Character

    if not Character then
        return false
    end

    local Origin = Camera.CFrame.Position
    local Direction =
        TargetPart.Position - Origin

    local Params = RaycastParams.new()

    Params.FilterType =
        Enum.RaycastFilterType.Exclude

    Params.FilterDescendantsInstances = {
        Character
    }

    Params.IgnoreWater = true

    local Result =
        workspace:Raycast(
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

--========================================================--
-- TARGET FINDER
--========================================================--

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
    local BestDistance = Config.Combat.AimFOV

    for _, Player in ipairs(
        Players:GetPlayers()
    ) do

        if Player ~= LocalPlayer then
            local Character =
                GetCharacter(Player)

            if Character then
                local SameTeam =
                    IsTeammate(Player)

                if not (
                    Config.Combat.TeamCheck
                    and SameTeam
                ) then

                    local TargetPart =
                        GetTargetPart(Character)

                    if TargetPart then
                        local ValidVisibility = true

                        if Config.Combat.VisibleOnly then
                            ValidVisibility =
                                IsVisible(TargetPart)
                        end

                        if ValidVisibility then
                            local ScreenPosition,
                                OnScreen =
                                Camera:WorldToViewportPoint(
                                    TargetPart.Position
                                )

                            if OnScreen
                                and ScreenPosition.Z > 0 then

                                local Distance =
                                    (
                                        Vector2.new(
                                            ScreenPosition.X,
                                            ScreenPosition.Y
                                        ) - Center
                                    ).Magnitude

                                if Distance <
                                    BestDistance then

                                    BestDistance =
                                        Distance

                                    BestPlayer =
                                        Player
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    return BestPlayer
end

--========================================================--
-- AIM ASSIST
--========================================================--

RunService.RenderStepped:Connect(function()
    if Config.Runtime.Destroyed then
        return
    end

    local Camera =
        workspace.CurrentCamera

    if not Camera then
        return
    end

    FOVCircle.Visible =
        Config.Visuals.FOVCircle

    FOVCircle.Size =
        UDim2.fromOffset(
            Config.Visuals.FOVSize,
            Config.Visuals.FOVSize
        )

    FOVStroke.Thickness =
        Config.Visuals.FOVThickness

    if not Config.Combat.AimAssist then
        return
    end

    local Target =
        GetClosestTarget()

    if not Target then
        return
    end

    local Character =
        GetCharacter(Target)

    if not Character then
        return
    end

    local TargetPart =
        GetTargetPart(Character)

    if not TargetPart then
        return
    end

    local Desired =
        CFrame.new(
            Camera.CFrame.Position,
            TargetPart.Position
        )

    Camera.CFrame =
        Camera.CFrame:Lerp(
            Desired,
            0.12
        )
end)

--========================================================--
-- ESP SYSTEM
--========================================================--

local ESPObjects = {}

local function RemoveESP(Player)
    local Data =
        ESPObjects[Player]

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
    if Player == LocalPlayer then
        return
    end

    local Character =
        GetCharacter(Player)

    if not Character then
        return
    end

    RemoveESP(Player)

    local Highlight =
        Instance.new("Highlight")

    Highlight.Name =
        "RivalsHubESP"

    Highlight.Adornee =
        Character

    Highlight.DepthMode =
        Enum.HighlightDepthMode.AlwaysOnTop

    Highlight.FillTransparency = 0.78
    Highlight.OutlineTransparency = 0.1

    Highlight.FillColor =
        Config.Colors.Accent

    Highlight.OutlineColor =
        Config.Colors.Accent

    Highlight.Parent =
        Character

    local Billboard =
        Instance.new("BillboardGui")

    Billboard.Name =
        "RivalsHubInfo"

    Billboard.Adornee =
        Character:FindFirstChild("Head")
        or Character:FindFirstChild(
            "HumanoidRootPart"
        )

    Billboard.Size =
        UDim2.fromOffset(200, 45)

    Billboard.StudsOffset =
        Vector3.new(0, 2.8, 0)

    Billboard.AlwaysOnTop = true
    Billboard.MaxDistance = 2000
    Billboard.Parent = ScreenGui

    local Text =
        Instance.new("TextLabel")

    Text.Name = "Info"
    Text.BackgroundTransparency = 1
    Text.Size = UDim2.fromScale(1, 1)

    Text.TextColor3 =
        Config.Colors.Text

    Text.TextStrokeTransparency = 0.5
    Text.Font =
        Enum.Font.GothamBold

    Text.TextSize = 11
    Text.TextWrapped = true
    Text.Parent = Billboard

    ESPObjects[Player] = {
        Highlight = Highlight,
        Billboard = Billboard,
        Text = Text
    }
end

local function UpdateESP()
    for _, Player in ipairs(
        Players:GetPlayers()
    ) do

        if Player ~= LocalPlayer then
            local Character, Humanoid =
                GetCharacter(Player)

            local Data =
                ESPObjects[Player]

            local ShouldShow =
                Config.Visuals.ESP
                and Character ~= nil
                and Humanoid ~= nil

            if Config.Visuals.VisualTeamCheck
                and IsTeammate(Player) then

                ShouldShow = false
            end

            if ShouldShow then
                if not Data then
                    CreateESP(Player)
                    Data =
                        ESPObjects[Player]
                end

                if Data then
                    if Data.Highlight then
                        Data.Highlight.Enabled =
                            true

                        Data.Highlight.FillColor =
                            Config.Colors.Accent

                        Data.Highlight.OutlineColor =
                            Config.Colors.Accent
                    end

                    if Data.Text then
                        local Parts = {}

                        if Config.Visuals.ESPNames then
                            table.insert(
                                Parts,
                                Player.DisplayName
                            )
                        end

                        if Config.Visuals.ESPDistance then
                            local MyCharacter =
                                LocalPlayer.Character

                            local MyRoot =
                                MyCharacter
                                and MyCharacter:
                                    FindFirstChild(
                                        "HumanoidRootPart"
                                    )

                            local TheirRoot =
                                Character:
                                    FindFirstChild(
                                        "HumanoidRootPart"
                                    )

                            if MyRoot
                                and TheirRoot then

                                local Distance =
                                    (
                                        MyRoot.Position
                                        - TheirRoot.Position
                                    ).Magnitude

                                table.insert(
                                    Parts,
                                    math.floor(
                                        Distance
                                    ) .. " studs"
                                )
                            end
                        end

                        if Config.Visuals.ESPHealth then
                            table.insert(
                                Parts,
                                "HP: "
                                .. math.floor(
                                    Humanoid.Health
                                )
                            )
                        end

                        Data.Text.Text =
                            table.concat(
                                Parts,
                                "  •  "
                            )

                        Data.Text.Visible =
                            #Parts > 0
                    end
                end
            else
                if Data then
                    if Data.Highlight then
                        Data.Highlight.Enabled =
                            false
                    end

                    if Data.Text then
                        Data.Text.Visible =
                            false
                    end
                end
            end
        end
    end
end

task.spawn(function()
    while not Config.Runtime.Destroyed do
        UpdateESP()
        task.wait(0.15)
    end
end)

Players.PlayerRemoving:Connect(function(Player)
    RemoveESP(Player)
end)

Players.PlayerAdded:Connect(function(Player)
    Player.CharacterAdded:Connect(function()
        task.wait(0.5)

        if Config.Visuals.ESP then
            CreateESP(Player)
        end
    end)
end)

--========================================================--
-- MOVEMENT SYSTEM
--========================================================--

local OriginalWalkSpeed = 16
local OriginalJumpPower = 50

local function UpdateMovement()
    local Character =
        LocalPlayer.Character

    if not Character then
        return
    end

    local Humanoid =
        Character:FindFirstChildOfClass(
            "Humanoid"
        )

    if not Humanoid then
        return
    end

    if Config.Movement.SpeedEnabled then
        Humanoid.WalkSpeed =
            Config.Movement.Speed
    else
        Humanoid.WalkSpeed =
            OriginalWalkSpeed
    end

    if Config.Movement.JumpEnabled then
        Humanoid.UseJumpPower = true
        Humanoid.JumpPower =
            Config.Movement.Jump
    else
        Humanoid.UseJumpPower = true
        Humanoid.JumpPower =
            OriginalJumpPower
    end

    if Config.Movement.Noclip then
        for _, Object in ipairs(
            Character:GetDescendants()
        ) do

            if Object:IsA("BasePart") then
                Object.CanCollide = false
            end
        end
    else
        for _, Object in ipairs(
            Character:GetDescendants()
        ) do

            if Object:IsA("BasePart")
                and Object.Name ~= "HumanoidRootPart" then

                Object.CanCollide = true
            end
        end
    end
end

LocalPlayer.CharacterAdded:Connect(
    function(Character)
        task.wait(0.5)

        local Humanoid =
            Character:FindFirstChildOfClass(
                "Humanoid"
            )

        if Humanoid then
            OriginalWalkSpeed =
                Humanoid.WalkSpeed

            OriginalJumpPower =
                Humanoid.JumpPower
        end
    end
)

RunService.Heartbeat:Connect(function()
    if Config.Runtime.Destroyed then
        return
    end

    UpdateMovement()
end)

--========================================================--
-- INFINITE JUMP
--========================================================--

UserInputService.JumpRequest:Connect(
    function()
        if Config.Runtime.Destroyed then
            return
        end

        if not Config.Movement.InfiniteJump then
            return
        end

        local Character =
            LocalPlayer.Character

        if not Character then
            return
        end

        local Humanoid =
            Character:FindFirstChildOfClass(
                "Humanoid"
            )

        if Humanoid then
            Humanoid:ChangeState(
                Enum.HumanoidStateType.Jumping
            )
        end
    end
)

--========================================================--
-- AUTO SPRINT
--========================================================--

RunService.RenderStepped:Connect(function()
    if Config.Runtime.Destroyed then
        return
    end

    if not Config.Movement.AutoSprint then
        return
    end

    local Character =
        LocalPlayer.Character

    if not Character then
        return
    end

    local Humanoid =
        Character:FindFirstChildOfClass(
            "Humanoid"
        )

    if not Humanoid then
        return
    end

    if Humanoid.MoveDirection.Magnitude > 0 then
        if Config.Movement.SpeedEnabled then
            Humanoid.WalkSpeed =
                math.max(
                    Config.Movement.Speed,
                    18
                )
        else
            Humanoid.WalkSpeed = 18
        end
    end
end)

--========================================================--
-- MINI BUTTON
--========================================================--

local MiniButton = New("TextButton", {
    Name = "MiniButton",
    Parent = ScreenGui,
    BackgroundColor3 = Config.Colors.Panel,
    BackgroundTransparency = 0.04,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = Holder.Position,
    Size = UDim2.fromOffset(54, 54),
    Text = "R",
    TextColor3 = Config.Colors.Text,
    TextSize = 24,
    Font = Enum.Font.GothamBlack,
    AutoButtonColor = false,
    Visible = false,
    ZIndex = 1000
})

AddCorner(MiniButton, 16)

local MiniStroke =
    AddStroke(
        MiniButton,
        Config.Colors.Accent,
        1.5,
        0.15
    )

--========================================================--
-- DRAG SYSTEM
--========================================================--

local function MakeDraggable(Object, DragArea)
    local Dragging = false
    local DragStart
    local StartPosition

    DragArea.InputBegan:Connect(function(Input)
        if Input.UserInputType
            ~= Enum.UserInputType.MouseButton1
            and Input.UserInputType
            ~= Enum.UserInputType.Touch then
            return
        end

        Dragging = true
        DragStart = Input.Position
        StartPosition = Object.Position
    end)

    UserInputService.InputChanged:Connect(
        function(Input)
            if not Dragging then
                return
            end

            if Input.UserInputType
                ~= Enum.UserInputType.MouseMovement
                and Input.UserInputType
                ~= Enum.UserInputType.Touch then
                return
            end

            local Delta =
                Input.Position - DragStart

            Object.Position =
                UDim2.new(
                    StartPosition.X.Scale,
                    StartPosition.X.Offset
                        + Delta.X,
                    StartPosition.Y.Scale,
                    StartPosition.Y.Offset
                        + Delta.Y
                )
        end
    )

    UserInputService.InputEnded:Connect(
        function(Input)
            if Input.UserInputType
                == Enum.UserInputType.MouseButton1
                or Input.UserInputType
                == Enum.UserInputType.Touch then

                Dragging = false
            end
        end
    )
end

-- Top bar controls movement of the full menu.
MakeDraggable(Holder, TopBar)

-- Mini R can be moved independently.
MakeDraggable(MiniButton, MiniButton)

--========================================================--
-- MINIMIZE / RESTORE
--========================================================--

local IsMinimized = false
local IsClosing = false
local KeyDebounce = false

local function MinimizeMenu()
    if IsClosing or IsMinimized then
        return
    end

    IsMinimized = true

    -- Put the mini R exactly where the menu currently is.
    MiniButton.Position = Holder.Position
    MiniButton.Visible = true

    if Config.UI.Animations then
        Tween(
            Holder,
            {
                Size = UDim2.fromOffset(54, 54),
                BackgroundTransparency = 1
            },
            0.28
        )

        task.delay(0.25, function()
            if IsMinimized and not IsClosing then
                Main.Visible = false
                Holder.Visible = false
            end
        end)
    else
        Main.Visible = false
        Holder.Visible = false
    end
end

local function RestoreMenu()
    if IsClosing or not IsMinimized then
        return
    end

    IsMinimized = false

    -- Restore from the current position of the mini R.
    Holder.Position = MiniButton.Position

    Holder.Size = UDim2.fromOffset(54, 54)
    Holder.BackgroundTransparency = 1

    Holder.Visible = true
    Main.Visible = true

    if Config.UI.Animations then
        Tween(
            Holder,
            {
                Size = UDim2.fromOffset(650, 455),
                BackgroundTransparency = 0
            },
            0.32
        )
    else
        Holder.Size = UDim2.fromOffset(650, 455)
        Holder.BackgroundTransparency = 0
    end

    MiniButton.Visible = false
end

--========================================================--
-- MINI R BUTTON
--========================================================--

MiniButton.MouseButton1Click:Connect(function()
    if IsClosing then
        return
    end

    RestoreMenu()
end)

--========================================================--
-- MINIMIZE BUTTON
--========================================================--

MinimizeButton.MouseButton1Click:Connect(function()
    if IsClosing then
        return
    end

    MinimizeMenu()
end)

--========================================================--
-- CLOSE
--========================================================--

local function CloseMenu()
    if IsClosing then
        return
    end

    IsClosing = true
    Config.Runtime.Destroyed = true

    -- Remove ESP objects.
    for Player in pairs(ESPObjects) do
        RemoveESP(Player)
    end

    if Config.UI.Animations and Holder.Visible then
        Tween(
            Holder,
            {
                Size = UDim2.fromOffset(0, 0),
                BackgroundTransparency = 1
            },
            0.25
        )

        task.wait(0.27)
    end

    if ScreenGui and ScreenGui.Parent then
        ScreenGui:Destroy()
    end
end

CloseButton.MouseButton1Click:Connect(function()
    CloseMenu()
end)

--========================================================--
-- RIGHT SHIFT
--========================================================--

UserInputService.InputBegan:Connect(function(Input, GameProcessed)
    if GameProcessed then
        return
    end

    if Input.KeyCode ~= Enum.KeyCode.RightShift then
        return
    end

    if KeyDebounce or IsClosing then
        return
    end

    KeyDebounce = true

    if IsMinimized then
        RestoreMenu()
    else
        MinimizeMenu()
    end

    task.delay(0.25, function()
        KeyDebounce = false
    end)
end)

--========================================================--
-- BACKGROUND EFFECT CONTROL
--========================================================--

task.spawn(function()
    while not Config.Runtime.Destroyed do
        local Enabled =
            Config.UI.BackgroundEffects

        for Index, Line in ipairs(BackgroundLines) do
            if Line and Line.Parent then
                Line.Visible = Enabled

                if Enabled then
                    local Time = os.clock()

                    local Offset =
                        math.sin(
                            Time * 0.7 + Index * 0.55
                        ) * 12

                    Line.Position =
                        UDim2.new(
                            Line.Position.X.Scale,
                            Line.Position.X.Offset,
                            0,
                            -70 + Offset
                        )
                end
            end
        end

        for Index, Glow in ipairs(BackgroundGlows) do
            if Glow and Glow.Parent then
                Glow.Visible = Enabled

                if Enabled then
                    local Time = os.clock()

                    local Alpha =
                        0.65 +
                        math.sin(
                            Time * 0.8 + Index
                        ) * 0.15

                    Glow.BackgroundTransparency =
                        math.clamp(
                            Alpha,
                            0.35,
                            0.85
                        )
                end
            end
        end

        task.wait(0.03)
    end
end)

--========================================================--
-- ACCENT REFRESH
--========================================================--

local function RefreshAccent()
    if not ScreenGui
        or not ScreenGui.Parent then
        return
    end

    local Accent =
        Config.Colors.Accent

    local HolderStroke =
        Holder:FindFirstChildOfClass("UIStroke")

    if HolderStroke then
        HolderStroke.Color = Accent
    end

    local TopStroke =
        TopBar:FindFirstChildOfClass("UIStroke")

    if TopStroke then
        TopStroke.Color = Accent
    end

    if MiniStroke then
        MiniStroke.Color = Accent
    end

    if FOVStroke then
        FOVStroke.Color = Accent
    end
end

RefreshAccent()

--========================================================--
-- OPEN ANIMATION
--========================================================--

Holder.Visible = true
Main.Visible = true

if Config.UI.Animations then
    local FinalSize =
        UDim2.fromOffset(650, 455)

    Holder.Size =
        UDim2.fromOffset(40, 40)

    Tween(
        Holder,
        {
            Size = FinalSize
        },
        0.4
    )
end

--========================================================--
-- INITIAL CHARACTER DATA
--========================================================--

task.defer(function()
    local Character =
        LocalPlayer.Character

    if not Character then
        return
    end

    local Humanoid =
        Character:FindFirstChildOfClass("Humanoid")

    if Humanoid then
        OriginalWalkSpeed =
            Humanoid.WalkSpeed

        OriginalJumpPower =
            Humanoid.JumpPower
    end
end)

--========================================================--
-- FINAL CLEANUP
--========================================================--

ScreenGui.AncestryChanged:Connect(function(_, Parent)
    if Parent == nil then
        Config.Runtime.Destroyed = true

        for Player in pairs(ESPObjects) do
            RemoveESP(Player)
        end
    end
end)

--========================================================--
-- END OF RIVALS HUB
--========================================================--

--========================================================--
-- EMERGENCY MENU CONTROLS
--========================================================--

task.defer(function()
    if not ScreenGui or not ScreenGui.Parent then
        return
    end

    local Menu = ScreenGui:FindFirstChild("Holder")

    if not Menu then
        return
    end

    local Top = Menu:FindFirstChild("TopBar")

    if not Top then
        return
    end

    local MainFrame = Menu:FindFirstChild("Main")

    -- MINIMIZE
    local MinButton =
        Top:FindFirstChild("MinimizeButton")

    if MinButton and MinButton:IsA("TextButton") then
        MinButton.MouseButton1Click:Connect(function()
            if MainFrame then
                MainFrame.Visible = false
            end

            Top.Visible = false

            Menu.Visible = false

            local Mini = ScreenGui:FindFirstChild("EmergencyR")

            if not Mini then
                Mini = Instance.new("TextButton")
                Mini.Name = "EmergencyR"
                Mini.Size = UDim2.fromOffset(54, 54)
                Mini.Position = Menu.Position
                Mini.AnchorPoint = Vector2.new(0.5, 0.5)
                Mini.Text = "R"
                Mini.TextSize = 24
                Mini.Font = Enum.Font.GothamBlack
                Mini.TextColor3 = Color3.fromRGB(245,245,250)
                Mini.BackgroundColor3 = Color3.fromRGB(18,18,28)
                Mini.Parent = ScreenGui

                local Corner = Instance.new("UICorner")
                Corner.CornerRadius = UDim.new(0,16)
                Corner.Parent = Mini

                local Stroke = Instance.new("UIStroke")
                Stroke.Color = Color3.fromRGB(150,85,255)
                Stroke.Thickness = 1.5
                Stroke.Parent = Mini
            end

            Mini.Visible = true

            Mini.MouseButton1Click:Connect(function()
                Mini.Visible = false
                Menu.Visible = true

                if MainFrame then
                    MainFrame.Visible = true
                end

                Top.Visible = true
            end)
        end)
    end

    -- CLOSE
    local CloseButton =
        Top:FindFirstChild("CloseButton")

    if CloseButton and CloseButton:IsA("TextButton") then
        CloseButton.MouseButton1Click:Connect(function()
            ScreenGui:Destroy()
        end)
    end
end)

--========================================================--
-- END EMERGENCY CONTROLS
--========================================================--
