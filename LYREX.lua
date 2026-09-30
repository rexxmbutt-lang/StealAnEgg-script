--==================================================
-- S SCRIPT CLIENT
-- Taruh di StarterPlayerScripts
--==================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local remotes = ReplicatedStorage:WaitForChild("SScriptRemotes")
local actionRemote = remotes:WaitForChild("Action")

--==================================================
-- GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "SScript"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 620, 0, 420)
main.Position = UDim2.new(0.5, -310, 0.5, -210)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 25)
main.BorderSizePixel = 0
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = main

--==================================================
-- GALAXY BACKGROUND
--==================================================

local background = Instance.new("ImageLabel")
background.Size = UDim2.fromScale(1, 1)
background.BackgroundTransparency = 1
background.Image = "rbxassetid://YOUR_GALAXY_IMAGE_ID"
background.ScaleType = Enum.ScaleType.Crop
background.ImageTransparency = 0.25
background.Parent = main

local bgCorner = Instance.new("UICorner")
bgCorner.CornerRadius = UDim.new(0, 14)
bgCorner.Parent = background

local overlay = Instance.new("Frame")
overlay.Size = UDim2.fromScale(1, 1)
overlay.BackgroundColor3 = Color3.fromRGB(5, 5, 20)
overlay.BackgroundTransparency = 0.18
overlay.BorderSizePixel = 0
overlay.Parent = main

local overlayCorner = Instance.new("UICorner")
overlayCorner.CornerRadius = UDim.new(0, 14)
overlayCorner.Parent = overlay

--==================================================
-- TITLE
--==================================================

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -70, 0, 45)
title.Position = UDim2.new(0, 18, 0, 8)
title.BackgroundTransparency = 1
title.Text = "S Script"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextSize = 27
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = overlay

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -70, 0, 20)
subtitle.Position = UDim2.new(0, 19, 0, 43)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Universal Game Hub"
subtitle.TextColor3 = Color3.fromRGB(170,170,190)
subtitle.TextSize = 12
subtitle.Font = Enum.Font.Gotham
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = overlay

--==================================================
-- CLOSE
--==================================================

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 35, 0, 35)
close.Position = UDim2.new(1, -48, 0, 12)
close.BackgroundColor3 = Color3.fromRGB(45, 30, 50)
close.Text = "×"
close.TextColor3 = Color3.fromRGB(255,255,255)
close.TextSize = 22
close.Font = Enum.Font.GothamBold
close.Parent = overlay

Instance.new("UICorner", close).CornerRadius = UDim.new(0, 8)

close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

--==================================================
-- SIDEBAR
--==================================================

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 145, 1, -80)
sidebar.Position = UDim2.new(0, 15, 0, 70)
sidebar.BackgroundColor3 = Color3.fromRGB(10,10,25)
sidebar.BackgroundTransparency = 0.1
sidebar.BorderSizePixel = 0
sidebar.Parent = overlay

Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 10)

local tabsContainer = Instance.new("Frame")
tabsContainer.Size = UDim2.new(1, -14, 1, -14)
tabsContainer.Position = UDim2.new(0, 7, 0, 7)
tabsContainer.BackgroundTransparency = 1
tabsContainer.Parent = sidebar

local tabsLayout = Instance.new("UIListLayout")
tabsLayout.Padding = UDim.new(0, 8)
tabsLayout.Parent = tabsContainer

--==================================================
-- CONTENT
--==================================================

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -180, 1, -80)
content.Position = UDim2.new(0, 170, 0, 70)
content.BackgroundColor3 = Color3.fromRGB(8,8,20)
content.BackgroundTransparency = 0.08
content.BorderSizePixel = 0
content.Parent = overlay

Instance.new("UICorner", content).CornerRadius = UDim.new(0, 10)

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -20, 1, -20)
scroll.Position = UDim2.new(0, 10, 0, 10)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 4
scroll.Parent = content

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 7)
layout.Parent = scroll

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	scroll.CanvasSize = UDim2.new(
		0,
		0,
		0,
		layout.AbsoluteContentSize.Y + 15
	)
end)

--==================================================
-- STATE
--==================================================

local state = {
	AutoFarm = false,

	AntiHitGuard = false,
	AntiHitBattle = false,
	AntiAFK = false,
	AntiTrap = false,

	AutoStealSecret = false,
	AutoStealEternal = false,
	AutoStealDivine = false,

	ESPEgg = false,
	ESPPlayer = false,
	ESPHitbox = false,
	ESPSkeleton = false,

	AutoTreadmill = false,
	AutoEggEternal = false,
	AutoEggDivine = false,
	AntiDisconnect = false,
}

--==================================================
-- TOGGLE
--==================================================

local function createToggle(text, key, callback)

	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, -4, 0, 42)
	button.BackgroundColor3 = Color3.fromRGB(25,25,45)
	button.BorderSizePixel = 0
	button.Text = ""
	button.AutoButtonColor = false
	button.Parent = scroll

	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -80, 1, 0)
	label.Position = UDim2.new(0, 12, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(235,235,245)
	label.TextSize = 14
	label.Font = Enum.Font.Gotham
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = button

	local status = Instance.new("TextLabel")
	status.Size = UDim2.new(0, 55, 0, 25)
	status.Position = UDim2.new(1, -65, 0.5, -12)
	status.BackgroundColor3 = Color3.fromRGB(55,55,75)
	status.Text = "OFF"
	status.TextColor3 = Color3.fromRGB(190,190,200)
	status.TextSize = 12
	status.Font = Enum.Font.GothamBold
	status.Parent = button

	Instance.new("UICorner", status).CornerRadius = UDim.new(0, 7)

	local function refresh()

		if state[key] then
			status.Text = "ON"
			status.BackgroundColor3 = Color3.fromRGB(70,120,255)
			status.TextColor3 = Color3.fromRGB(255,255,255)
		else
			status.Text = "OFF"
			status.BackgroundColor3 = Color3.fromRGB(55,55,75
