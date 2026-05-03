local UI_Lib = {}
local S = {CG = game:GetService("CoreGui"), UIS = game:GetService("UserInputService")}

function UI_Lib:Init(Data)
    local ScreenGui = Instance.new("ScreenGui", S.CG)
    
    -- [ 320 小按鈕 ]
    local MiniBtn = Instance.new("TextButton", ScreenGui)
    MiniBtn.Size = UDim2.new(0, 60, 0, 60)
    MiniBtn.Position = UDim2.new(0, 20, 0, 20)
    MiniBtn.Text = "320"; MiniBtn.Visible = false
    Instance.new("UICorner", MiniBtn).CornerRadius = UDim.new(1, 0)
    local MiniStroke = Instance.new("UIStroke", MiniBtn); MiniStroke.Thickness = 2

    -- [ 主介面 ]
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 400, 0, 250)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
    MainFrame.Active = true
    MainFrame.Draggable = true -- 讓你可以用滑鼠移動 UI

    local MainStroke = Instance.new("UIStroke", MainFrame); MainStroke.Thickness = 2

    -- 最小化功能
    MiniBtn.MouseButton1Click:Connect(function() MainFrame.Visible = true; MiniBtn.Visible = false end)
    
    local CloseBtn = Instance.new("TextButton", MainFrame)
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -35, 0, 5)
    CloseBtn.Text = "—"
    CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false; MiniBtn.Visible = true end)

    -- [ Hitbox 功能區 ]
    local Toggle = Instance.new("TextButton", MainFrame)
    Toggle.Size = UDim2.new(0, 300, 0, 40)
    Toggle.Position = UDim2.new(0.5, -150, 0, 60)
    Toggle.Text = "Hitbox: 關閉"
    
    local hb_on = false
    Toggle.MouseButton1Click:Connect(function()
        hb_on = not hb_on
        Toggle.Text = hb_on and "Hitbox: 開啟" or "關閉"
        if Data.Combat then Data.Combat:ToggleHitbox(hb_on) end
    end)

    local Input = Instance.new("TextBox", MainFrame)
    Input.Size = UDim2.new(0, 300, 0, 40)
    Input.Position = UDim2.new(0.5, -150, 0, 110)
    Input.PlaceholderText = "輸入大小 (按 Enter 生效)"
    Input.Text = "15"

    Input.FocusLost:Connect(function(enter)
        local n = tonumber(Input.Text)
        if n and Data.Combat then Data.Combat:UpdateSize(n) end
    end)

    -- RGB 特效
    task.spawn(function()
        while true do
            local color = Color3.fromHSV(tick() % 5 / 5, 0.8, 1)
            MainStroke.Color = color; MiniStroke.Color = color; task.wait()
        end
    end)
end

return UI_Lib
