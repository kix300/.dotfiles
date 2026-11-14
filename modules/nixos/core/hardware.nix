{
	flake.modules.nixos.hardware =
		{ ... }:
		{
			hardware = {
				i2c.enable = false;
				bluetooth = {
					enable = true;
					powerOnBoot = true;
					settings = {
						LE = {
							MinConnectionInterval = 16;
							MaxConnectionInterval = 16;
							ConnectionLatency = 10;
							ConnectionSupervisionTimeout = 100;
						};
						General.Experimental = true;
						Policy.AutoEnable = true;
					};
				};
				graphics.enable = true;
			};
		};
}
