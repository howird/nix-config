{pkgs, ...}: {
  home.packages = with pkgs; [
    thunar
    thunar-volman
    thunar-vcs-plugin
    thunar-archive-plugin
  ];

  home.sessionVariables.TERMINAL = "ghostty";
  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=ghostty
    TerminalEmulatorDismissed=true
  '';

  xdg.configFile."Thunar/uca.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <actions>
    <action>
    	<icon>utilities-terminal</icon>
    	<name>Open Terminal Here</name>
    	<submenu></submenu>
    	<unique-id>1727754804824446-1</unique-id>
    	<command>for f in %F; do ghostty --env=FILEBROWSER=1 --working-directory=$f; done</command>
    	<description>Example for a custom action</description>
    	<range></range>
    	<patterns>*</patterns>
    	<startup-notify/>
    	<directories/>
    </action>
    <action>
    	<icon></icon>
    	<name>Decompress with ouch</name>
    	<submenu></submenu>
    	<unique-id>1770140224889685-1</unique-id>
    	<command>ouch decompress %F</command>
    	<description></description>
    	<range>*</range>
    	<patterns>*</patterns>
    </action>
    </actions>
  '';
}
