local UI_Lib = {}
local S = {CG = game:GetService("CoreGui"), UIS = game:GetService("UserInputService")}

function UI_Lib:Init(Data)
    local ScreenGui = Instance.new("ScreenGui", S.CG)
    ScreenGui.Name = "320_Master_System"

    -- 【320 圓形啟動按鈕】
    local MiniBtn = Instance.new("TextButton", ScreenGui)
    MiniBtn.Size = UDim2.new(0, 60, 0, 60)
    MiniBtn.Position = UDim2.new(0, 50, 0, 50)
    MiniBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MiniBtn.Text = "320"
    MiniBtn.TextColor3 = Color3.new(1, 1, 1)
    MiniBtn.Font = Enum.Font.GothamBold
    MiniBtn.Visible = false -- 初始隱藏
    Instance.new("UICorner", MiniBtn).CornerRadius = UDim.new(1, 0)
    local MiniStroke = Instance.new("UIStroke", MiniBtn)
    MiniStroke.Thickness = 2

    -- 【主介面 Frame】
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 450, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.Active = true
    MainFrame.Draggable = true -- 讓介面可以滑鼠拖動

    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Thickness = 2

    -- 最小化功能 (切換 320 按鈕與主介面)
    MiniBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = true
        MiniBtn.Visible = false
    end)

    local CloseBtn = Instance.new("TextButton", MainFrame)
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -35, 0, 5)
    CloseBtn.Text = "—"
    CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    CloseBtn.TextColor3 = Color3.new(1, 1, 1)
    CloseBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
        MiniBtn.Visible = true
    end)

    -- 【功能容器】
    local Container = Instance.new("Frame", MainFrame)
    Container.Position = UDim2.new(0, 20, 0, 40)
    Container.Size = UDim2.new(1, -40, 1, -60)
    Container.BackgroundTransparency = 1

    -- 1. Hitbox 開關按鈕
    local ToggleBtn = Instance.new("TextButton", Container)
    ToggleBtn.Size = UDim2.new(1, 0, 0, 45)
    ToggleBtn.Text = "Hitbox: 關閉"
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ToggleBtn.TextColor3 = Color3.new(1, 0, 0)

    local hb_state = false
    ToggleBtn.MouseButton1Click:Connect(function()
        hb_state = not hb_state
        ToggleBtn.Text = "Hitbox: " .. (hb_state and "開啟" or "關閉")
        ToggleBtn.TextColor3 = hb_state and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
        if Data.Combat then Data.Combat:ToggleHitbox(hb_state) end
    end)

    -- 2. 數字輸入框 (調整範圍)
    local Label = Instance.new("TextLabel", Container)
    Label.Position = UDim2.new(0, 0, 0, 60)
    Label.Size = UDim2.new(1, 0, 0, 30)
    Label.Text = "輸入打人範圍數字 (輸入後按 Enter)"
    Label.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    Label.BackgroundTransparency = 1

    local TextBox = Instance.new("TextBox", Container)
    TextBox.Position = UDim2.new(0, 0, 0, 95)
    TextBox.Size = UDim2.new(1, 0, 0, 40)
    TextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TextBox.Text = "15"
    TextBox.TextColor3 = Color3.new(0, 1, 1)
    TextBox.Font = Enum.Font.Gotham
    TextBox.TextSize = 18

    TextBox.FocusLost:Connect(function(enterPressed)
        local num = tonumber(TextBox.Text)
        if num then
            if Data.Combat then Data.Combat:UpdateSize(num) end
            print("已設定 Hitbox 大小為:", num)
        else
            TextBox.Text = "請輸入數字!"
        end
    end)

    -- RGB 特效
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
