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

    # a skill in any form programs.claude-code.skills accepts (inline SKILL.md
    # text, a SKILL.md file, or a skill dir), as a skill dir
    toSkillDir = name: content:
      if lib.isPath content || lib.hm.strings.isPathLike content
      then
        pkgs.runCommandLocal "skill-${name}" {} ''
          src=${lib.escapeShellArg "${content}"}
          if [[ -d "$src" ]]; then ln -s "$src" $out; else mkdir $out; ln -s "$src" $out/SKILL.md; fi
        ''
      else pkgs.writeTextDir "SKILL.md" content;

    # every agent but claude reads skills from here
    dir = "${config.xdg.configHome}/skills";
  in {
    options.programs.pi.coding-agent.excludedClaudeSkills = lib.mkOption {
      type = with lib.types; listOf str;
      default = [];
      description = "Skills in programs.claude-code.skills not shared with pi, e.g. ones that drive claude-only tools.";
    };

    config = {
      # claude-code.skills is the one skill list: home-manager modules (e.g.
      # worktrunk) add theirs here, and claude links each into ~/.claude/skills
      programs.claude-code.skills = skills;

      # pi gets the same list
      xdg.configFile =
        lib.mapAttrs' (name: content: lib.nameValuePair "skills/${name}" {source = toSkillDir name content;})
        (removeAttrs config.programs.claude-code.skills config.programs.pi.coding-agent.excludedClaudeSkills);

      programs.pi.coding-agent.settings.skills = [dir];
    };
  };
}
