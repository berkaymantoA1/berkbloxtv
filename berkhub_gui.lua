-- BerkHub MM2 Speed GUI
-- Arcues X Uyumlu

-- GUI Oluştur
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Subtitle = Instance.new("TextLabel")
local ToggleButton = Instance.new("TextButton")

-- Frame Ayarları
Frame.Name = "MainFrame"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BackgroundTransparency = 0.2
Frame.Position = UDim2.new(0.1, 0, 0.1, 0)
Frame.Size = UDim2.new(0, 200, 0, 120)
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

-- Alt Başlık
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

-- Rainbow efekt
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
ToggleButton.Size = UDim2.new(0.8, 0, 0.35, 0)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "Open"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.TextSize = 18
ToggleButton.BorderSizePixel = 0
ToggleButton.AutoButtonColor = true
ToggleButton.TextStrokeTransparency = 0.3
ToggleButton.TextStrokeColor3 = Color3.new(0, 0, 0)

-- Speed sistemi
local active = true
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

local lastJumpTime = 0
local jumpCount = 0

-- Zıplama kontrol fonksiyonu
local function handleJump()
    if not active then return end

    local now = tick()
    if now - lastJumpTime < 0.5 then
        jumpCount += 1
    else
        jumpCount = 1
    end
    lastJumpTime = now

    if jumpCount >= 2 then
        humanoid.WalkSpeed = 16 -- spam zıplama -> yavaşlat
    else
        humanoid.WalkSpeed = 40 -- normal zıplama -> hızlan
    end
end

-- Humanoid durum değişikliği
humanoid.StateChanged:Connect(function(_, newState)
    if newState == Enum.HumanoidStateType.Jumping then
        handleJump()
    elseif newState == Enum.HumanoidStateType.Landed then
        if active then
            humanoid.WalkSpeed = 16 -- inişte hız sıfırla
        end
    end
end)

-- Buton kontrolü
ToggleButton.MouseButton1Click:Connect(function()
    active = not active
    if active then
        ToggleButton.Text = "Open"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    else
        ToggleButton.Text = "Close"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        humanoid.WalkSpeed = 16
    end
end)

-- Yeni karakter doğduğunda
player.CharacterAdded:Connect(function(c)
    char = c
    humanoid = c:WaitForChild("Humanoid")

    humanoid.StateChanged:Connect(function(_, newState)
        if newState == Enum.HumanoidStateType.Jumping then
            handleJump()
        elseif newState == Enum.HumanoidStateType.Landed then
            if active then
                humanoid.WalkSpeed = 16
            end
        end
    end)
end)
