{config, pkgs, ...}:

{
  home.username = "ozen";
  home.homeDirectory = "/home/ozen";

  home.packages = with pkgs; [
    neofetch
    lshw
    asusctl
    pavucontrol
  ];


  programs.git = {

     enable = true;
     userName = "kix300";
     userEmail = "kixwalkiki@gmail.com";

  };

  programs.starship = {
     enable = true;

     settings = {
       add_newline = false;
       aws.disabled = true;
       gcloud.disabled = true;
       line_break.disabled = true;
     };
  };

  programs.waybar = {
    enable = true;
    
    settings = {
       mainBar = {
         layer = "top";
         position = "top";
         height = 32;
         output = [
           "eDP-1"
           "HDMI-A-1"
         ];
    	 modules-left = [ "hyprland/workspaces" ];
    	 modules-center = [ "clock" ];
    	 modules-right = [ "network" "temperature" "battery" ];

    	 "hyprland/workspaces" = {
      	   disable-scroll = true;
      	   all-outputs = true;
         };
	
	 "clock" = {
   	   format = "{:%H:%M}";
	   max-lenght = 25;
	 };
	 
	 "network" = {
	   format-wifi = " ";
	   format-disconnected = "";
	 };

	 "temperature" = {
	   format = "{temperatureC}°C "; 
	 };

	 "battery" = {
	   format = "{capacity}% {icon}";
	   format-icons = ["" "" "" "" ""];
         };
       };
     };
     style = "
      * {
        border: none;
        border-radius: 0;
	font-size: 15px;
      }
      window#waybar {
        background-color: transparent;
	color: white;
      }
      #workspaces button, #taskbar button {
        padding: 0 5px;
        background: transparent;
        color: white;
      }
      #workspaces button.focused, #taskbar button.focused { 
        background-color: transparent;
      }
      #battery, #temperature, #clock, #network {
        padding: 0 10px;
      }
     ";
   };

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

}
