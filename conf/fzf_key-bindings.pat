--- .fzf.bak/shell/key-bindings.bash	2017-08-04 14:02:29.648215000 +0900
+++ .fzf/shell/key-bindings.bash	2017-08-04 18:49:01.912215000 +0900
@@ -11,6 +11,22 @@ __fzf_select__() {
   echo
 }
 
+__fzf_myselect__() {
+  #local cmd="${FZF_CTRL_T_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
+  #  -o -type f -print \
+  #  -o -type d -print \
+  #  -o -type l -print 2> /dev/null | cut -b3-"}"
+  #eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" fzf -m "$@" | while read -r item; do
+  ols -1 | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" fzf --ansi -m "$@" | while read -r item ; do
+    if test ! $item ;then
+      echo "."
+    else
+      printf '%q ' "$item"
+    fi
+  done
+  echo
+}
+
 if [[ $- =~ i ]]; then
 
 __fzf_use_tmux__() {
@@ -44,6 +60,16 @@ fzf-file-widget() {
   fi
 }
 
+fzf-file-mywidget() {
+  if __fzf_use_tmux__; then
+    __fzf_select_tmux__
+  else
+    local selected="$(__fzf_myselect__)"
+    READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
+    READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
+  fi
+}
+
 __fzf_cd__() {
   local cmd dir
   cmd="${FZF_ALT_C_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
@@ -51,7 +77,7 @@ __fzf_cd__() {
   dir=$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" $(__fzfcmd) +m) && printf 'cd %q' "$dir"
 }
 
-__fzf_history__() (
+__fzf_history__() {
   local line
   shopt -u nocaseglob nocasematch
   line=$(
@@ -63,7 +89,7 @@ __fzf_history__() (
     else
       sed 's/^ *\([0-9]*\)\** *//' <<< "$line"
     fi
-)
+}
 
 if [[ ! -o vi ]]; then
   # Required to refresh the prompt after fzf
@@ -73,10 +99,14 @@ if [[ ! -o vi ]]; then
   # CTRL-T - Paste the selected file path into the command line
   if [ $BASH_VERSINFO -gt 3 ]; then
     bind -x '"\C-t": "fzf-file-widget"'
+    bind -x '"\C-k": "fzf-file-widget"'
+    bind -x '"\C-k": "fzf-file-mywidget"'
   elif __fzf_use_tmux__; then
     bind '"\C-t": " \C-u \C-a\C-k`__fzf_select_tmux__`\e\C-e\C-y\C-a\C-d\C-y\ey\C-h"'
   else
     bind '"\C-t": " \C-u \C-a\C-k`__fzf_select__`\e\C-e\C-y\C-a\C-y\ey\C-h\C-e\er \C-h"'
+    bind '"\C-k": " \C-u \C-a\C-k`__fzf_select__`\e\C-e\C-y\C-a\C-y\ey\C-h\C-e\er \C-h"'
+    bind '"\C-k": " \C-u \C-a\C-k`__fzf_myselect__`\e\C-e\C-y\C-a\C-y\ey\C-h\C-e\er \C-h"'
   fi
 
   # CTRL-R - Paste the selected command from history into the command line
