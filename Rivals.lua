--==============================================================--
-- RIVALS HUB - CLEAN REBUILD
-- PART 1/4
--==============================================================--

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

--==============================================================--
-- CONFIG
--==============================================================--

local Config = {
    Destroyed = false,
    Minimized = false,

    Animations = true,
    BackgroundEffects = true,

    Accent = Color3.fromRGB(145, 90, 255),
    AccentDark = Color3.fromRGB(82, 48, 165),

    Background = Color3.fromRGB(7, 7, 13),
    Panel = Color3.fromRGB(13, 13, 22),
    Panel2 = Color3.fromRGB(19, 19, 31),

    Text = Color3.fromRGB(242, 242, 250),
    SubText = Color3.fromRGB(145, 145, 165),
    Border = Color3.fromRGB(48, 39, 76),

    AimAssist = false,
    CombatTeamCheck = true,
    VisibleOnly = false,
    TargetPart = "Head",
    AimFOV = 150,

    ESP = false,
    ESPNames = true,
    ESPDistance = false,
    ESPHealth = false,
    VisualTeamCheck = true,

    FOVCircle = false,
    FOVSize = 150,
    FOVThickness = 2,

    SpeedEnabled = false,
    Speed = 16,

    JumpEnabled = false,
    Jump = 50,

    InfiniteJump = false,
    Noclip = false,
    AutoSprint = false,
}

--==============================================================--
-- REMOVE OLD VERSION
--==============================================================--

pcall(function()
    local old = game:GetService("CoreGui"):FindFirstChild("RivalsHub")

    if old then
        old:Destroy()
    end
end)

--==============================================================--
-- HELPERS
--==============================================================--

local function Tween(Object, Properties, Time)
    if not Object or not Object.Parent then
        return
    end

    if not Config.Animations then
        for Property, Value in pairs(Properties) do
            pcall(function()
                Object[Property] = Value
            end)
        end

        return
    end

    local Info = TweenInfo.new(
        Time or 0.2,
        Enum.EasingStyle.Quart,
        Enum.EasingDirection.Out
    )

    pcall(function()
        TweenService:Create(
            Object,
            Info,
            Properties
        ):Play()
    end)
end

local function Corner(Object, Radius)
    local CornerObject = Instance.new("UICorner")

    CornerObject.CornerRadius =
        UDim.new(0, Radius or 10)

    CornerObject.Parent = Object

    return CornerObject
end

local function Stroke(
    Object,
    Color,
    Thickness,
    Transparency
)
    local StrokeObject = Instance.new("UIStroke")

    StrokeObject.Color =
        Color or Config.Border

    StrokeObject.Thickness =
        Thickness or 1

    StrokeObject.Transparency =
        Transparency or 0

    StrokeObject.ApplyStrokeMode =
        Enum.ApplyStrokeMode.Border

    StrokeObject.Parent = Object

    return StrokeObject
end

local function New(ClassName, Properties, Parent)
    local Object = Instance.new(ClassName)

    for Property, Value in pairs(Properties or {}) do
        pcall(function()
            Object[Property] = Value
        end)
    end

    Object.Parent = Parent

    return Object
end

local function Label(
    Parent,
    Text,
    TextSize,
    TextColor,
    Font
)
    return New("TextLabel", {
        BackgroundTransparency = 1,

        Text = Text,

        TextSize = TextSize or 12,

        TextColor3 =
            TextColor or Config.Text,

        Font =
            Font or Enum.Font.Gotham,

        TextXAlignment =
            Enum.TextXAlignment.Left,
    }, Parent)
end

--==============================================================--
-- SCREEN GUI
--==============================================================--

local ScreenGui = New("ScreenGui", {
    Name = "RivalsHub",

    ResetOnSpawn = false,

    IgnoreGuiInset = true,

    ZIndexBehavior =
        Enum.ZIndexBehavior.Sibling,
}, game:GetService("CoreGui"))

--==============================================================--
-- MAIN HOLDER
--==============================================================--

local Holder = New("Frame", {
    Name = "MainHolder",

    AnchorPoint =
        Vector2.new(0.5, 0.5),

    Position =
        UDim2.fromScale(0.5, 0.5),

    Size =
        UDim2.fromOffset(650, 455),

    BackgroundColor3 =
        Config.Background,

    BorderSizePixel = 0,

    ClipsDescendants = true,

    ZIndex = 5,
}, ScreenGui)

Corner(Holder, 18)

Stroke(
    Holder,
    Config.Border,
    1,
    0.05
)

local HolderScale = New("UIScale", {
    Scale = 0.92,
}, Holder)

--==============================================================--
-- BACKGROUND
--==============================================================--

local Background = New("Frame", {
    Name = "AnimatedBackground",

    Size =
        UDim2.fromScale(1, 1),

    BackgroundColor3 =
        Config.Background,

    BorderSizePixel = 0,

    ZIndex = 1,
}, Holder)

Corner(Background, 18)

local BackgroundGradient = New("UIGradient", {
    Rotation = 25,

    Color =
        ColorSequence.new({
            ColorSequenceKeypoint.new(
                0,
                Color3.fromRGB(7, 7, 13)
            ),

            ColorSequenceKeypoint.new(
                0.5,
                Color3.fromRGB(18, 10, 30)
            ),

            ColorSequenceKeypoint.new(
                1,
                Color3.fromRGB(7, 7, 13)
            ),
        }),
}, Background)

local BackgroundLines = {}

for Index = 1, 8 do
    local Line = New("Frame", {
        Name = "Line" .. Index,

        Position =
            UDim2.new(
                -0.4,
                Index * 105,
                0,
                0
            ),

        Size =
            UDim2.fromOffset(2, 700),

        Rotation = 28,

        BackgroundColor3 =
            Config.Accent,

        BackgroundTransparency =
            0.91,

        BorderSizePixel = 0,

        ZIndex = 2,
    }, Background)

    table.insert(
        BackgroundLines,
        Line
    )
end

for Index = 1, 3 do
    local Glow = New("Frame", {
        Name = "Glow" .. Index,

        AnchorPoint =
            Vector2.new(0.5, 0.5),

        Position =
            UDim2.new(
                Index / 4,
                0,
                0.25 + Index * 0.15,
                0
            ),

        Size =
            UDim2.fromOffset(180, 180),

        BackgroundColor3 =
            Config.Accent,

        BackgroundTransparency =
            0.965,

        BorderSizePixel = 0,

        ZIndex = 2,
    }, Background)

    Corner(Glow, 999)

    table.insert(
        BackgroundLines,
        Glow
    )
end

--==============================================================--
-- TOP BAR
--==============================================================--

local TopBar = New("Frame", {
    Name = "TopBar",

    Position =
        UDim2.fromOffset(10, 10),

    Size =
        UDim2.new(1, -20, 0, 56),

    BackgroundColor3 =
        Config.Panel,

    BorderSizePixel = 0,

    ZIndex = 10,
}, Holder)

Corner(TopBar, 13)

Stroke(
    TopBar,
    Config.Border,
    1,
    0.2
)

--==============================================================--
-- LOGO
--==============================================================--

local Logo = New("TextLabel", {
    Name = "Logo",

    Position =
        UDim2.fromOffset(12, 9),

    Size =
        UDim2.fromOffset(38, 38),

    BackgroundColor3 =
        Config.AccentDark,

    Text = "R",

    TextColor3 =
        Config.Text,

    TextSize = 21,

    Font =
        Enum.Font.GothamBold,

    TextXAlignment =
        Enum.TextXAlignment.Center,

    TextYAlignment =
        Enum.TextYAlignment.Center,

    ZIndex = 12,
}, TopBar)

Corner(10)

Stroke(
    Logo,
    Config.Accent,
    1,
    0.2
)

--==============================================================--
-- TITLE
--==============================================================--

local Title = Label(
    TopBar,
    "RIVALS HUB",
    15,
    Config.Text,
    Enum.Font.GothamBold
)

Title.Position =
    UDim2.fromOffset(61, 8)

Title.Size =
    UDim2.new(1, -150, 0, 22)

Title.ZIndex = 12

local Subtitle = Label(
    TopBar,
    "Clean controls • Smooth interface",
    10,
    Config.SubText,
    Enum.Font.Gotham
)

Subtitle.Position =
    UDim2.fromOffset(61, 30)

Subtitle.Size =
    UDim2.new(1, -150, 0, 16)

Subtitle.ZIndex = 12

--==============================================================--
-- MINIMIZE BUTTON
--==============================================================--

local MinButton = New("TextButton", {
    Name = "Minimize",

    Position =
        UDim2.new(1, -77, 0, 12),

    Size =
        UDim2.fromOffset(31, 31),

    BackgroundColor3 =
        Config.Panel2,

    Text = "—",

    TextColor3 =
        Config.SubText,

    TextSize = 17,

    Font =
        Enum.Font.GothamBold,

    AutoButtonColor = false,

    ZIndex = 15,
}, TopBar)

Corner(9)

--==============================================================--
-- CLOSE BUTTON
--==============================================================--

local CloseButton = New("TextButton", {
    Name = "Close",

    Position =
        UDim2.new(1, -42, 0, 12),

    Size =
        UDim2.fromOffset(31, 31),

    BackgroundColor3 =
        Config.Panel2,

    Text = "×",

    TextColor3 =
        Config.SubText,

    TextSize = 19,

    Font =
        Enum.Font.Gotham,

    AutoButtonColor = false,

    ZIndex = 15,
}, TopBar)

Corner(9)

--==============================================================--
-- CONTENT
--==============================================================--

local Content = New("Frame", {
    Name = "Content",

    Position =
        UDim2.fromOffset(10, 76),

    Size =
        UDim2.new(1, -20, 1, -86),

    BackgroundTransparency = 1,

    ZIndex = 5,
}, Holder)

--==============================================================--
-- SIDEBAR
--==============================================================--

local Sidebar = New("Frame", {
    Name = "Sidebar",

    Size =
        UDim2.new(0, 150, 1, 0),

    BackgroundColor3 =
        Config.Panel,

    BorderSizePixel = 0,

    ZIndex = 6,
}, Content)

Corner(Sidebar, 13)

Stroke(
    Sidebar,
    Config.Border,
    1,
    0.25
)

local CategoryTitle = Label(
    Sidebar,
    "CATEGORIES",
    10,
    Config.SubText,
    Enum.Font.GothamBold
)

CategoryTitle.Position =
    UDim2.fromOffset(15, 14)

CategoryTitle.Size =
    UDim2.new(1, -30, 0, 18)

CategoryTitle.ZIndex = 8

--==============================================================--
-- PAGE HOLDER
--==============================================================--

local PageHolder = New("Frame", {
    Name = "PageHolder",

    Position =
        UDim2.fromOffset(162, 0),

    Size =
        UDim2.new(1, -162, 1, 0),

    BackgroundColor3 =
        Config.Panel,

    BorderSizePixel = 0,

    ZIndex = 6,
}, Content)

Corner(PageHolder, 13)

Stroke(
    PageHolder,
    Config.Border,
    1,
    0.25
)

--==============================================================--
-- PAGE SYSTEM
--==============================================================--

local Pages = {}
local PageButtons = {}

local CurrentPage = nil

local function CreatePage(Name)
    local Page = New("ScrollingFrame", {
        Name = Name,

        Size =
            UDim2.fromScale(1, 1),

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        ScrollBarThickness = 3,

        ScrollBarImageColor3 =
            Config.Accent,

        CanvasSize =
            UDim2.new(0, 0, 0, 0),

        AutomaticCanvasSize =
            Enum.AutomaticSize.Y,

        ScrollingDirection =
            Enum.ScrollingDirection.Y,

        Visible = false,

        ZIndex = 7,
    }, PageHolder)

    local PaddingObject =
        Instance.new("UIPadding")

    PaddingObject.PaddingLeft =
        UDim.new(0, 16)

    PaddingObject.PaddingRight =
        UDim.new(0, 12)

    PaddingObject.PaddingTop =
        UDim.new(0, 15)

    PaddingObject.PaddingBottom =
        UDim.new(0, 15)

    PaddingObject.Parent = Page

    local Layout =
        Instance.new("UIListLayout")

    Layout.Padding =
        UDim.new(0, 10)

    Layout.SortOrder =
        Enum.SortOrder.LayoutOrder

    Layout.Parent = Page

    Pages[Name] = Page

    return Page
end

local function CreatePageButton(Name, Order)
    local Button = New("TextButton", {
        Name = Name .. "Button",

        Position =
            UDim2.fromOffset(
                10,
                48 + (Order - 1) * 43
            ),

        Size =
            UDim2.new(1, -20, 0, 36),

        BackgroundColor3 =
            Config.Panel,

        Text = Name,

        TextColor3 =
            Config.SubText,

        TextSize = 11,

        Font =
            Enum.Font.GothamMedium,

        AutoButtonColor = false,

        ZIndex = 8,
    }, Sidebar)

    Corner(Button, 9)

    PageButtons[Name] = Button

    Button.MouseButton1Click:Connect(function()
        if Config.Destroyed then
            return
        end

        for PageName, Page in pairs(Pages) do
            Page.Visible =
                PageName == Name
        end

        for PageName, PageButton in pairs(PageButtons) do
            Tween(PageButton, {
                BackgroundColor3 =
                    PageName == Name
                    and Config.AccentDark
                    or Config.Panel,

                TextColor3 =
                    PageName == Name
                    and Config.Text
                    or Config.SubText,
            }, 0.14)
        end

        CurrentPage = Name
    end)

    return Button
end

--==============================================================--
-- CREATE PAGES
--==============================================================--

local Combat =
    CreatePage("Combat")

local Visuals =
    CreatePage("Visuals")

local Movement =
    CreatePage("Movement")

local Settings =
    CreatePage("Settings")

CreatePageButton("Combat", 1)
CreatePageButton("Visuals", 2)
CreatePageButton("Movement", 3)
CreatePageButton("Settings", 4)

--==============================================================--
-- COMPONENT STORAGE
--==============================================================--

local Components = {}

--==============================================================--
-- END PART 1
--==============================================================--

--==============================================================--
-- RIVALS HUB
-- PART 2/4
-- COMPONENTS + COMBAT + VISUALS
--==============================================================--

--==============================================================--
-- SECTION
--==============================================================--

local function CreateSection(Parent, Text)
    local Frame = New("Frame", {
        Size = UDim2.new(1, 0, 0, 28),
        BackgroundTransparency = 1,
        ZIndex = 8,
    }, Parent)

    local LabelObject = Label(
        Frame,
        Text,
        11,
        Config.Text,
        Enum.Font.GothamBold
    )

    LabelObject.Size =
        UDim2.new(1, 0, 1, 0)

    LabelObject.ZIndex = 9

    return Frame
end

--==============================================================--
-- INFO CARD
--==============================================================--

local function CreateInfoCard(
    Parent,
    TitleText,
    DescriptionText
)
    local Frame = New("Frame", {
        Size = UDim2.new(1, 0, 0, 64),
        BackgroundColor3 = Config.Panel2,
        BorderSizePixel = 0,
        ZIndex = 8,
    }, Parent)

    Corner(Frame, 10)

    Stroke(
        Frame,
        Config.Border,
        1,
        0.35
    )

    local TitleObject = Label(
        Frame,
        TitleText,
        12,
        Config.Text,
        Enum.Font.GothamBold
    )

    TitleObject.Position =
        UDim2.fromOffset(13, 8)

    TitleObject.Size =
        UDim2.new(1, -26, 0, 19)

    TitleObject.ZIndex = 9

    local DescriptionObject = Label(
        Frame,
        DescriptionText,
        9,
        Config.SubText,
        Enum.Font.Gotham
    )

    DescriptionObject.Position =
        UDim2.fromOffset(13, 31)

    DescriptionObject.Size =
        UDim2.new(1, -26, 0, 25)

    DescriptionObject.TextWrapped = true
    DescriptionObject.ZIndex = 9

    return Frame
end

--==============================================================--
-- TOGGLE
--==============================================================--

local function CreateToggle(
    Parent,
    Name,
    Description,
    Default,
    Callback
)
    local Frame = New("TextButton", {
        Name = Name .. "Toggle",

        Size =
            UDim2.new(1, 0, 0, 54),

        BackgroundColor3 =
            Config.Panel2,

        BorderSizePixel = 0,

        Text = "",

        AutoButtonColor = false,

        ZIndex = 8,
    }, Parent)

    Corner(Frame, 10)

    Stroke(
        Frame,
        Config.Border,
        1,
        0.45
    )

    local TitleObject = Label(
        Frame,
        Name,
        11,
        Config.Text,
        Enum.Font.GothamMedium
    )

    TitleObject.Position =
        UDim2.fromOffset(13, 7)

    TitleObject.Size =
        UDim2.new(1, -90, 0, 18)

    TitleObject.ZIndex = 9

    local DescriptionObject = Label(
        Frame,
        Description,
        9,
        Config.SubText,
        Enum.Font.Gotham
    )

    DescriptionObject.Position =
        UDim2.fromOffset(13, 28)

    DescriptionObject.Size =
        UDim2.new(1, -90, 0, 16)

    DescriptionObject.ZIndex = 9

    -- Switch
    local Switch = New("Frame", {
        Name = "Switch",

        Position =
            UDim2.new(1, -54, 0.5, -10),

        Size =
            UDim2.fromOffset(40, 20),

        BackgroundColor3 =
            Color3.fromRGB(38, 38, 52),

        BorderSizePixel = 0,

        ZIndex = 10,
    }, Frame)

    Corner(Switch, 10)

    local Knob = New("Frame", {
        Name = "Knob",

        Position =
            UDim2.fromOffset(3, 3),

        Size =
            UDim2.fromOffset(14, 14),

        BackgroundColor3 =
            Config.Text,

        BorderSizePixel = 0,

        ZIndex = 11,
    }, Switch)

    Corner(Knob, 8)

    local State =
        Default == true

    local Component = {
        Type = "Toggle",
        Value = State,
        Callback = Callback,
    }

    Components[Name] = Component

    local function UpdateVisual()
        if State then
            Tween(
                Switch,
                {
                    BackgroundColor3 =
                        Config.AccentDark
                },
                0.12
            )

            Tween(
                Knob,
                {
                    Position =
                        UDim2.fromOffset(23, 3)
                },
                0.12
            )
        else
            Tween(
                Switch,
                {
                    BackgroundColor3 =
                        Color3.fromRGB(38, 38, 52)
                },
                0.12
            )

            Tween(
                Knob,
                {
                    Position =
                        UDim2.fromOffset(3, 3)
                },
                0.12
            )
        end
    end

    local function SetState(Value, FireCallback)
        State = Value == true

        Component.Value = State

        UpdateVisual()

        if FireCallback ~= false
            and Component.Callback then

            task.spawn(
                Component.Callback,
                State
            )
        end
    end

    Component.Set = SetState

    UpdateVisual()

    -- IMPORTANT:
    -- Only ONE click connection.
    -- This prevents the old double-toggle bug.

    Frame.Activated:Connect(function()
        if Config.Destroyed then
            return
        end

        SetState(not State, true)
    end)

    Frame.MouseEnter:Connect(function()
        if Config.Destroyed then
            return
        end

        Tween(
            Frame,
            {
                BackgroundColor3 =
                    Color3.fromRGB(23, 23, 38)
            },
            0.1
        )
    end)

    Frame.MouseLeave:Connect(function()
        if Config.Destroyed then
            return
        end

        Tween(
            Frame,
            {
                BackgroundColor3 =
                    Config.Panel2
            },
            0.1
        )
    end)

    return Component
end

--==============================================================--
-- SLIDER
--==============================================================--

local function CreateSlider(
    Parent,
    Name,
    Description,
    Minimum,
    Maximum,
    Default,
    Callback
)
    local Frame = New("Frame", {
        Name = Name .. "Slider",

        Size =
            UDim2.new(1, 0, 0, 70),

        BackgroundColor3 =
            Config.Panel2,

        BorderSizePixel = 0,

        ZIndex = 8,
    }, Parent)

    Corner(Frame, 10)

    Stroke(
        Frame,
        Config.Border,
        1,
        0.45
    )

    local TitleObject = Label(
        Frame,
        Name,
        11,
        Config.Text,
        Enum.Font.GothamMedium
    )

    TitleObject.Position =
        UDim2.fromOffset(13, 7)

    TitleObject.Size =
        UDim2.new(1, -100, 0, 18)

    TitleObject.ZIndex = 9

    local ValueObject = Label(
        Frame,
        tostring(Default),
        10,
        Config.Accent,
        Enum.Font.GothamBold
    )

    ValueObject.Position =
        UDim2.new(1, -70, 0, 7)

    ValueObject.Size =
        UDim2.fromOffset(55, 18)

    ValueObject.TextXAlignment =
        Enum.TextXAlignment.Right

    ValueObject.ZIndex = 9

    local DescriptionObject = Label(
        Frame,
        Description,
        9,
        Config.SubText,
        Enum.Font.Gotham
    )

    DescriptionObject.Position =
        UDim2.fromOffset(13, 25)

    DescriptionObject.Size =
        UDim2.new(1, -26, 0, 14)

    DescriptionObject.ZIndex = 9

    local Bar = New("Frame", {
        Name = "Bar",

        Position =
            UDim2.fromOffset(13, 48),

        Size =
            UDim2.new(1, -26, 0, 5),

        BackgroundColor3 =
            Color3.fromRGB(39, 39, 52),

        BorderSizePixel = 0,

        ZIndex = 9,
    }, Frame)

    Corner(Bar, 5)

    local Fill = New("Frame", {
        Name = "Fill",

        Size =
            UDim2.new(
                math.clamp(
                    (Default - Minimum)
                    / (Maximum - Minimum),
                    0,
                    1
                ),
                0,
                1,
                0
            ),

        BackgroundColor3 =
            Config.Accent,

        BorderSizePixel = 0,

        ZIndex = 10,
    }, Bar)

    Corner(Fill, 5)

    local Component = {
        Type = "Slider",
        Value = Default,
        Callback = Callback,
    }

    Components[Name] = Component

    local DraggingSlider = false

    local function SetValue(Value, FireCallback)
        Value = math.clamp(
            tonumber(Value) or Minimum,
            Minimum,
            Maximum
        )

        Value = math.floor(Value + 0.5)

        Component.Value = Value

        local Alpha =
            (Value - Minimum)
            / (Maximum - Minimum)

        Fill.Size =
            UDim2.new(
                Alpha,
                0,
                1,
                0
            )

        ValueObject.Text =
            tostring(Value)

        if FireCallback ~= false
            and Component.Callback then

            task.spawn(
                Component.Callback,
                Value
            )
        end
    end

    Component.Set = SetValue

    local function UpdateFromMouse(X)
        if Bar.AbsoluteSize.X <= 0 then
            return
        end

        local Alpha =
            math.clamp(
                (
                    X -
                    Bar.AbsolutePosition.X
                ) /
                Bar.AbsoluteSize.X,
                0,
                1
            )

        local Value =
            Minimum +
            (Maximum - Minimum) * Alpha

        SetValue(Value, true)
    end

    Bar.InputBegan:Connect(function(Input)
        if Input.UserInputType ==
            Enum.UserInputType.MouseButton1
            or
            Input.UserInputType ==
            Enum.UserInputType.Touch then

            DraggingSlider = true

            UpdateFromMouse(
                Input.Position.X
            )
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

            UpdateFromMouse(
                Input.Position.X
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(Input)
        if Input.UserInputType ==
            Enum.UserInputType.MouseButton1
            or
            Input.UserInputType ==
            Enum.UserInputType.Touch then

            DraggingSlider = false
        end
    end)

    return Component
end

--==============================================================--
-- DROPDOWN
--==============================================================--

local function CreateDropdown(
    Parent,
    Name,
    Description,
    Options,
    Default,
    Callback
)
    local Frame = New("TextButton", {
        Name = Name .. "Dropdown",

        Size =
            UDim2.new(1, 0, 0, 60),

        BackgroundColor3 =
            Config.Panel2,

        BorderSizePixel = 0,

        Text = "",

        AutoButtonColor = false,

        ZIndex = 8,
    }, Parent)

    Corner(Frame, 10)

    Stroke(
        Frame,
        Config.Border,
        1,
        0.45
    )

    local TitleObject = Label(
        Frame,
        Name,
        11,
        Config.Text,
        Enum.Font.GothamMedium
    )

    TitleObject.Position =
        UDim2.fromOffset(13, 8)

    TitleObject.Size =
        UDim2.new(1, -180, 0, 18)

    TitleObject.ZIndex = 9

    local DescriptionObject = Label(
        Frame,
        Description,
        9,
        Config.SubText,
        Enum.Font.Gotham
    )

    DescriptionObject.Position =
        UDim2.fromOffset(13, 30)

    DescriptionObject.Size =
        UDim2.new(1, -180, 0, 16)

    DescriptionObject.ZIndex = 9

    local ValueObject = Label(
        Frame,
        tostring(Default),
        10,
        Config.Accent,
        Enum.Font.GothamBold
    )

    ValueObject.Position =
        UDim2.new(1, -150, 0, 20)

    ValueObject.Size =
        UDim2.fromOffset(130, 20)

    ValueObject.TextXAlignment =
        Enum.TextXAlignment.Right

    ValueObject.ZIndex = 9

    local Arrow = Label(
        Frame,
        "›",
        18,
        Config.SubText,
        Enum.Font.GothamBold
    )

    Arrow.Position =
        UDim2.new(1, -25, 0, 17)

    Arrow.Size =
        UDim2.fromOffset(15, 25)

    Arrow.TextXAlignment =
        Enum.TextXAlignment.Center

    Arrow.ZIndex = 9

    local Index =
        table.find(Options, Default) or 1

    local Component = {
        Type = "Dropdown",
        Value = Default,
        Callback = Callback,
    }

    Components[Name] = Component

    local function SetValue(Value, FireCallback)
        local Found =
            table.find(Options, Value)

        if not Found then
            return
        end

        Index = Found

        Component.Value = Value

        ValueObject.Text =
            tostring(Value)

        if FireCallback ~= false
            and Component.Callback then

            task.spawn(
                Component.Callback,
                Value
            )
        end
    end

    Component.Set = SetValue

    Frame.Activated:Connect(function()
        if Config.Destroyed then
            return
        end

        Index += 1

        if Index > #Options then
            Index = 1
        end

        SetValue(
            Options[Index],
            true
        )
    end)

    return Component
end

--==============================================================--
-- COMBAT PAGE
--==============================================================--

CreateInfoCard(
    Combat,
    "Combat Controls",
    "Targeting and aim settings."
)

CreateSection(
    Combat,
    "AIM ASSISTANCE"
)

CreateToggle(
    Combat,
    "Aim Assist",
    "Smoothly aims toward a valid target.",
    Config.AimAssist,
    function(Value)
        Config.AimAssist = Value
    end
)

CreateToggle(
    Combat,
    "Team Check",
    "Ignore teammates when selecting targets.",
    Config.CombatTeamCheck,
    function(Value)
        Config.CombatTeamCheck = Value
    end
)

CreateToggle(
    Combat,
    "Visible Only",
    "Only target players visible to the camera.",
    Config.VisibleOnly,
    function(Value)
        Config.VisibleOnly = Value
    end
)

CreateDropdown(
    Combat,
    "Target Part",
    "Body part used for targeting.",
    {
        "Head",
        "UpperTorso",
        "HumanoidRootPart",
        "LowerTorso"
    },
    Config.TargetPart,
    function(Value)
        Config.TargetPart = Value
    end
)

CreateSlider(
    Combat,
    "Aim FOV",
    "Maximum screen distance for targeting.",
    10,
    500,
    Config.AimFOV,
    function(Value)
        Config.AimFOV = Value
    end
)

--==============================================================--
-- VISUALS PAGE
--==============================================================--

CreateInfoCard(
    Visuals,
    "Visual Controls",
    "Player ESP and FOV display."
)

CreateSection(
    Visuals,
    "PLAYER ESP"
)

CreateToggle(
    Visuals,
    "ESP",
    "Highlight valid players.",
    Config.ESP,
    function(Value)
        Config.ESP = Value
    end
)

CreateToggle(
    Visuals,
    "ESP Names",
    "Display player names.",
    Config.ESPNames,
    function(Value)
        Config.ESPNames = Value
    end
)

CreateToggle(
    Visuals,
    "ESP Distance",
    "Display distance from your character.",
    Config.ESPDistance,
    function(Value)
        Config.ESPDistance = Value
    end
)

CreateToggle(
    Visuals,
    "ESP Health",
    "Display player health.",
    Config.ESPHealth,
    function(Value)
        Config.ESPHealth = Value
    end
)

CreateToggle(
    Visuals,
    "Visual Team Check",
    "Ignore teammates in ESP.",
    Config.VisualTeamCheck,
    function(Value)
        Config.VisualTeamCheck = Value
    end
)

CreateSection(
    Visuals,
    "FOV"
)

CreateToggle(
    Visuals,
    "FOV Circle",
    "Show the targeting radius.",
    Config.FOVCircle,
    function(Value)
        Config.FOVCircle = Value
    end
)

CreateSlider(
    Visuals,
    "FOV Size",
    "Size of the FOV circle.",
    25,
    500,
    Config.FOVSize,
    function(Value)
        Config.FOVSize = Value
    end
)

CreateSlider(
    Visuals,
    "FOV Thickness",
    "Circle outline thickness.",
    1,
    5,
    Config.FOVThickness,
    function(Value)
        Config.FOVThickness = Value
    end
)

--==============================================================--
-- END PART 2/4
--==============================================================--

--// ============================================================
--// RIVALS HUB 2.1
--// PART 3/4 — TARGET SYSTEM / ESP / MOVEMENT
--// ============================================================

local Camera = workspace.CurrentCamera

--// ============================================================
--// TARGET HELPERS
--// ============================================================

local function IsAlive(Character)
    if not Character then
        return false
    end

    local Humanoid = Character:FindFirstChildOfClass("Humanoid")

    return Humanoid and Humanoid.Health > 0
end

local function IsEnemy(Player)
    if Player == LocalPlayer then
        return false
    end

    local Character = Player.Character

    if not Character or not IsAlive(Character) then
        return false
    end

    if Config.CombatTeamCheck then
        if LocalPlayer.Team and Player.Team then
            if LocalPlayer.Team == Player.Team then
                return false
            end
        end
    end

    return true
end

local function GetTargetPart(Character)
    if not Character then
        return nil
    end

    local Part =
        Character:FindFirstChild(Config.TargetPart)
        or Character:FindFirstChild("HumanoidRootPart")
        or Character:FindFirstChild("Head")

    return Part
end

local function IsVisible(TargetPart)
    if not TargetPart then
        return false
    end

    local Character = TargetPart.Parent

    if not Character then
        return false
    end

    Camera = workspace.CurrentCamera

    if not Camera then
        return false
    end

    local Origin = Camera.CFrame.Position
    local Direction = TargetPart.Position - Origin

    local Params = RaycastParams.new()
    Params.FilterType = Enum.RaycastFilterType.Exclude
    Params.FilterDescendantsInstances = {
        LocalPlayer.Character,
        Camera
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

    return Result.Instance:IsDescendantOf(Character)
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
    local ClosestDistance = Config.AimFOV

    for _, Player in ipairs(Players:GetPlayers()) do
        if IsEnemy(Player) then
            local Character = Player.Character
            local TargetPart = GetTargetPart(Character)

            if TargetPart then
                local ScreenPosition, OnScreen =
                    Camera:WorldToViewportPoint(TargetPart.Position)

                if OnScreen and ScreenPosition.Z > 0 then
                    local ScreenPoint = Vector2.new(
                        ScreenPosition.X,
                        ScreenPosition.Y
                    )

                    local Distance = (
                        ScreenPoint - Center
                    ).Magnitude

                    if Distance <= ClosestDistance then
                        if not Config.VisibleOnly or IsVisible(TargetPart) then
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

--// ============================================================
--// AIM ASSIST
--// ============================================================

RunService.RenderStepped:Connect(function()
    if not Config.AimAssist then
        return
    end

    Camera = workspace.CurrentCamera

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
    local TargetPosition = TargetPart.Position

    local DesiredCFrame = CFrame.lookAt(
        CameraPosition,
        TargetPosition
    )

    Camera.CFrame = Camera.CFrame:Lerp(
        DesiredCFrame,
        Config.AimSmoothness or 0.18
    )
end)

--// ============================================================
--// FOV CIRCLE
--// ============================================================

local FOVCircle = New(
    "Frame",
    ScreenGui,
    {
        Name = "FOVCircle",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromOffset(
            Config.FOVSize * 2,
            Config.FOVSize * 2
        ),
        Position = UDim2.fromOffset(0, 0),
        Visible = Config.FOVCircle,
        ZIndex = 20
    }
)

Corner(
    FOVCircle,
    999
)

local FOVStroke = Stroke(
    FOVCircle,
    Config.Accent,
    Config.FOVThickness,
    0.15
)

RunService.RenderStepped:Connect(function()
    Camera = workspace.CurrentCamera

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

    FOVCircle.Visible = Config.FOVCircle

    FOVStroke.Thickness = Config.FOVThickness
    FOVStroke.Color = Config.Accent
end)

--// ============================================================
--// ESP SYSTEM
--// ============================================================

local ESPObjects = {}

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
    if Player == LocalPlayer then
        return
    end

    if ESPObjects[Player] then
        return ESPObjects[Player]
    end

    local Highlight = Instance.new("Highlight")
    Highlight.Name = "RivalsHubESP"
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Highlight.FillColor = Config.Accent
    Highlight.OutlineColor = Config.Accent
    Highlight.FillTransparency = 0.82
    Highlight.OutlineTransparency = 0.15
    Highlight.Parent = ScreenGui

    local Billboard = Instance.new("BillboardGui")
    Billboard.Name = "RivalsHubInfo"
    Billboard.AlwaysOnTop = true
    Billboard.Size = UDim2.fromOffset(220, 80)
    Billboard.StudsOffset = Vector3.new(0, 3, 0)
    Billboard.MaxDistance = 500
    Billboard.Parent = ScreenGui

    local Text = Instance.new("TextLabel")
    Text.Name = "Info"
    Text.BackgroundTransparency = 1
    Text.Size = UDim2.fromScale(1, 1)
    Text.Font = Enum.Font.GothamSemibold
    Text.TextColor3 = Color3.fromRGB(245, 245, 255)
    Text.TextStrokeTransparency = 0.35
    Text.TextSize = 13
    Text.TextWrapped = true
    Text.TextYAlignment = Enum.TextYAlignment.Center
    Text.Parent = Billboard

    ESPObjects[Player] = {
        Highlight = Highlight,
        Billboard = Billboard,
        Text = Text
    }

    return ESPObjects[Player]
end

local function UpdateESPForPlayer(Player)
    if Player == LocalPlayer then
        return
    end

    if not Config.ESP then
        RemoveESP(Player)
        return
    end

    local Character = Player.Character

    if not Character or not IsAlive(Character) then
        RemoveESP(Player)
        return
    end

    if Config.VisualTeamCheck then
        if LocalPlayer.Team and Player.Team then
            if LocalPlayer.Team == Player.Team then
                RemoveESP(Player)
                return
            end
        end
    end

    local Root =
        Character:FindFirstChild("HumanoidRootPart")
        or Character:FindFirstChild("UpperTorso")
        or Character:FindFirstChild("Torso")

    if not Root then
        RemoveESP(Player)
        return
    end

    local Data = CreateESP(Player)

    if not Data then
        return
    end

    Data.Highlight.Adornee = Character
    Data.Highlight.FillColor = Config.Accent
    Data.Highlight.OutlineColor = Config.Accent

    Data.Billboard.Adornee = Root

    local Humanoid =
        Character:FindFirstChildOfClass("Humanoid")

    local TextParts = {}

    if Config.ESPNames then
        table.insert(
            TextParts,
            Player.DisplayName
        )
    end

    if Config.ESPDistance then
        local MyCharacter = LocalPlayer.Character
        local MyRoot =
            MyCharacter
            and (
                MyCharacter:FindFirstChild("HumanoidRootPart")
                or MyCharacter:FindFirstChild("UpperTorso")
            )

        if MyRoot then
            local Distance =
                (MyRoot.Position - Root.Position).Magnitude

            table.insert(
                TextParts,
                math.floor(Distance) .. " studs"
            )
        end
    end

    if Config.ESPHealth and Humanoid then
        table.insert(
            TextParts,
            "HP: " .. math.floor(Humanoid.Health)
        )
    end

    Data.Text.Text = table.concat(
        TextParts,
        "\n"
    )

    Data.Billboard.Enabled = (
        #TextParts > 0
    )
end

task.spawn(function()
    while ScreenGui.Parent do
        if Config.ESP then
            for _, Player in ipairs(Players:GetPlayers()) do
                UpdateESPForPlayer(Player)
            end
        else
            for Player in pairs(ESPObjects) do
                RemoveESP(Player)
            end
        end

        task.wait(0.15)
    end
end)

Players.PlayerRemoving:Connect(function(Player)
    RemoveESP(Player)
end)

Players.PlayerAdded:Connect(function(Player)
    Player.CharacterAdded:Connect(function()
        task.wait(0.5)

        if Config.ESP then
            UpdateESPForPlayer(Player)
        end
    end)
end)

--// ============================================================
--// MOVEMENT SYSTEM
--// ============================================================

local function GetHumanoid()
    local Character = LocalPlayer.Character

    if not Character then
        return nil
    end

    return Character:FindFirstChildOfClass("Humanoid")
end

local function ApplyMovement()
    local Humanoid = GetHumanoid()

    if not Humanoid then
        return
    end

    -- Speed
    if Config.SpeedEnabled then
        Humanoid.WalkSpeed = Config.Speed
    elseif not Config.AutoSprint then
        Humanoid.WalkSpeed = 16
    end

    -- Jump
    if Config.JumpEnabled then
        Humanoid.UseJumpPower = true
        Humanoid.JumpPower = Config.Jump
    else
        Humanoid.UseJumpPower = true
        Humanoid.JumpPower = 50
    end

    -- Noclip
    local Character = LocalPlayer.Character

    if Character then
        for _, Object in ipairs(Character:GetDescendants()) do
            if Object:IsA("BasePart") then
                Object.CanCollide = not Config.Noclip
            end
        end
    end

    -- Auto Sprint
    if Config.AutoSprint then
        if Humanoid.MoveDirection.Magnitude > 0 then
            Humanoid.WalkSpeed = math.max(
                Config.Speed,
                24
            )
        elseif Config.SpeedEnabled then
            Humanoid.WalkSpeed = Config.Speed
        else
            Humanoid.WalkSpeed = 16
        end
    end
end

RunService.Heartbeat:Connect(function()
    ApplyMovement()
end)

--// ============================================================
--// INFINITE JUMP
--// ============================================================

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

--// ============================================================
--// CHARACTER RESET
--// ============================================================

LocalPlayer.CharacterAdded:Connect(function(Character)
    task.wait(0.5)

    local Humanoid =
        Character:WaitForChild(
            "Humanoid",
            5
        )

    if Humanoid then
        Humanoid.UseJumpPower = true
    end
end)

--// ============================================================
--// END PART 3/4
--// ============================================================

--// ============================================================
--// RIVALS HUB 2.1
--// PART 4/4 — MOVEMENT / SETTINGS / MENU CONTROLS
--// ============================================================

--// ============================================================
--// MOVEMENT PAGE
--// ============================================================

CreateInfoCard(
    Pages.Movement,
    "Movement Controls",
    "Customize your movement and mobility."
)

CreateSection(
    Pages.Movement,
    "MOVEMENT"
)

CreateToggle(
    Pages.Movement,
    "Speed",
    "Increase your movement speed.",
    Config.SpeedEnabled,
    function(Value)
        Config.SpeedEnabled = Value
    end
)

CreateSlider(
    Pages.Movement,
    "Speed Value",
    "Choose your movement speed.",
    16,
    100,
    Config.Speed,
    function(Value)
        Config.Speed = Value
    end
)

CreateToggle(
    Pages.Movement,
    "Jump Power",
    "Increase your jump power.",
    Config.JumpEnabled,
    function(Value)
        Config.JumpEnabled = Value
    end
)

CreateSlider(
    Pages.Movement,
    "Jump Value",
    "Choose your jump power.",
    50,
    150,
    Config.Jump,
    function(Value)
        Config.Jump = Value
    end
)

CreateToggle(
    Pages.Movement,
    "Infinite Jump",
    "Jump continuously while airborne.",
    Config.InfiniteJump,
    function(Value)
        Config.InfiniteJump = Value
    end
)

CreateToggle(
    Pages.Movement,
    "Noclip",
    "Walk through physical objects.",
    Config.Noclip,
    function(Value)
        Config.Noclip = Value
    end
)

CreateToggle(
    Pages.Movement,
    "Auto Sprint",
    "Automatically increase speed while moving.",
    Config.AutoSprint,
    function(Value)
        Config.AutoSprint = Value
    end
)

--// ============================================================
--// SETTINGS PAGE
--// ============================================================

CreateInfoCard(
    Pages.Settings,
    "Interface Settings",
    "Customize the appearance and behavior of the hub."
)

CreateSection(
    Pages.Settings,
    "INTERFACE"
)

CreateToggle(
    Pages.Settings,
    "Animations",
    "Enable menu animations.",
    Config.Animations,
    function(Value)
        Config.Animations = Value
    end
)

CreateToggle(
    Pages.Settings,
    "Background Effects",
    "Show the animated background.",
    Config.BackgroundEffects,
    function(Value)
        Config.BackgroundEffects = Value
    end
)

CreateToggle(
    Pages.Settings,
    "Show Status",
    "Show the status indicator in the top bar.",
    Config.ShowStatus,
    function(Value)
        Config.ShowStatus = Value
    end
)

--// ============================================================
--// SETTINGS PAGE — COLORS
--// ============================================================

CreateSection(
    Pages.Settings,
    "ACCENT COLOR"
)

CreateDropdown(
    Pages.Settings,
    "Accent",
    "Choose the hub accent color.",
    {
        "Purple",
        "Blue",
        "Pink",
        "Cyan",
        "White"
    },
    1,
    function(Value)
        local Colors = {
            Purple = Color3.fromRGB(155, 90, 255),
            Blue = Color3.fromRGB(90, 140, 255),
            Pink = Color3.fromRGB(255, 90, 190),
            Cyan = Color3.fromRGB(80, 220, 255),
            White = Color3.fromRGB(235, 235, 245)
        }

        if Colors[Value] then
            Config.Accent = Colors[Value]
        end
    end
)

--// ============================================================
--// STATUS INDICATOR
--// ============================================================

local StatusDot = New(
    "Frame",
    TopBar,
    {
        Name = "StatusDot",
        BackgroundColor3 = Config.Accent,
        BorderSizePixel = 0,
        Size = UDim2.fromOffset(7, 7),
        Position = UDim2.new(1, -70, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ZIndex = 8
    }
)

Corner(
    StatusDot,
    999
)

local StatusText = Label(
    TopBar,
    "ONLINE",
    10,
    Config.MutedText,
    Enum.Font.GothamMedium
)

StatusText.Name = "StatusText"
StatusText.AnchorPoint = Vector2.new(1, 0.5)
StatusText.Position = UDim2.new(
    1,
    -78,
    0.5,
    0
)
StatusText.Size = UDim2.fromOffset(
    55,
    20
)
StatusText.TextXAlignment = Enum.TextXAlignment.Right
StatusText.ZIndex = 8

--// ============================================================
--// BACKGROUND EFFECT CONTROL
--// ============================================================

task.spawn(function()
    while ScreenGui.Parent do
        for _, Object in ipairs(Background:GetChildren()) do
            if Object:IsA("Frame") then
                Object.Visible = Config.BackgroundEffects
            end
        end

        task.wait(0.15)
    end
end)

--// ============================================================
--// ACCENT COLOR REFRESH
--// ============================================================

task.spawn(function()
    while ScreenGui.Parent do
        local Accent = Config.Accent

        StatusDot.BackgroundColor3 = Accent

        if FOVStroke then
            FOVStroke.Color = Accent
        end

        for _, Object in ipairs(ScreenGui:GetDescendants()) do
            if Object:IsA("UIStroke") then
                if Object.Name ~= "OuterStroke" then
                    if Object:GetAttribute("UseAccent") then
                        Object.Color = Accent
                    end
                end
            end
        end

        task.wait(0.2)
    end
end)

--// ============================================================
--// MENU STATE
--// ============================================================

local MenuOpen = true
local MenuBusy = false
local MiniDragging = false
local DragStart = nil
local StartPosition = nil

--// Mini button
local MiniButton = New(
    "TextButton",
    ScreenGui,
    {
        Name = "MiniButton",
        Text = "R",
        Font = Enum.Font.GothamBold,
        TextSize = 18,
        TextColor3 = Config.Text,
        BackgroundColor3 = Config.Background,
        BackgroundTransparency = 0.04,
        BorderSizePixel = 0,
        Size = UDim2.fromOffset(54, 54),
        Position = UDim2.new(
            0.5,
            -27,
            0.5,
            -27
        ),
        Visible = false,
        AutoButtonColor = false,
        ZIndex = 100
    }
)

Corner(
    MiniButton,
    16
)

local MiniStroke = Stroke(
    MiniButton,
    Config.Accent,
    1.5,
    0.15
)

--// ============================================================
--// DRAGGING THE MAIN MENU
--// ============================================================

local MainDragging = false
local MainDragStart = nil
local MainStartPosition = nil

TopBar.InputBegan:Connect(function(Input)
    if Input.UserInputType ~= Enum.UserInputType.MouseButton1
        and Input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    MainDragging = true
    MainDragStart = Input.Position
    MainStartPosition = Holder.Position

    Input.Changed:Connect(function()
        if Input.UserInputState == Enum.UserInputState.End then
            MainDragging = false
        end
    end)
end)

UserInputService.InputChanged:Connect(function(Input)
    if not MainDragging then
        return
    end

    if Input.UserInputType ~= Enum.UserInputType.MouseMovement
        and Input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    local Delta = Input.Position - MainDragStart

    Holder.Position = UDim2.new(
        MainStartPosition.X.Scale,
        MainStartPosition.X.Offset + Delta.X,
        MainStartPosition.Y.Scale,
        MainStartPosition.Y.Offset + Delta.Y
    )
end)

--// ============================================================
--// MINIMIZE
--// ============================================================

local function MinimizeMenu()
    if MenuBusy or not MenuOpen then
        return
    end

    MenuBusy = true
    MenuOpen = false

    local CurrentPosition = Holder.AbsolutePosition

    MiniButton.Position = UDim2.fromOffset(
        CurrentPosition.X + Holder.AbsoluteSize.X / 2 - 27,
        CurrentPosition.Y + Holder.AbsoluteSize.Y / 2 - 27
    )

    MiniButton.Visible = true

    if Config.Animations then
        local TweenInfoData = TweenInfo.new(
            Config.AnimationTime,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.InOut
        )

        local Shrink = TweenService:Create(
            Holder,
            TweenInfoData,
            {
                Size = UDim2.fromOffset(0, 0)
            }
        )

        Shrink:Play()
        Shrink.Completed:Wait()
    else
        Holder.Size = UDim2.fromOffset(0, 0)
    end

    Main.Visible = false
    MenuBusy = false
end

--// ============================================================
--// RESTORE
--// ============================================================

local function RestoreMenu()
    if MenuBusy or MenuOpen then
        return
    end

    MenuBusy = true
    MenuOpen = true

    Main.Visible = true

    if Config.Animations then
        Holder.Size = UDim2.fromOffset(0, 0)

        local Grow = TweenService:Create(
            Holder,
            TweenInfo.new(
                Config.AnimationTime,
                Enum.EasingStyle.Quint,
                Enum.EasingDirection.InOut
            ),
            {
                Size = UDim2.fromOffset(650, 455)
            }
        )

        Grow:Play()
        Grow.Completed:Wait()
    else
        Holder.Size = UDim2.fromOffset(650, 455)
    end

    MiniButton.Visible = false
    MenuBusy = false
end

--// ============================================================
--// MINI BUTTON DRAG + CLICK
--// ============================================================

MiniButton.InputBegan:Connect(function(Input)
    if Input.UserInputType ~= Enum.UserInputType.MouseButton1
        and Input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    MiniDragging = false
    DragStart = Input.Position
    StartPosition = MiniButton.Position

    local Finished = false

    local Connection

    Connection = Input.Changed:Connect(function()
        if Input.UserInputState == Enum.UserInputState.End then
            Finished = true

            if Connection then
                Connection:Disconnect()
            end

            if not MiniDragging then
                RestoreMenu()
            end
        end
    end)

    local MoveConnection

    MoveConnection = UserInputService.InputChanged:Connect(function(Change)
        if Finished then
            if MoveConnection then
                MoveConnection:Disconnect()
            end
            return
        end

        if Change.UserInputType ~= Enum.UserInputType.MouseMovement
            and Change.UserInputType ~= Enum.UserInputType.Touch then
            return
        end

        local Delta = Change.Position - DragStart

        if math.abs(Delta.X) > 5
            or math.abs(Delta.Y) > 5 then

            MiniDragging = true

            MiniButton.Position = UDim2.new(
                StartPosition.X.Scale,
                StartPosition.X.Offset + Delta.X,
                StartPosition.Y.Scale,
                StartPosition.Y.Offset + Delta.Y
            )
        end
    end)
end)

--// ============================================================
--// CLOSE MENU
--// ============================================================

local function CloseMenu()
    if MenuBusy then
        return
    end

    MenuBusy = true

    if Config.Animations then
        local CloseTween = TweenService:Create(
            Holder,
            TweenInfo.new(
                Config.AnimationTime * 0.8,
                Enum.EasingStyle.Quint,
                Enum.EasingDirection.In
            ),
            {
                Size = UDim2.fromOffset(0, 0)
            }
        )

        CloseTween:Play()
        CloseTween.Completed:Wait()
    end

    Config.MenuDestroyed = true

    if ScreenGui then
        ScreenGui:Destroy()
    end
end

--// ============================================================
--// TOP BAR BUTTONS
--// ============================================================

MinimizeButton.Activated:Connect(function()
    MinimizeMenu()
end)

CloseButton.Activated:Connect(function()
    CloseMenu()
end)

--// ============================================================
--// RIGHT SHIFT — MINIMIZE / RESTORE
--// ============================================================

UserInputService.InputBegan:Connect(function(Input, GameProcessed)
    if GameProcessed then
        return
    end

    if Input.KeyCode == Enum.KeyCode.RightShift then
        if MenuOpen then
            MinimizeMenu()
        else
            RestoreMenu()
        end
    end
end)

--// ============================================================
--// PAGE BUTTON ACCENT REFRESH
--// ============================================================

task.spawn(function()
    while ScreenGui.Parent do
        for PageName, Button in pairs(PageButtons) do
            if CurrentPage == PageName then
                Button.BackgroundColor3 = Config.Accent
                Button.TextColor3 = Color3.fromRGB(
                    255,
                    255,
                    255
                )
            else
                Button.BackgroundColor3 = Color3.fromRGB(
                    255,
                    255,
                    255
                )

                Button.BackgroundTransparency = 1

                Button.TextColor3 = Config.MutedText
            end
        end

        MiniStroke.Color = Config.Accent
        MiniButton.TextColor3 = Config.Text

        task.wait(0.2)
    end
end)

--// ============================================================
--// PAGE OPEN ANIMATION
--// ============================================================

for PageName, Page in pairs(Pages) do
    Page.Visible = PageName == CurrentPage
end

--// ============================================================
--// INITIAL STATE
--// ============================================================

Main.Visible = true
MiniButton.Visible = false
Holder.Visible = true
Holder.Size = UDim2.fromOffset(650, 455)

--// ============================================================
--// FINAL SAFETY
--// ============================================================

task.spawn(function()
    while ScreenGui.Parent do
        if Config.MenuDestroyed then
            break
        end

        if StatusDot then
            StatusDot.BackgroundColor3 = Config.Accent
        end

        if StatusText then
            StatusText.Visible = Config.ShowStatus
        end

        task.wait(0.25)
    end
end)

--// ============================================================
--// RIVALS HUB 2.1 — COMPLETE
--// ============================================================
