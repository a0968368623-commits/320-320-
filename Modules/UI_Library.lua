local UI_Lib = {}

-- 統一變數名稱
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")

function UI_Lib:Init(Data)
    local ScreenGui = Instance.new("ScreenGui", CoreGui)
    ScreenGui.Name = "320_Master_Fixed"
    ScreenGui.ResetOnSpawn = false

    -- ==========================================
    -- 【320 小按鈕】
    -- ==========================================
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

    -- ==========================================
    -- 【主介面 Frame】
    -- ==========================================
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 400, 0, 250)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.Active = true
    MainFrame.Draggable = true 

    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Thickness = 2

    -- 關閉按鈕
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

    -- [ 功能：Hitbox 開關 ]
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

    -- [ 功能：大小輸入 ]
    local Input = Instance.new("TextBox", MainFrame)
    Input.Size = UDim2.new(0, 300, 0, 45)
    Input.Position = UDim2.new(0.5, -150, 0, 120)
    Input.PlaceholderText = "輸入範圍數字"
    Input.Text = "15"
    Input.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Input.TextColor3 = Color3.new(0, 1, 1)
    Input.FocusLost:Connect(function()
        local n = tonumber(Input.Text)
        if n and Data.Combat then Data.Combat:UpdateSize(n) end
    end)

    -- ==========================================
    -- 【小按鈕強制拖拽邏輯】 使用統一變數名
    -- ==========================================
    local dragging = false
    local dragStart, startPos

    UIS.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and MiniBtn.Visible then
            local mPos = UIS:GetMouseLocation() - GuiService:GetGuiInset()
            local absPos = MiniBtn.AbsolutePosition
            local absSize = MiniBtn.AbsoluteSize
            
            if mPos.X >= absPos.X and mPos.X <= absPos.X + absSize.X and
               mPos.Y >= absPos.Y and mPos.Y <= absPos.Y + absSize.Y then
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
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if dragging then
                dragging = false
                local delta = (input.Position - dragStart).Magnitude
                if delta < 5 then
                    MainFrame.Visible = true
                    MiniBtn.Visible = false
                end
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
