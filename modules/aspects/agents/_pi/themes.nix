{config, ...}: let
  palette = config.lib.stylix.colors.withHashtag;

  stylixTheme = {
    "$schema" = "https://pi.dev/schemas/theme.schema.json";
    name = "stylix";
    appearance = "dark";

    vars = {
      background = palette.base00;
      panel = palette.base01;
      selection = palette.base02;
      subtle = palette.base03;
      muted = palette.base04;
      text = palette.base05;
      bright = palette.base07;
      red = palette.base08;
      orange = palette.base09;
      yellow = palette.base0A;
      green = palette.base0B;
      cyan = palette.base0C;
      blue = palette.base0D;
      violet = palette.base0E;
      brown = palette.base0F;
    };

    colors = {
      accent = "green";
      border = "blue";
      borderAccent = "violet";
      borderMuted = "subtle";
      success = "green";
      error = "red";
      warning = "yellow";
      muted = "muted";
      dim = "subtle";
      text = "text";
      thinkingText = "muted";
      selectedBg = "selection";
      scrollbarTrack = "subtle";
      scrollbarThumb = "muted";
      searchMatchBg = "yellow";
      searchMatchText = "background";
      userMessageBg = "selection";
      userMessageText = "bright";
      customMessageBg = "panel";
      customMessageText = "text";
      customMessageLabel = "violet";
      toolPendingBg = "panel";
      toolSuccessBg = "panel";
      toolErrorBg = "panel";
      toolTitle = "bright";
      toolOutput = "muted";
      mdHeading = "yellow";
      mdLink = "blue";
      mdLinkUrl = "muted";
      mdCode = "violet";
      mdCodeBlock = "green";
      mdCodeBlockBorder = "subtle";
      mdQuote = "muted";
      mdQuoteBorder = "subtle";
      mdHr = "subtle";
      mdListBullet = "violet";
      toolDiffAdded = "green";
      toolDiffRemoved = "red";
      toolDiffContext = "muted";
      syntaxComment = "muted";
      syntaxKeyword = "blue";
      syntaxFunction = "yellow";
      syntaxVariable = "cyan";
      syntaxString = "green";
      syntaxNumber = "orange";
      syntaxType = "violet";
      syntaxOperator = "muted";
      syntaxPunctuation = "text";
      thinkingOff = "subtle";
      thinkingMinimal = "muted";
      thinkingLow = "blue";
      thinkingMedium = "cyan";
      thinkingHigh = "violet";
      thinkingXhigh = "orange";
      thinkingMax = "red";
      bashMode = "green";
    };

    export = {
      pageBg = "background";
      cardBg = "panel";
      infoBg = "selection";
    };
  };
in {
  home.file.".pi/agent/themes/stylix.json".text = builtins.toJSON stylixTheme;
  programs.pi-coding-agent.settings.theme = "stylix";
}
