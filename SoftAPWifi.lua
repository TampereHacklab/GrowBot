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

function CreateAP(timeout)

    print("Setting up Wi-Fi connection..")
    
	
	local str=wifi.ap.getmac();
	local ssidTemp=string.format("%s%s%s",string.sub(str,10,11),string.sub(str,13,14),string.sub(str,16,17));
  
	
	cfg={}
	cfg.ssid = "GrowBot station "..ssidTemp; 
	cfg.pwd = "GrowBotPWD";
	
	wifi.ap.config(cfg);
	
	cfg={}
	cfg.ip="192.168.9.1";
	cfg.netmask="255.255.255.0";
	cfg.gateway="192.168.1.1";
	wifi.ap.setip(cfg);
	wifi.setmode(wifi.SOFTAP)
	
	str=nil;
	ssidTemp=nil;
	collectgarbage();
     
	print("Soft AP started")
	print("Heap:(bytes)"..node.heap());
	print("MAC:"..wifi.ap.getmac().."\r\nIP:"..wifi.ap.getip());
end

-- Main loop --
CreateAP()
