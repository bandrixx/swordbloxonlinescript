-- URL of the allowed game
local allowedGameId = 4733278992
local currentGameId = game.PlaceId

-- Check if the script is executed in the correct game
if currentGameId ~= allowedGameId then
    game.Players.LocalPlayer:Kick("This script only works in the correct game: Sword Blox Online Rebirth.")
    return
end

-- Create the frame and set background color to RGB(10, 10, 10)
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 300)  -- Adjust size to fit the content
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)  -- Center the frame
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)  -- Set background color to RGB(10, 10, 10)
mainFrame.Parent = screenGui

-- Create the farm section
local farmSection = Instance.new("TextLabel")
farmSection.Size = UDim2.new(0, 400, 0, 50)
farmSection.Position = UDim2.new(0, 0, 0, 0)
farmSection.BackgroundTransparency = 1
farmSection.Text = "Farm"
farmSection.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text
farmSection.TextSize = 24
farmSection.TextBold = true
farmSection.Parent = mainFrame

-- Create toggle buttons for Farm options
local farmBoarsToggleButton = Instance.new("TextButton")
farmBoarsToggleButton.Size = UDim2.new(0, 200, 0, 50)
farmBoarsToggleButton.Position = UDim2.new(0, 0, 0, 50)
farmBoarsToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Red when OFF
farmBoarsToggleButton.Text = "Farm Boars (OFF)"
farmBoarsToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text
farmBoarsToggleButton.TextSize = 18
farmBoarsToggleButton.Parent = mainFrame

-- Create toggle for Aim Assist
local aimAssistToggleButton = Instance.new("TextButton")
aimAssistToggleButton.Size = UDim2.new(0, 200, 0, 50)
aimAssistToggleButton.Position = UDim2.new(0, 0, 0, 150)
aimAssistToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Red when OFF
aimAssistToggleButton.Text = "Aim Assist (OFF)"
aimAssistToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text
aimAssistToggleButton.TextSize = 18
aimAssistToggleButton.Parent = mainFrame

-- Create toggle for Kill Aura
local killAuraToggleButton = Instance.new("TextButton")
killAuraToggleButton.Size = UDim2.new(0, 200, 0, 50)
killAuraToggleButton.Position = UDim2.new(0, 0, 0, 200)
killAuraToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Red when OFF
killAuraToggleButton.Text = "Kill Aura (OFF)"
killAuraToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text
killAuraToggleButton.TextSize = 18
killAuraToggleButton.Parent = mainFrame

-- Toggle logic for buttons
local function toggleButton(button, toggleState)
    if toggleState then
        button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- White when ON
        button.Text = button.Text:match("(.*) %(OFF%)") .. " (ON)"
    else
        button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Red when OFF
        button.Text = button.Text:match("(.*) %(ON%)") .. " (OFF)"
    end
end

local killAuraToggle = false
local aimAssistToggle = false

-- Function to get closest entity
local function getClosestEntity()
    local closestEntity = nil
    local shortestDistance = math.huge  -- Set a high initial value
    local player = game.Players.LocalPlayer
    local humanoids = game.Workspace:GetChildren()

    for _, entity in ipairs(humanoids) do
        if entity:IsA("Model") and entity:FindFirstChild("Humanoid") then
            local humanoid = entity.Humanoid
            local distance = (entity.PrimaryPart.Position - player.Character.HumanoidRootPart.Position).magnitude
            if distance < shortestDistance then
                closestEntity = entity
                shortestDistance = distance
            end
        end
    end
    return closestEntity
end

-- Kill Aura function
local function activateKillAura()
    while killAuraToggle do
        local target = getClosestEntity()
        if target then
            -- Perform the kill action here (this is just a placeholder)
            print("Kill Aura Target: " .. target.Name)
            -- You can simulate attacking or performing an action here
        end
        wait(1)  -- Delay between each kill check
    end
end

-- Aim Assist function (to track and aim at entities)
local function activateAimAssist()
    while aimAssistToggle do
        local target = getClosestEntity()
        if target then
            -- Simulate aiming at the closest entity (this is a placeholder)
            print("Aim Assist Target: " .. target.Name)
            -- You can add logic to aim towards the entity or use some other in-game mechanics to track
        end
        wait(0.1)  -- Update the tracking every 0.1 seconds
    end
end

-- Connect the toggles to the respective functions
farmBoarsToggleButton.MouseButton1Click:Connect(function()
    farmBoarsToggle = not farmBoarsToggle
    toggleButton(farmBoarsToggleButton, farmBoarsToggle)
end)

aimAssistToggleButton.MouseButton1Click:Connect(function()
    aimAssistToggle = not aimAssistToggle
    toggleButton(aimAssistToggleButton, aimAssistToggle)
    if aimAssistToggle then
        activateAimAssist()  -- Start the aim assist if enabled
    end
end)

killAuraToggleButton.MouseButton1Click:Connect(function()
    killAuraToggle = not killAuraToggle
    toggleButton(killAuraToggleButton, killAuraToggle)
    if killAuraToggle then
        activateKillAura()  -- Start the kill aura if enabled
    end
end)
