-- Clean Peel Controller Script with R Key Toggle
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Safe CoreGui container fallback
local uiParent = (pcall(gethui) and gethui()) or CoreGui

-- Remove existing GUI if already loaded
if uiParent:FindFirstChild("PeelControllerGui") then
    uiParent.PeelControllerGui:Destroy()
end

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PeelControllerGui"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 999
screenGui.Parent = uiParent

-- Main Draggable Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 185)
mainFrame.Position = UDim2.new(0, 40, 0, 100)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(0, 170, 255)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

-- Title Bar
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 35)
titleLabel.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
titleLabel.Text = "Peel Controller [R: Toggle]"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 13
titleLabel.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = titleLabel

-- Helper Function to Create Styled Buttons
local function createButton(posY, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 38)
    btn.Position = UDim2.new(0, 10, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    btn.Text = text
    btn.Parent = mainFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- References to Remote Events/Functions
local remotesFolder = ReplicatedStorage:WaitForChild("Remotes")
local beginPeelEvent = remotesFolder:WaitForChild("BeginPeel")
local finishPeelEvent = remotesFolder:WaitForChild("FinishPeel")
local cancelPeelEvent = remotesFolder:WaitForChild("CancelPeel")

-- UI Buttons Setup
createButton(45, "Begin Peel", function()
    pcall(function()
        beginPeelEvent:InvokeServer()
    end)
end)

createButton(90, "Finish Peel", function()
    pcall(function()
        finishPeelEvent:FireServer()
    end)
end)

createButton(135, "Cancel Peel", function()
    pcall(function()
        cancelPeelEvent:FireServer()
    end)
end)

-- R Key Toggle to Show/Hide UI
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.R then
        screenGui.Enabled = not screenGui.Enabled
    end
end)
