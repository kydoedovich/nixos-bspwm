{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    profiles.default = {
      id = 0;
      isDefault = true;
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
	"browser.startup.page" = 0;
	"browser.startup.homepage" = "about:blank";
	"browser.newtabpage.activity-stream.feeds.topsites" = false;
	"browser.tabs.inTitlebar" = 0;

	"browser.newtabpage.activity-stream.showSponsored" = false;
	"browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
	"browser.newtabpage.activity-stream.default.sites" = "";

	"browser.urlbar.suggest.calculator" = true;
      };
      userChrome = ''
      #PersonalToolbar, #back-button, #forward-button, #reload-button, #stop-reload-button, #fxa-toolbar-menu-button, #unified-extensions-button, #alltabs-button, .tab-close-button, .tab-icon-stack, #tabs-newtab-button, .searchmode-switcher { display: none !important; }
      .tabbrowser-tab { transition: max-width 0.2s ease, min-width 0.2s ease !important; color: #ffffff !important; min-width: 80px !important; max-width: 150px !important; justify-content: center !important; padding: 0 !important; border-bottom: 1px solid #ffffff !important; margin: 0 3px !important; background-color: rgba(15,15,15,1) !important; }
      .tabbrowser-tab[selected] { min-width: 180px !important; max-width: 250px !important; border-bottom: 1px solid #ffffff !important; color: #ffffff !important; margin: 0px 3px !important; background-color: rgba(30,30,30,1) !important; }
      .tab-content { display: flex !important; justify-content: center !important; align-items: center !important; width: 100% !important; padding: 0 !important; }
      .tab-label-container { display: flex !important; justify-content: center !important; align-items: center !important; margin: 0 auto !important; direction: ltr !important; }
      .tab-text { text-align: center !important; margin: 0 auto !important; }
      #tabbrowser-tabs { background-color: #000000 !important; border-bottom: 1px solid #ffffff !important; }
      #nav-bar-customization-target, #urlbar-input, #PanelUI-menu-button { background-color: rgba(0,0,0,1) !important; border-bottom: 1px solid rgba(255,255,255,1) !important; }
      #urlbar { color: #ffffff !important; border: 1px solid rgba(255,255,255,1) !important; padding-bottom: 5px !important; }
      #urlbar, .urlbar-background, .urlbarView { background-color: #000000 !important; border: 1px solid #ffffff !important; }
      #urlbar[open], .urlbar-background { box-shadow: none !important; border: none !important; }
      .urlbarView { border-radius: 0px !important; border: 1px solid rgba(255,255,255,0.5) !important; }
      .urlbarView-row { border-radius: 0px !important; }
      .urlbarView-row[selected] { background-color: rgba(25,25,25,1) !important; }
      .urlbarView-title, .urlbarView-url { color: #ffffff !important; }
      .urlbarView-favicon { display: none !important; }
      '';
    };
  };
}
