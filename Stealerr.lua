-- LocalScript in StarterPlayerScripts

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "CountdownGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 1000 -- Highest priority to cover other prompts
gui.Parent = playerGui

-- Optional: Hide all core UI
local StarterGui = game:GetService("StarterGui")
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

-- Main box (100% of screen)
local textBox = Instance.new("TextLabel")
textBox.Size = UDim2.new(1, 0, 1, 0)
textBox.Position = UDim2.new(0, 0, 0, 0)
textBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
textBox.TextColor3 = Color3.new(1, 1, 1)
textBox.Font = Enum.Font.SourceSansBold
textBox.TextScaled = true
textBox.Text = "Wait 70 seconds for the script to work"
textBox.Parent = gui

Instance.new("UICorner", textBox).CornerRadius = UDim.new(0.05, 0)
Instance.new("UIStroke", textBox).Thickness = 3

-- Spinner (loading-style circle)
local spinner = Instance.new("ImageLabel")
spinner.Size = UDim2.new(0, 100, 0, 100)
spinner.Position = UDim2.new(0.5, -50, 0.05, 0)
spinner.AnchorPoint = Vector2.new(0.5, 0)
spinner.BackgroundTransparency = 1
spinner.Image = "rbxassetid://5592112054" -- Spinner asset
spinner.ImageColor3 = Color3.fromRGB(255, 255, 255)
spinner.Parent = gui

-- Spinner animation
local rotating = true
task.spawn(function()
	while rotating do
		spinner.Rotation += 5
		wait(0.01)
	end
end)

-- Countdown logic
local countdown = 70
while countdown > 0 do
	textBox.Text = "Wait " .. countdown .. " seconds for the script to work"
	wait(1)
	countdown -= 1
end

-- Cleanup
rotating = false
spinner:Destroy()
textBox.Text = "Script is now working!"

-- Restore core UI
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)

-- Script logic after countdown
print("Countdown done, executing script.")
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
humanoid.WalkSpeed = 32
