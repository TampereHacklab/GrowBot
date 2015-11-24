----------- CONFIG -----------
SSID      = "[yourwlanssid"
PASSWORD   = "[yourwlanpasword]"
TIMEOUT    = 30000000 -- 30s
------------------------------

STAMODE = {
STATION_IDLE             = 0,
STATION_CONNECTING       = 1,
STATION_WRONG_PASSWORD   = 2,
STATION_NO_AP_FOUND      = 3,
STATION_CONNECT_FAIL     = 4,
STATION_GOT_IP           = 5
}

function connect(timeout)

    print("Setting up Wi-Fi connection..")
    wifi.setmode(wifi.STATION)
    wifi.sta.config(SSID, PASSWORD)

   local time = tmr.now()
   wifi.sta.connect()

   -- Wait for IP address; check each 1000ms; timeout
   tmr.alarm(1, 1000, 1, 
      function() 
         if wifi.sta.status() == STAMODE.STATION_GOT_IP then 
               tmr.stop(1)
                  print("Station: connected! IP: " .. wifi.sta.getip())
         else
                     if tmr.now() - time > timeout then
                        tmr.stop(1)
                        print("Timeout!")
                        if wifi.sta.status() == STAMODE.STATION_IDLE          then print("Station: idling") end
                        if wifi.sta.status() == STAMODE.STATION_CONNECTING       then print("Station: connecting") end
                        if wifi.sta.status() == STAMODE.STATION_WRONG_PASSWORD    then print("Station: wrong password") end
                        if wifi.sta.status() == STAMODE.STATION_NO_AP_FOUND    then print("Station: AP not found") end
                        if wifi.sta.status() == STAMODE.STATION_CONNECT_FAIL    then print("Station: connection failed") end
                  end
         end 
      end
   )
end

-- Main loop --
connect(TIMEOUT)
