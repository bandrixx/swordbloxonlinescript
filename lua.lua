-- ENTIRE SOURCE CODE IN THIS CODE HERE! CREDIT IF WANNA REMAKE.


-- Create a ScreenGui for the UI elements
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create the main frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 250)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)  -- Center the frame
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)  -- Set background color to RGB(10, 10, 10)
mainFrame.Parent = screenGui

-- Create the Farm section label
local farmLabel = Instance.new("TextLabel")
farmLabel.Size = UDim2.new(0, 150, 0, 40)
farmLabel.Position = UDim2.new(0, 10, 0, 10)
farmLabel.Text = "Farm"
farmLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
farmLabel.BackgroundTransparency = 1
farmLabel.Parent = mainFrame

-- Create the KillAura toggle label
local killAuraLabel = Instance.new("TextLabel")
killAuraLabel.Size = UDim2.new(0, 150, 0, 40)
killAuraLabel.Position = UDim2.new(0, 10, 0, 50)
killAuraLabel.Text = "KillAura (OFF)"
killAuraLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
killAuraLabel.BackgroundTransparency = 1
killAuraLabel.Parent = mainFrame

-- Create the AutoAFK toggle label
local autoAFKLabel = Instance.new("TextLabel")
autoAFKLabel.Size = UDim2.new(0, 150, 0, 40)
autoAFKLabel.Position = UDim2.new(0, 200, 0, 50)
autoAFKLabel.Text = "AutoAFK (OFF)"
autoAFKLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
autoAFKLabel.BackgroundTransparency = 1
autoAFKLabel.Parent = mainFrame

-- Create the AURA section label
local auraLabel = Instance.new("TextLabel")
auraLabel.Size = UDim2.new(0, 150, 0, 40)
auraLabel.Position = UDim2.new(0, 10, 0, 100)
auraLabel.Text = "AURA"
auraLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
auraLabel.BackgroundTransparency = 1
auraLabel.Parent = mainFrame

-- Create the AimAssist toggle label
local aimAssistLabel = Instance.new("TextLabel")
aimAssistLabel.Size = UDim2.new(0, 150, 0, 40)
aimAssistLabel.Position = UDim2.new(0, 10, 0, 150)
aimAssistLabel.Text = "AimAssist (OFF)"
aimAssistLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
aimAssistLabel.BackgroundTransparency = 1
aimAssistLabel.Parent = mainFrame

-- Create the AutoJump toggle label
local autoJumpLabel = Instance.new("TextLabel")
autoJumpLabel.Size = UDim2.new(0, 150, 0, 40)
autoJumpLabel.Position = UDim2.new(0, 200, 0, 150)
autoJumpLabel.Text = "AutoJump (OFF)"
autoJumpLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
autoJumpLabel.BackgroundTransparency = 1
autoJumpLabel.Parent = mainFrame

-- Toggle States (initially OFF)
local killAuraState = false
local aimAssistState = false
local autoAFKState = false
local autoJumpState = false

-- Function to toggle KillAura
local function toggleKillAura()
    killAuraState = not killAuraState
    killAuraLabel.Text = "KillAura (" .. (killAuraState and "ON" or "OFF") .. ")"
    -- Implement KillAura functionality here
end

-- Function to toggle AimAssist
local function toggleAimAssist()
    aimAssistState = not aimAssistState
    aimAssistLabel.Text = "AimAssist (" .. (aimAssistState and "ON" or "OFF") .. ")"
    -- Implement AimAssist functionality here
end

-- Function to toggle AutoAFK
local function toggleAutoAFK()
    autoAFKState = not autoAFKState
    autoAFKLabel.Text = "AutoAFK (" .. (autoAFKState and "ON" or "OFF") .. ")"
    -- Implement AutoAFK functionality here
end

-- Function to toggle AutoJump
local function toggleAutoJump()
    autoJumpState = not autoJumpState
    autoJumpLabel.Text = "AutoJump (" .. (autoJumpState and "ON" or "OFF") .. ")"
    -- Implement AutoJump functionality here
end

-- Connect the toggles to MouseButton1Click (left-click)
killAuraLabel.MouseButton1Click:Connect(toggleKillAura)
aimAssistLabel.MouseButton1Click:Connect(toggleAimAssist)
autoAFKLabel.MouseButton1Click:Connect(toggleAutoAFK)
autoJumpLabel.MouseButton1Click:Connect(toggleAutoJump)
