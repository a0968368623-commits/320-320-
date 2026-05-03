local UI_Lib = {}

function UI_Lib:Init(Data)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 400, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    
    -- RGB 邊框特效
    local UIStroke = Instance.new("UIStroke", MainFrame)
    UIStroke.Thickness = 3
    
    -- RGB 循環邏輯 (讓邊框顏色一直閃)
    task.spawn(function()
        while true do
            local hue = tick() % 5 / 5
            local color = Color3.fromHSV(hue, 1, 1)
            UIStroke.Color = color
            task.wait()
        end
    end)

    -- 加入輸入框 (用於輸入座標名稱)
    local NameInput = Instance.new("TextBox", MainFrame)
    NameInput.Size = UDim2.new(0.8, 0, 0, 40)
    NameInput.Position = UDim2.new(0.1, 0, 0.1, 0)
    NameInput.PlaceholderText = "輸入座標名稱..."
    NameInput.Text = ""

    -- 儲存按鈕
    local SaveBtn = Instance.new("TextButton", MainFrame)
    SaveBtn.Text = "儲存當前座標"
    SaveBtn.Size = UDim2.new(0.35, 0, 0, 40)
    SaveBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
    SaveBtn.MouseButton1Click:Connect(function()
        Data.Movement:SaveCurrentPos(NameInput.Text ~= "" and NameInput.Text or "未命名")
    end)

    -- 瞬移按鈕
    local TPBtn = Instance.new("TextButton", MainFrame)
    TPBtn.Text = "瞬移到該點"
    TPBtn.Size = UDim2.new(0.35, 0, 0, 40)
    TPBtn.Position = UDim2.new(0.55, 0, 0.3, 0)
    TPBtn.MouseButton1Click:Connect(function()
        Data.Movement:TeleportTo(NameInput.Text)
    end)
    
    -- 打人範圍開關
    local RangeBtn = Instance.new("TextButton", MainFrame)
    RangeBtn.Text = "範圍變大: OFF"
    RangeBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
    RangeBtn.Size = UDim2.new(0.8, 0, 0, 40)
    RangeBtn.MouseButton1Click:Connect(function()
        Data.Combat.Settings.Enabled = not Data.Combat.Settings.Enabled
        RangeBtn.Text = "範圍變大: " .. (Data.Combat.Settings.Enabled and "ON" or "OFF")
    end)
end

return UI_Lib
