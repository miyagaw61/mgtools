miyagawtools
============

miyagawtools is many scripts for bash that has been written by @miyagaw61.

install
-------

<pre>
git clone https://github.com/miyagaw61.git $HOME/miyagawtools/
</pre>

tutorial
--------

* allmv

<pre>
Usage: allmv src...
 src : src file path
</pre>

* allrm

<pre>
Usage: allrm file...
 file : file name that you want to remove
</pre>

* aslr

<pre>
Usage: aslr [option]
 NoUseOptions : check now aslr
 on           : aslr on
 off          : aslr off
</pre>

* binsed

<pre>
Usage: binsed [file_name] [before] [after] 
</pre>

* bkup

<pre>
Usage: bkup
</pre>

* build

<pre>
Usage: ./build -s src -d dst [-u user] [cmd...]
 -s [src]  set source image name
 -d [dst]  set destination image name
 -u [user] set your user name (default: miyagaw61)
 cmd       set RUN command
</pre>

* calc

<pre>
Usage: calc [option] [expr]
default: to_int
-x: to_hex
-b: to_bin
-i: intaractive_mode
</pre>

* cecho

<pre>
Usage: cecho [option] [arg]
[+]UsageOptions:
   h: help
   f: file version
   n: not enter
   r: red
   g: green
   b: blue
   s: sian
   w: white
   m: mazenta
   y: yellow
   k: kuro
</pre>

* chkbmap

<pre>
Usage: chkbmap [kbmap_symbol]
[+]UsageSymbol:
   jp: Japan
   us: USA
   dv: Dvorak
</pre>

* cpall

<pre>
Usage: ./cpall [-h] src... -d dst
 -h       show help
 -d [dst] dst dir path
 src	  src file/dir path
</pre>

* def

<pre>
Usage: def file_name
</pre>

* defc

<pre>
Usage: def file_name
</pre>

* dirmk

<pre>
Usage: dirmk file
</pre>

* dirrm

<pre>
usage: dirrm file
</pre>

* docker2

<pre>
Usage: docker2 [command]
[+]command:
   pl:  pull
   ps:  ps
   psa: ps -a
   i:   images
   rm:  rm
   rmi: rmi
   1:   start [container_name]
   0:   stop [container_name]
   c:   commit [container_name] [image_name]
   r:   run -it [image_name] bash
   x:   exec -it [container_name] bash
   d:   run --privileged -d -p 8080:80 --name [name] [image_name] /sbin/init
</pre>

* gc

<pre>
Usage: gc [options] [C_file]
[+]UsageOptions:
   sspoff/canaryoff
   depoff/nxoff
   pie
   fullrelro
</pre>

* getfile

<pre>
Usage: getfile [option]
[+]UsageOption:
   d: dir
   x: exe
   o: others
   a: all
</pre>

* gettldata.py

<pre>
Usage: python gettldata.py userid count
userid : user id
count  : tweet_county
</pre>

* gettweetdata.py

<pre>
Usage: python gettweetdata.py statusid
 statusid : tweet's status id
</pre>

* git2

<pre>
Usage: git2 [option]
 clone:          super git clone
 [LABEL] [path]: copy to repository and cd repository ( Usage_LABEL: mt/mp/tmp/io/mc )
 add [path]:     git add [path]
 commit/c:       git commit
 remote/r:       git remote add origin https://github.com/[user_name]/[repository_name]
 push/p:         git push origin master
 all/a:          add&commit&push.all_automation (git add . -> git commit -> git push origin master)

 (EXAMPLE)
 git2 mt --> cd /home/miyagaw61/git/miyagawtools/
 git2 mt gcc --> cp -a ./gcc /home/miyagaw61/git/miyagawtools/; cd /home/miyagaw61/git/miyagawtools/
 git2 add .  ( \*\*\* You have to be in the repository directory \*\*\*)
 git2 commit ( \*\*\* You have to be in the repository directory \*\*\*)
 git2 c      ( \*\*\* You have to be in the repository directory \*\*\*)
 git2 remote ( \*\*\* You have to be in the repository directory \*\*\*)
 git2 r      ( \*\*\* You have to be in the repository directory \*\*\*)
 git2 push   ( \*\*\* You have to be in the repository directory \*\*\*)
 git2 p      ( \*\*\* You have to be in the repository directory \*\*\*)
 git2 all    ( \*\*\* You have to be in the repository directory \*\*\*)
 git2 a      ( \*\*\* You have to be in the repository directory \*\*\*)
</pre>

* hashdiff

<pre>
Usage: hashdiff [path1] [path2] [option]
[+]UsageOption:
   check: check_diff_file
</pre>

* index2ts

<pre>
Usage: index2ts [index.m3u8_file]
</pre>

* ipcalc.py

<pre>
Usage: ipcalc [option]
[+]UsageOption: 
   ip [int_ip]: ip_addr
   ipb [bin_ip]: ip_addr
   mask [int_mask]: subnetmask
</pre>

* kp

<pre>
Usage: kp process_name
</pre>

* libcstrings

<pre>
Usage: libcstrings [option] [strings]
default: defalut_libc
-f [libc_name]: use_notDefault_libc
</pre>


