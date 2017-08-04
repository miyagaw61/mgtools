--- .fzf.bak/shell/key-bindings.bash	2017-08-03 18:28:59.242013000 +0900
+++ .fzf/shell/key-bindings.bash	2017-08-03 16:25:43.898439999 +0900
@@ -51,7 +51,7 @@ __fzf_cd__() {
   dir=$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" $(__fzfcmd) +m) && printf 'cd %q' "$dir"
 }
 
-__fzf_history__() (
+__fzf_history__() {
   local line
   shopt -u nocaseglob nocasematch
   line=$(
@@ -63,7 +63,7 @@ __fzf_history__() (
     else
       sed 's/^ *\([0-9]*\)\** *//' <<< "$line"
     fi
-)
+}
 
 if [[ ! -o vi ]]; then
   # Required to refresh the prompt after fzf
@@ -73,10 +73,12 @@ if [[ ! -o vi ]]; then
   # CTRL-T - Paste the selected file path into the command line
   if [ $BASH_VERSINFO -gt 3 ]; then
     bind -x '"\C-t": "fzf-file-widget"'
+    bind -x '"\C-k": "fzf-file-widget"'
   elif __fzf_use_tmux__; then
     bind '"\C-t": " \C-u \C-a\C-k`__fzf_select_tmux__`\e\C-e\C-y\C-a\C-d\C-y\ey\C-h"'
   else
     bind '"\C-t": " \C-u \C-a\C-k`__fzf_select__`\e\C-e\C-y\C-a\C-y\ey\C-h\C-e\er \C-h"'
+    bind '"\C-k": " \C-u \C-a\C-k`__fzf_select__`\e\C-e\C-y\C-a\C-y\ey\C-h\C-e\er \C-h"'
   fi
 
   # CTRL-R - Paste the selected command from history into the command line
