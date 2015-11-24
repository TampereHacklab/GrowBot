

-- Safe boot --
countdown = 3;
tmr.alarm(0,1000,1,function()
    print(countdown)
    countdown = countdown-1
    if countdown < 1 then
        tmr.stop(0)
        countdown = nil
        local s,err
        
        if file.open("ConnectWifi.lua") then
            file.close()
            s,err = pcall(function() dofile("ConnectWiFi.lua") end)
        end

        if file.open("main.lua") then
            file.close()
            s,err = pcall(function() dofile("main.lua") end)
        end
    end
end)

