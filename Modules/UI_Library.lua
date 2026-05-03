-- ==========================================
    -- 【320 小按鈕】 終極拖拽修復版
    -- ==========================================
    local MiniBtn = Instance.new("TextButton", ScreenGui)
    MiniBtn.Size = UDim2.new(0, 60, 0, 60)
    MiniBtn.Position = UDim2.new(0, 50, 0, 50)
    MiniBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MiniBtn.Text = "320"
    MiniBtn.TextColor3 = Color3.new(1, 1, 1)
    MiniBtn.Font = Enum.Font.GothamBold
    MiniBtn.Visible = false
    MiniBtn.Active = false -- 關鍵：設為 false 讓滑鼠事件穿透到我們的手寫邏輯
    Instance.new("UICorner", MiniBtn).CornerRadius = UDim.new(1, 0)
    
    local MiniStroke = Instance.new("UIStroke", MiniBtn)
    MiniStroke.Thickness = 2

    local dragging = false
    local dragStart, startPos

    -- 透過 UserInputService 監控全局點擊
    S.UIS.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and MiniBtn.Visible then
            local mPos = S.UIS:GetMouseLocation() - game:GetService("GuiService"):GetGuiInset()
            local absPos = MiniBtn.AbsolutePosition
            local absSize = MiniBtn.AbsoluteSize
            
            -- 檢查是否點在按鈕範圍內
            if mPos.X >= absPos.X and mPos.X <= absPos.X + absSize.X and
               mPos.Y >= absPos.Y and mPos.Y <= absPos.Y + absSize.Y then
                
                dragging = true
                dragStart = input.Position
                startPos = MiniBtn.Position
                
                -- 點擊反饋（縮放一下）
                game:GetService("TweenService"):Create(MiniBtn, TweenInfo.new(0.2), {Size = UDim2.new(0, 55, 0, 55)}):Play()
            end
        end
    end)

    S.UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            MiniBtn.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X, 
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    S.UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if dragging then
                dragging = false
                -- 恢復大小並判斷是否為「點擊」
                game:GetService("TweenService"):Create(MiniBtn, TweenInfo.new(0.2), {Size = UDim2.new(0, 60, 0, 60)}):Play()
                
                local delta = (input.Position - dragStart).Magnitude
                if delta < 5 then -- 移動距離小於 5 像素，判定為點擊
                    MainFrame.Visible = true
                    MiniBtn.Visible = false
                end
            end
        end
    end)
