{lib, ...}: {
  programs.taskwarrior.config = let
    # task show report | grep labels
    defaultLabs = {
      "report.active.labels" = "ID,Started,Active,Age,D,P,Project,Tags,Recur,W,Sch,Due,Until,Description";
      "report.all.labels" = "ID,St,UUID,A,Age,Done,D,P,Project,Tags,R,Wait,Sch,Due,Until,Description";
      "report.blocked.labels" = "ID,Deps,Proj,Pri,Due,Active,Age,Description";
      "report.blocking.labels" = "ID,UUID,A,Deps,Project,Tags,R,W,Sch,Due,Until,Description,Urg";
      "report.completed.labels" = "ID,UUID,Created,Completed,Age,Deps,P,Project,Tags,R,Due,Description";
      "report.list.labels" = "ID,Active,Age,D,P,Project,Tags,R,Sch,Due,Until,Description,Urg";
      "report.long.labels" = "ID,A,Created,Mod,Deps,P,Project,Tags,Recur,Wait,Sched,Due,Until,Description";
      "report.ls.labels" = "ID,A,D,Project,Tags,R,Wait,S,Due,Until,Description";
      "report.minimal.labels" = "ID,Project,Tags,Description";
      "report.newest.labels" = "ID,Active,Created,Age,Mod,D,P,Project,Tags,R,Wait,Sch,Due,Until,Description";
      "report.next.labels" = "ID,Active,Age,Deps,P,Project,Tag,Recur,S,Due,Until,Description,Urg";
      "report.oldest.labels" = "ID,Active,Created,Age,Mod,D,P,Project,Tags,R,Wait,Sch,Due,Until,Description";
      "report.overdue.labels" = "ID,Active,Age,Deps,P,Project,Tag,R,S,Due,Until,Description,Urg";
      "report.ready.labels" = "ID,Active,Age,D,P,Project,Tags,R,S,Due,Until,Description,Urg";
      "report.recurring.labels" = "ID,Active,Age,D,P,Parent,Project,Tags,Recur,Sch,Due,Until,Description,Urg";
      "report.unblocked.labels" = "ID,Deps,Proj,Pri,Due,Active,Age,Description";
      "report.waiting.labels" = "ID,A,Age,D,P,Project,Tags,R,Wait,Remaining,Sched,Due,Until,Description";
    };

    # task show report | grep columns
    defaultCols = {
      "report.active.columns" = "id,start,start.age,entry.age,depends.indicator,priority,project,tags,recur,wait,scheduled.remaining,due,until,description";
      "report.all.columns" = "id,status.short,uuid.short,start.active,entry.age,end.age,depends.indicator,priority,project.parent,tags.count,recur.indicator,wait.remaining,scheduled.remaining,due,until.remaining,description";
      "report.blocked.columns" = "id,depends,project,priority,due,start.active,entry.age,description";
      "report.blocking.columns" = "id,uuid.short,start.active,depends,project,tags,recur,wait,scheduled.remaining,due.relative,until.remaining,description.count,urgency";
      "report.completed.columns" = "id,uuid.short,entry,end,entry.age,depends,priority,project,tags,recur.indicator,due,description";
      "report.list.columns" = "id,start.age,entry.age,depends.indicator,priority,project,tags,recur.indicator,scheduled.countdown,due,until.remaining,description.count,urgency";
      "report.long.columns" = "id,start.active,entry,modified.age,depends,priority,project,tags,recur,wait.remaining,scheduled,due,until,description";
      "report.ls.columns" = "id,start.active,depends.indicator,project,tags,recur.indicator,wait.remaining,scheduled.countdown,due.countdown,until.countdown,description.count";
      "report.minimal.columns" = "id,project,tags.count,description.count";
      "report.newest.columns" = "id,start.age,entry,entry.age,modified.age,depends.indicator,priority,project,tags,recur.indicator,wait.remaining,scheduled.countdown,due,until.age,description";
      "report.next.columns" = "id,start.age,entry.age,depends,priority,project,tags,recur,scheduled.countdown,due.relative,until.remaining,description,urgency";
      "report.oldest.columns" = "id,start.age,entry,entry.age,modified.age,depends.indicator,priority,project,tags,recur.indicator,wait.remaining,scheduled.countdown,due,until.age,description";
      "report.overdue.columns" = "id,start.age,entry.age,depends,priority,project,tags,recur.indicator,scheduled.countdown,due,until,description,urgency";
      "report.ready.columns" = "id,start.age,entry.age,depends.indicator,priority,project,tags,recur.indicator,scheduled.countdown,due.countdown,until.remaining,description,urgency";
      "report.recurring.columns" = "id,start.age,entry.age,depends.indicator,priority,parent.short,project,tags,recur,scheduled.countdown,due,until.remaining,description,urgency";
      "report.unblocked.columns" = "id,depends,project,priority,due,start.active,entry.age,description";
      "report.waiting.columns" = "id,start.active,entry.age,depends.indicator,priority,project,tags,recur.indicator,wait,wait.remaining,scheduled,due,until,description";
    };

    toCommaSep = lib.lists.foldl (a: b: a + "," + b) "";
    addReport = attrSet: newVals: (lib.attrsets.mapAttrs (_: value: value + (toCommaSep newVals)) attrSet);
  in
    {
      "uda.taskwarrior-tui.keyconfig.zoom" = "=";
      "uda.taskwarrior-tui.keyconfig.undo" = "";
      "uda.taskwarrior-tui.shortcuts.1" = "";

      "urgency.annotations.coefficient" = 0;
      "urgency.tags.coefficient" = 0;
      "urgency.project.coefficient" = 0;

      "uda.priority.values" = "H,M,,L";
      "urgency.uda.priority..coefficient" = 1.8;
      "urgency.uda.priority.L.coefficient" = 0;

      "uda.activity.type" = "string";
      "uda.activity.label" = "Activity";
      "uda.activity.values" = "coding,writing,admin,reading,lecture,q";

      "uda.tt.type" = "string";
      "uda.tt.label" = "TaskType";
      "uda.tt.values" = "fleeting,,unrefined,idea";
      "urgency.uda.tt..coefficient" = 1.8;
      "urgency.uda.tt.fleeting.coefficient" = 5.0;
      "urgency.uda.tt.idea.coefficient" = 0;
      "urgency.uda.tt.undefined.coefficient" = 3.6;
    }
    // (addReport defaultCols ["activity" "tt"]) // (addReport defaultLabs ["Activity" "TaskType"]);
}
