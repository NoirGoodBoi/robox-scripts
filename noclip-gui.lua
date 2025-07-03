local p = game.Players.LocalPlayer
local rs = game:GetService("RunService")
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "NoirGUI"

local menuBtn = Instance.new("TextButton", gui)
menuBtn.Size = UDim2.new(0, 50, 0, 50)
menuBtn.Position = UDim2.new(1, -60, 1, -60)
menuBtn.Text = "⚙️"
menuBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
menuBtn.TextColor3 = Color3.new(1,1,1)
menuBtn.TextSize = 26

local panel = Instance.new("Frame", gui)
panel.Size = UDim2.new(0, 200, 0, 150)
panel.Position = UDim2.new(1, -210, 1, -210)
panel.BackgroundColor3 = Color3.fromRGB(20,20,20)
panel.Visible = false
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 8)

menuBtn.MouseButton1Click:Connect(function()
	panel.Visible = not panel.Visible
end)

local noclipBtn = Instance.new("TextButton", panel)
noclipBtn.Size = UDim2.new(1, -20, 0, 40)
noclipBtn.Position = UDim2.new(0, 10, 0, 10)
noclipBtn.Text = "Noclip: OFF"
noclipBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
noclipBtn.TextColor3 = Color3.new(1,1,1)
noclipBtn.TextSize = 18
Instance.new("UICorner", noclipBtn).CornerRadius = UDim.new(0, 6)

local invisBtn = Instance.new("TextButton", panel)
invisBtn.Size = UDim2.new(1, -20, 0, 40)
invisBtn.Position = UDim2.new(0, 10, 0, 60)
invisBtn.Text = "Invisible: OFF"
invisBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
invisBtn.TextColor3 = Color3.new(1,1,1)
invisBtn.TextSize = 18
Instance.new("UICorner", invisBtn).CornerRadius = UDim.new(0, 6)

local noclip = false
local noclipParts = {}

noclipBtn.MouseButton1Click:Connect(function()
	noclip = not noclip
	noclipBtn.Text = noclip and "Noclip: ON" or "Noclip: OFF"
	if not noclip then
		for _, part in pairs(noclipParts) do
			if part and part:IsA("BasePart") then
				part.CanCollide = true
			end
		end
	end
end)

rs.Stepped:Connect(function()
	if noclip and p.Character then
		noclipParts = {}
		for _, part in pairs(p.Character:GetDescendants()) do
			if part:IsA("BasePart") and part.CanCollide then
				part.CanCollide = false
				table.insert(noclipParts, part)
			end
		end
	end
end)

local spawnPos = Vector3.new(0, 10, 0)
rs.Heartbeat:Connect(function()
	local hrp = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
	if hrp and hrp.Position.Y < -50 then
		hrp.CFrame = CFrame.new(spawnPos + Vector3.new(0, math.random(2,4), 0))
	end
end)

local invisible = false
local originalSizes = {}

invisBtn.MouseButton1Click:Connect(function()
	invisible = not invisible
	invisBtn.Text = invisible and "Invisible: ON" or "Invisible: OFF"
	local char = p.Character
	if char then
		for _, part in pairs(char:GetDescendants()) do
			if part:IsA("BasePart") then
				if invisible then
					originalSizes[part] = part.Size
					part.Transparency = 1
					part.CanCollide = false
					part.Size = Vector3.new(0, 0, 0)
				else
					part.Transparency = 0
					part.CanCollide = true
					if originalSizes[part] then
						part.Size = originalSizes[part]
					end
				end
			elseif part:IsA("Decal") then
				part.Transparency = invisible and 1 or 0
			elseif part:IsA("ParticleEmitter") or part:IsA("Trail") then
				part.Enabled = not invisible
			end
		end
	end
end)
