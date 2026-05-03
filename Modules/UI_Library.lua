local UI_Lib = {}
local S = {
    CG = game:GetService("CoreGui"),
    UIS = game:GetService("UserInputService"),
    RS = game:GetService("RunService")
}

function UI_Lib:Init(Data)
    -- 1. 建立 UI 載體
    local ScreenGui = Instance.new("ScreenGui", S.CG)
    ScreenGui.Name = "320_Master_Final"
    ScreenGui.ResetOnSpawn = false

    -- 2. 320 懸浮小按鈕 (初始隱藏，腳本運行後按下介面上的最小化才會出現)
    local MiniBtn = Instance.new("TextButton", ScreenGui)
    MiniBtn.Size = UDim2.new(0, 60, 0, 60)
    MiniBtn.Position = UDim2.new(0, 20, 0, 20)
    MiniBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MiniBtn.Text = "320"
    MiniBtn.TextColor3 = Color3.new(1, 1, 1)
    MiniBtn.Font = Enum.Font.GothamBold
    MiniBtn.Visible = false
    Instance.new("UICorner", MiniBtn).CornerRadius = UDim.new(1, 0) -- 圓形
    local MiniStroke = Instance.new("UIStroke", MiniBtn)
    MiniStroke.Thickness = 2

    -- 3. 主介面 (MainFrame)
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 500, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Active = true
    MainFrame.Draggable = true 
    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Thickness = 2

    -- 4. 最小化/還原邏輯
    local function ToggleUI()
        MainFrame.Visible = not MainFrame.Visible
        MiniBtn.Visible = not MainFrame.Visible
    end
    MiniBtn.MouseButton1Click:Connect(ToggleUI)

    -- 右上角最小化按鈕
    local CloseBtn = Instance.new("TextButton", MainFrame)
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -35, 0, 5)
    CloseBtn.Text = "—"
    CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    CloseBtn.TextColor3 = Color3.new(1, 1, 1)
    CloseBtn.MouseButton1Click:Connect(ToggleUI)

    -- 5. 右側內容區
    local Container = Instance.new("Frame", MainFrame)
    Container.Position = UDim2.new(0, 140, 0, 40)
    Container.Size = UDim2.new(1, -150, 1, -50)
    Container.BackgroundTransparency = 1

    -- [ 戰鬥功能：調整打人範圍 ]
    local HitboxLabel = Instance.new("TextLabel", Container)
    HitboxLabel.Size = UDim2.new(1, 0, 0, 30)
    HitboxLabel.Text = "打人範圍 (Hitbox Size): 15"
    HitboxLabel.TextColor3 = Color3.new(1, 1, 1)
    HitboxLabel.BackgroundTransparency = 1

    -- 滑動條背景
    local SliderBg = Instance.new("Frame", Container)
    SliderBg.Position = UDim2.new(0, 0, 0, 40)
    SliderBg.Size = UDim2.new(1, 0, 0, 10)
    SliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

    -- 滑動按鈕
    local SliderBtn = Instance.new("TextButton", SliderBg)
    SliderBtn.Size = UDim2.new(0, 20, 1, 10)
    SliderBtn.Position = UDim2.new(0.3, -10, 0, -5) -- 預設 15 (範圍 0-50)
    SliderBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
    SliderBtn.Text = ""

    -- 滑動邏輯
    local dragging = false
    SliderBtn.MouseButton1Down:Connect(function() dragging = true end)
    S.UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
    
    S.UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local relativeX = math.clamp((input.Position.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
            SliderBtn.Position = UDim2.new(relativeX, -10, 0, -5)
            
            local val = math.floor(relativeX * 50) -- 最大範圍 50
            HitboxLabel.Text = "打人範圍 (Hitbox Size): " .. val
            
            -- 即時更新 Combat 模組的數值
            if Data.Combat and Data.Combat.UpdateSize then
                Data.Combat:UpdateSize(val)
            end
        end
    end)

    -- 6. RGB 循環
    task.spawn(function()
        while true do
            local color = Color3.fromHSV(tick() % 5 / 5, 0.8, 1)
            MainStroke.Color = color
            MiniStroke.Color = color
            task.wait()
        end
    end)
end

return UI_Lib
