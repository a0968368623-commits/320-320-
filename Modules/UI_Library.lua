-- ==========================================
    -- 【320 小按鈕】 強制拖拽邏輯
    -- ==========================================
    local MiniBtn = Instance.new("TextButton", ScreenGui)
    MiniBtn.Size = UDim2.new(0, 60, 0, 60)
    MiniBtn.Position = UDim2.new(0, 50, 0, 50)
    MiniBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MiniBtn.Text = "320"
    MiniBtn.TextColor3 = Color3.new(1, 1, 1)
    MiniBtn.Font = Enum.Font.GothamBold
    MiniBtn.Visible = false
    MiniBtn.ClipsDescendants = true
    Instance.new("UICorner", MiniBtn).CornerRadius = UDim.new(1, 0)
    local MiniStroke = Instance.new("UIStroke", MiniBtn)
    MiniStroke.Thickness = 2

    local dragInput, dragStart, startPos
    
    -- 核心：處理輸入開始
    MiniBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragStart = input.Position
            startPos = MiniBtn.Position
            
            -- 監聽移動
            local connection
            connection = S.UIS.InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                    local delta = input.Position - dragStart
                    -- 直接修改偏移量 (Offset)，不動比例 (Scale)
                    MiniBtn.Position = UDim2.new(
                        startPos.X.Scale, 
                        startPos.X.Offset + delta.X, 
                        startPos.Y.Scale, 
                        startPos.Y.Offset + delta.Y
                    )
                end
            end)
            
            -- 監聽放開滑鼠
            MiniBtn.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    if connection then connection:Disconnect() end
                end
            end)
        end
    end)
