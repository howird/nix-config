{mattpocockSkillsSrc, ...}: let
  src = mattpocockSkillsSrc;
  categories = ["engineering" "productivity"];
in {
  programs.pi-coding-agent.settings.skills =
    map (c: "${src}/skills/${c}") categories;
}
