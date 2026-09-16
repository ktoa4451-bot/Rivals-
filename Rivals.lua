--========================================================
-- RIVALS HUB 3.0
-- PART 1/4
-- UI CORE / WINDOW / PAGES / ANIMATIONS
--========================================================

--========================================================
-- SERVICES
--========================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

--========================================================
-- CONFIG
--========================================================

local Config = {
    MenuOpen = true,

    SmoothAnimations = true,
    AnimationSpeed = 0.22,

    MenuWidth = 620,
    MenuHeight = 430,

    Accent = Color3.fromRGB(125, 75, 255),
    AccentDark = Color3.fromRGB(78, 45, 170),

    Background = Color3.fromRGB(10, 10, 18),
    Panel = Color3.fromRGB(15, 15, 27),
    PanelLight = Color3.fromRGB(20, 20, 35),

    Text = Color3.fromRGB(235, 235, 245),
    TextDark = Color3.fromRGB(145, 145, 165),

    Border = Color3.fromRGB(55, 40, 105),
}

--========================================================
-- HELPERS
--========================================================

local function Tween(Object, Time, Properties, Style, Direction)
    if not Object then
        return
    end

    if not Config.SmoothAnimations then
        for Property, Value in pairs(Properties) do
            Object[Property] = Value
        end

        return
    end

    local Info = TweenInfo.new(
        Time or Config.AnimationSpeed,
        Style or Enum.EasingStyle.Quint,
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

local function Corner(Object, Radius)
    local UI = Instance.new("UICorner")

    UI.CornerRadius = UDim.new(
        0,
        Radius or 10
    )

    UI.Parent = Object

    return UI
end

local function Stroke(Object, Color, Thickness, Transparency)
    local UI = Instance.new("UIStroke")

    UI.Color = Color or Config.Border
    UI.Thickness = Thickness or 1
    UI.Transparency = Transparency or 0

    UI.Parent = Object

    return UI
end

local function Padding(Object, Left, Right, Top, Bottom)
    local UI = Instance.new("UIPadding")

    UI.PaddingLeft = UDim.new(0, Left or 0)
    UI.PaddingRight = UDim.new(0, Right or 0)
    UI.PaddingTop = UDim.new(0, Top or 0)
    UI.PaddingBottom = UDim.new(0, Bottom or 0)

    UI.Parent = Object

    return UI
end

local function New(ClassName, Properties, Parent)
    local Object = Instance.new(ClassName)

    for Property, Value in pairs(Properties or {}) do
        Object[Property] = Value
    end

    Object.Parent = Parent

    return Object
end

--========================================================
-- GUI
--========================================================

local Gui = New(
    "ScreenGui",
    {
        Name = "RivalsHub3",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    },
    LocalPlayer:WaitForChild("PlayerGui")
)

--========================================================
-- MAIN HOLDER
--========================================================

local Holder = New(
    "Frame",
    {
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

        Active = true,
    },
    Gui
)

Corner(Holder, 18)

local MainStroke = Stroke(
    Holder,
    Config.Border,
    1.2,
    0.05
)

--========================================================
-- SUBTLE BACKGROUND
--========================================================

local BackgroundGlow = New(
    "Frame",
    {
        Name = "BackgroundGlow",

        Size = UDim2.fromOffset(
            260,
            260
        ),

        Position = UDim2.new(
            1,
            -150,
            0,
            -100
        ),

        BackgroundColor3 =
            Config.AccentDark,

        BackgroundTransparency = 0.88,

        BorderSizePixel = 0,

        ZIndex = 0,
    },
    Holder
)

Corner(BackgroundGlow, 130)

local BackgroundGlow2 = New(
    "Frame",
    {
        Name = "BackgroundGlow2",

        Size = UDim2.fromOffset(
            220,
            220
        ),

        Position = UDim2.new(
            0,
            -100,
            1,
            -100
        ),

        BackgroundColor3 =
            Config.Accent,

        BackgroundTransparency = 0.94,

        BorderSizePixel = 0,

        ZIndex = 0,
    },
    Holder
)

Corner(BackgroundGlow2, 110)

--========================================================
-- TOP BAR
--========================================================

local TopBar = New(
    "Frame",
    {
        Name = "TopBar",

        Size = UDim2.new(
            1,
            0,
            0,
            72
        ),

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        Active = true,

        ZIndex = 10,
    },
    Holder
)

--========================================================
-- LOGO
--========================================================

local LogoButton = New(
    "TextButton",
    {
        Name = "Logo",

        Size = UDim2.fromOffset(
            44,
            44
        ),

        Position = UDim2.fromOffset(
            16,
            14
        ),

        BackgroundColor3 =
            Color3.fromRGB(16, 14, 28),

        Text = "R",

        TextColor3 =
            Config.Accent,

        TextSize = 21,

        Font = Enum.Font.GothamBold,

        AutoButtonColor = false,

        BorderSizePixel = 0,

        ZIndex = 11,
    },
    TopBar
)

Corner(LogoButton, 22)

Stroke(
    LogoButton,
    Config.AccentDark,
    1,
    0.2
)

--========================================================
-- TITLE
--========================================================

local Title = New(
    "TextLabel",
    {
        Name = "Title",

        Size = UDim2.fromOffset(
            250,
            24
        ),

        Position = UDim2.fromOffset(
            72,
            15
        ),

        BackgroundTransparency = 1,

        Text = "RIVALS HUB",

        TextColor3 =
            Config.Text,

        TextSize = 15,

        Font = Enum.Font.GothamBold,

        TextXAlignment =
            Enum.TextXAlignment.Left,

        ZIndex = 11,
    },
    TopBar
)

local Version = New(
    "TextLabel",
    {
        Name = "Version",

        Size = UDim2.fromOffset(
            150,
            18
        ),

        Position = UDim2.fromOffset(
            72,
            37
        ),

        BackgroundTransparency = 1,

        Text = "v3.0",

        TextColor3 =
            Config.TextDark,

        TextSize = 11,

        Font = Enum.Font.GothamMedium,

        TextXAlignment =
            Enum.TextXAlignment.Left,

        ZIndex = 11,
    },
    TopBar
)

--========================================================
-- CLOSE BUTTON
--========================================================

local CloseButton = New(
    "TextButton",
    {
        Name = "Close",

        Size = UDim2.fromOffset(
            38,
            38
        ),

        Position = UDim2.new(
            1,
            -52,
            0,
            17
        ),

        BackgroundColor3 =
            Color3.fromRGB(17, 17, 29),

        Text = "×",

        TextColor3 =
            Color3.fromRGB(190, 190, 205),

        TextSize = 19,

        Font = Enum.Font.GothamMedium,

        AutoButtonColor = false,

        BorderSizePixel = 0,

        ZIndex = 11,
    },
    TopBar
)

Corner(CloseButton, 12)

--========================================================
-- MINIMIZE BUTTON
--========================================================

local MinimizeButton = New(
    "TextButton",
    {
        Name = "Minimize",

        Size = UDim2.fromOffset(
            38,
            38
        ),

        Position = UDim2.new(
            1,
            -96,
            0,
            17
        ),

        BackgroundColor3 =
            Color3.fromRGB(17, 17, 29),

        Text = "—",

        TextColor3 =
            Color3.fromRGB(190, 190, 205),

        TextSize = 18,

        Font = Enum.Font.GothamMedium,

        AutoButtonColor = false,

        BorderSizePixel = 0,

        ZIndex = 11,
    },
    TopBar
)

Corner(MinimizeButton, 12)

--========================================================
-- CONTENT HOLDER
--========================================================

local Content = New(
    "Frame",
    {
        Name = "Content",

        Size = UDim2.new(
            1,
            -24,
            1,
            -84
        ),

        Position = UDim2.fromOffset(
            12,
            76
        ),

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        ZIndex = 5,
    },
    Holder
)

--========================================================
-- SIDEBAR
--========================================================

local Sidebar = New(
    "Frame",
    {
        Name = "Sidebar",

        Size = UDim2.new(
            0,
            145,
            1,
            0
        ),

        BackgroundColor3 =
            Color3.fromRGB(13, 13, 23),

        BorderSizePixel = 0,

        ZIndex = 6,
    },
    Content
)

Corner(Sidebar, 14)

Stroke(
    Sidebar,
    Color3.fromRGB(30, 25, 52),
    1,
    0.35
)

Padding(
    Sidebar,
    8,
    8,
    10,
    10
)

--========================================================
-- PAGE CONTAINER
--========================================================

local PageContainer = New(
    "Frame",
    {
        Name = "PageContainer",

        Size = UDim2.new(
            1,
            -157,
            1,
            0
        ),

        Position = UDim2.fromOffset(
            157,
            0
        ),

        BackgroundColor3 =
            Color3.fromRGB(11, 11, 19),

        BorderSizePixel = 0,

        ClipsDescendants = true,

        ZIndex = 6,
    },
    Content
)

Corner(PageContainer, 14)

Stroke(
    PageContainer,
    Color3.fromRGB(30, 25, 52),
    1,
    0.35
)

--========================================================
-- SIDEBAR TITLE
--========================================================

local SidebarTitle = New(
    "TextLabel",
    {
        Name = "SidebarTitle",

        Size = UDim2.new(
            1,
            0,
            0,
            28
        ),

        BackgroundTransparency = 1,

        Text = "PAGES",

        TextColor3 =
            Config.TextDark,

        TextSize = 10,

        Font = Enum.Font.GothamBold,

        TextXAlignment =
            Enum.TextXAlignment.Left,

        ZIndex = 7,
    },
    Sidebar
)

--========================================================
-- NAVIGATION
--========================================================

local Navigation = New(
    "Frame",
    {
        Name = "Navigation",

        Size = UDim2.new(
            1,
            0,
            1,
            -32
        ),

        Position = UDim2.fromOffset(
            0,
            32
        ),

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        ZIndex = 7,
    },
    Sidebar
)

local NavigationLayout = New(
    "UIListLayout",
    {
        Padding = UDim.new(
            0,
            6
        ),

        SortOrder =
            Enum.SortOrder.LayoutOrder,
    },
    Navigation
)

--========================================================
-- PAGE DATA
--========================================================

local Pages = {}
local PageButtons = {}

local CurrentPage = nil

--========================================================
-- PAGE CREATOR
--========================================================

local function CreatePage(Name, Description, Order)

    local Page = New(
        "ScrollingFrame",
        {
            Name = Name .. "Page",

            Size = UDim2.new(
                1,
                0,
                1,
                0
            ),

            BackgroundTransparency = 1,

            BorderSizePixel = 0,

            ScrollBarThickness = 3,

            ScrollBarImageColor3 =
                Config.Accent,

            ScrollBarImageTransparency =
                0.25,

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

            ZIndex = 7,
        },
        PageContainer
    )

    Padding(
        Page,
        18,
        18,
        18,
        18
    )

    local Layout = New(
        "UIListLayout",
        {
            Padding = UDim.new(
                0,
                10
            ),

            SortOrder =
                Enum.SortOrder.LayoutOrder,
        },
        Page
    )

    local PageHeader = New(
        "Frame",
        {
            Name = "Header",

            Size = UDim2.new(
                1,
                0,
                0,
                52
            ),

            BackgroundTransparency = 1,

            BorderSizePixel = 0,

            LayoutOrder = 1,

            ZIndex = 8,
        },
        Page
    )

    local PageTitle = New(
        "TextLabel",
        {
            Name = "Title",

            Size = UDim2.new(
                1,
                0,
                0,
                25
            ),

            BackgroundTransparency = 1,

            Text = Name,

            TextColor3 =
                Config.Text,

            TextSize = 20,

            Font = Enum.Font.GothamBold,

            TextXAlignment =
                Enum.TextXAlignment.Left,

            ZIndex = 8,
        },
        PageHeader
    )

    local PageDescription = New(
        "TextLabel",
        {
            Name = "Description",

            Size = UDim2.new(
                1,
                0,
                0,
                20
            ),

            Position = UDim2.fromOffset(
                0,
                27
            ),

            BackgroundTransparency = 1,

            Text = Description or "",

            TextColor3 =
                Config.TextDark,

            TextSize = 11,

            Font = Enum.Font.GothamMedium,

            TextXAlignment =
                Enum.TextXAlignment.Left,

            ZIndex = 8,
        },
        PageHeader
    )

    Pages[Name] = {
        Frame = Page,
        Title = PageTitle,
        Description = PageDescription,
        Layout = Layout,
    }

    --====================================================
    -- PAGE BUTTON
    --====================================================

    local Button = New(
        "TextButton",
        {
            Name = Name .. "Button",

            Size = UDim2.new(
                1,
                0,
                0,
                38
            ),

            BackgroundColor3 =
                Color3.fromRGB(
                    17,
                    17,
                    29
                ),

            BackgroundTransparency = 1,

            Text = "",

            AutoButtonColor = false,

            BorderSizePixel = 0,

            LayoutOrder =
                Order or 1,

            ZIndex = 8,
        },
        Navigation
    )

    Corner(
        Button,
        10
    )

    local Indicator = New(
        "Frame",
        {
            Name = "Indicator",

            Size = UDim2.fromOffset(
                3,
                20
            ),

            Position = UDim2.new(
                0,
                0,
                0.5,
                -10
            ),

            BackgroundColor3 =
                Config.Accent,

            BackgroundTransparency = 1,

            BorderSizePixel = 0,

            ZIndex = 9,
        },
        Button
    )

    Corner(
        Indicator,
        3
    )

    local ButtonText = New(
        "TextLabel",
        {
            Name = "Text",

            Size = UDim2.new(
                1,
                -14,
                1,
                0
            ),

            Position = UDim2.fromOffset(
                12,
                0
            ),

            BackgroundTransparency = 1,

            Text = Name,

            TextColor3 =
                Config.TextDark,

            TextSize = 12,

            Font = Enum.Font.GothamMedium,

            TextXAlignment =
                Enum.TextXAlignment.Left,

            ZIndex = 9,
        },
        Button
    )

    PageButtons[Name] = {
        Button = Button,
        Text = ButtonText,
        Indicator = Indicator,
    }

    --====================================================
    -- PAGE BUTTON HOVER
    --====================================================

    Button.MouseEnter:Connect(function()

        if CurrentPage ~= Name then

            Tween(
                Button,
                0.15,
                {
                    BackgroundTransparency = 0.75
                }
            )

            Tween(
                ButtonText,
                0.15,
                {
                    TextColor3 =
                        Config.Text
                }
            )

        end

    end)

    Button.MouseLeave:Connect(function()

        if CurrentPage ~= Name then

            Tween(
                Button,
                0.15,
                {
                    BackgroundTransparency = 1
                }
            )

            Tween(
                ButtonText,
                0.15,
                {
                    TextColor3 =
                        Config.TextDark
                }
            )

        end

    end)

    --====================================================
    -- PAGE SWITCH
    --====================================================

    Button.MouseButton1Click:Connect(function()

        if CurrentPage == Name then
            return
        end

        --================================================
        -- HIDE OLD PAGE
        --================================================

        if CurrentPage then

            local OldPage =
                Pages[CurrentPage]

            if OldPage then

                Tween(
                    OldPage.Frame,
                    0.16,
                    {
                        Position =
                            UDim2.new(
                                -0.08,
                                0,
                                0,
                                0
                            )
                    }
                )

                task.delay(
                    0.16,
                    function()

                        OldPage.Frame.Visible =
                            false

                        OldPage.Frame.Position =
                            UDim2.new(
                                0,
                                0,
                                0,
                                0
                            )

                    end
                )

            end

            --============================================
            -- RESET OLD BUTTON
            --============================================

            local OldButton =
                PageButtons[CurrentPage]

            if OldButton then

                Tween(
                    OldButton.Button,
                    0.15,
                    {
                        BackgroundTransparency = 1
                    }
                )

                Tween(
                    OldButton.Text,
                    0.15,
                    {
                        TextColor3 =
                            Config.TextDark
                    }
                )

                Tween(
                    OldButton.Indicator,
                    0.15,
                    {
                        BackgroundTransparency = 1
                    }
                )

            end

        end

        --================================================
        -- SET CURRENT PAGE
        --================================================

        CurrentPage = Name

        local NewPage =
            Pages[Name]

        if NewPage then

            NewPage.Frame.Position =
                UDim2.new(
                    0.08,
                    0,
                    0,
                    0
                )

            NewPage.Frame.Visible =
                true

            Tween(
                NewPage.Frame,
                0.2,
                {
                    Position =
                        UDim2.new(
                            0,
                            0,
                            0,
                            0
                        )
                }
            )

        end

        --================================================
        -- ACTIVATE NEW BUTTON
        --================================================

        local NewButton =
            PageButtons[Name]

        if NewButton then

            Tween(
                NewButton.Button,
                0.15,
                {
                    BackgroundTransparency =
                        0.55
                }
            )

            Tween(
                NewButton.Text,
                0.15,
                {
                    TextColor3 =
                        Config.Text
                }
            )

            Tween(
                NewButton.Indicator,
                0.15,
                {
                    BackgroundTransparency = 0
                }
            )

        end

    end)

    return Page
end

--========================================================
-- CREATE PAGES
--========================================================

local CombatPage = CreatePage(
    "Combat",
    "Combat related controls",
    1
)

local VisualsPage = CreatePage(
    "Visuals",
    "Visual customization",
    2
)

local MovementPage = CreatePage(
    "Movement",
    "Movement related controls",
    3
)

local SettingsPage = CreatePage(
    "Settings",
    "Interface and menu settings",
    4
)

--========================================================
-- DEFAULT PAGE
--========================================================

CurrentPage =
    "Combat"

Pages.Combat.Frame.Visible =
    true

PageButtons.Combat.Button.BackgroundTransparency =
    0.55

PageButtons.Combat.Text.TextColor3 =
    Config.Text

PageButtons.Combat.Indicator.BackgroundTransparency =
    0

--========================================================
-- DRAG SYSTEM
--========================================================

local Dragging = false
local DragStart = nil
local StartPosition = nil

TopBar.InputBegan:Connect(function(Input)

    if Input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or
        Input.UserInputType ==
        Enum.UserInputType.Touch then

        Dragging = true

        DragStart =
            Input.Position

        StartPosition =
            Holder.Position

    end

end)

TopBar.InputEnded:Connect(function(Input)

    if Input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or
        Input.UserInputType ==
        Enum.UserInputType.Touch then

        Dragging = false

    end

end)

UserInputService.InputChanged:Connect(function(Input)

    if not Dragging then
        return
    end

    if Input.UserInputType ~=
        Enum.UserInputType.MouseMovement
        and
        Input.UserInputType ~=
        Enum.UserInputType.Touch then

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

end)

--========================================================
-- MINIMIZED BUTTON
--========================================================

local MiniButton = New(
    "TextButton",
    {
        Name = "MiniButton",

        Size = UDim2.fromOffset(
            54,
            54
        ),

        Position = UDim2.new(
            0.5,
            -27,
            0.5,
            -27
        ),

        BackgroundColor3 =
            Config.Background,

        Text = "R",

        TextColor3 =
            Config.Accent,

        TextSize = 22,

        Font = Enum.Font.GothamBold,

        AutoButtonColor = false,

        BorderSizePixel = 0,

        Visible = false,

        ZIndex = 50,
    },
    Gui
)

Corner(
    MiniButton,
    27
)

Stroke(
    MiniButton,
    Config.AccentDark,
    1.2,
    0.05
)

--========================================================
-- OPEN MENU
--========================================================

local function OpenMenu()

    Config.MenuOpen = true

    Holder.Visible = true

    Holder.Size =
        UDim2.fromOffset(
            Config.MenuWidth - 35,
            Config.MenuHeight - 25
        )

    Holder.BackgroundTransparency =
        1

    Tween(
        Holder,
        0.24,
        {
            Size =
                UDim2.fromOffset(
                    Config.MenuWidth,
                    Config.MenuHeight
                ),

            BackgroundTransparency =
                0
        }
    )

    Tween(
        MiniButton,
        0.16,
        {
            BackgroundTransparency =
                1
        }
    )

    task.delay(
        0.17,
        function()

            MiniButton.Visible =
                false

        end
    )

end

--========================================================
-- CLOSE MENU
--========================================================

local function CloseMenu()

    Config.MenuOpen = false

    Tween(
        Holder,
        0.2,
        {
            Size =
                UDim2.fromOffset(
                    Config.MenuWidth - 35,
                    Config.MenuHeight - 25
                ),

            BackgroundTransparency =
                1
        }
    )

    task.delay(
        0.2,
        function()

            Holder.Visible =
                false

            MiniButton.Visible =
                true

            MiniButton.BackgroundTransparency =
                1

            Tween(
                MiniButton,
                0.18,
                {
                    BackgroundTransparency =
                        0
                }
            )

        end
    )

end

--========================================================
-- MINIMIZE
--========================================================

local function MinimizeMenu()

    Config.MenuOpen = false

    Tween(
        Holder,
        0.2,
        {
            Size =
                UDim2.fromOffset(
                    Config.MenuWidth - 45,
                    Config.MenuHeight - 35
                ),

            BackgroundTransparency =
                1
        }
    )

    task.delay(
        0.2,
        function()

            Holder.Visible =
                false

            MiniButton.Visible =
                true

            MiniButton.BackgroundTransparency =
                1

            Tween(
                MiniButton,
                0.2,
                {
                    BackgroundTransparency =
                        0
                }
            )

        end
    )

end

--========================================================
-- CLOSE BUTTON HOVER
--========================================================

CloseButton.MouseEnter:Connect(function()

    Tween(
        CloseButton,
        0.12,
        {
            BackgroundColor3 =
                Color3.fromRGB(
                    90,
                    35,
                    45
                ),

            TextColor3 =
                Color3.fromRGB(
                    255,
                    190,
                    200
                )
        }
    )

end)

CloseButton.MouseLeave:Connect(function()

    Tween(
        CloseButton,
        0.12,
        {
            BackgroundColor3 =
                Color3.fromRGB(
                    17,
                    17,
                    29
                ),

            TextColor3 =
                Color3.fromRGB(
                    190,
                    190,
                    205
                )
        }
    )

end)

CloseButton.MouseButton1Click:Connect(function()

    CloseMenu()

end)

--========================================================
-- MINIMIZE BUTTON HOVER
--========================================================

MinimizeButton.MouseEnter:Connect(function()

    Tween(
        MinimizeButton,
        0.12,
        {
            BackgroundColor3 =
                Color3.fromRGB(
                    27,
                    24,
                    45
                ),

            TextColor3 =
                Config.Text
        }
    )

end)

MinimizeButton.MouseLeave:Connect(function()

    Tween(
        MinimizeButton,
        0.12,
        {
            BackgroundColor3 =
                Color3.fromRGB(
                    17,
                    17,
                    29
                ),

            TextColor3 =
                Color3.fromRGB(
                    190,
                    190,
                    205
                )
        }
    )

end)

MinimizeButton.MouseButton1Click:Connect(function()

    MinimizeMenu()

end)

--========================================================
-- MINI BUTTON HOVER
--========================================================

MiniButton.MouseEnter:Connect(function()

    Tween(
        MiniButton,
        0.15,
        {
            Size =
                UDim2.fromOffset(
                    58,
                    58
                )
        }
    )

end)

MiniButton.MouseLeave:Connect(function()

    Tween(
        MiniButton,
        0.15,
        {
            Size =
                UDim2.fromOffset(
                    54,
                    54
                )
        }
    )

end)

MiniButton.MouseButton1Click:Connect(function()

    OpenMenu()

end)

--========================================================
-- LOGO ANIMATION
--========================================================

LogoButton.MouseEnter:Connect(function()

    Tween(
        LogoButton,
        0.15,
        {
            BackgroundColor3 =
                Color3.fromRGB(
                    23,
                    19,
                    42
                )
        }
    )

    Tween(
        LogoButton,
        0.2,
        {
            Rotation = 8
        }
    )

end)

LogoButton.MouseLeave:Connect(function()

    Tween(
        LogoButton,
        0.15,
        {
            BackgroundColor3 =
                Color3.fromRGB(
                    16,
                    14,
                    28
                )
        }
    )

    Tween(
        LogoButton,
        0.2,
        {
            Rotation = 0
        }
    )

end)

--========================================================
-- STARTUP ANIMATION
--========================================================

Holder.Size =
    UDim2.fromOffset(
        Config.MenuWidth - 35,
        Config.MenuHeight - 25
    )

Holder.BackgroundTransparency =
    1

task.defer(function()

    task.wait(0.05)

    Tween(
        Holder,
        0.28,
        {
            Size =
                UDim2.fromOffset(
                    Config.MenuWidth,
                    Config.MenuHeight
                ),

            BackgroundTransparency =
                0
        }
    )

end)

--========================================================
-- PART 1/4 END
--========================================================

--========================================================
-- RIVALS HUB 3.0
-- PART 2/4
-- UI COMPONENTS / SEARCH / COMBAT / VISUALS
--========================================================


--========================================================
-- COMPONENT HELPERS
--========================================================

local Components = {}

local function RegisterComponent(Object, Data)
    if not Object then
        return
    end

    Data = Data or {}
    Data.Object = Object

    table.insert(Components, Data)

    return Object
end


--========================================================
-- SECTION
--========================================================

local function CreateSection(Page, Text, Order)

    local Section = New(
        "TextLabel",
        {
            Name = "Section",

            Size = UDim2.new(
                1,
                0,
                0,
                24
            ),

            BackgroundTransparency = 1,

            Text = Text,

            TextColor3 =
                Config.Accent,

            TextSize = 11,

            Font =
                Enum.Font.GothamBold,

            TextXAlignment =
                Enum.TextXAlignment.Left,

            LayoutOrder =
                Order or 2,

            ZIndex = 9,
        },
        Page
    )

    return Section
end


--========================================================
-- INFO CARD
--========================================================

local function CreateInfoCard(
    Page,
    TitleText,
    Description,
    Order
)

    local Card = New(
        "Frame",
        {
            Name = "InfoCard",

            Size = UDim2.new(
                1,
                0,
                0,
                58
            ),

            BackgroundColor3 =
                Config.Panel,

            BorderSizePixel = 0,

            LayoutOrder =
                Order or 2,

            ZIndex = 8,
        },
        Page
    )

    Corner(Card, 11)

    Stroke(
        Card,
        Color3.fromRGB(
            35,
            30,
            58
        ),
        1,
        0.25
    )

    local Title = New(
        "TextLabel",
        {
            Name = "Title",

            Size = UDim2.new(
                1,
                -24,
                0,
                20
            ),

            Position = UDim2.fromOffset(
                12,
                8
            ),

            BackgroundTransparency = 1,

            Text = TitleText,

            TextColor3 =
                Config.Text,

            TextSize = 12,

            Font =
                Enum.Font.GothamBold,

            TextXAlignment =
                Enum.TextXAlignment.Left,

            ZIndex = 9,
        },
        Card
    )

    local Desc = New(
        "TextLabel",
        {
            Name = "Description",

            Size = UDim2.new(
                1,
                -24,
                0,
                22
            ),

            Position = UDim2.fromOffset(
                12,
                29
            ),

            BackgroundTransparency = 1,

            Text = Description or "",

            TextColor3 =
                Config.TextDark,

            TextSize = 10,

            Font =
                Enum.Font.GothamMedium,

            TextWrapped = true,

            TextXAlignment =
                Enum.TextXAlignment.Left,

            ZIndex = 9,
        },
        Card
    )

    return Card
end


--========================================================
-- TOGGLE
--========================================================

local function CreateToggle(
    Page,
    TitleText,
    Description,
    Key,
    Order,
    Callback
)

    local Card = New(
        "Frame",
        {
            Name = TitleText .. "Toggle",

            Size = UDim2.new(
                1,
                0,
                0,
                64
            ),

            BackgroundColor3 =
                Config.Panel,

            BorderSizePixel = 0,

            LayoutOrder =
                Order or 2,

            ZIndex = 8,
        },
        Page
    )

    Corner(Card, 11)

    Stroke(
        Card,
        Color3.fromRGB(
            35,
            30,
            58
        ),
        1,
        0.3
    )

    local Title = New(
        "TextLabel",
        {
            Name = "Title",

            Size = UDim2.new(
                1,
                -78,
                0,
                21
            ),

            Position = UDim2.fromOffset(
                13,
                9
            ),

            BackgroundTransparency = 1,

            Text = TitleText,

            TextColor3 =
                Config.Text,

            TextSize = 12,

            Font =
                Enum.Font.GothamBold,

            TextXAlignment =
                Enum.TextXAlignment.Left,

            ZIndex = 9,
        },
        Card
    )

    local Desc = New(
        "TextLabel",
        {
            Name = "Description",

            Size = UDim2.new(
                1,
                -78,
                0,
                23
            ),

            Position = UDim2.fromOffset(
                13,
                30
            ),

            BackgroundTransparency = 1,

            Text = Description or "",

            TextColor3 =
                Config.TextDark,

            TextSize = 9,

            Font =
                Enum.Font.GothamMedium,

            TextWrapped = true,

            TextXAlignment =
                Enum.TextXAlignment.Left,

            ZIndex = 9,
        },
        Card
    )

    --====================================================
    -- SWITCH
    --====================================================

    local Switch = New(
        "TextButton",
        {
            Name = "Switch",

            Size = UDim2.fromOffset(
                42,
                22
            ),

            Position = UDim2.new(
                1,
                -56,
                0.5,
                -11
            ),

            BackgroundColor3 =
                Color3.fromRGB(
                    35,
                    35,
                    50
                ),

            Text = "",

            AutoButtonColor = false,

            BorderSizePixel = 0,

            ZIndex = 10,
        },
        Card
    )

    Corner(Switch, 11)

    local Knob = New(
        "Frame",
        {
            Name = "Knob",

            Size = UDim2.fromOffset(
                16,
                16
            ),

            Position = UDim2.fromOffset(
                3,
                3
            ),

            BackgroundColor3 =
                Color3.fromRGB(
                    155,
                    155,
                    170
                ),

            BorderSizePixel = 0,

            ZIndex = 11,
        },
        Switch
    )

    Corner(Knob, 8)

    local State = false

    if Config[Key] ~= nil then
        State = Config[Key]
    else
        Config[Key] = false
    end

    local function SetState(Value, Instant)

        State = Value
        Config[Key] = Value

        if Value then

            if Instant then

                Switch.BackgroundColor3 =
                    Config.Accent

                Knob.Position =
                    UDim2.new(
                        1,
                        -19,
                        0,
                        3
                    )

                Knob.BackgroundColor3 =
                    Color3.fromRGB(
                        255,
                        255,
                        255
                    )

            else

                Tween(
                    Switch,
                    0.16,
                    {
                        BackgroundColor3 =
                            Config.Accent
                    }
                )

                Tween(
                    Knob,
                    0.16,
                    {
                        Position =
                            UDim2.new(
                                1,
                                -19,
                                0,
                                3
                            ),

                        BackgroundColor3 =
                            Color3.fromRGB(
                                255,
                                255,
                                255
                            )
                    }
                )

            end

        else

            if Instant then

                Switch.BackgroundColor3 =
                    Color3.fromRGB(
                        35,
                        35,
                        50
                    )

                Knob.Position =
                    UDim2.fromOffset(
                        3,
                        3
                    )

                Knob.BackgroundColor3 =
                    Color3.fromRGB(
                        155,
                        155,
                        170
                    )

            else

                Tween(
                    Switch,
                    0.16,
                    {
                        BackgroundColor3 =
                            Color3.fromRGB(
                                35,
                                35,
                                50
                            )
                    }
                )

                Tween(
                    Knob,
                    0.16,
                    {
                        Position =
                            UDim2.fromOffset(
                                3,
                                3
                            ),

                        BackgroundColor3 =
                            Color3.fromRGB(
                                155,
                                155,
                                170
                            )
                    }
                )

            end
        end

        if Callback then
            task.spawn(
                Callback,
                Value
            )
        end
    end

    Switch.MouseButton1Click:Connect(function()
        SetState(
            not State,
            false
        )
    end)

    Switch.MouseEnter:Connect(function()

        Tween(
            Switch,
            0.12,
            {
                Size =
                    UDim2.fromOffset(
                        44,
                        23
                    )
            }
        )

    end)

    Switch.MouseLeave:Connect(function()

        Tween(
            Switch,
            0.12,
            {
                Size =
                    UDim2.fromOffset(
                        42,
                        22
                    )
            }
        )

    end)

    SetState(
        State,
        true
    )

    RegisterComponent(
        Card,
        {
            Type = "Toggle",
            Key = Key,
            Set = SetState,
            Get = function()
                return State
            end,
        }
    )

    return Card
end


--========================================================
-- SLIDER
--========================================================

local function CreateSlider(
    Page,
    TitleText,
    Description,
    Key,
    Order,
    Minimum,
    Maximum,
    Default,
    Callback
)

    Minimum =
        tonumber(Minimum) or 0

    Maximum =
        tonumber(Maximum) or 100

    Default =
        tonumber(Default) or Minimum

    Default =
        math.clamp(
            Default,
            Minimum,
            Maximum
        )

    if Config[Key] == nil then
        Config[Key] = Default
    end

    local Card = New(
        "Frame",
        {
            Name = TitleText .. "Slider",

            Size = UDim2.new(
                1,
                0,
                0,
                76
            ),

            BackgroundColor3 =
                Config.Panel,

            BorderSizePixel = 0,

            LayoutOrder =
                Order or 2,

            ZIndex = 8,
        },
        Page
    )

    Corner(Card, 11)

    Stroke(
        Card,
        Color3.fromRGB(
            35,
            30,
            58
        ),
        1,
        0.3
    )

    local Title = New(
        "TextLabel",
        {
            Name = "Title",

            Size = UDim2.new(
                1,
                -75,
                0,
                20
            ),

            Position = UDim2.fromOffset(
                13,
                8
            ),

            BackgroundTransparency = 1,

            Text = TitleText,

            TextColor3 =
                Config.Text,

            TextSize = 12,

            Font =
                Enum.Font.GothamBold,

            TextXAlignment =
                Enum.TextXAlignment.Left,

            ZIndex = 9,
        },
        Card
    )

    local ValueLabel = New(
        "TextLabel",
        {
            Name = "Value",

            Size = UDim2.fromOffset(
                55,
                20
            ),

            Position = UDim2.new(
                1,
                -68,
                0,
                8
            ),

            BackgroundTransparency = 1,

            Text = tostring(
                Config[Key]
            ),

            TextColor3 =
                Config.Accent,

            TextSize = 11,

            Font =
                Enum.Font.GothamBold,

            TextXAlignment =
                Enum.TextXAlignment.Right,

            ZIndex = 9,
        },
        Card
    )

    local Desc = New(
        "TextLabel",
        {
            Name = "Description",

            Size = UDim2.new(
                1,
                -26,
                0,
                18
            ),

            Position = UDim2.fromOffset(
                13,
                29
            ),

            BackgroundTransparency = 1,

            Text = Description or "",

            TextColor3 =
                Config.TextDark,

            TextSize = 9,

            Font =
                Enum.Font.GothamMedium,

            TextXAlignment =
                Enum.TextXAlignment.Left,

            ZIndex = 9,
        },
        Card
    )

    --====================================================
    -- SLIDER BACKGROUND
    --====================================================

    local SliderBack = New(
        "Frame",
        {
            Name = "Slider",

            Size = UDim2.new(
                1,
                -26,
                0,
                5
            ),

            Position = UDim2.new(
                0,
                13,
                1,
                -14
            ),

            BackgroundColor3 =
                Color3.fromRGB(
                    37,
                    37,
                    52
                ),

            BorderSizePixel = 0,

            ZIndex = 9,
        },
        Card
    )

    Corner(
        SliderBack,
        3
    )

    local Fill = New(
        "Frame",
        {
            Name = "Fill",

            Size = UDim2.new(
                0,
                0,
                1,
                0
            ),

            BackgroundColor3 =
                Config.Accent,

            BorderSizePixel = 0,

            ZIndex = 10,
        },
        SliderBack
    )

    Corner(
        Fill,
        3
    )

    local Knob = New(
        "Frame",
        {
            Name = "Knob",

            Size = UDim2.fromOffset(
                13,
                13
            ),

            AnchorPoint =
                Vector2.new(
                    0.5,
                    0.5
                ),

            Position = UDim2.new(
                0,
                0,
                0.5,
                0
            ),

            BackgroundColor3 =
                Color3.fromRGB(
                    245,
                    245,
                    255
                ),

            BorderSizePixel = 0,

            ZIndex = 11,
        },
        SliderBack
    )

    Corner(
        Knob,
        7
    )

    local DraggingSlider = false

    local function SetValue(
        Value,
        Instant,
        FireCallback
    )

        Value =
            math.clamp(
                tonumber(Value) or Minimum,
                Minimum,
                Maximum
            )

        Value =
            math.floor(
                Value + 0.5
            )

        Config[Key] =
            Value

        local Alpha = 0

        if Maximum ~= Minimum then

            Alpha =
                (Value - Minimum)
                / (Maximum - Minimum)

        end

        ValueLabel.Text =
            tostring(Value)

        local FillSize =
            UDim2.new(
                Alpha,
                0,
                1,
                0
            )

        local KnobPosition =
            UDim2.new(
                Alpha,
                0,
                0.5,
                0
            )

        if Instant then

            Fill.Size =
                FillSize

            Knob.Position =
                KnobPosition

        else

            Tween(
                Fill,
                0.1,
                {
                    Size = FillSize
                }
            )

            Tween(
                Knob,
                0.1,
                {
                    Position =
                        KnobPosition
                }
            )

        end

        if FireCallback
        and Callback then

            task.spawn(
                Callback,
                Value
            )

        end
    end

    local function UpdateFromInput(Input)

        local X =
            Input.Position.X

        local Start =
            SliderBack.AbsolutePosition.X

        local Width =
            SliderBack.AbsoluteSize.X

        local Alpha =
            math.clamp(
                (X - Start) / Width,
                0,
                1
            )

        local Value =
            Minimum
            + (
                Maximum - Minimum
            ) * Alpha

        SetValue(
            Value,
            false,
            true
        )
    end

    SliderBack.InputBegan:Connect(function(Input)

        if Input.UserInputType ==
            Enum.UserInputType.MouseButton1
            or
            Input.UserInputType ==
            Enum.UserInputType.Touch then

            DraggingSlider = true

            UpdateFromInput(Input)

        end

    end)

    SliderBack.InputEnded:Connect(function(Input)

        if Input.UserInputType ==
            Enum.UserInputType.MouseButton1
            or
            Input.UserInputType ==
            Enum.UserInputType.Touch then

            DraggingSlider = false

        end

    end)

    UserInputService.InputChanged:Connect(function(Input)

        if not DraggingSlider then
            return
        end

        if Input.UserInputType ==
            Enum.UserInputType.MouseMovement
            or
            Input.UserInputType ==
            Enum.UserInputType.Touch then

            UpdateFromInput(Input)

        end

    end)

    SetValue(
        Config[Key],
        true,
        false
    )

    RegisterComponent(
        Card,
        {
            Type = "Slider",
            Key = Key,
            Set = SetValue,
            Get = function()
                return Config[Key]
            end,
        }
    )

    return Card
end


--========================================================
-- DROPDOWN
--========================================================

local function CreateDropdown(
    Page,
    TitleText,
    Description,
    Key,
    Options,
    Order,
    Callback
)

    local Card =
        New(
            "Frame",
            {
                Parent = Page,
                Size = UDim2.new(1, -8, 0, 72),
                BackgroundColor3 = Config.Panel,
                BorderSizePixel = 0,
                LayoutOrder = Order,
                ClipsDescendants = true,
            }
        )

    Corner(Card, 10)
    Stroke(Card, Config.Border, 1)

    local Title =
        New(
            "TextLabel",
            {
                Parent = Card,
                Position = UDim2.fromOffset(14, 9),
                Size = UDim2.new(1, -190, 0, 22),
                BackgroundTransparency = 1,
                Text = TitleText,
                TextColor3 = Config.Text,
                Font = Enum.Font.GothamSemibold,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
            }
        )

    local Desc =
        New(
            "TextLabel",
            {
                Parent = Card,
                Position = UDim2.fromOffset(14, 32),
                Size = UDim2.new(1, -190, 0, 25),
                BackgroundTransparency = 1,
                Text = Description,
                TextColor3 = Config.TextDark,
                Font = Enum.Font.Gotham,
                TextSize = 11,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
            }
        )

    local DropButton =
        New(
            "TextButton",
            {
                Parent = Card,
                Position = UDim2.new(1, -170, 0, 18),
                Size = UDim2.fromOffset(150, 36),
                BackgroundColor3 = Config.PanelLight,
                BorderSizePixel = 0,
                Text = "",
                AutoButtonColor = false,
            }
        )

    Corner(DropButton, 8)
    Stroke(DropButton, Config.Border, 1)

    local ValueLabel =
        New(
            "TextLabel",
            {
                Parent = DropButton,
                Position = UDim2.fromOffset(10, 0),
                Size = UDim2.new(1, -35, 1, 0),
                BackgroundTransparency = 1,
                Text = tostring(Options[1] or "None"),
                TextColor3 = Config.Text,
                Font = Enum.Font.GothamSemibold,
                TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Left,
            }
        )

    local Arrow =
        New(
            "TextLabel",
            {
                Parent = DropButton,
                Position = UDim2.new(1, -28, 0, 0),
                Size = UDim2.fromOffset(24, 36),
                BackgroundTransparency = 1,
                Text = "⌄",
                TextColor3 = Config.TextDark,
                Font = Enum.Font.GothamBold,
                TextSize = 16,
            }
        )

    local List =
        New(
            "Frame",
            {
                Parent = Card,
                Position = UDim2.fromOffset(14, 78),
                Size = UDim2.new(1, -28, 0, 0),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Visible = false,
            }
        )

    local ListLayout =
        New(
            "UIListLayout",
            {
                Parent = List,
                Padding = UDim.new(0, 5),
                SortOrder = Enum.SortOrder.LayoutOrder,
            }
        )

    local Opened = false

    local function CloseDropdown()

        if not Opened then
            return
        end

        Opened = false

        Arrow.Text = "⌄"
        List.Visible = false

        Tween(
            Card,
            0.18,
            {
                Size = UDim2.new(1, -8, 0, 72)
            }
        )

    end

    local function OpenDropdown()

        if Opened then
            CloseDropdown()
            return
        end

        Opened = true

        List.Visible = true
        Arrow.Text = "⌃"

        local ListHeight =
            (#Options * 33) +
            math.max(0, (#Options - 1) * 5)

        Tween(
            Card,
            0.22,
            {
                Size =
                    UDim2.new(
                        1,
                        -8,
                        0,
                        88 + ListHeight
                    )
            }
        )

    end

    for Index, Option in ipairs(Options) do

        local OptionButton =
            New(
                "TextButton",
                {
                    Parent = List,
                    Size = UDim2.new(1, 0, 0, 33),
                    BackgroundColor3 = Config.PanelLight,
                    BorderSizePixel = 0,
                    Text = tostring(Option),
                    TextColor3 = Config.TextDark,
                    Font = Enum.Font.Gotham,
                    TextSize = 11,
                    AutoButtonColor = false,
                    LayoutOrder = Index,
                }
            )

        Corner(OptionButton, 7)
        Stroke(OptionButton, Config.Border, 1)

        OptionButton.MouseEnter:Connect(function()

            Tween(
                OptionButton,
                0.12,
                {
                    BackgroundColor3 = Config.AccentDark,
                    TextColor3 = Config.Text
                }
            )

        end)

        OptionButton.MouseLeave:Connect(function()

            Tween(
                OptionButton,
                0.12,
                {
                    BackgroundColor3 = Config.PanelLight,
                    TextColor3 = Config.TextDark
                }
            )

        end)

        OptionButton.MouseButton1Click:Connect(function()

            Config[Key] = Option
            ValueLabel.Text = tostring(Option)

            if Callback then
                Callback(Option)
            end

            CloseDropdown()

        end)

    end

    DropButton.MouseEnter:Connect(function()

        Tween(
            DropButton,
            0.12,
            {
                BackgroundColor3 = Config.AccentDark
            }
        )

    end)

    DropButton.MouseLeave:Connect(function()

        Tween(
            DropButton,
            0.12,
            {
                BackgroundColor3 = Config.PanelLight
            }
        )

    end)

    DropButton.MouseButton1Click:Connect(OpenDropdown)

    RegisterComponent(
        Card,
        TitleText
    )

    return Card

end


--========================================================
-- SEARCH BOX
--========================================================

local SearchFrame =
    New(
        "Frame",
        {
            Parent = Holder,
            Position = UDim2.new(0, 170, 0, 76),
            Size = UDim2.new(1, -182, 0, 38),
            BackgroundColor3 = Config.Panel,
            BorderSizePixel = 0,
        }
    )

Corner(SearchFrame, 9)
Stroke(SearchFrame, Config.Border, 1)

local SearchIcon =
    New(
        "TextLabel",
        {
            Parent = SearchFrame,
            Position = UDim2.fromOffset(12, 0),
            Size = UDim2.fromOffset(25, 38),
            BackgroundTransparency = 1,
            Text = "⌕",
            TextColor3 = Config.Accent,
            Font = Enum.Font.GothamBold,
            TextSize = 19,
        }
    )

local SearchBox =
    New(
        "TextBox",
        {
            Parent = SearchFrame,
            Position = UDim2.fromOffset(40, 0),
            Size = UDim2.new(1, -50, 1, 0),
            BackgroundTransparency = 1,
            PlaceholderText = "Search...",
            PlaceholderColor3 = Config.TextDark,
            Text = "",
            TextColor3 = Config.Text,
            Font = Enum.Font.Gotham,
            TextSize = 12,
            ClearTextOnFocus = false,
            TextXAlignment = Enum.TextXAlignment.Left,
        }
    )

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()

    local Query =
        string.lower(
            SearchBox.Text
        )

    for _, Component in ipairs(Components) do

        if Component.Object then

            local Name =
                string.lower(
                    Component.Name or ""
                )

            local Match =
                Query == "" or
                string.find(
                    Name,
                    Query,
                    1,
                    true
                )

            Component.Object.Visible = Match

        end

    end

end)


--========================================================
-- CONTENT POSITION
--========================================================

Content.Position =
    UDim2.fromOffset(
        12,
        120
    )

Content.Size =
    UDim2.new(
        1,
        -24,
        1,
        -132
    )


--========================================================
-- COMBAT PAGE
--========================================================

CreateToggle(
    Pages.Combat,
    "Aim Assist",
    "Automatically follows the selected target.",
    "AimAssist",
    1
)

CreateToggle(
    Pages.Combat,
    "Silent Aim",
    "Redirects shots toward the selected target.",
    "SilentAim",
    2
)

CreateDropdown(
    Pages.Combat,
    "Target Part",
    "Select the body part used for targeting.",
    "TargetPart",
    {
        "Head",
        "HumanoidRootPart",
        "UpperTorso",
        "LowerTorso"
    },
    3
)

CreateToggle(
    Pages.Combat,
    "Visible Only",
    "Only target players that are visible.",
    "VisibleOnly",
    4
)

CreateToggle(
    Pages.Combat,
    "Team Check",
    "Ignore players on your team.",
    "TeamCheck",
    5
)

CreateSlider(
    Pages.Combat,
    "Aim FOV",
    "Maximum targeting field of view.",
    "AimFOV",
    6,
    25,
    1000,
    250
)

CreateToggle(
    Pages.Combat,
    "FOV Circle",
    "Display the current aiming field of view.",
    "FOVCircle",
    7
)

CreateInfoCard(
    Pages.Combat,
    "Target System",
    "Combat targeting controls are configured here."
)


--========================================================
-- VISUALS PAGE
--========================================================

CreateToggle(
    Pages.Visuals,
    "ESP",
    "Display information about other players.",
    "ESP",
    1
)

CreateToggle(
    Pages.Visuals,
    "Box ESP",
    "Draw boxes around visible players.",
    "BoxESP",
    2
)

CreateToggle(
    Pages.Visuals,
    "Name ESP",
    "Display player names.",
    "NameESP",
    3
)

CreateToggle(
    Pages.Visuals,
    "Health ESP",
    "Display player health.",
    "HealthESP",
    4
)

CreateToggle(
    Pages.Visuals,
    "Distance ESP",
    "Display distance to players.",
    "DistanceESP",
    5
)--========================================================
-- PART 3/4
-- MOVEMENT PAGE
--========================================================

CreateToggle(
    Pages.Movement,
    "Speed",
    "Change the local player's movement speed.",
    "Speed",
    1
)

CreateSlider(
    Pages.Movement,
    "WalkSpeed",
    "Set the desired movement speed.",
    "WalkSpeed",
    2,
    16,
    150,
    16
)

CreateToggle(
    Pages.Movement,
    "Jump Power",
    "Change the local player's jump power.",
    "JumpPowerEnabled",
    3
)

CreateSlider(
    Pages.Movement,
    "JumpPower",
    "Set the desired jump power.",
    "JumpPower",
    4,
    25,
    150,
    50
)

CreateToggle(
    Pages.Movement,
    "Infinite Jump",
    "Allows jumping while airborne.",
    "InfiniteJump",
    5
)

CreateToggle(
    Pages.Movement,
    "Noclip",
    "Disable character collisions.",
    "Noclip",
    6
)

CreateToggle(
    Pages.Movement,
    "Fly",
    "Enable basic character flight.",
    "Fly",
    7
)

CreateSlider(
    Pages.Movement,
    "Fly Speed",
    "Control the speed while flying.",
    "FlySpeed",
    8,
    10,
    150,
    50
)

CreateInfoCard(
    Pages.Movement,
    "Movement System",
    "Movement options will be handled by the movement controller."
)


--========================================================
-- SETTINGS PAGE
--========================================================

CreateSection(
    Pages.Settings,
    "GENERAL",
    1
)

CreateToggle(
    Pages.Settings,
    "Smooth Animations",
    "Enable smooth interface animations.",
    "SmoothAnimations",
    2
)

CreateSlider(
    Pages.Settings,
    "Animation Speed",
    "Control the interface animation speed.",
    "AnimationSpeed",
    3,
    5,
    100,
    22
)

CreateSection(
    Pages.Settings,
    "INTERFACE",
    4
)

CreateToggle(
    Pages.Settings,
    "Menu Blur",
    "Enable the background visual effect.",
    "MenuBlur",
    5
)

CreateToggle(
    Pages.Settings,
    "Notifications",
    "Show notifications when features change.",
    "Notifications",
    6
)

CreateToggle(
    Pages.Settings,
    "Compact Mode",
    "Use a smaller interface layout.",
    "CompactMode",
    7
)

CreateSection(
    Pages.Settings,
    "CONFIG",
    8
)

CreateInfoCard(
    Pages.Settings,
    "Configuration",
    "All interface and feature settings are stored in the Config table."
)

local ResetCard =
    New(
        "Frame",
        {
            Parent = Pages.Settings,
            Size = UDim2.new(1, -8, 0, 72),
            BackgroundColor3 = Config.Panel,
            BorderSizePixel = 0,
            LayoutOrder = 9,
        }
    )

Corner(ResetCard, 10)
Stroke(ResetCard, Config.Border, 1)

local ResetTitle =
    New(
        "TextLabel",
        {
            Parent = ResetCard,
            Position = UDim2.fromOffset(14, 10),
            Size = UDim2.new(1, -180, 0, 20),
            BackgroundTransparency = 1,
            Text = "Reset Config",
            TextColor3 = Config.Text,
            Font = Enum.Font.GothamSemibold,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
        }
    )

local ResetDescription =
    New(
        "TextLabel",
        {
            Parent = ResetCard,
            Position = UDim2.fromOffset(14, 32),
            Size = UDim2.new(1, -180, 0, 25),
            BackgroundTransparency = 1,
            Text = "Restore the default configuration.",
            TextColor3 = Config.TextDark,
            Font = Enum.Font.Gotham,
            TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
        }
    )

local ResetButton =
    New(
        "TextButton",
        {
            Parent = ResetCard,
            Position = UDim2.new(1, -155, 0, 18),
            Size = UDim2.fromOffset(135, 36),
            BackgroundColor3 = Config.PanelLight,
            BorderSizePixel = 0,
            Text = "RESET",
            TextColor3 = Config.Text,
            Font = Enum.Font.GothamBold,
            TextSize = 11,
            AutoButtonColor = false,
        }
    )

Corner(ResetButton, 8)
Stroke(ResetButton, Config.Border, 1)

ResetButton.MouseEnter:Connect(function()

    Tween(
        ResetButton,
        0.12,
        {
            BackgroundColor3 = Config.AccentDark
        }
    )

end)

ResetButton.MouseLeave:Connect(function()

    Tween(
        ResetButton,
        0.12,
        {
            BackgroundColor3 = Config.PanelLight
        }
    )

end)

ResetButton.MouseButton1Click:Connect(function()

    Config.AimAssist = false
    Config.SilentAim = false
    Config.TargetPart = "Head"
    Config.VisibleOnly = false
    Config.TeamCheck = false
    Config.AimFOV = 250
    Config.FOVCircle = false

    Config.ESP = false
    Config.BoxESP = false
    Config.NameESP = false
    Config.HealthESP = false
    Config.DistanceESP = false

    Config.Speed = false
    Config.WalkSpeed = 16
    Config.JumpPowerEnabled = false
    Config.JumpPower = 50
    Config.InfiniteJump = false
    Config.Noclip = false
    Config.Fly = false
    Config.FlySpeed = 50

    Config.SmoothAnimations = true
    Config.AnimationSpeed = 22
    Config.MenuBlur = false
    Config.Notifications = true
    Config.CompactMode = false

end)


--========================================================
-- SEARCH REGISTER
--========================================================

for _, Page in pairs(Pages) do

    Page.ChildAdded:Connect(function(Object)

        task.wait()

        if Object:IsA("Frame") then

            local TitleObject =
                Object:FindFirstChildWhichIsA(
                    "TextLabel"
                )

            if TitleObject then

                RegisterComponent(
                    Object,
                    TitleObject.Text
                )

            end

        end

    end)

end


--========================================================
-- PAGE VISIBILITY FIX
--========================================================

for Name, Page in pairs(Pages) do

    Page.Visible =
        Name == "Combat"

end

CurrentPage = Pages.Combat


--========================================================
-- SEARCH RESET
--========================================================

SearchBox.FocusLost:Connect(function()

    if SearchBox.Text == "" then

        for _, Component in ipairs(Components) do

            if Component.Object then
                Component.Object.Visible = true
            end

        end

    end

end)


--========================================================
-- INITIAL CONFIG
--========================================================

Config.AimAssist =
    Config.AimAssist or false

Config.SilentAim =
    Config.SilentAim or false

Config.TargetPart =
    Config.TargetPart or "Head"

Config.VisibleOnly =
    Config.VisibleOnly or false

Config.TeamCheck =
    Config.TeamCheck or false

Config.AimFOV =
    Config.AimFOV or 250

Config.FOVCircle =
    Config.FOVCircle or false

Config.ESP =
    Config.ESP or false

Config.BoxESP =
    Config.BoxESP or false

Config.NameESP =
    Config.NameESP or false

Config.HealthESP =
    Config.HealthESP or false

Config.DistanceESP =
    Config.DistanceESP or false

Config.Speed =
    Config.Speed or false

Config.WalkSpeed =
    Config.WalkSpeed or 16

Config.JumpPowerEnabled =
    Config.JumpPowerEnabled or false

Config.JumpPower =
    Config.JumpPower or 50

Config.InfiniteJump =
    Config.InfiniteJump or false

Config.Noclip =
    Config.Noclip or false

Config.Fly =
    Config.Fly or false

Config.FlySpeed =
    Config.FlySpeed or 50

Config.MenuBlur =
    Config.MenuBlur or false

Config.Notifications =
    Config.Notifications ~= false

Config.CompactMode =
    Config.CompactMode or false


--========================================================
-- PART 3/4 END
--========================================================



CreateInfoCard(
    Pages.Visuals,
    "Visual System",
    "Visual settings and ESP options are configured here."
)


--========================================================
-- END OF PART 2/4
--========================================================

--========================================================
-- PART 4/4
-- MOVEMENT CONTROLLER
--========================================================

local Character
local Humanoid
local RootPart

local function UpdateCharacter()

    Character = LocalPlayer.Character

    if not Character then
        Humanoid = nil
        RootPart = nil
        return
    end

    Humanoid =
        Character:FindFirstChildOfClass(
            "Humanoid"
        )

    RootPart =
        Character:FindFirstChild(
            "HumanoidRootPart"
        )

end

UpdateCharacter()

LocalPlayer.CharacterAdded:Connect(function()

    task.wait(0.25)

    UpdateCharacter()

end)


--========================================================
-- WALK SPEED
--========================================================

RunService.Heartbeat:Connect(function()

    if not Humanoid then
        return
    end

    if Config.Speed then

        Humanoid.WalkSpeed =
            tonumber(Config.WalkSpeed)
            or 16

    else

        Humanoid.WalkSpeed = 16

    end

end)


--========================================================
-- JUMP POWER
--========================================================

RunService.Heartbeat:Connect(function()

    if not Humanoid then
        return
    end

    if Config.JumpPowerEnabled then

        Humanoid.UseJumpPower = true

        Humanoid.JumpPower =
            tonumber(Config.JumpPower)
            or 50

    else

        Humanoid.UseJumpPower = true
        Humanoid.JumpPower = 50

    end

end)


--========================================================
-- INFINITE JUMP
--========================================================

UserInputService.JumpRequest:Connect(function()

    if not Config.InfiniteJump then
        return
    end

    if not Humanoid then
        return
    end

    Humanoid:ChangeState(
        Enum.HumanoidStateType.Jumping
    )

end)


--========================================================
-- NOCLIP
--========================================================

RunService.Stepped:Connect(function()

    if not Config.Noclip then
        return
    end

    if not Character then
        return
    end

    for _, Object in ipairs(
        Character:GetDescendants()
    ) do

        if Object:IsA("BasePart") then

            Object.CanCollide = false

        end

    end

end)


--========================================================
-- RESTORE COLLISION
--========================================================

local function RestoreCollision()

    if not Character then
        return
    end

    for _, Object in ipairs(
        Character:GetDescendants()
    ) do

        if Object:IsA("BasePart") then

            Object.CanCollide = true

        end

    end

end


--========================================================
-- FLY
--========================================================

local FlyConnection

local function StopFly()

    if FlyConnection then

        FlyConnection:Disconnect()
        FlyConnection = nil

    end

    if RootPart then

        local Velocity =
            RootPart:FindFirstChild(
                "RivalsFlyVelocity"
            )

        local Gyro =
            RootPart:FindFirstChild(
                "RivalsFlyGyro"
            )

        if Velocity then
            Velocity:Destroy()
        end

        if Gyro then
            Gyro:Destroy()
        end

    end

end


local function StartFly()

    StopFly()

    if not RootPart then
        return
    end

    local BodyVelocity =
        Instance.new(
            "BodyVelocity"
        )

    BodyVelocity.Name =
        "RivalsFlyVelocity"

    BodyVelocity.MaxForce =
        Vector3.new(
            math.huge,
            math.huge,
            math.huge
        )

    BodyVelocity.Velocity =
        Vector3.zero

    BodyVelocity.Parent =
        RootPart


    local BodyGyro =
        Instance.new(
            "BodyGyro"
        )

    BodyGyro.Name =
        "RivalsFlyGyro"

    BodyGyro.MaxTorque =
        Vector3.new(
            math.huge,
            math.huge,
            math.huge
        )

    BodyGyro.P =
        90000

    BodyGyro.CFrame =
        RootPart.CFrame

    BodyGyro.Parent =
        RootPart


    FlyConnection =
        RunService.RenderStepped:Connect(
            function()

                if not Config.Fly then

                    StopFly()
                    return

                end

                if not Character
                    or not Humanoid
                    or not RootPart then

                    UpdateCharacter()
                    return

                end

                local Camera =
                    workspace.CurrentCamera

                if not Camera then
                    return
                end

                local Direction =
                    Vector3.zero

                if UserInputService:IsKeyDown(
                    Enum.KeyCode.W
                ) then

                    Direction +=
                        Camera.CFrame.LookVector

                end

                if UserInputService:IsKeyDown(
                    Enum.KeyCode.S
                ) then

                    Direction -=
                        Camera.CFrame.LookVector

                end

                if UserInputService:IsKeyDown(
                    Enum.KeyCode.A
                ) then

                    Direction -=
                        Camera.CFrame.RightVector

                end

                if UserInputService:IsKeyDown(
                    Enum.KeyCode.D
                ) then

                    Direction +=
                        Camera.CFrame.RightVector

                end

                if UserInputService:IsKeyDown(
                    Enum.KeyCode.Space
                ) then

                    Direction +=
                        Vector3.yAxis

                end

                if UserInputService:IsKeyDown(
                    Enum.KeyCode.LeftControl
                ) then

                    Direction -=
                        Vector3.yAxis

                end

                if Direction.Magnitude > 0 then

                    Direction =
                        Direction.Unit

                end

                BodyVelocity.Velocity =
                    Direction *
                    (
                        tonumber(
                            Config.FlySpeed
                        )
                        or 50
                    )

                BodyGyro.CFrame =
                    Camera.CFrame

            end
        )

end


--========================================================
-- FLY STATE
--========================================================

local LastFlyState =
    Config.Fly

RunService.Heartbeat:Connect(function()

    if Config.Fly ~= LastFlyState then

        LastFlyState =
            Config.Fly

        if Config.Fly then
            StartFly()
        else
            StopFly()
        end

    end

end)


--========================================================
-- CLEANUP
--========================================================

LocalPlayer.CharacterRemoving:Connect(
    function()

        StopFly()

    end
)


--========================================================
-- MENU KEYBIND
--========================================================

local MenuKey =
    Enum.KeyCode.RightShift

UserInputService.InputBegan:Connect(
    function(Input, Processed)

        if Processed then
            return
        end

        if Input.KeyCode == MenuKey then

            if Config.MenuOpen then
                CloseMenu()
            else
                OpenMenu()
            end

        end

    end
)


--========================================================
-- FINAL MENU STATE
--========================================================

Holder.Visible = true
MiniButton.Visible = false

Config.MenuOpen = true

CurrentPage =
    CurrentPage
    or Pages.Combat


--========================================================
-- FINAL SAFETY
--========================================================

task.defer(function()

    if Holder and Holder.Parent then

        Holder.AnchorPoint =
            Vector2.new(
                0.5,
                0.5
            )

    end

end)


--========================================================
-- END OF RIVALS HUB 3.0
--========================================================
