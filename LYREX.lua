--[[
    REXX SCRIPT - Steal An Egg
    Delta Executor Compatible
    Theme: Green + White
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--// Config
local Config = {
    Theme = {
        Main = Color3.fromRGB(255, 255, 255),
        Accent = Color3.fromRGB(0, 200, 80),
        AccentDark = Color3.fromRGB(0, 150, 60),
        Text = Color3.fromRGB(30, 30, 30),
        TextLight = Color3.fromRGB(255, 255, 255),
        ToggleOn = Color3.fromRGB(0, 200, 80),
        ToggleOff = Color3.fromRGB(180, 180, 180),
        TabSelected = Color3.fromRGB(0, 180, 70),
        TabUnselected = Color3.fromRGB(240, 240, 240),
    },
    Links = {
        Discord = "https://discord.gg/XFu7NvmFj",
        WA1 = "https://whatsapp.com/channel/0029Vb8btgUEawdxyjZ8hF1J",
        WA2 = "https://whatsapp.com/channel/0029VbD6xItEgGfHYgbJrM3h",
    }
}

--// State
local Toggles = {
    AutoFarm = false,
    AntiHitGuard = false,
    AntiHit = false,
    AntiAFK = false,
    AntiTrap = false,
    AutoStealSecret = false,
    AutoStealEternal = false,
    AutoStealDivine = false,
    AutoHatch = false,
    BatAura = false,
    ESPEgg = false,
    ESPPlayer = false,
    ESPHitbox = false,
    ESPSkeleton = false,
    AutoTreadmill = false,
    AutoStealEggEternal = false,
    AutoStealEggDivine = false,
    AntiDisconnect = false,
    FPSBoost = false,
    NoShadow = false,
    NoEffect = false,
}

local ESPColor = Color3.fromRGB(0, 255, 100)
local Minimized = false
local CurrentTab = "Home"

--// Cleanup old UI
if CoreGui:FindFirstChild("RexxScriptUI") then
    CoreGui.RexxScriptUI:Destroy()
end
if CoreGui:FindFirstChild("RexxMiniLogo") then
    CoreGui.RexxMiniLogo:Destroy()
end

--// Main ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RexxScriptUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

--// Main Frame
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 480, 0, 360)
Main.Position = UDim2.new(0.5, -240, 0.5, -180)
Main.BackgroundColor3 = Config.Theme.Main
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Config.Theme.Accent
MainStroke.Thickness = 2.5
MainStroke.Parent = Main

--// Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 38)
TitleBar.BackgroundColor3 = Config.Theme.Accent
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Main

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local TitleFix = Instance.new("Frame")
TitleFix.Size = UDim2.new(1, 0, 0, 12)
TitleFix.Position = UDim2.new(0, 0, 1, -12)
TitleFix.BackgroundColor3 = Config.Theme.Accent
TitleFix.BorderSizePixel = 0
TitleFix.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -90, 1, 0)
Title.Position = UDim2.new(0, 14, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "REXX SCRIPT  |  STEAL AN EGG"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.TextColor3 = Config.Theme.TextLight
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Minimize Button (-)
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 32, 0, 28)
MinBtn.Position = UDim2.new(1, -70, 0.5, -14)
MinBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Text = "-"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 20
MinBtn.TextColor3 = Config.Theme.AccentDark
MinBtn.Parent = TitleBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinBtn

-- Close Button (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 32, 0, 28)
CloseBtn.Position = UDim2.new(1, -34, 0.5, -14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

--// Tab Bar
local TabBar = Instance.new("Frame")
TabBar.Name = "TabBar"
TabBar.Size = UDim2.new(1, -20, 0, 34)
TabBar.Position = UDim2.new(0, 10, 0, 46)
TabBar.BackgroundTransparency = 1
TabBar.Parent = Main

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Padding = UDim.new(0, 6)
TabLayout.Parent = TabBar

local Tabs = {"Home", "Fitur", "ESP", "AutoFarm", "Boost"}
local TabButtons = {}
local ContentFrames = {}

for _, name in ipairs(Tabs) do
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0, 84, 1, 0)
    btn.BackgroundColor3 = Config.Theme.TabUnselected
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.TextColor3 = Config.Theme.Text
    btn.Parent = TabBar

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    TabButtons[name] = btn

    local content = Instance.new("ScrollingFrame")
    content.Name = name .. "Content"
    content.Size = UDim2.new(1, -20, 1, -95)
    content.Position = UDim2.new(0, 10, 0, 88)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.ScrollBarThickness = 4
    content.ScrollBarImageColor3 = Config.Theme.Accent
    content.CanvasSize = UDim2.new(0, 0, 0, 0)
    content.Visible = false
    content.Parent = Main

    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0, 8)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Parent = content

    ContentFrames[name] = content
end

--// Helper: Create Section Title
local function CreateSection(parent, text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 22)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 14
    lbl.TextColor3 = Config.Theme.AccentDark
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = parent
    return lbl
end

--// Helper: Create Toggle
local function CreateToggle(parent, name, key, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 36)
    frame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
    frame.BorderSizePixel = 0
    frame.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -60, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.TextColor3 = Config.Theme.Text
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 44, 0, 22)
    toggle.Position = UDim2.new(1, -52, 0.5, -11)
    toggle.BackgroundColor3 = Config.Theme.ToggleOff
    toggle.Text = ""
    toggle.Parent = frame

    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(1, 0)
    tCorner.Parent = toggle

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 18, 0, 18)
    circle.Position = UDim2.new(0, 2, 0.5, -9)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.BorderSizePixel = 0
    circle.Parent = toggle

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(1, 0)
    cCorner.Parent = circle

    local function UpdateVisual(state)
        if state then
            toggle.BackgroundColor3 = Config.Theme.ToggleOn
            TweenService:Create(circle, TweenInfo.new(0.15), {Position = UDim2.new(1, -20, 0.5, -9)}):Play()
        else
            toggle.BackgroundColor3 = Config.Theme.ToggleOff
            TweenService:Create(circle, TweenInfo.new(0.15), {Position = UDim2.new(0, 2, 0.5, -9)}):Play()
        end
    end

    toggle.MouseButton1Click:Connect(function()
        Toggles[key] = not Toggles[key]
        UpdateVisual(Toggles[key])
        if callback then callback(Toggles[key]) end
    end)

    UpdateVisual(Toggles[key])
    return frame
end

--// Helper: Create Button
local function CreateButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.BackgroundColor3 = Config.Theme.Accent
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.TextColor3 = Config.Theme.TextLight
    btn.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(callback)
    return btn
end

--==================== HOME TAB ====================
do
    local content = ContentFrames["Home"]
    CreateSection(content, "JOIN COMMUNITY")
    CreateButton(content, "Join Discord", function()
        setclipboard(Config.Links.Discord)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "REXX SCRIPT",
            Text = "Discord link copied!",
            Duration = 3
        })
    end)
    CreateButton(content, "Join WhatsApp Channel 1", function()
        setclipboard(Config.Links.WA1)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "REXX SCRIPT",
            Text = "WA Channel 1 copied!",
            Duration = 3
        })
    end)
    CreateButton(content, "Join WhatsApp Channel 2", function()
        setclipboard(Config.Links.WA2)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "REXX SCRIPT",
            Text = "WA Channel 2 copied!",
            Duration = 3
        })
    end)

    CreateSection(content, "SERVER")
    CreateButton(content, "Server Hop", function()
        local PlaceId = game.PlaceId
        local JobId = game.JobId
        local success, servers = pcall(function()
            return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        end)
        if success and servers and servers.data then
            for _, server in ipairs(servers.data) do
                if server.id \~= JobId and server.playing < server.maxPlayers then
                    TeleportService:TeleportToPlaceInstance(PlaceId, server.id, LocalPlayer)
                    break
                end
            end
        end
    end)
    CreateButton(content, "Auto Join Private Server (Sepi)", function()
        -- Mencari server dengan player paling sedikit
        local PlaceId = game.PlaceId
        local success, servers = pcall(function()
            return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        end)
        if success and servers and servers.data then
            table.sort(servers.data, function(a, b) return a.playing < b.playing end)
            for _, server in ipairs(servers.data) do
                if server.playing <= 5 and server.id \~= game.JobId then
                    TeleportService:TeleportToPlaceInstance(PlaceId, server.id, LocalPlayer)
                    break
                end
            end
        end
    end)
end

--==================== FITUR TAB ====================
do
    local content = ContentFrames["Fitur"]
    CreateSection(content, "MAIN FEATURES")
    CreateToggle(content, "Auto Farm", "AutoFarm")
    CreateToggle(content, "Anti Hit Guard", "AntiHitGuard")
    CreateToggle(content, "Anti Hit", "AntiHit")
    CreateToggle(content, "Anti AFK", "AntiAFK", function(state)
        if state then
            LocalPlayer.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end
    end)
    CreateToggle(content, "Anti Trap", "AntiTrap")
    CreateToggle(content, "Auto Steal Secret", "AutoStealSecret")
    CreateToggle(content, "Auto Steal Eternal", "AutoStealEternal")
    CreateToggle(content, "Auto Steal Divine", "AutoStealDivine")
    CreateToggle(content, "Auto Hatch Egg", "AutoHatch")
    CreateToggle(content, "Bat Aura", "BatAura")
end

--==================== ESP TAB ====================
do
    local content = ContentFrames["ESP"]
    CreateSection(content, "ESP OPTIONS")
    CreateToggle(content, "ESP Egg", "ESPEgg")
    CreateToggle(content, "ESP Player", "ESPPlayer")
    CreateToggle(content, "ESP Hitbox", "ESPHitbox")
    CreateToggle(content, "ESP Skeleton", "ESPSkeleton")

    CreateSection(content, "ESP COLOR")
    local colorBtn = CreateButton(content, "Set Color ESP (Green)", function()
        ESPColor = Color3.fromRGB(0, 255, 100)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "REXX SCRIPT",
            Text = "ESP Color set to Green",
            Duration = 2
        })
    end)
end

--==================== AUTOFARM TAB ====================
do
    local content = ContentFrames["AutoFarm"]
    CreateSection(content, "AUTO FARM")
    CreateToggle(content, "Auto Treadmill", "AutoTreadmill")
    CreateToggle(content, "Auto Steal Egg Eternal", "AutoStealEggEternal")
    CreateToggle(content, "Auto Steal Egg Divine", "AutoStealEggDivine")
    CreateToggle(content, "Anti AFK", "AntiAFK")
    CreateToggle(content, "Anti Disconnect", "AntiDisconnect")
end

--==================== BOOST TAB ====================
do
    local content = ContentFrames["Boost"]
    CreateSection(content, "PERFORMANCE BOOST")
    CreateToggle(content, "FPS Boost (Grafik Burik)", "FPSBoost", function(state)
        if state then
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            for _, v in pairs(Lighting:GetChildren()) do
                if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("BloomEffect") or v:IsA("ColorCorrectionEffect") then
                    v.Enabled = false
                end
            end
        else
            settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        end
    end)
    CreateToggle(content, "No Shadow", "NoShadow", function(state)
        Lighting.GlobalShadows = not state
    end)
    CreateToggle(content, "No Effect", "NoEffect", function(state)
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") then
                v.Enabled = not state
            end
        end
    end)
end

-- Update CanvasSize
for _, content in pairs(ContentFrames) do
    local list = content:FindFirstChildOfClass("UIListLayout")
    if list then
        list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            content.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y + 10)
        end)
        content.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y + 10)
    end
end

--// Tab Switching
local function SwitchTab(name)
    CurrentTab = name
    for n, btn in pairs(TabButtons) do
        if n == name then
            btn.BackgroundColor3 = Config.Theme.TabSelected
            btn.TextColor3 = Config.Theme.TextLight
            ContentFrames[n].Visible = true
        else
            btn.BackgroundColor3 = Config.Theme.TabUnselected
            btn.TextColor3 = Config.Theme.Text
            ContentFrames[n].Visible = false
        end
    end
end

for name, btn in pairs(TabButtons) do
    btn.MouseButton1Click:Connect(function()
        SwitchTab(name)
    end)
end
SwitchTab("Home")

--// Minimize Logo (seperti logo yang kamu kirim)
local MiniGui = Instance.new("ScreenGui")
MiniGui.Name = "RexxMiniLogo"
MiniGui.ResetOnSpawn = false
MiniGui.Enabled = false
MiniGui.Parent = CoreGui

local MiniBtn = Instance.new("ImageButton")
MiniBtn.Name = "Logo"
MiniBtn.Size = UDim2.new(0, 70, 0, 70)
MiniBtn.Position = UDim2.new(0, 20, 0.5, -35)
MiniBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MiniBtn.Image = "" -- kosong, kita pakai text + design
MiniBtn.Parent = MiniGui

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(0, 12)
MiniCorner.Parent = MiniBtn

local MiniStroke = Instance.new("UIStroke")
MiniStroke.Color = Config.Theme.Accent
MiniStroke.Thickness = 2.5
MiniStroke.Parent = MiniBtn

local MiniIcon = Instance.new("TextLabel")
MiniIcon.Size = UDim2.new(1, 0, 0.6, 0)
MiniIcon.Position = UDim2.new(0, 0, 0.05, 0)
MiniIcon.BackgroundTransparency = 1
MiniIcon.Text = "Δ"
MiniIcon.Font = Enum.Font.GothamBold
MiniIcon.TextSize = 28
MiniIcon.TextColor3 = Config.Theme.Accent
MiniIcon.Parent = MiniBtn

local MiniText = Instance.new("TextLabel")
MiniText.Size = UDim2.new(1, 0, 0.35, 0)
MiniText.Position = UDim2.new(0, 0, 0.6, 0)
MiniText.BackgroundTransparency = 1
MiniText.Text = "REXX"
MiniText.Font = Enum.Font.GothamBold
MiniText.TextSize = 11
MiniText.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniText.Parent = MiniBtn

--// Minimize / Restore
MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    MiniGui.Enabled = true
    Minimized = true
end)

MiniBtn.MouseButton1Click:Connect(function()
    Main.Visible = true
    MiniGui.Enabled = false
    Minimized = false
end)

--// Close
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    MiniGui:Destroy()
end)

--// Drag Main
local dragging, dragInput, dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

--// Drag Mini Logo
local mDragging, mDragInput, mDragStart, mStartPos
MiniBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        mDragging = true
        mDragStart = input.Position
        mStartPos = MiniBtn.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                mDragging = false
            end
        end)
    end
end)
MiniBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        mDragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == mDragInput and mDragging then
        local delta = input.Position - mDragStart
        MiniBtn.Position = UDim2.new(mStartPos.X.Scale, mStartPos.X.Offset + delta.X, mStartPos.Y.Scale, mStartPos.Y.Offset + delta.Y)
    end
end)

-- Notification
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "REXX SCRIPT",
    Text = "Script loaded! Theme: Green + White",
    Duration = 4
})

print("REXX SCRIPT | Steal An Egg loaded successfully!")
