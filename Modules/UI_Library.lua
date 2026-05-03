local UI_Lib = {}
local S = {
    CG = game:GetService("CoreGui"), 
    UIS = game:GetService("UserInputService"), 
    RS = game:GetService("RunService")
}

function UI_Lib:Init(Data)
    local ScreenGui = Instance.new("ScreenGui", S.CG)
    ScreenGui.Name = "320_System_V2"

    -- 【320 小按鈕】
    local MiniBtn = Instance.new("TextButton", ScreenGui)
    MiniBtn.Size = UDim2.new(0, 60, 0, 60)
    MiniBtn.Position = UDim2.new(0, 20, 0, 20)
    MiniBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MiniBtn.Text = "320"
    MiniBtn.TextColor3 = Color3.new(1, 1, 1)
    MiniBtn.Font = Enum.Font.GothamBold
    MiniBtn.Visible = false
    Instance.new("UICorner", MiniBtn).CornerRadius = UDim.new(1, 0)
    local MiniStroke = Instance.new("UIStroke", MiniBtn)
    MiniStroke.Thickness = 2

    -- 【主介面】
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 500, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Active = true
    MainFrame.Draggable = true -- 開啟移動功能

    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Thickness = 2

    -- 最小化/還原切換
    MiniBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = true
        MiniBtn.Visible = false
    end)

    local CloseBtn = Instance.new("TextButton", MainFrame)
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -35, 0, 5)
    CloseBtn.Text = "—"
    CloseBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    CloseBtn.TextColor3 = Color3.new(1, 1, 1)
    CloseBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
        MiniBtn.Visible = true
    end)

    -- 【右側內容區】
    local Container = Instance.new("Frame", MainFrame)
    Container.Position = UDim2.new(0, 140, 0, 40)
    Container.Size = UDim2.new(1, -150, 1, -50)
    Container.BackgroundTransparency = 1

    -- 1. Hitbox 總開關
    local ToggleBtn = Instance.new("TextButton", Container)
    ToggleBtn.Size = UDim2.new(1, 0, 0, 40)
    ToggleBtn.Text = "Hitbox 開關: [ 關閉 ]"
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    ToggleBtn.TextColor3 = Color3.new(1, 0, 0)
    
    local hb_enabled = false
    ToggleBtn.MouseButton1Click:Connect(function()
        hb_enabled = not hb_enabled
        ToggleBtn.Text = "Hitbox 開關: [ " .. (hb_enabled and "開啟" or "關閉") .. " ]"
        ToggleBtn.TextColor3 = hb_enabled and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
        if Data.Combat then Data.Combat:ToggleHitbox(hb_enabled) end
    end)

    -- 2. 數字輸入框 (TextBox)
    local InputLabel = Instance.new("TextLabel", Container)
    InputLabel.Position = UDim2.new(0, 0, 0, 60)
    InputLabel.Size = UDim2.new(1, 0, 0, 30)
    InputLabel.Text = "輸入 Hitbox 數值 (例如: 20)"
    InputLabel.TextColor3 = Color3.new(1, 1, 1)
    InputLabel.BackgroundTransparency = 1

    local SizeInput = Instance.new("TextBox", Container)
    SizeInput.Position = UDim2.new(0, 0, 0, 90)
    SizeInput.Size = UDim2.new(1, 0, 0, 40)
    SizeInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SizeInput.Text = "15" -- 預設數值
    SizeInput.TextColor3 = Color3.new(0, 1, 1)
    SizeInput.Font = Enum.Font.Gotham
    SizeInput.TextSize = 20

    -- 當輸入框內容改變且按下 Enter 時觸發
    SizeInput.FocusLost:Connect(function(enterPressed)
        local val = tonumber(SizeInput.Text)
        if val then
            if Data.Combat and Data.Combat.UpdateSize then
                Data.Combat:UpdateSize(val)
                print("Hitbox 範圍已設定為: " .. val)
            end
        else
            SizeInput.Text = "請輸入數字"
        end
    end)

    -- RGB 循環特效
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
