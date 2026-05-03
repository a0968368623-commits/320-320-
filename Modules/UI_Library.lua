local UI_Lib = {}
local S = {
    CG = game:GetService("CoreGui"),
    UIS = game:GetService("UserInputService"),
    RS = game:GetService("RunService"),
    LP = game.Players.LocalPlayer
}

function UI_Lib:Init(Data)
    print("[V1] UI 模組啟動中...")
    
    -- 建立 320 懸浮小按鈕
    local ScreenGui = Instance.new("ScreenGui", S.CG)
    ScreenGui.Name = "320_Core_UI"
    ScreenGui.ResetOnSpawn = false

    local SmallBtn = Instance.new("TextButton", ScreenGui)
    SmallBtn.Size = UDim2.new(0, 60, 0, 60)
    SmallBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
    SmallBtn.Text = "320"
    SmallBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SmallBtn.TextColor3 = Color3.new(1, 1, 1)
    SmallBtn.TextSize = 20
    
    local Corner = Instance.new("UICorner", SmallBtn)
    Corner.CornerRadius = UDim.new(1, 0)
    
    local Stroke = Instance.new("UIStroke", SmallBtn)
    Stroke.Color = Color3.fromRGB(0, 255, 150)
    Stroke.Thickness = 2

    -- 主面板 (修復影片中的路徑報錯)
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.Visible = false -- 預設隱藏
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

    -- 測試用：飛行開關按鈕
    local FlyBtn = Instance.new("TextButton", MainFrame)
    FlyBtn.Size = UDim2.new(0.8, 0, 0, 50)
    FlyBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
    FlyBtn.Text = "穩定飛行: OFF"
    FlyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    FlyBtn.TextColor3 = Color3.new(1, 1, 1)

    local flying = false
    FlyBtn.MouseButton1Click:Connect(function()
        flying = not flying
        FlyBtn.Text = "穩定飛行: " .. (flying and "ON" or "OFF")
        -- 呼叫移動模組
        if Data.MoveFunc then
            Data.MoveFunc:ToggleFly(flying, 150)
        end
    end)

    -- 點擊 320 按鈕切換主面板顯示
    SmallBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
        print("[V1] 主面板狀態: " .. tostring(MainFrame.Visible))
    end)

    -- 讓 320 按鈕可以被拖動 (防止擋住畫面)
    local dragging, dragInput, dragStart, startPos
    SmallBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = SmallBtn.Position
        end
    end)
    S.UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            SmallBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    S.UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)

    print("[V1] UI 初始化成功，點擊紅色圓鈕開啟。")
end

return UI_Lib
