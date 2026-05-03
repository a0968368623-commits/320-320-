local UI_Lib = {}

local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")

function UI_Lib:Init(Data)
    local ScreenGui = Instance.new("ScreenGui", CoreGui)
    ScreenGui.Name = "320_Master_Complete"
    ScreenGui.ResetOnSpawn = false

    -- 1. 小按鈕 (MiniBtn)
    local MiniBtn = Instance.new("TextButton", ScreenGui)
    MiniBtn.Size = UDim2.new(0, 60, 0, 60)
    MiniBtn.Position = UDim2.new(0, 50, 0, 50)
    MiniBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MiniBtn.Text = "320"
    MiniBtn.TextColor3 = Color3.new(1, 1, 1)
    MiniBtn.Font = Enum.Font.GothamBold
    MiniBtn.Visible = false 
    MiniBtn.Active = false
    Instance.new("UICorner", MiniBtn).CornerRadius = UDim.new(1, 0)
    local MiniStroke = Instance.new("UIStroke", MiniBtn)
    MiniStroke.Thickness = 2

    -- 2. 主介面 (MainFrame)
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.Active = true
    MainFrame.Draggable = true 
    
    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Thickness = 2
    Instance.new("UICorner", MainFrame)

    -- 標題
    local Title = Instance.new("TextLabel", MainFrame)
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Text = "320 MASTER - V1"
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18

    -- 3. 功能容器 (這是讓內容出現的關鍵)
    local Container = Instance.new("ScrollingFrame", MainFrame)
    Container.Size = UDim2.new(1, -20, 1, -60)
    Container.Position = UDim2.new(0, 10, 0, 50)
    Container.BackgroundTransparency = 1
    Container.CanvasSize = UDim2.new(0, 0, 2, 0)
    Container.ScrollBarThickness = 2

    local Layout = Instance.new("UIListLayout", Container)
    Layout.Padding = UDim.new(0, 10)
    Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    -- [ 功能 A：Hitbox 開關 ]
    local HitboxBtn = Instance.new("TextButton", Container)
    HitboxBtn.Size = UDim2.new(0, 350, 0, 45)
    HitboxBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    HitboxBtn.Text = "Hitbox: 關閉"
    HitboxBtn.TextColor3 = Color3.new(1, 0, 0)
    HitboxBtn.Font = Enum.Font.Gotham
    Instance.new("UICorner", HitboxBtn)

    local hb_on = false
    HitboxBtn.MouseButton1Click:Connect(function()
        hb_on = not hb_on
        HitboxBtn.Text = "Hitbox: " .. (hb_on and "開啟" or "關閉")
        HitboxBtn.TextColor3 = hb_on and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
        if Data.Combat then Data.Combat:ToggleHitbox(hb_on) end
    end)

    -- [ 功能 B：範圍輸入 ]
    local SizeInput = Instance.new("TextBox", Container)
    SizeInput.Size = UDim2.new(0, 350, 0, 45)
    SizeInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SizeInput.PlaceholderText = "設置 Hitbox 大小 (預設 15)"
    SizeInput.Text = ""
    SizeInput.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", SizeInput)

    SizeInput.FocusLost:Connect(function()
        local val = tonumber(SizeInput.Text)
        if val and Data.Combat then
            Data.Combat:UpdateSize(val)
            print("[320] 範圍已更新: " .. val)
        end
    end)

    -- 最小化按鈕邏輯
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

    -- 小按鈕拖拽 (UIS 版本)
    local dragging = false
    local dragStart, startPos
    UIS.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and MiniBtn.Visible then
            local mPos = UIS:GetMouseLocation() - GuiService:GetGuiInset()
            if mPos.X >= MiniBtn.AbsolutePosition.X and mPos.X <= MiniBtn.AbsolutePosition.X + MiniBtn.AbsoluteSize.X and
               mPos.Y >= MiniBtn.AbsolutePosition.Y and mPos.Y <= MiniBtn.AbsolutePosition.Y + MiniBtn.AbsoluteSize.Y then
                dragging = true
                dragStart = input.Position
                startPos = MiniBtn.Position
            end
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            MiniBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragging = false
            if (input.Position - dragStart).Magnitude < 5 then
                MainFrame.Visible = true
                MiniBtn.Visible = false
            end
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
