-- ==========================================
-- PRO MAX MOBILE EDITION V21 (AUTO PLAYER LIST + TWEEN ANIMATIONS)
-- ==========================================
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local UIS = game:GetService("UserInputService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local player = Players.LocalPlayer

local State = {
    Instant = false, Noclip = false, LowGfx = false, Speed = false, Jump = false,
    InfJump = false, PlayerLight = false, ESP = false, AntiAfk = false,
    SpeedValue = 60, JumpValue = 120
}

-- [BẢNG MÀU CHỦ ĐẠO - HIỆN ĐẠI HƠN]
local Theme = {
    MainBg = Color3.fromRGB(18, 18, 22),     
    HeaderBg = Color3.fromRGB(25, 25, 30),
    TabBg = Color3.fromRGB(28, 28, 34),
    ItemBg = Color3.fromRGB(36, 36, 44),
    Stroke = Color3.fromRGB(65, 65, 75),
    TextTitle = Color3.fromRGB(255, 255, 255),
    TextDim = Color3.fromRGB(160, 160, 170),
    AccentOn = Color3.fromRGB(46, 204, 113),  
    AccentOff = Color3.fromRGB(255, 71, 87),  
    Brand = Color3.fromRGB(0, 212, 255)       
}

-- [1. GIAO DIỆN CHÍNH]
local gui = Instance.new("ScreenGui")
gui.Name = "MobileProMax_V21"
gui.ResetOnSpawn = false
gui.DisplayOrder = 99999
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global

if gethui then
    gui.Parent = gethui()
else
    local success, coreGui = pcall(function() return game:GetService("CoreGui") end)
    if success and coreGui then gui.Parent = coreGui else gui.Parent = player:WaitForChild("PlayerGui") end
end

-- [NÚT MỞ MENU]
local openBtn = Instance.new("TextButton", gui)
openBtn.Size = UDim2.new(0, 95, 0, 40)
openBtn.Position = UDim2.new(0, 15, 0, 15)
openBtn.Text = "⚡ MENU"
openBtn.BackgroundColor3 = Theme.ItemBg
openBtn.TextColor3 = Theme.TextTitle
openBtn.Font = Enum.Font.GothamBold
openBtn.TextSize = 13
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1, 0)
local openStroke = Instance.new("UIStroke", openBtn)
openStroke.Color = Theme.Brand; openStroke.Thickness = 1.5; openStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local btnDragToggle, btnDragStart, btnStartPos
openBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        btnDragToggle = true; btnDragStart = input.Position; btnStartPos = openBtn.Position
    end
end)
UIS.InputChanged:Connect(function(input)
    if btnDragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - btnDragStart
        openBtn.Position = UDim2.new(btnStartPos.X.Scale, btnStartPos.X.Offset + delta.X, btnStartPos.Y.Scale, btnStartPos.Y.Offset + delta.Y)
    end
end)
UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then btnDragToggle = false end end)

-- [KHUNG CHÍNH MENU]
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 330, 0, 420)
frame.Position = UDim2.new(0.5, -165, 1.2, 0)
frame.BackgroundColor3 = Theme.MainBg
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)
local frameStroke = Instance.new("UIStroke", frame); frameStroke.Color = Theme.Stroke; frameStroke.Thickness = 1

local header = Instance.new("Frame", frame)
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Theme.HeaderBg; header.BorderSizePixel = 0
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)
local headerCover = Instance.new("Frame", header) 
headerCover.Size = UDim2.new(1, 0, 0, 10); headerCover.Position = UDim2.new(0, 0, 1, -10)
headerCover.BackgroundColor3 = Theme.HeaderBg; headerCover.BorderSizePixel = 0
local titleLabel = Instance.new("TextLabel", header)
titleLabel.Size = UDim2.new(1, 0, 1, 0); titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🇻🇳 PRO MAX V21 🇻🇳"
titleLabel.TextColor3 = Theme.Brand; titleLabel.Font = Enum.Font.GothamBold; titleLabel.TextSize = 14

-- [KÉO THẢ MENU]
local dragToggle, dragStart, startPos
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragToggle = true; dragStart = input.Position; startPos = frame.Position
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragToggle = false end end)

-- [HỆ THỐNG TAB]
local tabBar = Instance.new("Frame", frame)
tabBar.Size = UDim2.new(1, 0, 0, 40); tabBar.Position = UDim2.new(0, 0, 0, 40)
tabBar.BackgroundColor3 = Theme.TabBg; tabBar.BorderSizePixel = 0
local function createTab(name, x, width)
    local btn = Instance.new("TextButton", tabBar)
    btn.Size = UDim2.new(width, 0, 1, 0); btn.Position = UDim2.new(x, 0, 0, 0)
    btn.Text = name; btn.BackgroundTransparency = 1; btn.TextColor3 = Theme.TextDim
    btn.Font = Enum.Font.GothamBold; btn.TextSize = 10
    local indicator = Instance.new("Frame", btn)
    indicator.Size = UDim2.new(0.6, 0, 0, 3); indicator.Position = UDim2.new(0.2, 0, 1, -3)
    indicator.BackgroundColor3 = Theme.Brand; indicator.BorderSizePixel = 0; indicator.Visible = false
    Instance.new("UICorner", indicator).CornerRadius = UDim.new(1, 0)
    return btn, indicator
end
local tab1, ind1 = createTab("🤵NHÂN", 0, 0.2)
local tab2, ind2 = createTab("🌍MAP", 0.2, 0.2)
local tab3, ind3 = createTab("💻TOOL", 0.4, 0.2)
local tab4, ind4 = createTab("📍SAVE", 0.6, 0.2)
local tab5, ind5 = createTab("🚀TP", 0.8, 0.2)

local pageContainer = Instance.new("Frame", frame)
pageContainer.Size = UDim2.new(1, 0, 1, -80); pageContainer.Position = UDim2.new(0, 0, 0, 80)
pageContainer.BackgroundTransparency = 1

local function createPage()
    local pg = Instance.new("ScrollingFrame", pageContainer)
    pg.Size = UDim2.new(1, 0, 1, 0); pg.BackgroundTransparency = 1
    pg.ScrollBarThickness = 2; pg.ScrollBarImageColor3 = Theme.Brand; pg.Visible = false
    local layout = Instance.new("UIListLayout", pg)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center; layout.Padding = UDim.new(0, 8)
    Instance.new("UIPadding", pg).PaddingTop = UDim.new(0, 10); Instance.new("UIPadding", pg).PaddingBottom = UDim.new(0, 10)
    
    -- TỰ ĐỘNG GIÃN KHUNG CUỘN (TÍNH NĂNG MỚI)
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        pg.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
    end)
    return pg
end
local page1, page2, page3, page4, page5 = createPage(), createPage(), createPage(), createPage(), createPage()

local function showTab(pg, tb, ind)
    page1.Visible = false; page2.Visible = false; page3.Visible = false; page4.Visible = false; page5.Visible = false
    tab1.TextColor3 = Theme.TextDim; tab2.TextColor3 = Theme.TextDim; tab3.TextColor3 = Theme.TextDim; tab4.TextColor3 = Theme.TextDim; tab5.TextColor3 = Theme.TextDim
    ind1.Visible = false; ind2.Visible = false; ind3.Visible = false; ind4.Visible = false; ind5.Visible = false
    pg.Visible = true; tb.TextColor3 = Theme.TextTitle; ind.Visible = true
end
tab1.MouseButton1Click:Connect(function() showTab(page1, tab1, ind1) end)
tab2.MouseButton1Click:Connect(function() showTab(page2, tab2, ind2) end)
tab3.MouseButton1Click:Connect(function() showTab(page3, tab3, ind3) end)
tab4.MouseButton1Click:Connect(function() showTab(page4, tab4, ind4) end)
tab5.MouseButton1Click:Connect(function() showTab(page5, tab5, ind5) end)
showTab(page1, tab1, ind1)

local opened = false
openBtn.MouseButton1Click:Connect(function()
    opened = not opened
    openBtn.Text = opened and "❌ ĐÓNG" or "⚡ MENU"
    TweenService:Create(openStroke, TweenInfo.new(0.3), {Color = opened and Theme.AccentOff or Theme.Brand}):Play()
    frame:TweenPosition(opened and UDim2.new(0.5, -165, 0.5, -210) or UDim2.new(0.5, -165, 1.2, 0), "Out", "Back", 0.4)
end)

-- [HÀM TẠO NÚT MENU CÓ HIỆU ỨNG TWEEN]
local function createButton(parent, text, color, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.92, 0, 0, 42); btn.BackgroundColor3 = Theme.ItemBg; btn.Text = ""
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke", btn); stroke.Color = color; stroke.Thickness = 1.5; stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    local title = Instance.new("TextLabel", btn)
    title.Size = UDim2.new(1, 0, 1, 0); title.BackgroundTransparency = 1; title.Text = text
    title.TextColor3 = color; title.Font = Enum.Font.GothamBold; title.TextSize = 13
    
    btn.MouseButton1Click:Connect(function()
        -- Hiệu ứng chớp màu khi bấm
        TweenService:Create(stroke, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true), {Color = Theme.TextTitle}):Play()
        callback()
    end)
    return btn
end

local function createToggle(parent, text, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.92, 0, 0, 44); btn.BackgroundColor3 = Theme.ItemBg; btn.Text = ""
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Theme.Stroke; stroke.Thickness = 1; stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    local title = Instance.new("TextLabel", btn)
    title.Size = UDim2.new(0.7, 0, 1, 0); title.Position = UDim2.new(0.05, 0, 0, 0)
    title.BackgroundTransparency = 1; title.Text = text
    title.TextColor3 = Theme.TextTitle; title.Font = Enum.Font.GothamSemibold; title.TextSize = 13
    title.TextXAlignment = Enum.TextXAlignment.Left
    local status = Instance.new("TextLabel", btn)
    status.Size = UDim2.new(0.2, 0, 1, 0); status.Position = UDim2.new(0.75, 0, 0, 0)
    status.BackgroundTransparency = 1; status.Text = "OFF"
    status.TextColor3 = Theme.AccentOff; status.Font = Enum.Font.GothamBold; status.TextSize = 12
    status.TextXAlignment = Enum.TextXAlignment.Right
    
    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        status.Text = active and "ON" or "OFF"
        -- Tween chuyển màu cho mượt
        TweenService:Create(status, TweenInfo.new(0.2), {TextColor3 = active and Theme.AccentOn or Theme.AccentOff}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.2), {Color = active and Theme.AccentOn or Theme.Stroke}):Play()
        callback(active)
    end)
end

local function optimizePart(obj)
    if State.LowGfx then
        if obj:IsA("BasePart") or obj:IsA("MeshPart") then
            obj.Material = Enum.Material.Plastic; obj.Reflectance = 0
        elseif obj:IsA("Decal") or obj:IsA("Texture") then obj.Transparency = 1
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then obj.Enabled = false end
    end
end

-- [TAB 1, 2, 3: GIỮ NGUYÊN NHƯNG ĐƯỢC THỪA HƯỞNG HIỆU ỨNG TWEEN]
createToggle(page1, "🏃 Chạy nhanh", function(v) State.Speed = v end)
createToggle(page1, "🦘 Nhảy cao", function(v) State.Jump = v end)
createToggle(page1, "🚀 Nhảy vô hạn", function(v) State.InfJump = v end) 
UIS.JumpRequest:Connect(function()
    if State.InfJump and player.Character then
        local hum = player.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

createToggle(page2, "👻 Xuyên tường", function(v) State.Noclip = v end)
createToggle(page2, "🎮 Giảm Lag", function(v) 
    State.LowGfx = v 
    if v then Lighting.GlobalShadows = false; pcall(function() settings().Rendering.QualityLevel = 1 end); for _, obj in pairs(workspace:GetDescendants()) do optimizePart(obj) end
    else Lighting.GlobalShadows = true; pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic end) end
end)
createToggle(page2, "👁️ ESP Nhìn Xuyên", function(v) State.ESP = v end)
createToggle(page2, "💡 Phát Sáng", function(v) 
    State.PlayerLight = v 
    if not v and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local light = player.Character.HumanoidRootPart:FindFirstChild("PlayerPointLight")
        if light then light:Destroy() end
    end
end)
createButton(page2, "🌞 TRỜI SÁNG", Color3.fromRGB(243, 156, 18), function() Lighting.ClockTime = 12 end)
createButton(page2, "🌚 TRỜI TỐI", Color3.fromRGB(52, 152, 219), function() Lighting.ClockTime = 0 end)

createToggle(page3, "🖱️ Lấy vật phẩm nhanh", function(v) 
    State.Instant = v 
    if v then for _, prompt in pairs(workspace:GetDescendants()) do if prompt:IsA("ProximityPrompt") then prompt.HoldDuration = 0; prompt.MaxActivationDistance = 20 end end end
end)
ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt) if State.Instant then pcall(function() fireproximityprompt(prompt) end) end end)
createToggle(page3, "🛡️ Anti-AFK", function(v) State.AntiAfk = v end)
createButton(page3, "🕊️ KÍCH HOẠT FLY", Theme.Brand, function()
    pcall(function() loadstring(game:HttpGet(('https://gist.githubusercontent.com/meozoneYT/bf037dff9f0a70017304ddd67fdcd370/raw/e14e74f425b060df523343cf30b787074eb3c5d2/arceus%2520x%2520fly%25202%2520obflucator'),true))() end)
end)

-- [TAB 4: VỊ TRÍ]
local savedLocCount = 0
local function createPosItem(name, cframe)
    local item = Instance.new("Frame", page4)
    item.Size = UDim2.new(0.92, 0, 0, 48); item.BackgroundColor3 = Theme.ItemBg
    Instance.new("UICorner", item).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke", item); stroke.Color = Theme.Stroke; stroke.Thickness = 1
    
    local nameBox = Instance.new("TextBox", item)
    nameBox.Size = UDim2.new(0.45, 0, 1, 0); nameBox.Position = UDim2.new(0.05, 0, 0, 0)
    nameBox.Text = name; nameBox.TextColor3 = Theme.TextTitle
    nameBox.Font = Enum.Font.GothamSemibold; nameBox.TextSize = 12
    nameBox.BackgroundTransparency = 1; nameBox.TextXAlignment = Enum.TextXAlignment.Left; nameBox.ClearTextOnFocus = false
    
    local tpBtn = Instance.new("TextButton", item)
    tpBtn.Size = UDim2.new(0.25, 0, 0.65, 0); tpBtn.Position = UDim2.new(0.53, 0, 0.175, 0)
    tpBtn.Text = "ĐẾN"; tpBtn.BackgroundColor3 = Theme.Brand; tpBtn.TextColor3 = Color3.new(1,1,1)
    tpBtn.Font = Enum.Font.GothamBold; tpBtn.TextSize = 11; Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 6)
    
    local delBtn = Instance.new("TextButton", item)
    delBtn.Size = UDim2.new(0.15, 0, 0.65, 0); delBtn.Position = UDim2.new(0.81, 0, 0.175, 0)
    delBtn.Text = "X"; delBtn.BackgroundColor3 = Theme.AccentOff; delBtn.TextColor3 = Color3.new(1,1,1)
    delBtn.Font = Enum.Font.GothamBold; delBtn.TextSize = 12; Instance.new("UICorner", delBtn).CornerRadius = UDim.new(0, 6)
    
    tpBtn.MouseButton1Click:Connect(function() if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then player.Character.HumanoidRootPart.CFrame = cframe end end)
    delBtn.MouseButton1Click:Connect(function() item:Destroy() end)
end

createButton(page4, "🎯 LƯU VỊ TRÍ HIỆN TẠI", Theme.AccentOn, function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        savedLocCount = savedLocCount + 1
        createPosItem("📌 Vị trí " .. savedLocCount, player.Character.HumanoidRootPart.CFrame)
    end
end)

-- [TAB 5: DANH SÁCH NGƯỜI CHƠI (TÍNH NĂNG ĐƯỢC NÂNG CẤP)]
local function updatePlayerList()
    -- Xóa các nút cũ (trừ nút Làm mới)
    for _, child in pairs(page5:GetChildren()) do
        if child.Name == "PlayerBtn_TP" then child:Destroy() end
    end
    
    -- Tạo nút cho từng người chơi
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player then
            local btn = Instance.new("TextButton", page5)
            btn.Name = "PlayerBtn_TP"
            btn.Size = UDim2.new(0.92, 0, 0, 42)
            btn.BackgroundColor3 = Theme.ItemBg
            btn.Text = "👤 " .. p.DisplayName .. " (@" .. p.Name .. ")"
            btn.TextColor3 = Theme.TextTitle
            btn.Font = Enum.Font.GothamSemibold
            btn.TextSize = 12
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
            local stroke = Instance.new("UIStroke", btn)
            stroke.Color = Theme.Stroke; stroke.Thickness = 1
            
            btn.MouseButton1Click:Connect(function()
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    -- Hiệu ứng chớp nháy màu xanh lá khi dịch chuyển thành công
                    TweenService:Create(stroke, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true), {Color = Theme.AccentOn}):Play()
                    TweenService:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true), {BackgroundColor3 = Color3.fromRGB(40, 50, 45)}):Play()
                    
                    player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
                end
            end)
        end
    end
end

-- Đặt nút làm mới ở đầu trang
createButton(page5, "🔄 LÀM MỚI DANH SÁCH", Theme.Brand, updatePlayerList)
updatePlayerList() -- Khởi chạy list lần đầu

-- [VÒNG LẶP HỆ THỐNG]
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
                if not light then
                    local newLight = Instance.new("PointLight", root)
                    newLight.Name = "PlayerPointLight"; newLight.Brightness = 2; newLight.Range = 150; newLight.Shadows = false
                end
            else
                if light then light:Destroy() end
            end
        end
        
        if State.ESP then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= player and p.Character then
                    local hl = p.Character:FindFirstChild("MobileESP") or Instance.new("Highlight", p.Character)
                    hl.Name = "MobileESP"; hl.Enabled = true; hl.FillTransparency = 0.5; hl.OutlineColor = Theme.Brand
                end
            end
        end
    end
end)

workspace.DescendantAdded:Connect(function(v)
    if State.LowGfx then optimizePart(v) end
    if State.Instant and v:IsA("ProximityPrompt") then v.HoldDuration = 0; v.MaxActivationDistance = 20 end
end)
