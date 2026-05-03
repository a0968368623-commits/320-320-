-- 1. 主介面框架 (確保高度足夠)
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 400, 0, 320) -- 稍微調高一點
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -160)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    
    -- 2. 功能排版容器 (自動排列)
    local Container = Instance.new("ScrollingFrame", MainFrame)
    Container.Size = UDim2.new(1, -20, 1, -60)
    Container.Position = UDim2.new(0, 10, 0, 50)
    Container.BackgroundTransparency = 1
    Container.ScrollBarThickness = 3
    Container.CanvasSize = UDim2.new(0, 0, 0, 400) -- 確保畫布夠長可以滾動

    local Layout = Instance.new("UIListLayout", Container)
    Layout.Padding = UDim.new(0, 8)
    Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    Layout.SortOrder = Enum.SortOrder.LayoutOrder

    -- 3. 打人範圍開關 (Hitbox Toggle)
    local HitboxToggle = Instance.new("TextButton", Container)
    HitboxToggle.Size = UDim2.new(0, 360, 0, 50)
    HitboxToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    HitboxToggle.Text = "打人範圍: 關閉"
    HitboxToggle.TextColor3 = Color3.new(1, 0, 0)
    HitboxToggle.Font = Enum.Font.GothamBold
    HitboxToggle.TextSize = 16
    Instance.new("UICorner", HitboxToggle)

    local hb_on = false
    HitboxToggle.MouseButton1Click:Connect(function()
        hb_on = not hb_on
        HitboxToggle.Text = "打人範圍: " .. (hb_on and "開啟" or "關閉")
        HitboxToggle.TextColor3 = hb_on and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
        
        -- 調用 Combat 模組
        if Data.Combat and Data.Combat.ToggleHitbox then
            Data.Combat:ToggleHitbox(hb_on)
        end
    end)

    -- 4. 範圍數值調整 (TextBox)
    local RangeInput = Instance.new("TextBox", Container)
    RangeInput.Size = UDim2.new(0, 360, 0, 50)
    RangeInput.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    RangeInput.PlaceholderText = "在此輸入範圍數字 (例如: 20)"
    RangeInput.Text = ""
    RangeInput.TextColor3 = Color3.new(1, 1, 1)
    RangeInput.Font = Enum.Font.Gotham
    RangeInput.TextSize = 14
    Instance.new("UICorner", RangeInput)

    RangeInput.FocusLost:Connect(function(enterPressed)
        local num = tonumber(RangeInput.Text)
        if num and Data.Combat and Data.Combat.UpdateSize then
            Data.Combat:UpdateSize(num)
            print("[320] 範圍已設定為: " .. num)
        end
    end)
