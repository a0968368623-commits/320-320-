local Combat = {
    Settings = {
        HitboxSize = 10,
        HitboxTransparency = 0.7,
        Enabled = false
    }
}

function Combat:Init()
    game:GetService("RunService").Stepped:Connect(function()
        if self.Settings.Enabled then
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character then
                    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.Size = Vector3.new(self.Settings.HitboxSize, self.Settings.HitboxSize, self.Settings.HitboxSize)
                        hrp.Transparency = self.Settings.HitboxTransparency
                        hrp.CanCollide = false -- 防止碰撞導致回彈
                    end
                end
            end
        end
    end)
end

return Combat
