--//
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TempSplash"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local imageLabel = Instance.new("ImageLabel")
imageLabel.Size = UDim2.new(1, 0, 1, 0)
imageLabel.Position = UDim2.new(0, 0, 0, 0)
imageLabel.Image = "rbxassetid://71239200066191"
imageLabel.BackgroundTransparency = 1
imageLabel.Parent = screenGui

--//
delay(2, function()
    screenGui:Destroy()
    --//
    loadstring(game:HttpGet("https://raw.githubusercontent.com/anuragaming1/Meow_gaming/refs/heads/main/TSBkaitun.txt"))()
end)

--//
--//
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

--//
Lighting.GlobalShadows = false
Lighting.FogEnd = 9e9
Lighting.Brightness = 2
Lighting.OutdoorAmbient = Color3.new(1,1,1)
Lighting.ClockTime = 14

--//
for _, obj in pairs(Workspace:GetDescendants()) do
    if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") then
        obj.Enabled = false
    elseif obj:IsA("Terrain") then
        local materialMap = obj:CopyTo(Workspace)
        obj:Clear()
        obj.CanCollide = true
    elseif obj:IsA("BasePart") then
        if not obj:IsDescendantOf(Players.LocalPlayer.Character) then
            obj.Transparency = 1
            obj.CanCollide = true
            obj.Material = Enum.Material.Plastic
            obj.CastShadow = false
        end
    end
end

--//
for _, d in pairs(Workspace:GetDescendants()) do
    if d:IsA("Decal") or d:IsA("Texture") then
        d:Destroy()
    end
end

--//
RunService.Stepped:Connect(function()
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") then
            obj.Enabled = false
        elseif obj:IsA("BasePart") then
            if not obj:IsDescendantOf(Players.LocalPlayer.Character) then
                obj.Transparency = 1
                obj.CanCollide = true
                obj.Material = Enum.Material.Plastic
                obj.CastShadow = false
            end
        end
    end
end)

print("FPS boost")
--//
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

--//
local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "ESPFolder"
ESPFolder.Parent = game.CoreGui

--//
local ESPs = {}

--//
local function CreateESP(player)
    --//
    if player == LocalPlayer then return end

    -- //
    if ESPs[player] then
        ESPs[player]:Destroy()
        ESPs[player] = nil
    end

    --//
    local character = player.Character or player.CharacterAdded:Wait()
    local head = character:WaitForChild("Head")
    local humanoid = character:WaitForChild("Humanoid")

    --//
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP"
    billboard.Size = UDim2.new(0,120,0,50)
    billboard.Adornee = head
    billboard.AlwaysOnTop = true
    billboard.Parent = ESPFolder

    --//
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1,0,1,0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.fromRGB(255,0,0)
    textLabel.TextStrokeTransparency = 0
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextScaled = true
    textLabel.Parent = billboard

    --//
    ESPs[player] = billboard

    --//
    local updateConnection
    updateConnection = RunService.RenderStepped:Connect(function()
        if not humanoid.Parent or humanoid.Health <= 0 then
            billboard:Destroy()
            ESPs[player] = nil
            updateConnection:Disconnect()
            return
        end
        local hpPercent = math.floor(humanoid.Health / humanoid.MaxHealth * 100)
        textLabel.Text = player.Name .. " | " .. hpPercent .. "%"
    end)
end

--//
for _, player in pairs(Players:GetPlayers()) do
    player.CharacterAdded:Connect(function() CreateESP(player) end)
    CreateESP(player)
end

--//
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function() CreateESP(player) end)
end)
