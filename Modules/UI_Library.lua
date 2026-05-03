local UI_Lib = {}
local S = {
    CG = game:GetService("CoreGui"),
    UIS = game:GetService("UserInputService"),
    RS = game:GetService("RunService"),
    Tween = game:GetService("TweenService")
}

function UI_Lib:Init(Data)
    -- 1. 建立主載體
    local ScreenGui = Instance.new("ScreenGui", S.CG)
    ScreenGui.Name = "Aethelgard_V120_Final"

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 500, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true -- 必須開啟 Active 才能移動
    MainFrame.Draggable = true -- 簡單移動方案 (部分執行器適用)

    -- 2. 專業拖動腳本 (Draggable 的穩定替代方案)
    local function MakeDraggable(gui)
        local dragging, dragInput, dragStart, startPos
        gui.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = gui.Position
            end
        end)
        gui.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                dragInput = input
            end
        end)
        S.UIS.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
        S.UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
    end
    MakeDraggable(MainFrame)

    -- 3. RGB 邊框 (對齊影片視覺)
    local Stroke = Instance.new("UIStroke", MainFrame)
    Stroke.Thickness = 2
    task.spawn(function()
        while true do
            local hue = tick() % 5 / 5
            Stroke.Color = Color3.fromHSV(hue, 0.8, 1)
            task.wait()
        end
    end)

    -- 4. 側邊欄 (分頁切換)
    local SideBar = Instance.new("Frame", MainFrame)
    SideBar.Size = UDim2.new(0, 120, 1, 0)
    SideBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

    local Title = Instance.new("TextLabel", SideBar)
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Text = "AETHELGARD"
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold

    -- 5. 功能按鈕實例 (示範：戰鬥系統)
    local CombatBtn = Instance.new("TextButton", SideBar)
    CombatBtn.Size = UDim2.new(0.9, 0, 0, 35)
    CombatBtn.Position = UDim2.new(0.05, 0, 0, 50)
    CombatBtn.Text = "⚔️ 戰鬥系統"
    CombatBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    CombatBtn.TextColor3 = Color3.new(1, 1, 1)

    CombatBtn.MouseButton1Click:Connect(function()
        print("切換至戰鬥分頁")
        -- 這裡觸發 Data.Combat 裡的功能
        if Data.Combat then
            Data.Combat:ToggleHitbox(true, 15)
        end
    end)

    -- 6. 移動系統 (對齊地點管理功能)
    local MoveBtn = Instance.new("TextButton", SideBar)
    MoveBtn.Size = UDim2.new(0.9, 0, 0, 35)
    MoveBtn.Position = UDim2.new(0.05, 0, 0, 90)
    MoveBtn.Text = "📍 地點管理"
    MoveBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    MoveBtn.TextColor3 = Color3.new(1, 1, 1)

    MoveBtn.MouseButton1Click:Connect(function()
        if Data.Movement then
            Data.Movement:SaveLocation("當前地點")
        end
    end)

    print("✅ V120 完整 UI 已加載 (含拖動功能)")
end

return UI_Lib
