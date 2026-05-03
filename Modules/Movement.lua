local Movement = {SavedPoints = {}}

-- 座標儲存與命名
function Movement:SaveLocation(name)
    local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
    self.SavedPoints[name] = hrp.CFrame
    print("已儲存座標: " .. name)
end

-- 瞬移至座標
function Movement:Teleport(name)
    if self.SavedPoints[name] then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = self.SavedPoints[name]
    end
end

-- 超級飛行 (防回彈版)
function Movement:Fly(state)
    -- 此處填入之前討論的 BodyVelocity 穩定飛行代碼...
end

return Movement
