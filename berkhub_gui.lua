-- BerkHub MM2 Speed GUI
-- Arcues X Delta Fluxus Codex 

-- GUI Oluştur
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Subtitle = Instance.new("TextLabel")
local ToggleButton = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")
local CollapseButton = Instance.new("TextButton")

-- Frame Ayarları
Frame.Name = "MainFrame"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BackgroundTransparency = 0.2
Frame.Position = UDim2.new(0.1, 0, 0.1, 0)
Frame.Size = UDim2.new(0, 200, 0, 140)
Frame.Active = true
Frame.Draggable = true
Frame.BorderSizePixel = 0
Frame.ClipsDescendants = true
Frame.Visible = true

-- Başlık (BerkHub - Rainbow)
Title.Name = "Title"
Title.Parent = Frame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Size = UDim2.new(1, 0, 0.3, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "BerkHub"
Title.TextSize = 20
Title.TextStrokeTransparency = 0
Title.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Alt Başlık (YouTube: BerkHubRoblox - Küçük rainbow)
Subtitle.Name = "Subtitle"
Subtitle.Parent = Frame
Subtitle.BackgroundTransparency = 1
Subtitle.Position = UDim2.new(0, 0, 0.25, 0)
Subtitle.Size = UDim2.new(1, 0, 0.2, 0)
Subtitle.Font = Enum.Font.Gotham
Subtitle.Text = "YouTube: BerkHubRoblox"
Subtitle.TextSize = 13
Subtitle.TextColor3 = Color3.fromRGB(255, 255, 255)
Subtitle.TextStrokeTransparency = 0.2

-- Rainbow efekt (başlık + alt başlık)
spawn(function()
    while true do
        local hue = tick() % 5 / 5
        Title.TextColor3 = Color3.fromHSV(hue, 1, 1)
        Subtitle.TextColor3 = Color3.fromHSV((hue + 0.2) % 1, 1, 1)
        wait()
    end
end)

-- Buton (Open/Close)
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = Frame
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
ToggleButton.Position = UDim2.new(0.1, 0, 0.55, 0)
ToggleButton.Size = UDim2.new(0.8, 0, 0.25, 0)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "Open"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.TextSize = 18
ToggleButton.BorderSizePixel = 0
ToggleButton.AutoButtonColor = true
ToggleButton.TextStrokeTransparency = 0.3
ToggleButton.TextStrokeColor3 = Color3.new(0, 0, 0)

-- Durum Göstergesi
StatusLabel.Name = "StatusLabel"
StatusLabel.Parent = Frame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 0, 0.83, 0)
StatusLabel.Size = UDim2.new(1, 0, 0.2, 0)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 14
StatusLabel.TextStrokeTransparency = 0.3
StatusLabel.Text = "Speed Glitch is not active"
StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)

-- Küçült/Aç butonu
CollapseButton.Name = "CollapseButton"
CollapseButton.Parent = Frame
CollapseButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
CollapseButton.Position = UDim2.new(1, -20, 0, 0)
CollapseButton.Size = UDim2.new(0, 20, 0, 20)
CollapseButton.Text = "-"
CollapseButton.TextColor3 = Color3.new(1, 1, 1)
CollapseButton.Font = Enum.Font.GothamBold
CollapseButton.TextSize = 14
CollapseButton.BorderSizePixel = 0
CollapseButton.AutoButtonColor = true
CollapseButton.TextStrokeTransparency = 0.4

-- Script fonksiyonları
local active = false
local collapsed = false
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

-- Speed kontrol (StateChanged kullanılarak)
local function connectStateListener(h)
    h.StateChanged:Connect(function(_, newState)
        if active then
            if newState == Enum.HumanoidStateType.Jumping or newState == Enum.HumanoidStateType.Freefall then
                h.WalkSpeed = 40
            else
                h.WalkSpeed = 16
            end
        else
            h.WalkSpeed = 16
        end
    end)
end

connectStateListener(humanoid)

-- ToggleButton işlemi
ToggleButton.MouseButton1Click:Connect(function()
    active = not active
    if active then
        ToggleButton.Text = "Close"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        StatusLabel.Text = "Speed Glitch is currently active"
        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    else
        ToggleButton.Text = "Open"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        StatusLabel.Text = "Speed Glitch is not active"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        humanoid.WalkSpeed = 16
    end
end)

-- Karakter tekrar spawn olunca yeniden bağlan
player.CharacterAdded:Connect(function(c)
    char = c
    humanoid = c:WaitForChild("Humanoid")
    connectStateListener(humanoid)
end)

-- Animasyonlu Aç/Kapat işlemi (Title ortalanmış)
local fullSize = UDim2.new(0, 200, 0, 140)
local collapsedSize = UDim2.new(0, 200, 0, 36)

CollapseButton.MouseButton1Click:Connect(function()
    collapsed = not collapsed
    if collapsed then
        -- Başlığı ortala
        Title.Position = UDim2.new(0, 0, 0, 8)
        Title.Size = UDim2.new(1, 0, 0, 20)

        Frame:TweenSize(collapsedSize, "Out", "Sine", 0.4, true)
        for _, child in pairs(Frame:GetChildren()) do
            if child ~= Title and child ~= CollapseButton then
                child.Visible = false
            end
        end
    else
        -- Başlığı eski haline döndür
        Title.Position = UDim2.new(0, 0, 0, 0)
        Title.Size = UDim2.new(1, 0, 0.3, 0)

        Frame:TweenSize(fullSize, "Out", "Sine", 0.4, true)
        task.delay(0.4, function()
            for _, child in pairs(Frame:GetChildren()) do
                child.Visible = true
            end
        end)
    end
end)
