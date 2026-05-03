local Move_Mod = {}
local S = {
    RS = game:GetService("RunService"),
    LP = game.Players.LocalPlayer,
    UIS = game:GetService("UserInputService")
}

function Move_Mod:ToggleFly(State, Speed)
    local char = S.LP.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local HRP = char.HumanoidRootPart

    -- 清除舊的飛行力道
    if char:FindFirstChild("320_FlyForce") then char["320_FlyForce"]:Destroy() end

    if State then
        -- 建立抗重力
        local bg = Instance.new("BodyGyro", HRP)
        bg.Name = "320_FlyForce"
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = HRP.CFrame

        local bv = Instance.new("BodyVelocity", HRP)
        bv.Name = "320_FlyVelocity"
        bv.velocity = Vector3.new(0, 0.1, 0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)

        -- 飛行循環
        task.spawn(function()
            while State and char:FindFirstChild("320_FlyForce") do
                local dt = S.RS.RenderStepped:Wait()
                local CamCF = workspace.CurrentCamera.CFrame
                local dir = Vector3.new(0, 0, 0)

                if S.UIS:IsKeyDown(Enum.KeyCode.W) then dir = dir + CamCF.LookVector end
                if S.UIS:IsKeyDown(Enum.KeyCode.S) then dir = dir - CamCF.LookVector end
                if S.UIS:IsKeyDown(Enum.KeyCode.A) then dir = dir - CamCF.RightVector end
                if S.UIS:IsKeyDown(Enum.KeyCode.D) then dir = dir + CamCF.RightVector end
                
                bv.velocity = dir * Speed
                bg.cframe = CamCF
            end
            -- 關閉時清除
            bg:Destroy()
            bv:Destroy()
        end)
    end
end

return Move_Mod
