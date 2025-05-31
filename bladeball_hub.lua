
-- Blade Ball Hub by ChatGPT
-- Fitur: Auto Parry, Auto Spam, Auto Curve Ball dengan GUI

-- UI Library (Simple)
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "BladeBallHub"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 250, 0, 200)
Frame.Position = UDim2.new(0, 20, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", Frame)
title.Text = "Blade Ball Hub"
title.Size = UDim2.new(1, 0, 0, 30)
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20

-- Buttons
local function createButton(text, yPos)
    local btn = Instance.new("TextButton", Frame)
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

-- Feature toggles
local autoParry = false
local autoSpam = false
local autoCurve = false

-- Auto Parry Function
local function startAutoParry()
    task.spawn(function()
        while autoParry do
            pcall(function()
                local ball = workspace:FindFirstChild("Ball")
                local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if ball and hrp then
                    local dist = (hrp.Position - ball.Position).Magnitude
                    if dist < 20 then
                        game:GetService("ReplicatedStorage").Remotes.ParryButtonPress:FireServer(true)
                    end
                end
            end)
            task.wait(0.05)
        end
    end)
end

-- Auto Spam Function
local function startAutoSpam()
    task.spawn(function()
        while autoSpam do
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.ParryButtonPress:FireServer(true)
            end)
            task.wait(0.1)
        end
    end)
end

-- Auto Curve Function
local function startAutoCurve()
    task.spawn(function()
        while autoCurve do
            pcall(function()
                local rep = game:GetService("ReplicatedStorage")
                rep.Remotes.Curve:FireServer("Left")
                task.wait(0.3)
                rep.Remotes.Curve:FireServer("Right")
                task.wait(0.3)
            end)
        end
    end)
end

-- UI Button Logic
local parryBtn = createButton("Auto Parry [OFF]", 40)
parryBtn.MouseButton1Click:Connect(function()
    autoParry = not autoParry
    parryBtn.Text = "Auto Parry [" .. (autoParry and "ON" or "OFF") .. "]"
    if autoParry then startAutoParry() end
end)

local spamBtn = createButton("Auto Spam [OFF]", 80)
spamBtn.MouseButton1Click:Connect(function()
    autoSpam = not autoSpam
    spamBtn.Text = "Auto Spam [" .. (autoSpam and "ON" or "OFF") .. "]"
    if autoSpam then startAutoSpam() end
end)

local curveBtn = createButton("Auto Curve [OFF]", 120)
curveBtn.MouseButton1Click:Connect(function()
    autoCurve = not autoCurve
    curveBtn.Text = "Auto Curve [" .. (autoCurve and "ON" or "OFF") .. "]"
    if autoCurve then startAutoCurve() end
end)
