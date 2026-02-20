-- ==========================================
-- MENU VIP PRO V28 (FIX LỖI ESP, XÓA KHUNG & ICON)
-- ==========================================
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local UIS = game:GetService("UserInputService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local VirtualUser = game:GetService("VirtualUser")
local player = Players.LocalPlayer

local State = {
    Instant = false, Noclip = false, LowGfx = false, Speed = false, Jump = false,
    InfJump = false, PlayerLight = false, ESP = false, AntiAfk = false,
    SpeedValue = 60, JumpValue = 120
}

-- [BẢNG MÀU CHỦ ĐẠO]
local Theme = {
    MainBg = Color3.fromRGB(15, 15, 20),      
    HeaderBg = Color3.fromRGB(22, 22, 28),
    TabBg = Color3.fromRGB(20, 20, 26),
    ItemBg = Color3.fromRGB(30, 30, 38),
    Stroke = Color3.fromRGB(70, 70, 85),
    TextTitle = Color3.fromRGB(255, 255, 255),
    TextDim = Color3.fromRGB(150, 150, 165),
    AccentOn = Color3.fromRGB(0, 255, 128),   
    AccentOff = Color3.fromRGB(255, 60, 80),  
    Brand = Color3.fromRGB(0, 190, 255),      
    BrandGradient = Color3.fromRGB(160, 32, 240) 
}

-- [1. GIAO DIỆN CHÍNH]
local gui = Instance.new("ScreenGui")
gui.Name = "MobileProMax_V28"
gui.ResetOnSpawn = false
gui.DisplayOrder = 99999
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global

local guiParent = player:WaitForChild("PlayerGui")
pcall(function()
    if gethui and type(gethui) == "function" then
        local hui = gethui()
        if hui then guiParent = hui end
    elseif game:GetService("CoreGui") then
        guiParent = game:GetService("CoreGui")
    end
end)
gui.Parent = guiParent

-- [NÚT MỞ MENU]
local openBtn = Instance.new("TextButton", gui)
openBtn.Size = UDim2.new(0, 100, 0, 42)
openBtn.Position = UDim2.new(0, 15, 0, 15)
openBtn.Text = "🛑 Mở"
openBtn.BackgroundColor3 = Theme.MainBg
openBtn.BackgroundTransparency = 0.1
openBtn.TextColor3 = Theme.TextTitle
openBtn.Font = Enum.Font.GothamBlack
openBtn.TextSize = 12
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1, 0)
local openStroke = Instance.new("UIStroke", openBtn)
openStroke.Color = Theme.Brand; openStroke.Thickness = 2; openStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local function clickAnimate(obj)
    local scale = Instance.new("UIScale", obj)
    TweenService:Create(scale, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 0.9}):Play()
    task.wait(0.1)
    TweenService:Create(scale, TweenInfo.new(0.15, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {Scale = 1}):Play()
    task.delay(0.3, function() scale:Destroy() end)
end

local btnDragToggle, btnDragStart, btnStartPos
openBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        btnDragToggle = true; btnDragStart = input.Position; btnStartPos = openBtn.Position
    end
end)
UIS.InputChanged:Connect(function(input)
    if btnDragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        openBtn.Position = UDim2.new(btnStartPos.X.Scale, btnStartPos.X.Offset + (input.Position.X - btnDragStart.X), btnStartPos.Y.Scale, btnStartPos.Y.Offset + (input.Position.Y - btnDragStart.Y))
    end
end)
UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then btnDragToggle = false end end)

-- [KHUNG CHÍNH MENU]
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 340, 0, 440)
frame.Position = UDim2.new(0.5, -170, 1.2, 0)
frame.BackgroundColor3 = Theme.MainBg
frame.BackgroundTransparency = 0.15 
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
local frameStroke = Instance.new("UIStroke", frame); frameStroke.Color = Theme.Stroke; frameStroke.Thickness = 1.5

local header = Instance.new("Frame", frame)
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundColor3 = Theme.HeaderBg; header.BackgroundTransparency = 0.1; header.BorderSizePixel = 0
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 16)
local headerCover = Instance.new("Frame", header) 
headerCover.Size = UDim2.new(1, 0, 0, 15); headerCover.Position = UDim2.new(0, 0, 1, -15)
headerCover.BackgroundColor3 = Theme.HeaderBg; headerCover.BackgroundTransparency = 0.1; headerCover.BorderSizePixel = 0

local titleLabel = Instance.new("TextLabel", header)
titleLabel.Size = UDim2.new(1, 0, 1, 0); titleLabel.BackgroundTransparency = 1
titleLabel.Text = " MENU VIP V28 "
titleLabel.TextColor3 = Color3.new(1, 1, 1); titleLabel.Font = Enum.Font.GothamBlack; titleLabel.TextSize = 16
local titleGradient = Instance.new("UIGradient", titleLabel)
titleGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Theme.Brand), ColorSequenceKeypoint.new(1, Theme.BrandGradient)})

-- [KÉO THẢ MENU]
local dragToggle, dragStart, startPos
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragToggle = true; dragStart = input.Position; startPos = frame.Position end
end)
UIS.InputChanged:Connect(function(input)
    if dragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + (input.Position.X - dragStart.X), startPos.Y.Scale, startPos.Y.Offset + (input.Position.Y - dragStart.Y))
    end
end)
UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragToggle = false end end)

-- [HỆ THỐNG TAB]
local tabBar = Instance.new("Frame", frame)
tabBar.Size = UDim2.new(1, 0, 0, 35); tabBar.Position = UDim2.new(0, 0, 0, 45)
tabBar.BackgroundColor3 = Theme.TabBg; tabBar.BackgroundTransparency = 0.5; tabBar.BorderSizePixel = 0
local function createTab(name, x, width)
    local btn = Instance.new("TextButton", tabBar)
    btn.Size = UDim2.new(width, 0, 1, 0); btn.Position = UDim2.new(x, 0, 0, 0)
    btn.Text = name; btn.BackgroundTransparency = 1; btn.TextColor3 = Theme.TextDim
    btn.Font = Enum.Font.GothamBold; btn.TextSize = 10
    local indicator = Instance.new("Frame", btn)
    indicator.Size = UDim2.new(0.5, 0, 0, 3); indicator.Position = UDim2.new(0.25, 0, 1, -3)
    indicator.BackgroundColor3 = Theme.Brand; indicator.BorderSizePixel = 0; indicator.Visible = false
    Instance.new("UICorner", indicator).CornerRadius = UDim.new(1, 0)
    return btn, indicator
end
local tab1, ind1 = createTab("NHÂN VẬT", 0, 0.2)
local tab2, ind2 = createTab("BẢN ĐỒ", 0.2, 0.2)
local tab3, ind3 = createTab("TIỆN ÍCH", 0.4, 0.2)
local tab4, ind4 = createTab("TP SAVE", 0.6, 0.2)
local tab5, ind5 = createTab("TP PLAYER", 0.8, 0.2)

local pageContainer = Instance.new("Frame", frame)
pageContainer.Size = UDim2.new(1, 0, 1, -90); pageContainer.Position = UDim2.new(0, 0, 0, 85)
pageContainer.BackgroundTransparency = 1

local function createPage()
    local pg = Instance.new("ScrollingFrame", pageContainer)
    pg.Size = UDim2.new(1, 0, 1, 0); pg.BackgroundTransparency = 1
    pg.ScrollBarThickness = 2; pg.ScrollBarImageColor3 = Theme.Brand; pg.Visible = false; pg.BorderSizePixel = 0
    local layout = Instance.new("UIListLayout", pg)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center; layout.Padding = UDim.new(0, 10)
    Instance.new("UIPadding", pg).PaddingTop = UDim.new(0, 10); Instance.new("UIPadding", pg).PaddingBottom = UDim.new(0, 10)
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() pg.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20) end)
    return pg
end
local page1, page2, page3, page4, page5 = createPage(), createPage(), createPage(), createPage(), createPage()

local function showTab(pg, tb, ind)
    for _, p in pairs({page1, page2, page3, page4, page5}) do p.Visible = false end
    for _, t in pairs({tab1, tab2, tab3, tab4, tab5}) do t.TextColor3 = Theme.TextDim end
    for _, i in pairs({ind1, ind2, ind3, ind4, ind5}) do i.Visible = false end
    pg.Visible = true; tb.TextColor3 = Theme.TextTitle; ind.Visible = true
    ind.Size = UDim2.new(0, 0, 0, 3)
    TweenService:Create(ind, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0.5, 0, 0, 3)}):Play()
end
tab1.MouseButton1Click:Connect(function() showTab(page1, tab1, ind1) end)
tab2.MouseButton1Click:Connect(function() showTab(page2, tab2, ind2) end)
tab3.MouseButton1Click:Connect(function() showTab(page3, tab3, ind3) end)
tab4.MouseButton1Click:Connect(function() showTab(page4, tab4, ind4) end)
tab5.MouseButton1Click:Connect(function() showTab(page5, tab5, ind5) end)
showTab(page1, tab1, ind1)

local opened = false
openBtn.MouseButton1Click:Connect(function()
    clickAnimate(openBtn)
    opened = not opened
    openBtn.Text = opened and "❌ ĐÓNG" or "🛑 Mở"
    TweenService:Create(openStroke, TweenInfo.new(0.3), {Color = opened and Theme.AccentOff or Theme.Brand}):Play()
    frame:TweenPosition(opened and UDim2.new(0.5, -170, 0.5, -220) or UDim2.new(0.5, -170, 1.2, 0), "Out", "Back", 0.5)
end)

-- [CÁC HÀM TẠO NÚT, CÔNG TẮC, SLIDER]
local function createButton(parent, text, color, callback)
    local btnFrame = Instance.new("Frame", parent)
    btnFrame.Size = UDim2.new(0.9, 0, 0, 44); btnFrame.BackgroundTransparency = 1
    local btn = Instance.new("TextButton", btnFrame)
    btn.Size = UDim2.new(1, 0, 1, 0); btn.BackgroundColor3 = Theme.ItemBg; btn.Text = ""; btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    local stroke = Instance.new("UIStroke", btn); stroke.Color = color; stroke.Thickness = 1.2; stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    local title = Instance.new("TextLabel", btn)
    title.Size = UDim2.new(1, 0, 1, 0); title.BackgroundTransparency = 1; title.Text = text
    title.TextColor3 = color; title.Font = Enum.Font.GothamBold; title.TextSize = 13
    btn.MouseButton1Click:Connect(function()
        clickAnimate(btn); TweenService:Create(stroke, TweenInfo.new(0.15), {Color = Theme.TextTitle}):Play()
        task.wait(0.15); TweenService:Create(stroke, TweenInfo.new(0.3), {Color = color}):Play(); callback()
    end)
    return btn
end

local function createToggle(parent, text, callback)
    local btnFrame = Instance.new("Frame", parent)
    btnFrame.Size = UDim2.new(0.9, 0, 0, 46); btnFrame.BackgroundTransparency = 1
    local btn = Instance.new("TextButton", btnFrame)
    btn.Size = UDim2.new(1, 0, 1, 0); btn.BackgroundColor3 = Theme.ItemBg; btn.Text = ""; btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    local stroke = Instance.new("UIStroke", btn); stroke.Color = Theme.Stroke; stroke.Thickness = 1.2
    local title = Instance.new("TextLabel", btn)
    title.Size = UDim2.new(0.7, 0, 1, 0); title.Position = UDim2.new(0.05, 0, 0, 0)
    title.BackgroundTransparency = 1; title.Text = text
    title.TextColor3 = Theme.TextTitle; title.Font = Enum.Font.GothamSemibold; title.TextSize = 13; title.TextXAlignment = Enum.TextXAlignment.Left
    local status = Instance.new("TextLabel", btn)
    status.Size = UDim2.new(0.2, 0, 1, 0); status.Position = UDim2.new(0.75, 0, 0, 0)
    status.BackgroundTransparency = 1; status.Text = "OFF"
    status.TextColor3 = Theme.AccentOff; status.Font = Enum.Font.GothamBlack; status.TextSize = 12; status.TextXAlignment = Enum.TextXAlignment.Right
    local active = false
    btn.MouseButton1Click:Connect(function()
        clickAnimate(btn); active = not active; status.Text = active and "ON" or "OFF"
        TweenService:Create(status, TweenInfo.new(0.2), {TextColor3 = active and Theme.AccentOn or Theme.AccentOff}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.2), {Color = active and Theme.AccentOn or Theme.Stroke}):Play()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = active and Color3.fromRGB(35, 45, 40) or Theme.ItemBg}):Play()
        callback(active)
    end)
end

local function createSlider(parent, text, min, max, default, callback)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(0.9, 0, 0, 50); frame.BackgroundTransparency = 1
    local bg = Instance.new("Frame", frame)
    bg.Size = UDim2.new(1, 0, 1, 0); bg.BackgroundColor3 = Theme.ItemBg
    Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 10)
    local stroke = Instance.new("UIStroke", bg); stroke.Color = Theme.Stroke; stroke.Thickness = 1.2
    local titleLabel = Instance.new("TextLabel", bg)
    titleLabel.Size = UDim2.new(0.7, 0, 0.4, 0); titleLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
    titleLabel.BackgroundTransparency = 1; titleLabel.Text = text; titleLabel.TextColor3 = Theme.TextTitle
    titleLabel.Font = Enum.Font.GothamSemibold; titleLabel.TextSize = 12; titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    local valLabel = Instance.new("TextLabel", bg)
    valLabel.Size = UDim2.new(0.25, 0, 0.4, 0); valLabel.Position = UDim2.new(0.7, 0, 0.1, 0)
    valLabel.BackgroundTransparency = 1; valLabel.Text = tostring(default); valLabel.TextColor3 = Theme.Brand
    valLabel.Font = Enum.Font.GothamBold; valLabel.TextSize = 12; valLabel.TextXAlignment = Enum.TextXAlignment.Right
    local track = Instance.new("Frame", bg)
    track.Size = UDim2.new(0.9, 0, 0.15, 0); track.Position = UDim2.new(0.05, 0, 0.65, 0); track.BackgroundColor3 = Theme.MainBg
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)
    local fill = Instance.new("Frame", track)
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0); fill.BackgroundColor3 = Theme.AccentOn
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
    local dragging = false
    local function updateSlider(input)
        local pos = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + ((max - min) * pos))
        valLabel.Text = tostring(value)
        TweenService:Create(fill, TweenInfo.new(0.1), {Size = UDim2.new(pos, 0, 1, 0)}):Play()
        callback(value)
    end
    track.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true; updateSlider(input) end end)
    UIS.InputChanged:Connect(function(input) if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then updateSlider(input) end end)
    UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
    callback(default)
    return bg
end

local function optimizePart(obj)
    if State.LowGfx then
        if obj:IsA("BasePart") or obj:IsA("MeshPart") then 
            obj.Material = Enum.Material.SmoothPlastic; obj.Reflectance = 0; obj.CastShadow = false 
        elseif obj:IsA("Decal") or obj:IsA("Texture") then obj.Transparency = 1 
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then obj.Enabled = false end
    end
end

-- ==============================================
-- [NỘI DUNG TỪNG TAB]
-- ==============================================

-- [TAB 1: NHÂN VẬT]
createToggle(page1, "🏃 Chạy nhanh", function(v) State.Speed = v end)
createSlider(page1, "Chỉnh tốc độ chạy", 16, 250, 60, function(val) State.SpeedValue = val end)
createToggle(page1, "🦘 Nhảy siêu cao", function(v) State.Jump = v end)
createSlider(page1, "Chỉnh lực nhảy", 50, 300, 120, function(val) State.JumpValue = val end)
createToggle(page1, "🚀 Nhảy trên không", function(v) State.InfJump = v end) 

UIS.JumpRequest:Connect(function() 
    if State.InfJump and player.Character then 
        local hum = player.Character:FindFirstChildOfClass("Humanoid") 
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end 
    end 
end)

-- [TAB 2: BẢN ĐỒ]
createToggle(page2, "👻 Đi xuyên tường", function(v) State.Noclip = v end)
createToggle(page2, "🕹️ FPS Boost (Giảm Lag MAX)", function(v) 
    State.LowGfx = v 
    if v then 
        Lighting.GlobalShadows = false; Lighting.FogEnd = 9e9; pcall(function() settings().Rendering.QualityLevel = 1 end)
        pcall(function() workspace.Terrain.WaterWaveSize = 0; workspace.Terrain.WaterWaveSpeed = 0; workspace.Terrain.WaterReflectance = 0; workspace.Terrain.WaterTransparency = 0; workspace.Terrain.Decoration = false end)
        for _, obj in pairs(Lighting:GetChildren()) do if obj:IsA("PostEffect") or obj:IsA("BlurEffect") or obj:IsA("SunRaysEffect") or obj:IsA("ColorCorrectionEffect") or obj:IsA("BloomEffect") or obj:IsA("DepthOfFieldEffect") then obj.Enabled = false end end
        for _, obj in pairs(workspace:GetDescendants()) do optimizePart(obj) end
    else 
        Lighting.GlobalShadows = true; pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic end) 
    end
end)
createToggle(page2, "🔴 ESP Tên & Khoảng Cách", function(v) State.ESP = v end)
createToggle(page2, "💡 Ánh sáng quanh người", function(v) 
    State.PlayerLight = v 
    if not v and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then local light = player.Character.HumanoidRootPart:FindFirstChild("PlayerPointLight"); if light then light:Destroy() end end
end)
createButton(page2, "🌞 Chỉnh Trời Sáng", Color3.fromRGB(243, 156, 18), function() Lighting.ClockTime = 12 end)
createButton(page2, "🌚 Chỉnh Trời Tối", Color3.fromRGB(160, 32, 240), function() Lighting.ClockTime = 0 end)

-- [TAB 3: TIỆN ÍCH]
createToggle(page3, "🐿️ Lấy đồ nhanh", function(v) 
    State.Instant = v 
    if v then for _, prompt in pairs(workspace:GetDescendants()) do if prompt:IsA("ProximityPrompt") then prompt.HoldDuration = 0; prompt.MaxActivationDistance = 25 end end end
end)
ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt) if State.Instant then pcall(function() fireproximityprompt(prompt) end) end end)
createToggle(page3, "🛡️ Chống bị kick (Anti-AFK)", function(v) State.AntiAfk = v end)
createButton(page3, "💻 BẬT ADMIN (Infinite Yield)", Theme.AccentOn, function() pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end) end)
createButton(page3, "🔨 LẤY BTOOLS", Theme.Brand, function() pcall(function() loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/BTools.txt"))() end) end)
createButton(page3, "🕊️ FLY (Bay)", Theme.Brand, function() pcall(function() loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\40\39\104\116\116\112\115\58\47\47\103\105\115\116\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\109\101\111\122\111\110\101\89\84\47\98\102\48\51\55\100\102\102\57\102\48\97\55\48\48\49\55\51\48\52\100\100\100\54\55\102\100\99\100\51\55\48\47\114\97\119\47\101\49\52\101\55\52\102\52\50\53\98\48\54\48\100\102\53\50\51\51\52\51\99\102\51\48\98\55\56\55\48\55\52\101\98\51\99\53\100\50\47\97\114\99\101\117\115\37\50\53\50\48\120\37\50\53\50\48\102\108\121\37\50\53\50\48\50\37\50\53\50\48\111\98\102\108\117\99\97\116\111\114\39\41\44\116\114\117\101\41\41\40\41\10\10")() end) end)
createButton(page3, "📂 MENU TP SAVE V2", Theme.Brand, function() pcall(function() loadstring(game:HttpGet(('https://raw.githubusercontent.com/0Ben1/fe/main/Tp%20Place%20GUI'),true))() end) end)

-- [TAB 4: VỊ TRÍ]
local savedLocCount = 0
local function createPosItem(name, cframe)
    local item = Instance.new("Frame", page4)
    item.Size = UDim2.new(0.9, 0, 0, 50); item.BackgroundColor3 = Theme.ItemBg
    Instance.new("UICorner", item).CornerRadius = UDim.new(0, 10)
    local stroke = Instance.new("UIStroke", item); stroke.Color = Theme.Stroke; stroke.Thickness = 1
    local nameBox = Instance.new("TextBox", item)
    nameBox.Size = UDim2.new(0.45, 0, 1, 0); nameBox.Position = UDim2.new(0.05, 0, 0, 0)
    nameBox.Text = name; nameBox.TextColor3 = Theme.TextTitle; nameBox.Font = Enum.Font.GothamSemibold; nameBox.TextSize = 12
    nameBox.BackgroundTransparency = 1; nameBox.TextXAlignment = Enum.TextXAlignment.Left; nameBox.ClearTextOnFocus = false
    local tpBtn = Instance.new("TextButton", item)
    tpBtn.Size = UDim2.new(0.25, 0, 0.6, 0); tpBtn.Position = UDim2.new(0.53, 0, 0.2, 0)
    tpBtn.Text = "TP"; tpBtn.BackgroundColor3 = Theme.Brand; tpBtn.TextColor3 = Color3.new(1,1,1)
    tpBtn.Font = Enum.Font.GothamBold; tpBtn.TextSize = 11; Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 6)
    local delBtn = Instance.new("TextButton", item)
    delBtn.Size = UDim2.new(0.15, 0, 0.6, 0); delBtn.Position = UDim2.new(0.81, 0, 0.2, 0)
    delBtn.Text = "x"; delBtn.BackgroundColor3 = Theme.AccentOff; delBtn.TextColor3 = Color3.new(1,1,1)
    delBtn.Font = Enum.Font.GothamBold; delBtn.TextSize = 12; Instance.new("UICorner", delBtn).CornerRadius = UDim.new(0, 6)
    
    tpBtn.MouseButton1Click:Connect(function() clickAnimate(tpBtn); if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then player.Character.HumanoidRootPart.CFrame = cframe end end)
    delBtn.MouseButton1Click:Connect(function() clickAnimate(delBtn); task.wait(0.1); item:Destroy() end)
end
createButton(page4, "🎯 LƯU TỌA ĐỘ ĐANG ĐỨNG", Theme.AccentOn, function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        savedLocCount = savedLocCount + 1
        createPosItem("📌 Vị trí " .. savedLocCount, player.Character.HumanoidRootPart.CFrame)
    end
end)

-- [TAB 5: DANH SÁCH NGƯỜI CHƠI]
local function updatePlayerList()
    for _, child in pairs(page5:GetChildren()) do if child.Name == "PlayerBtn_TP" or child.Name == "PaddingFrame" then child:Destroy() end end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player then
            local pFrame = Instance.new("Frame", page5); pFrame.Name = "PaddingFrame"; pFrame.Size = UDim2.new(0.9, 0, 0, 44); pFrame.BackgroundTransparency = 1
            local btn = Instance.new("TextButton", pFrame)
            btn.Name = "PlayerBtn_TP"; btn.Size = UDim2.new(1, 0, 1, 0); btn.BackgroundColor3 = Theme.ItemBg; btn.AutoButtonColor = false
            btn.Text = " 👤 " .. p.DisplayName
            btn.TextColor3 = Theme.TextTitle; btn.Font = Enum.Font.GothamSemibold; btn.TextSize = 13; btn.TextXAlignment = Enum.TextXAlignment.Left
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
            local stroke = Instance.new("UIStroke", btn); stroke.Color = Theme.Stroke; stroke.Thickness = 1
            local arrow = Instance.new("TextLabel", btn)
            arrow.Size = UDim2.new(0.2, 0, 1, 0); arrow.Position = UDim2.new(0.75, 0, 0, 0); arrow.BackgroundTransparency = 1
            arrow.Text = " TP "; arrow.TextColor3 = Theme.Brand; arrow.Font = Enum.Font.GothamBold; arrow.TextSize = 11; arrow.TextXAlignment = Enum.TextXAlignment.Right
            
            btn.MouseButton1Click:Connect(function()
                clickAnimate(btn)
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    TweenService:Create(stroke, TweenInfo.new(0.3), {Color = Theme.AccentOn}):Play()
                    player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
                    task.wait(0.5); TweenService:Create(stroke, TweenInfo.new(0.3), {Color = Theme.Stroke}):Play()
                end
            end)
        end
    end
end
createButton(page5, "🔄 LÀM MỚI DANH SÁCH", Theme.Brand, updatePlayerList)
updatePlayerList()

-- ==============================================
-- [VÒNG LẶP HỆ THỐNG VÀ XỬ LÝ SỰ KIỆN]
-- ==============================================

player.Idled:Connect(function()
    if State.AntiAfk then
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end
end)

RunService.RenderStepped:Connect(function()
    local char = player.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        local hum = char:FindFirstChildOfClass("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        
        if State.Speed then hum.WalkSpeed = State.SpeedValue else hum.WalkSpeed = 16 end
        if State.Jump then hum.JumpPower = State.JumpValue else hum.JumpPower = 50 end
        if State.Noclip then for _, v in pairs(char:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end
        
        if root then
            local light = root:FindFirstChild("PlayerPointLight")
            if State.PlayerLight then 
                if not light then local newLight = Instance.new("PointLight", root); newLight.Name = "PlayerPointLight"; newLight.Brightness = 3; newLight.Range = 60; newLight.Shadows = false end 
            else 
                if light then light:Destroy() end 
            end
        end
        
        -- HỆ THỐNG ESP (Chỉ hiện Tên và Khoảng cách màu đỏ, bám chặt vào Head)
        if State.ESP then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Head") then
                    local head = p.Character.Head
                    
                    -- Tạo hoặc lấy BillboardGui đang gắn trên Head
                    local bgui = head:FindFirstChild("MobileESP_Name")
                    if not bgui then
                        bgui = Instance.new("BillboardGui", head)
                        bgui.Name = "MobileESP_Name"
                        bgui.Size = UDim2.new(0, 200, 0, 50)
                        bgui.StudsOffset = Vector3.new(0, 2, 0) -- Nổi lên trên đầu 2 mét
                        bgui.AlwaysOnTop = true -- Xuyên tường 100%
                        bgui.Adornee = head
                        
                        local tLabel = Instance.new("TextLabel", bgui)
                        tLabel.Name = "NameLabel"
                        tLabel.Size = UDim2.new(1, 0, 1, 0)
                        tLabel.BackgroundTransparency = 1
                        tLabel.TextColor3 = Color3.fromRGB(255, 50, 50) -- Màu đỏ tươi
                        tLabel.TextStrokeTransparency = 0 -- Viền đen bên ngoài chữ
                        tLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
                        tLabel.Font = Enum.Font.GothamBold
                        tLabel.TextSize = 12
                    end
                    
                    -- Cập nhật Text
                    if root then
                        local dist = math.floor((root.Position - p.Character.HumanoidRootPart.Position).Magnitude)
                        bgui.NameLabel.Text = p.DisplayName .. "\n[" .. dist .. "m]"
                    else
                        bgui.NameLabel.Text = p.DisplayName
                    end
                end
            end
        else
            -- Xóa ESP khi tắt
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("Head") then
                    local bgui = p.Character.Head:FindFirstChild("MobileESP_Name")
                    if bgui then bgui:Destroy() end
                end
                -- Đề phòng còn Highlight từ bản cũ
                if p.Character and p.Character:FindFirstChild("MobileESP_HL") then 
                    p.Character.MobileESP_HL:Destroy() 
                end
            end
        end
    end
end)

workspace.DescendantAdded:Connect(function(v)
    if State.LowGfx then optimizePart(v) end
    if State.Instant and v:IsA("ProximityPrompt") then v.HoldDuration = 0; v.MaxActivationDistance = 25 end
end)
