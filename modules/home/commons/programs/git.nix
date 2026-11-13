{ _ , ... }:
{
	programs = {
		lazygit = {
			enable = true;
		};
		git = {
			enable = true;
			signing.format = "openpgp";
			settings.user.name = "kix300";
			settings.user.email = "kixwalkiki@gmail.com";
		};
	};
}
