local Library     = loadstring(game:HttpGet("https://pastebin.com/raw/FsJak6AT"))()
local Window      = Library.new(true, "NoirHub V6 - FinityUI")

local Players     = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character   = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid    = Character:WaitForChild("Humanoid")

local Tab1 = Window:CreateTab("Di chuyển")
local Tab2 = Window:CreateTab("Aim & ESP")
local Tab3 = Window:CreateTab("To6 by Noir")
local Tab4 = Window:CreateTab("Điều khiển")
local Tab5 = Window:CreateTab("Animation")
local Tab6 = Window:CreateTab("Outfit")

getgenv().NoClip = false
Tab1:CreateToggle("No Clip", function(state)
    getgenv().NoClip = state
    game:GetService("RunService").Stepped:Connect(function()
        if getgenv().NoClip and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid:ChangeState(11)
        end
    end)
end)

Tab1:CreateToggle("Fly", function(state)
    if state then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Vehicle%20Fly%20Gui"))()
    end
end)

getgenv().InfJump = false
Tab1:CreateToggle("Infinite Jump", function(state)
    getgenv().InfJump = state
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if getgenv().InfJump then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end)
end)

Tab1:CreateSlider("Tốc độ di chuyển", 16, 100, function(val)
    LocalPlayer.Character.Humanoid.WalkSpeed = val
end)

Tab1:CreateSlider("Độ cao nhảy", 50, 200, function(val)
    LocalPlayer.Character.Humanoid.JumpPower = val
end)

Tab2:CreateToggle("ESP Tên người", function(state)
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
            if state then
                local billboard = Instance.new("BillboardGui", v.Character.Head)
                billboard.Name = "NoirESP"
                billboard.Size = UDim2.new(0, 100, 0, 40)
                billboard.AlwaysOnTop = true
                local label = Instance.new("TextLabel", billboard)
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.TextColor3 = Color3.fromRGB(0, 255, 0)
                label.TextStrokeTransparency = 0
                label.Text = v.Name .. " [" .. math.floor((v.Character.Head.Position - LocalPlayer.Character.Head.Position).Magnitude) .. "]"
            else
                if v.Character.Head:FindFirstChild("NoirESP") then
                    v.Character.Head.NoirESP:Destroy()
                end
            end
        end
    end
end)

Tab2:CreateButton("Aimbot (Head)", function()
    local camera = workspace.CurrentCamera
    local function getClosestPlayer()
        local closest = nil
        local shortest = math.huge
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                local pos = camera:WorldToViewportPoint(player.Character.Head.Position)
                local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)).Magnitude
                if dist < shortest then
                    closest = player
                    shortest = dist
                end
            end
        end
        return closest
    end

    game:GetService("RunService").RenderStepped:Connect(function()
        local target = getClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            camera.CFrame = CFrame.new(camera.CFrame.Position, target.Character.Head.Position)
        end
    end)
end)

Tab3:CreateToggle("Spam 'Cry about it'", function(state)
    if state then
        while wait(1) do
            if not state then break end
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Cry about it", "All")
        end
    end
end)

Tab4:CreateButton("Tự nổ (văng tất cả)", function()
    local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - root.Position).magnitude
            if distance < 25 then
                player.Character.HumanoidRootPart.Velocity = (player.Character.HumanoidRootPart.Position - root.Position).Unit * 150
            end
        end
    end
    LocalPlayer.Character:BreakJoints()
end)

Tab5:CreateButton("📦 Animation Pack (R6)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Emerson2-creator/Scripts-Roblox/main/ScriptR6/AnimGuiV2.lua"))()
end)

Tab5:CreateButton("🕺 Emote (R15)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Emerson2-creator/Scripts-Roblox/main/ScriptR15/EmoteGuiV2.lua"))()
end)

Tab6:CreateTextbox("Nhập UserId để copy outfit", function(text)
    pcall(function()
        local id = tonumber(text)
        if id then
            game.Players:CreateHumanoidModelFromUserId(id):PivotTo(LocalPlayer.Character:GetPivot())
        end
    end)
end)

Tab6:CreateButton("Mặc Headless", function()
    for _, accessory in pairs(LocalPlayer.Character:GetChildren()) do
        if accessory:IsA("Accessory") and accessory:FindFirstChild("Handle") and accessory.Handle:FindFirstChild("Mesh") then
            accessory.Handle.Mesh.Scale = Vector3.new(0, 0, 0)
        end
    end
end)

Tab6:CreateButton("Mặc Korblox", function()
    local leg = LocalPlayer.Character:FindFirstChild("RightLowerLeg")
    if leg then
        leg:Destroy()
    end
end)
