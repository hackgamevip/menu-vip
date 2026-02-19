-- ==========================================
-- PRO MAX MOBILE EDITION V20 (ALWAYS ON TOP)
-- ==========================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local UIS = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local ProximityPromptService = game:GetService("ProximityPromptService")
local player = Players.LocalPlayer
local State = {
    Instant = false, Noclip = false, LowGfx = false, Speed = false, Jump = false,
    InfJump = false, PlayerLight = false, ESP = false, AntiAfk = false,
    SpeedValue = 60, JumpValue = 120
}
-- [BẢNG MÀU CHỦ ĐẠO - THEME]
local Theme = {
    MainBg = Color3.fromRGB(20, 20, 25),
    HeaderBg = Color3.fromRGB(25, 25, 30),
    TabBg = Color3.fromRGB(30, 30, 35),
    ItemBg = Color3.fromRGB(35, 35, 42),
    Stroke = Color3.fromRGB(60, 60, 70),
    TextTitle = Color3.fromRGB(255, 255, 255),
    TextDim = Color3.fromRGB(160, 160, 170),
    AccentOn = Color3.fromRGB(46, 204, 113),  
    AccentOff = Color3.fromRGB(255, 71, 87),  
    Brand = Color3.fromRGB(0, 190, 255)       
}

-- [1. GIAO DIỆN CHÍNH]
local gui = Instance.new("ScreenGui")
gui.Name = "MobileProMax_V20"
gui.ResetOnSpawn = false
gui.DisplayOrder = 99999 -- ÉP MENU NỔI LÊN TRÊN CÙNG MỌI GIAO DIỆN GAME CÓ SẴN
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
gui.Parent = player:WaitForChild("PlayerGui")

-- [NÚT MỞ MENU & LOGIC KÉO THẢ NÚT]
local openBtn = Instance.new("TextButton", gui)
openBtn.Size = UDim2.new(0, 90, 0, 38)
openBtn.Position = UDim2.new(0, 15, 0, 15)
openBtn.Text = "✅ MENU"
openBtn.BackgroundColor3 = Theme.ItemBg
openBtn.TextColor3 = Theme.TextTitle
openBtn.Font = Enum.Font.GothamBold
openBtn.TextSize = 13
openBtn.Active = true
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1, 0)
local openStroke = Instance.new("UIStroke", openBtn)
openStroke.Color = Theme.Brand; openStroke.Thickness = 1.5; openStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
local btnDragToggle, btnDragStart, btnStartPos
local isDraggingBtn = false
openBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        btnDragToggle = true
        btnDragStart = input.Position
        btnStartPos = openBtn.Position
        isDraggingBtn = false
    end
end)
UIS.InputChanged:Connect(function(input)
    if btnDragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - btnDragStart
        if delta.Magnitude > 5 then
            isDraggingBtn = true
        end
        openBtn.Position = UDim2.new(btnStartPos.X.Scale, btnStartPos.X.Offset + delta.X, btnStartPos.Y.Scale, btnStartPos.Y.Offset + delta.Y)
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        btnDragToggle = false
    end
end)

-- KHUNG MENU CHÍNH
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 330, 0, 420)
frame.Position = UDim2.new(0.5, -165, 1.2, 0)
frame.BackgroundColor3 = Theme.MainBg
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)
local frameStroke = Instance.new("UIStroke", frame)
frameStroke.Color = Theme.Stroke; frameStroke.Thickness = 1
local header = Instance.new("Frame", frame)
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Theme.HeaderBg
header.BorderSizePixel = 0
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)
local headerCover = Instance.new("Frame", header) 
headerCover.Size = UDim2.new(1, 0, 0, 10); headerCover.Position = UDim2.new(0, 0, 1, -10)
headerCover.BackgroundColor3 = Theme.HeaderBg; headerCover.BorderSizePixel = 0
local titleLabel = Instance.new("TextLabel", header)
titleLabel.Size = UDim2.new(1, 0, 1, 0); titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🇻🇳 MENU VIP PRO 🇻🇳"
titleLabel.TextColor3 = Theme.Brand; titleLabel.Font = Enum.Font.GothamBold; titleLabel.TextSize = 14

-- [2. KÉO THẢ KHUNG MENU MƯỢT MÀ]
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

-- [3. HỆ THỐNG TAB HIỆN ĐẠI]
local tabBar = Instance.new("Frame", frame)
tabBar.Size = UDim2.new(1, 0, 0, 40)
tabBar.Position = UDim2.new(0, 0, 0, 40)
tabBar.BackgroundColor3 = Theme.TabBg
tabBar.BorderSizePixel = 0
local function createTab(name, x, width)
    local btn = Instance.new("TextButton", tabBar)
    btn.Size = UDim2.new(width, 0, 1, 0)
    btn.Position = UDim2.new(x, 0, 0, 0)
    btn.Text = name; btn.BackgroundTransparency = 1
    btn.TextColor3 = Theme.TextDim; btn.Font = Enum.Font.GothamBold; btn.TextSize = 11
    local indicator = Instance.new("Frame", btn)
    indicator.Size = UDim2.new(0.6, 0, 0, 3); indicator.Position = UDim2.new(0.2, 0, 1, -3)
    indicator.BackgroundColor3 = Theme.Brand; indicator.BorderSizePixel = 0; indicator.Visible = false
    Instance.new("UICorner", indicator).CornerRadius = UDim.new(1, 0)
    return btn, indicator
end
local tab1, ind1 = createTab("🤵NHÂN VẬT", 0, 0.25)
local tab2, ind2 = createTab("🌍THẾ GIỚI", 0.25, 0.25)
local tab3, ind3 = createTab("💻TIỆN ÍCH", 0.50, 0.25)
local tab4, ind4 = createTab("📍SAVE V1", 0.75, 0.25)
local pageContainer = Instance.new("Frame", frame)
pageContainer.Size = UDim2.new(1, 0, 1, -80); pageContainer.Position = UDim2.new(0, 0, 0, 80)
pageContainer.BackgroundTransparency = 1
local function createPage()
    local pg = Instance.new("ScrollingFrame", pageContainer)
    pg.Size = UDim2.new(1, 0, 1, 0); pg.BackgroundTransparency = 1
    pg.CanvasSize = UDim2.new(0, 0, 0, 650); pg.ScrollBarThickness = 2
    pg.ScrollBarImageColor3 = Theme.Brand; pg.Visible = false
    local layout = Instance.new("UIListLayout", pg)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center; layout.Padding = UDim.new(0, 8)
    Instance.new("UIPadding", pg).PaddingTop = UDim.new(0, 10); Instance.new("UIPadding", pg).PaddingBottom = UDim.new(0, 10)
    return pg
end
local page1, page2, page3, page4 = createPage(), createPage(), createPage(), createPage()
local function showTab(pg, tb, ind)
    page1.Visible = false; page2.Visible = false; page3.Visible = false; page4.Visible = false
    tab1.TextColor3 = Theme.TextDim; tab2.TextColor3 = Theme.TextDim; tab3.TextColor3 = Theme.TextDim; tab4.TextColor3 = Theme.TextDim
    ind1.Visible = false; ind2.Visible = false; ind3.Visible = false; ind4.Visible = false
    pg.Visible = true; tb.TextColor3 = Theme.TextTitle; ind.Visible = true
end
tab1.MouseButton1Click:Connect(function() showTab(page1, tab1, ind1) end)
tab2.MouseButton1Click:Connect(function() showTab(page2, tab2, ind2) end)
tab3.MouseButton1Click:Connect(function() showTab(page3, tab3, ind3) end)
tab4.MouseButton1Click:Connect(function() showTab(page4, tab4, ind4) end)
showTab(page1, tab1, ind1)

local opened = false
openBtn.MouseButton1Click:Connect(function()
    if isDraggingBtn then return end 
    
    opened = not opened
    openBtn.Text = opened and "❌ ĐÓNG" or "✅ MENU"
    openStroke.Color = opened and Theme.AccentOff or Theme.Brand
    frame:TweenPosition(opened and UDim2.new(0.5, -165, 0.5, -210) or UDim2.new(0.5, -165, 1.2, 0), "Out", "Back", 0.4)
end)

-- [4. HÀM TẠO NÚT MENU]
local function createButton(parent, text, color, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.92, 0, 0, 42); btn.BackgroundColor3 = Theme.ItemBg; btn.Text = ""
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke", btn); stroke.Color = color; stroke.Thickness = 1.5; stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    local title = Instance.new("TextLabel", btn)
    title.Size = UDim2.new(1, 0, 1, 0); title.BackgroundTransparency = 1; title.Text = text
    title.TextColor3 = color; title.Font = Enum.Font.GothamBold; title.TextSize = 13
    btn.MouseButton1Click:Connect(callback)
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
        status.TextColor3 = active and Theme.AccentOn or Theme.AccentOff
        stroke.Color = active and Theme.AccentOn or Theme.Stroke
        callback(active)
    end)
end

local function optimizePart(obj)
    if State.LowGfx then
        if obj:IsA("BasePart") or obj:IsA("MeshPart") then
            obj.Material = Enum.Material.Plastic; obj.Reflectance = 0
        elseif obj:IsA("Decal") or obj:IsA("Texture") then
            obj.Transparency = 1
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
            obj.Enabled = false
        end
    end
end

-- [TAB 1: NHÂN VẬT]
createToggle(page1, "🏃 Chạy nhanh", function(v) State.Speed = v end)
createToggle(page1, "🦘 Nhảy cao", function(v) State.Jump = v end)
createToggle(page1, "🚀 Nhảy vô hạn", function(v) State.InfJump = v end) 
UIS.JumpRequest:Connect(function()
    if State.InfJump and player.Character then
        local hum = player.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

-- [TAB 2: THẾ GIỚI]
createToggle(page2, "👻 Xuyên tường", function(v) State.Noclip = v end)
createToggle(page2, "🎮 Giảm Lag", function(v) 
    State.LowGfx = v 
    if v then
        Lighting.GlobalShadows = false
        pcall(function() settings().Rendering.QualityLevel = 1 end)
        for _, obj in pairs(workspace:GetDescendants()) do optimizePart(obj) end
    else
        Lighting.GlobalShadows = true
        pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic end)
    end
end)
createToggle(page2, "👁️ Hiện ví trí người chơi (ESP)", function(v) State.ESP = v end)
createToggle(page2, "💡 Ánh sáng xung quanh", function(v) 
    State.PlayerLight = v 
    if not v then
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local light = char.HumanoidRootPart:FindFirstChild("PlayerPointLight")
            if light then light:Destroy() end
        end
    end
end)
createButton(page2, "🌞 TRỜI SÁNG", Color3.fromRGB(243, 156, 18), function() Lighting.ClockTime = 12 end)
createButton(page2, "🌚 TRỜI TỐI", Color3.fromRGB(52, 152, 219), function() Lighting.ClockTime = 0 end)

-- [TAB 3: TIỆN ÍCH]
createToggle(page3, "🖱️ Lấy vật phẩm nhanh", function(v) 
    State.Instant = v 
    if v then
        for _, prompt in pairs(workspace:GetDescendants()) do
            if prompt:IsA("ProximityPrompt") then
                prompt.HoldDuration = 0; prompt.MaxActivationDistance = 20
            end
        end
    end
end)
ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
    if State.Instant then pcall(function() fireproximityprompt(prompt) end) end
end)
createToggle(page3, "🛡️ Anti-AFK", function(v) State.AntiAfk = v end)

-- CHUYỂN CÁC SCRIPT EXTERNAL QUA ĐÂY
createButton(page3, "🕊️ KÍCH HOẠT FLY (SCRIPT)", Theme.Brand, function()
    pcall(function()
        loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\40\39\104\116\116\112\115\58\47\47\103\105\115\116\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\109\101\111\122\111\110\101\89\84\47\98\102\48\51\55\100\102\102\57\102\48\97\55\48\48\49\55\51\48\52\100\100\100\54\55\102\100\99\100\51\55\48\47\114\97\119\47\101\49\52\101\55\52\102\52\50\53\98\48\54\48\100\102\53\50\51\51\52\51\99\102\51\48\98\55\56\55\48\55\52\101\98\51\99\53\100\50\47\97\114\99\101\117\115\37\50\53\50\48\120\37\50\53\50\48\102\108\121\37\50\53\50\48\50\37\50\53\50\48\111\98\102\108\117\99\97\116\111\114\39\41\44\116\114\117\101\41\41\40\41\10\10")()
    end)
end)
createButton(page3, "📂 Tp SAVE V2 (SCRIPT)", Theme.Brand, function()
    pcall(function()
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/0Ben1/fe/main/Tp%20Place%20GUI'),true))()
    end)
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
    nameBox.BackgroundTransparency = 1; nameBox.TextXAlignment = Enum.TextXAlignment.Left
    nameBox.ClearTextOnFocus = false; nameBox.PlaceholderText = "Nhập tên..."
    
    local tpBtn = Instance.new("TextButton", item)
    tpBtn.Size = UDim2.new(0.25, 0, 0.65, 0); tpBtn.Position = UDim2.new(0.53, 0, 0.175, 0)
    tpBtn.Text = "ĐẾN"; tpBtn.BackgroundColor3 = Theme.Brand; tpBtn.TextColor3 = Color3.new(1,1,1)
    tpBtn.Font = Enum.Font.GothamBold; tpBtn.TextSize = 11
    Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 6)
    
    local delBtn = Instance.new("TextButton", item)
    delBtn.Size = UDim2.new(0.15, 0, 0.65, 0); delBtn.Position = UDim2.new(0.81, 0, 0.175, 0)
    delBtn.Text = "X"; delBtn.BackgroundColor3 = Theme.AccentOff; delBtn.TextColor3 = Color3.new(1,1,1)
    delBtn.Font = Enum.Font.GothamBold; delBtn.TextSize = 12
    Instance.new("UICorner", delBtn).CornerRadius = UDim.new(0, 6)
    
    tpBtn.MouseButton1Click:Connect(function() if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then player.Character.HumanoidRootPart.CFrame = cframe end end)
    delBtn.MouseButton1Click:Connect(function() item:Destroy() end)
end

createButton(page4, "🎯 LƯU VỊ TRÍ HIỆN TẠI", Theme.AccentOn, function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        savedLocCount = savedLocCount + 1
        createPosItem("📌 Vị trí " .. savedLocCount, player.Character.HumanoidRootPart.CFrame)
    end
end)

-- [VÒNG LẶP HỆ THỐNG CHÍNH]
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
                    hl.Name = "MobileESP"; hl.Enabled = true; hl.FillTransparency = 0.5
                end
            end
        end
    end
end)

workspace.DescendantAdded:Connect(function(v)
    if State.LowGfx then optimizePart(v) end
    if State.Instant and v:IsA("ProximityPrompt") then v.HoldDuration = 0; v.MaxActivationDistance = 20 end
end)

print("PRO MAX V20 - UI OVERLAP FIXED!")
