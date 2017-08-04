--- .fzf.bak/shell/completion.bash	2017-08-03 18:28:59.242013000 +0900
+++ .fzf/shell/completion.bash	2017-08-04 13:18:00.539840910 +0900
@@ -135,7 +135,11 @@ __fzf_generic_path_completion() {
   fzf="$(__fzfcmd_complete)"
   cmd="${COMP_WORDS[0]//[^A-Za-z0-9_=]/_}"
   COMPREPLY=()
-  trigger=${FZF_COMPLETION_TRIGGER-'**'}
+  #trigger=${FZF_COMPLETION_TRIGGER-'**'}
+  #trigger=${FZF_COMPLETION_TRIGGER-'hoge'}
+  #trigger=${FZF_COMPLETION_TRIGGER-'*'}
+  #trigger=${FZF_COMPLETION_TRIGGER-''}
+  trigger=${FZF_COMPLETION_TRIGGER-'.'}
   cur="${COMP_WORDS[COMP_CWORD]}"
   if [[ "$cur" == *"$trigger" ]]; then
     base=${cur:0:${#cur}-${#trigger}}
@@ -179,6 +183,7 @@ _fzf_complete() {
 
   cmd="${COMP_WORDS[0]//[^A-Za-z0-9_=]/_}"
   trigger=${FZF_COMPLETION_TRIGGER-'**'}
+  trigger=${FZF_COMPLETION_TRIGGER-''}
   cur="${COMP_WORDS[COMP_CWORD]}"
   if [[ "$cur" == *"$trigger" ]]; then
     cur=${cur:0:${#cur}-${#trigger}}
