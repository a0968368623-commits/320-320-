local Combat = {}

function Combat:SetHitbox(State, Size)
    if State then
        print("[戰鬥] Hitbox 已開啟，大小：" .. Size)
        -- 這裡寫入原本的循環 Hitbox 邏輯
    else
        print("[戰鬥] Hitbox 已關閉")
    end
end

return Combat
