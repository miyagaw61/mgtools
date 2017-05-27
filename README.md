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
