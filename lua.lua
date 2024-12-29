-- DO NOT COPY THIS CODE IF YOU WANT TO COPY AND MAKE ANY CHANGES

if game.PlaceId ~= 4733278992 and not table.find(game:GetService("AssetService"):GetPlaceIdAssociatedGamePlaces(4733278992), game.PlaceId) then
    warn("This script is not compatible with this game.")
    return
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HumanoidRootPart = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
local Workspace = game:GetService("Workspace")

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local FarmButton = Instance.new("TextButton")
local AuraButton = Instance.new("TextButton")
local InfiniteButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local Notification = Instance.new("Frame")
local NotificationText = Instance.new("TextLabel")

ScreenGui.Name = "ExecutorScriptUI"
ScreenGui.Parent = game.CoreGui

Frame.Name = "MainFrame"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Size = UDim2.new(0.3, 0, 0.5, 0)
Frame.Position = UDim2.new(0.35, 0, 0.25, 0)

local buttons = {
    {FarmButton, "Farm", 0.1},
    {AuraButton, "Aura", 0.4},
    {InfiniteButton, "Infinite", 0.7},
}

for _, btn in pairs(buttons) do
    local button, text, pos = unpack(btn)
    button.Parent = Frame
    button.Size = UDim2.new(0.6, 0, 0.15, 0)
    button.Position = UDim2.new(0.2, 0, pos, 0)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
end

CloseButton.Name = "CloseButton"
CloseButton.Parent = Frame
CloseButton.Size = UDim2.new(0.1, 0, 0.1, 0)
CloseButton.Position = UDim2.new(0.9, -10, 0, 10)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)

Notification.Name = "Notification"
Notification.Parent = ScreenGui
Notification.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Notification.Size = UDim2.new(0.4, 0, 0.2, 0)
Notification.Position = UDim2.new(0.3, 0, 0.7, 0)
Notification.Visible = false

NotificationText.Name = "NotificationText"
NotificationText.Parent = Notification
NotificationText.Size = UDim2.new(1, 0, 1, 0)
NotificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
NotificationText.TextWrapped = true
NotificationText.Font = Enum.Font.SourceSans
NotificationText.TextSize = 24

local function showNotification(text)
    Notification.Visible = true
    NotificationText.Text = text
    wait(3)
    Notification.Visible = false
end

local farming = false
FarmButton.MouseButton1Click:Connect(function()
    farming = not farming
    if farming then
        showNotification("Auto Farm Enabled")
        while farming and wait() do

            HumanoidRootPart.CFrame = CFrame.new(0, -50, 0)

            for _, entity in pairs(Workspace:GetDescendants()) do
                if entity:FindFirstChild("Humanoid") and entity:FindFirstChild("HumanoidRootPart") then
                    entity.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame
                    fireclickdetector(entity.ClickDetector)
                end
            end
        end
    else
        showNotification("Auto Farm Disabled")
    end
end)

local aimAssist = false
local killAura = false
AuraButton.MouseButton1Click:Connect(function()
    aimAssist = not aimAssist
    killAura = not killAura
    if aimAssist or killAura then
        showNotification("Aura Enabled (Aim Assist + Kill Aura)")
        while (aimAssist or killAura) and wait() do

            local nearest = nil
            local nearestDistance = math.huge
            for _, entity in pairs(Workspace:GetDescendants()) do
                if entity:FindFirstChild("Humanoid") and entity:FindFirstChild("HumanoidRootPart") then
                    local distance = (HumanoidRootPart.Position - entity.HumanoidRootPart.Position).Magnitude
                    if distance < nearestDistance then
                        nearest = entity
                        nearestDistance = distance
                    end
                end
            end
            if nearest then
                if aimAssist then
                    -- Track entity
                    HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, nearest.HumanoidRootPart.Position)
                end
                if killAura and nearestDistance < 10 then
                    -- Jump and attack
                    LocalPlayer.Character.Humanoid.Jump = true
                    fireclickdetector(nearest.ClickDetector)
                end
            end
        end
    else
        showNotification("Aura Disabled")
    end
end)

local infiniteEnabled = false
InfiniteButton.MouseButton1Click:Connect(function()
    infiniteEnabled = not infiniteEnabled
    if infiniteEnabled then
        showNotification("Infinite Mode Enabled")
        LocalPlayer.Character.Humanoid.MaxHealth = math.huge
        LocalPlayer.Character.Humanoid.Health = math.huge
        LocalPlayer.Character.Humanoid.WalkSpeed = 50
        LocalPlayer.Character.Humanoid.JumpPower = 100
    else
        showNotification("Infinite Mode Disabled")
        LocalPlayer.Character.Humanoid.MaxHealth = 100
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
        LocalPlayer.Character.Humanoid.JumpPower = 50
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false
    showNotification("Press K to reopen the menu.")
end)

game:GetService("UserInputService").InputBegan:Connect(function(input, isProcessed)
    if isProcessed then return end
    if input.KeyCode == Enum.KeyCode.K then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)
