local UI_Lib = {}
local S = {CG = game:GetService("CoreGui"), UIS = game:GetService("UserInputService"), RS = game:GetService("RunService")}

function UI_Lib:Init(Data)
    local ScreenGui = Instance.new("ScreenGui", S.CG)
    ScreenGui.Name = "320_System"
    
    -- 【320 小按鈕】
    local MiniBtn = Instance.new("TextButton", ScreenGui)
    MiniBtn.Size = UDim2.new(0, 60, 0, 60)
    MiniBtn.Position = UDim2.new(0, 20, 0, 20)
    MiniBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MiniBtn.Text = "320"
    MiniBtn.TextColor3 = Color3.new(1, 1, 1)
    MiniBtn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", MiniBtn).CornerRadius = UDim.new(1, 0)
    local MiniStroke = Instance.new("UIStroke", MiniBtn)
    MiniStroke.Thickness = 2

    -- 【主介面】
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 500, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Visible = false -- 初始隱藏
    MainFrame.Active = true
    MainFrame.Draggable = true -- 讓它可以移動

    -- 最小化功能
    MiniBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
        MiniBtn.Visible = not MainFrame.Visible
    end)

    -- 右上角縮小按鈕
    local CloseBtn = Instance.new("TextButton", MainFrame)
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -35, 0, 5)
    CloseBtn.Text = "—"
    CloseBtn.TextColor3 = Color3.new(1, 1, 1)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    CloseBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
        MiniBtn.Visible = true
    end)

    -- 【右側內容區 - 戰鬥分頁】
    local Container = Instance.new("Frame", MainFrame)
    Container.Position = UDim2.new(0, 140, 0, 40)
    Container.Size = UDim2.new(1, -150, 1, -50)
    Container.BackgroundTransparency = 1

    local HitboxLabel = Instance.new("TextLabel", Container)
    HitboxLabel.Size = UDim2.new(1, 0, 0, 30)
    HitboxLabel.Text = "打人範圍 (Size): 15"
    HitboxLabel.TextColor3 = Color3.new(1, 1, 1)
    HitboxLabel.BackgroundTransparency = 1

    -- 滑動條 (Slider)
    local SliderBg = Instance.new("Frame", Container)
    SliderBg.Position = UDim2.new(0, 0, 0, 40)
    SliderBg.Size = UDim2.new(1, 0, 0, 10)
    SliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

    local SliderBtn = Instance.new("TextButton", SliderBg)
    SliderBtn.Size = UDim2.new(0, 20, 1, 10)
    SliderBtn.Position = UDim2.new(0.3, -10, 0, -5) -- 預設值位置
    SliderBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
    SliderBtn.Text = ""

    -- 滑動邏輯
    local dragging = false
    SliderBtn.MouseButton1Down:Connect(function() dragging = true end)
    S.UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
    
    S.UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local relX = math.clamp((input.Position.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
            SliderBtn.Position = UDim2.new(relX, -10, 0, -5)
            local val = math.floor(relX * 50) -- 範圍 0-50
            HitboxLabel.Text = "打人範圍 (Size): " .. val
            
            -- 調用 Combat 模組更新範圍
            if Data.Combat and Data.Combat.UpdateSize then
                Data.Combat:UpdateSize(val)
            end
        end
    end)

    -- RGB 邊框循環
    task.spawn(function()
        while true do
            local color = Color3.fromHSV(tick() % 5 / 5, 0.8, 1)
            MiniStroke.Color = color
            Instance.new("UIStroke", MainFrame).Color = color -- 確保主框也有 RGB
            task.wait()
        end
    end)
end

return UI_Lib
