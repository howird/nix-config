{inputs, ...}: {
  flake-file.inputs.mattpocock-skills = {
    url = "github:mattpocock/skills";
    flake = false;
  };

  den.aspects.skills.homeManager = {
    config,
    pkgs,
    lib,
    ...
  }: let
    dirsIn = dir: lib.attrNames (lib.filterAttrs (_: type: type == "directory") (builtins.readDir dir));

    # name -> skill dir, for every skill dir directly under `dir`
    skillsIn = dir: lib.genAttrs (dirsIn dir) (name: "${dir}/${name}");

    # upstream skills whose names clash with claude's built-in commands;
    # the other skills that invoke them by name are rewritten to match
    renames = {code-review = "spec-review";};

    upstream = pkgs.runCommand "mattpocock-skills" {} ''
      cp -r ${inputs.mattpocock-skills}/skills $out
      chmod -R u+w $out
      ${lib.concatLines (lib.mapAttrsToList (old: new: ''
          for d in $out/*/${old}; do mv "$d" "$(dirname "$d")/${new}"; done
          grep -rlZ -e '\b${old}\b' $out | xargs -0 -r sed -i 's/\b${old}\b/${new}/g'
        '')
        renames)}
    '';

    # names come from the input itself so listing them doesn't need the build above
    upstreamSkillsIn = category:
      lib.listToAttrs (map (name: let
        name' = renames.${name} or name;
      in
        lib.nameValuePair name' "${upstream}/${category}/${name'}")
      (dirsIn "${inputs.mattpocock-skills}/skills/${category}"));

    skills =
      upstreamSkillsIn "engineering"
      // upstreamSkillsIn "productivity"
      // skillsIn ./_skills;

    # every agent reads skills from here
    dir = "${config.xdg.configHome}/skills";
  in {
    xdg.configFile = lib.mapAttrs' (name: src: lib.nameValuePair "skills/${name}" {source = src;}) skills;

    # one link per skill: ~/.claude/skills also holds home-manager's plugin dir,
    # and claude doesn't load skills when ~/.claude/skills is itself a symlink
    home.file = lib.mapAttrs' (name: _:
      lib.nameValuePair "${config.programs.claude-code.configDir}/skills/${name}" {
        source = config.lib.file.mkOutOfStoreSymlink "${dir}/${name}";
      })
    skills;

    programs.pi.coding-agent.settings.skills = [dir];
  };
}
