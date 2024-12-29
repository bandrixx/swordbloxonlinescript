local allowedGameId = 4733278992

if game.PlaceId ~= allowedGameId and not table.find(game:GetService("AssetService"):GetLocalAssociatedGamePlaces(), allowedGameId) then
    warn("This script can only be used in Sword Blox Online Rebirth.")
    return
end

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local FarmButton = Instance.new("TextButton")
local AuraButton = Instance.new("TextButton")
local InfiniteButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local Notification = Instance.new("TextLabel")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "CustomScriptUI"

Frame.Parent = ScreenGui
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0

local function configureButton(button, text, position)
    button.Parent = Frame
    button.Size = UDim2.new(0.8, 0, 0.2, 0)
    button.Position = position
    button.Text = text
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 20
end

configureButton(FarmButton, "Farm", UDim2.new(0.1, 0, 0.1, 0))
configureButton(AuraButton, "Aura", UDim2.new(0.1, 0, 0.4, 0))
configureButton(InfiniteButton, "Infinite", UDim2.new(0.1, 0, 0.7, 0))

CloseButton.Parent = Frame
CloseButton.Size = UDim2.new(0.2, 0, 0.2, 0)
CloseButton.Position = UDim2.new(0.8, -30, 0, 10)
CloseButton.Text = "X"
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Font = Enum.Font.SourceSans
CloseButton.TextSize = 20

Notification.Parent = ScreenGui
Notification.AnchorPoint = Vector2.new(0.5, 1)
Notification.Position = UDim2.new(0.5, 0, 0.9, 0)
Notification.Size = UDim2.new(0, 400, 0, 50)
Notification.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Notification.TextColor3 = Color3.new(1, 1, 1)
Notification.Text = "Press K to reopen the menu."
Notification.Font = Enum.Font.SourceSans
Notification.TextSize = 16
Notification.Visible = false

local function showNotification(text)
    Notification.Text = text
    Notification.Visible = true
    task.delay(3, function()
        Notification.Visible = false
    end)
end

local function enableFarm()
    showNotification("Farm mode activated: Killing entities (boars, bosses) without moving.")
    while true do
        task.wait(0.5)
        for _, mob in pairs(workspace:GetDescendants()) do
            if mob:IsA("Model") and mob:FindFirstChild("Humanoid") then
                local rootPart = mob:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = rootPart.CFrame
                    task.wait(0.5)
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                end
            end
        end
    end
end

local function enableAura()
    showNotification("Aura mode activated: Kill Aura and Aim Assist enabled.")
    spawn(function()
        while true do
            task.wait(0.1)
            for _, mob in pairs(workspace:GetDescendants()) do
                if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
                    if (mob.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude < 10 then
                        game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                        game.Players.LocalPlayer.Character.Humanoid.Jump = true
                    end
                end
            end
        end
    end)

    local aimAssistGui = Instance.new("TextLabel")
    aimAssistGui.Parent = ScreenGui
    aimAssistGui.Text = "⭐ Aim Assist Enabled ⭐\nGo in first person or shift lock for better experience."
    aimAssistGui.Size = UDim2.new(0, 300, 0, 100)
    aimAssistGui.Position = UDim2.new(0.5, -150, 0.7, 0)
    aimAssistGui.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    aimAssistGui.TextColor3 = Color3.new(1, 1, 1)
    aimAssistGui.TextSize = 16
    task.wait(5)
    aimAssistGui:Destroy()
end

local function enableInfinite()
    showNotification("Infinite stamina and health activated!")
    spawn(function()
        while true do
            task.wait(1)
            local player = game.Players.LocalPlayer
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.MaxHealth = math.huge
                player.Character.Humanoid.Health = math.huge
                if player.Character:FindFirstChild("Stamina") then
                    player.Character.Stamina.Value = math.huge
                end
            end
        end
    end)
end

FarmButton.MouseButton1Click:Connect(enableFarm)
AuraButton.MouseButton1Click:Connect(enableAura)
InfiniteButton.MouseButton1Click:Connect(enableInfinite)
CloseButton.MouseButton1Click:Connect(function()
    Frame.Visible = false
    showNotification("Press K to reopen the menu.")
end)

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.K then
        Frame.Visible = not Frame.Visible
    end
end)
