local UI_Lib = {}
local S = {
    CG = game:GetService("CoreGui"),
    UIS = game:GetService("UserInputService"),
    RS = game:GetService("RunService"),
    Tween = game:GetService("TweenService")
}

function UI_Lib:Init(Data)
    -- 1. 建立 UI 載體
    local ScreenGui = Instance.new("ScreenGui", S.CG)
    ScreenGui.Name = "320_Master_V1"
    ScreenGui.ResetOnSpawn = false

    -- 2. 建立「320」懸浮小按鈕 (收納用)
    local MiniBtn = Instance.new("TextButton", ScreenGui)
    MiniBtn.Name = "320_Mini"
    MiniBtn.Size = UDim2.new(0, 50, 0, 50)
    MiniBtn.Position = UDim2.new(0, 50, 0, 50) -- 初始位置
    MiniBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MiniBtn.Text = "320"
    MiniBtn.TextColor3 = Color3.new(1, 1, 1)
    MiniBtn.Font = Enum.Font.GothamBold
    MiniBtn.TextSize = 18
    MiniBtn.Visible = false -- 初始隱藏，打開 UI 後才有用
    
    -- 讓小按鈕也有圓角和 RGB
    local MiniCorner = Instance.new("UICorner", MiniBtn)
    MiniCorner.CornerRadius = ToolResimen and UDim.new(0, 8) or UDim.new(0, 25) -- 圓形
    local MiniStroke = Instance.new("UIStroke", MiniBtn)
    MiniStroke.Thickness = 2

    -- 3. 主介面 (MainFrame)
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 550, 0, 380)
    MainFrame.Position = UDim2.new(0.5, -275, 0.5, -190)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Active = true
    MainFrame.Draggable = true -- 簡單拖拽

    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Thickness = 2

    -- 4. 調整大小功能 (Resize Handle)
    local ResizeHandle = Instance.new("TextButton", MainFrame)
    ResizeHandle.Size = UDim2.new(0, 15, 0, 15)
    ResizeHandle.Position = UDim2.new(1, -15, 1, -15)
    ResizeHandle.Text = "↘"
    ResizeHandle.BackgroundTransparency = 1
    ResizeHandle.TextColor3 = Color3.new(1, 1, 1)

    local resising = false
    ResizeHandle.MouseButton1Down:Connect(function() resising = true end)
    S.UIS.InputEnded:Connect(function(input) 
        if input.UserInputType == Enum.UserInputType.MouseButton1 then resising = false end 
    end)
    S.UIS.InputChanged:Connect(function(input)
        if resising and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = S.UIS:GetMouseLocation()
            local framePos = MainFrame.AbsolutePosition
            local newSize = UDim2.new(0, mousePos.X - framePos.X, 0, (mousePos.Y - 36) - framePos.Y)
            MainFrame.Size = newSize
        end
    end)

    -- 5. RGB 動效 (同步小按鈕與主介面)
    task.spawn(function()
        while true do
            local hue = tick() % 5 / 5
            local color = Color3.fromHSV(hue, 0.8, 1)
            MainStroke.Color = color
            MiniStroke.Color = color
            task.wait()
        end
    end)

    -- 6. 收納/顯示邏輯 (切換 320 按鈕與介面)
    local function ToggleUI()
        local isMainVisible = MainFrame.Visible
        MainFrame.Visible = not isMainVisible
        MiniBtn.Visible = isMainVisible
        print(isMainVisible and "[320] 介面已最小化" or "[320] 介面已還原")
    end

    -- 小按鈕點擊：還原介面
    MiniBtn.MouseButton1Click:Connect(ToggleUI)
    
    -- 主介面關閉按鈕 (修復關閉 Bug，改為縮小至 320 按鈕)
    local CloseBtn = Instance.new("TextButton", MainFrame)
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -35, 0, 5)
    CloseBtn.Text = "—" -- 最小化圖標
    CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    CloseBtn.TextColor3 = Color3.new(1, 1, 1)
    CloseBtn.MouseButton1Click:Connect(ToggleUI)

    -- 讓小按鈕也可以拖動 (防止擋到遊戲 UI)
    local miniDragging, miniDragStart, miniStartPos
    MiniBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            miniDragging = true
            miniDragStart = input.Position
            miniStartPos = MiniBtn.Position
        end
    end)
    S.UIS.InputChanged:Connect(function(input)
        if miniDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - miniDragStart
            MiniBtn.Position = UDim2.new(miniStartPos.X.Scale, miniStartPos.X.Offset + delta.X, miniStartPos.Y.Scale, miniStartPos.Y.Offset + delta.Y)
        end
    end)
    S.UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then miniDragging = false end
    end)

    print("✅ [320 Master] 旗艦級載入完成，按下介面 [—] 號即可收起至 320 按鈕")
end

return UI_Lib
