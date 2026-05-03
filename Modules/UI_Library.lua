local UI_Lib = {}
local S = {CG = game:GetService("CoreGui"), UIS = game:GetService("UserInputService"), RS = game:GetService("RunService")}

function UI_Lib:Init(Data)
    -- 1. 主框架與拖動 (保持不變)
    local ScreenGui = Instance.new("ScreenGui", S.CG)
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 500, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Active = true
    MainFrame.Draggable = true 

    -- RGB 邊框
    local Stroke = Instance.new("UIStroke", MainFrame)
    Stroke.Thickness = 2
    task.spawn(function()
        while true do
            local hue = tick() % 5 / 5
            Stroke.Color = Color3.fromHSV(hue, 0.8, 1)
            task.wait()
        end
    end)

    -- 2. 左側選單 (SideBar)
    local SideBar = Instance.new("Frame", MainFrame)
    SideBar.Size = UDim2.new(0, 130, 1, 0)
    SideBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

    -- 3. 右側主內容區 (這個就是你影片中空的地方！)
    local Container = Instance.new("Frame", MainFrame)
    Container.Name = "Container"
    Container.Position = UDim2.new(0, 140, 0, 10)
    Container.Size = UDim2.new(1, -150, 1, -20)
    Container.BackgroundTransparency = 1

    -- [ 功能頁面 1: 戰鬥 ]
    local CombatPage = Instance.new("ScrollingFrame", Container)
    CombatPage.Size = UDim2.new(1, 0, 1, 0)
    CombatPage.BackgroundTransparency = 1
    CombatPage.Visible = false -- 預設隱藏

    local HitboxTitle = Instance.new("TextLabel", CombatPage)
    HitboxTitle.Size = UDim2.new(1, 0, 0, 30)
    HitboxTitle.Text = "—— 戰鬥系統 (Combat) ——"
    HitboxTitle.TextColor3 = Color3.new(1, 1, 1)
    HitboxTitle.BackgroundTransparency = 1

    local ToggleHitbox = Instance.new("TextButton", CombatPage)
    ToggleHitbox.Position = UDim2.new(0, 0, 0, 40)
    ToggleHitbox.Size = UDim2.new(1, 0, 0, 40)
    ToggleHitbox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    ToggleHitbox.Text = "開啟巨大判定 (Hitbox): [ 關閉 ]"
    ToggleHitbox.TextColor3 = Color3.new(1, 1, 1)

    -- 點擊邏輯
    local hb_enabled = false
    ToggleHitbox.MouseButton1Click:Connect(function()
        hb_enabled = not hb_enabled
        ToggleHitbox.Text = "開啟巨大判定 (Hitbox): [ " .. (hb_enabled and "開啟" or "關閉") .. " ]"
        ToggleHitbox.TextColor3 = hb_enabled and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
        
        if Data.Combat then
            Data.Combat:ToggleHitbox(hb_enabled, 15) -- 調用 Combat 模組
        end
    end)

    -- 4. 按鈕切換邏輯
    local CombatBtn = Instance.new("TextButton", SideBar)
    CombatBtn.Size = UDim2.new(0.9, 0, 0, 35)
    CombatBtn.Position = UDim2.new(0.05, 0, 0, 50)
    CombatBtn.Text = "⚔️ 戰鬥系統"
    CombatBtn.MouseButton1Click:Connect(function()
        CombatPage.Visible = true -- 點了才顯示右邊內容
    end)

    print("✅ V120 功能頁面已裝載")
end

return UI_Lib
