local Movement = {}

function Movement:ToggleFly(State, Speed)
    if State then
        print("[移動] 雲端飛行加載成功，速度：" .. Speed)
        -- 這裡寫入防回彈的 Heartbeat 飛行邏輯
    end
end

return Movement
