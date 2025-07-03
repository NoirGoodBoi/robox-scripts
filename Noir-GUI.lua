local p = game.Players.LocalPlayer
local rs = game:GetService("RunService")
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "NoirGUI"

local menuBtn = Instance.new("TextButton", gui)
menuBtn.Size = UDim2.new(0, 40, 0, 40)
menuBtn.Position = UDim2.new(1, -50, 1, -50)
menuBtn.Text = "⚙️"
menuBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
menuBtn.TextColor3 = Color3.new(1, 1, 1)
menuBtn.TextSize = 24
menuBtn.Font = Enum.Font.GothamBold
menuBtn.AutoButtonColor = true
menuBtn.BackgroundTransparency = 0.2
menuBtn.BorderSizePixel = 0
local corner = Instance.new("UICorner", menuBtn)
corner.CornerRadius = UDim.new(1, 0)

local dragToggle = false
local dragInput
local dragStart
local startPos

menuBtn.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragToggle = true
		dragStart = input.Position
		startPos = menuBtn.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragToggle = false
			end
		end)
	end
end)

menuBtn.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if input == dragInput and dragToggle then
		local delta = input.Position - dragStart
		menuBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

local panel = Instance.new("Frame", gui)
panel.Size = UDim2.new(0, 200, 0, 150)
panel.Position = UDim2.new(1, -210, 1, -210)
panel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
panel.Visible = false
Instance.new("UICorner", panel)

menuBtn.MouseButton1Click:Connect(function()
	panel.Visible = not panel.Visible
end)
