local UI_Lib = {}
local S = {
    CG = game:GetService("CoreGui"), 
    UIS = game:GetService("UserInputService"),
    Tween = game:GetService("TweenService")
}

function UI_Lib:Init(Data)
    local ScreenGui = Instance.new("ScreenGui", S.CG)
    ScreenGui.Name = "320_Master_Final"

    -- ==========================================
    -- 【320 小按鈕】 加入手寫拖拽邏輯
    -- ==========================================
    local MiniBtn = Instance.new("TextButton", ScreenGui)
    MiniBtn.Size = UDim2.new(0, 60, 0, 60)
    MiniBtn.Position = UDim2.new(0, 50, 0, 50)
    MiniBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MiniBtn.Text = "320"
    MiniBtn.TextColor3 = Color3.new(1, 1, 1)
    MiniBtn.Font = Enum.Font.GothamBold
    MiniBtn.Visible = false
    Instance.new("UICorner", MiniBtn).CornerRadius = UDim.new(1, 0)
    local MiniStroke = Instance.new("UIStroke", MiniBtn)
    MiniStroke.Thickness = 2

    -- 小按鈕拖拽實現
    local dragToggle, dragStart, startPos
    MiniBtn.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragToggle = true
            dragStart = input.Position
            startPos = MiniBtn.Position
        end
    end)

    S.UIS.InputChanged:Connect(function(input)
        if dragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            MiniBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    MiniBtn.InputEnded:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragToggle = false
        end
    end)

    -- ==========================================
    -- 【主介面 Frame】
    -- ==========================================
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 400, 0, 250)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.Active = true
    MainFrame.Draggable = true -- 主介面使用內建拖拽

    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Thickness = 2

    -- 最小化功能
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

    -- [ Hitbox 控制區 ]
    local Toggle = Instance.new("TextButton", MainFrame)
    Toggle.Size = UDim2.new(0, 300, 0, 45)
    Toggle.Position = UDim2.new(0.5, -150, 0, 60)
    Toggle.Text = "Hitbox: 關閉"
    Toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Toggle.TextColor3 = Color3.new(1, 0, 0)
    
    local hb_on = false
    Toggle.MouseButton1Click:Connect(function()
        hb_on = not hb_on
        Toggle.Text = "Hitbox: " .. (hb_on and "開啟" or "關閉")
        Toggle.TextColor3 = hb_on and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
        if Data.Combat then Data.Combat:ToggleHitbox(hb_on) end
    end)

    local Input = Instance.new("TextBox", MainFrame)
    Input.Size = UDim2.new(0, 300, 0, 45)
    Input.Position = UDim2.new(0.5, -150, 0, 120)
    Input.PlaceholderText = "輸入範圍數字 (Enter 生效)"
    Input.Text = "15"
    Input.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Input.TextColor3 = Color3.new(0, 1, 1)

    Input.FocusLost:Connect(function(enter)
        local n = tonumber(Input.Text)
        if n and Data.Combat then 
            Data.Combat:UpdateSize(n) 
            print("範圍更新為: " .. n)
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
