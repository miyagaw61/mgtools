miyagawtools
============

miyagawtools is many scripts for bash that has been written by @miyagaw61.  
@miyagaw61によって作成された、bash上で使用可能なスクリプト群です。

install
-------

<pre>
git clone https://github.com/miyagaw61.git $HOME/miyagawtools/
</pre>

tutorial
--------

* allcp  
src...に記述した全ファイルを-dオプションに与えたパスへコピーする。
<pre>
Usage: cpall [-h] src... -d dst
-h       show help
-d [dst] dst dir path
src	  src file/dir path
</pre>

* allmv  
src...に記述した全ファイルを-dオプションに与えたパスへ移動する。
<pre>
Usage: allmv [-h] src... -d dst
 -h       show help
 -d [dst] dst dir path
 src	  src file/dir path
</pre>

* allrm  
file...に記述した全ファイルを削除。  
（存在しなくてもエラーを吐かないため、shellscriptでの使用に便利）
<pre>
Usage: allrm file...
file : file name that you want to remove
</pre>

* aslr  
現在のaslrをチェック、変更。
<pre>
Usage: aslr [option]
NoUseOptions : check now aslr
on           : aslr on
off          : aslr off
</pre>

* binsed  
バイナリレベルでの置換。
<pre>
Usage: binsed [file_name] [before] [after] 
</pre>

* bkup  
バックアップコマンド。  
バックアップ元、バックアップ先のディレクトリを変更したい場合は、コードの中のrsyncの文の引数を各自で書き換えてください。
<pre>
Usage: bkup
</pre>

* rst  
bkupコマンドの逆を行うコマンド。  
bkupとrstを使うことで、容易にバックアップとリストアを行う事が可能になる。  
bkupコマンドを書き換えた場合は、こちらも書き換えてください。  
<pre>
Usage: rst
</pre>

* build  
自動Dockerファイル生成/自動buildを行う。  
$HOME/Documents/docker/dockerという名前で  
FROM IMAGE  
COPY /home/USER/ /home/USER/  
を保存してから使用してください。  
(e.g)  
build -s image01 -d image02 -u user01 "apt-get -y update" "apt-get -y upgrade" "apt-get -y insatll vim python socat"
<pre>
Usage: ./build -s src -d dst [-u user] [cmd...]
-s [src]  set source image name
-d [dst]  set destination image name
-u [user] set your user name (default: miyagaw61)
cmd       set RUN command
</pre>

* calc  
計算ツール。  
複数の進数表現を用いての計算/ビット演算を行うことができる。  
単独の数値を渡すことで進数変換用としても使用可能。  
(e.g)  
calc 1+2 -> 3  
calc 2*3 -> 6  
calc 2*(1+3) -> 8  
calc -x 10 -> 0xa  
calc 0xa -> 10  
calc -b 10 -> 1010b  
calc 1010b -> 10  
calc 2+0xa -> 12  
calc 0x2+0xa -> 12  
calc 2+0xa+0xa -> 22  
calc 2+0xa+1010b -> 22  
calc -b "1100b&1010b" -> 1000b  
<pre>
Usage: calc [option] [expr]
default: to_int
-x: to_hex
-b: to_bin
-i: intaractive_mode
</pre>

* cecho  
引数に与えられた文字列に色を付けて出力する。  
青と黒が両方とも頭文字bで泣く泣く黒をkuroにした。  
fをつけるとファイル用になる。（正確には太字らしい）  
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
キーボード配列を変更する。  
jp配列,us配列,Dvorak配列に対応。  
リクエストして頂ければバリエーションを増やします。  
<pre>
Usage: chkbmap [kbmap_symbol]
[+]UsageSymbol:
jp: Japan
us: USA
dv: Dvorak
</pre>

* def  
シェルスクリプトのテンプレートを引数に与えたファイル名で生成。  
<pre>
Usage: def file_name
</pre>

* defc  
C言語のテンプレートを引数に与えたファイル名で生成。  
<pre>
Usage: def file_name
</pre>

* dirmk  
dirmkコマンドで作成したディレクトリは、パスのベースネームを入力するだけでそこへ飛べるようになる。  
（内部的にはcdirファイルに追加するだけ。このコマンドを使わなくてもcdirファイルに追記すればベースネームで飛べるようになる。）  
使用するにはbashrcに  
source $HOME/miyagawtools/cdir  
を追記する必要がある。  
<pre>
Usage: dirmk file
</pre>

* dirrm  
dirmkコマンドで作成したディレクトリを削除するときはこのコマンドを使用する。  
（このコマンドを使用せずに普通にrm -rfコマンドで削除しても問題は無い（cdirが汚なくなるだけ））  
<pre>
usage: dirrm file
</pre>

* docker2  
dockerのラッパーコマンド。  
alias d="docker2"とエイリアスをかけてあげると便利。  
d 1　で停止しているコンテナの起動  
d 0　で起動しているコンテナの停止  
d x　で起動中のコンテナのterminalを起動  
d r　でrun（d rだけでコマンド実行すると、run専用のヘルプが見れる。）  
d d　でデーモン起動（d dだけでコマンド実行すると、デーモン起動専用のヘルプが見れる。）  
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
gccのラッパーコマンド。  
デフォルトの出力ファイルがa.outではなく、拡張子の.cを取り除いたファイル名になる。  
また、オプションでセキュリティ機構を容易に設定してコンパイルを行うことが可能。  
<pre>
Usage: gc [options] [C_file]
[+]UsageOptions:
sspoff/canaryoff
depoff/nxoff
pie
fullrelro
</pre>

* x  
コンパイル->実行というフローを自動で行う。  
また、cファイルではなく実行可能ファイルを引数に与えた場合、コンパイルなしで実行。（./a.outと同じ挙動）  
<pre>
Usage: x [options] [C_file]
[+]UsageOptions:
   sspoff/canaryoff
   depoff/nxoff
   pie
   fullrelro
</pre>

* getfile  
オプションでファイルの種類を種別して表示することが可能。  
主にシェルスクリプト作成用のコマンドで、普段のlsの代わりには後述のols/lse/lsrコマンドを用いる。  
<pre>
Usage: getfile [option]
[+]UsageOption:
d: dir
x: exe
o: others
a: all
</pre>

* gettldata.py  
引数にユーザー名/ツイート数を与えることで、そのユーザーのタイムラインを取得。  
これ以降Twitter系のスクリプトが紹介されることがあるが、いずれも  
$HOME/Documents/twitter内に  
twitter.AS  twitter.AT  twitter.CK  twitter.CS  
という4つのファイルが必要です。  
その中には各自のAPIキー等を保存しておいてください。  
<pre>
Usage: python gettldata.py userid count
userid : user id
count  : tweet_county
</pre>

* gettweetdata.py  
引数にツイートの固有のID（URLに書いてある）を与えることで、そのツイートのJSONデータを取得。  
<pre>
Usage: python gettweetdata.py statusid
statusid : tweet's status id
</pre>

* git2  
gitのラッパーコマンド。  
alias g="git2"などとエイリアスをかけておくと便利。  
g cloneでは、clone先のURLを自動生成。  
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
ディレクトリAとディレクトリBの内部を再帰的にハッシュ比較し、一致すればTrueを、一致しなければFalseを文字列として返す。  
最後にオプションとしてcheckを追加することで、ファイルとして比較結果を出力。  
今回はただのパスの羅列で、上下の行に関連性が無いため、後述のwatchdiffコマンドを用いると見やすい。  
<pre>
Usage: hashdiff [path1] [path2] [option]
[+]UsageOption:
check: check_diff_file
</pre>

* watchdiff  
diffの結果として吐かれたファイルの不一致の部分だけが見れるようになる。（-U 0オプションをつけてdiffした場合と同じになる）  
<pre>
age: ./watchdiff [-h] -a argA [-b argB] [-c argC] expr...
 -h        show help
 -a [argA] set arg1
 -b [argB] set arg2
 -c [argC] set arg3
 expr      set expr
</pre>

* index2ts

<pre>
Usage: index2ts [index.m3u8_file]
</pre>

* ipcalc.py  
IPアドレスを計算するスクリプト。  
(e.g)  
python ipcalc.py ip 192.168.11.1 mask 255.255.255.0
<pre>
Usage: ipcalc [option]
[+]UsageOption: 
ip [int_ip]: ip_addr
ipb [bin_ip]: ip_addr
mask [int_mask]: subnetmask
</pre>

* kp  
プロセスをプロセス名でkillすることが可能。
<pre>
Usage: kp process_name
</pre>

* libcstrings  
共有ライブラリ内の文字列を検索することが可能。  
-fオプション無しで、デフォルトの共有ライブラリを使用する。  
（デフォルトは各自でコードを書き換えてください。）  
<pre>
Usage: libcstrings [option] [strings]
default: defalut_libc
-f [libc_name]: use_notDefault_libc
</pre>

* lse  
lsの結果をファイルの種類別にソートし、番号を付与する。  
付与された番号を入力することで、ディレクトリならcd、実行可能ファイルなら実行、テキストファイルならcatを自動で実行する。  
（後述のfコマンドで付与された番号のファイルの絶対パスを取得することが可能。また、実行可能ファイルをcatしたい場合や、テキストファイルをvimした場合などは、後述の末尾がfのスクリプト群を使用。）  
<pre>
Usage: lse [option] [clm_num(default: 3)]
[+]UsageOptions:
h: help
d: dir
x: exe
o: others
a: all
g: grep [$1: arg]
</pre>

* f  
lseコマンドで付与された番号を引数に渡すことで、そのファイルの絶対パスを取得することが可能。
<pre>
Usage: f number
number : lse number
</pre>

* catf  
lseコマンドで付与された番号を引数に渡すことで、そのファイルをcatすることが可能。
<pre>
Usage: catf number
number : lse numbe
</pre>

* vif  
lseコマンドで付与された番号を引数に渡すことで、そのファイルをvimすることが可能。
<pre>
Usage: vif number
number : lse number
</pre>

* rmf  
lseコマンドで付与された番号を引数に渡すことで、そのファイルをrmすることが可能。
<pre>
Usage: rmf number
number : lsenumber
</pre>

* lsr  
lsコマンドの結果をpercolに渡す。  
エンター後のreadでそのファイルに対して行うコマンドを入力できる。  
このコマンドを使用するにはpercolを導入してください。（inisial_settingのallinstall内部に導入コマンドが書いてある。）  
<pre>
Usage: lsr [option]
[+]UsageOption:
d: dir
x: exe
o: others
a: all
</pre>

* makeLib  
src_fileに与えたファイルを一行ずつ取得し、それぞれを最小文字数min、最大文字数maxで全パターン組み合わせ、dst_fileに出力する。  
これを用いれば、ワードリストから辞書攻撃用の辞書を生成することが可能。  
（johnを開発したチームが提供している辞書攻撃用のファイルはpasswordは存在していてもpasswordAは存在していないが、これを用いればpasswordAも含む辞書を作成することが可能。）  
※このコマンドを使用して生成した辞書を用いた攻撃を外部に対して行っても私は責任を負いません。  
※削除要請があり次第、リモートリポジトリから削除します。  
<pre>
Usage: makeLib [min] [max] [src_file] [dst_file]
min      : min char num
max      : max char num
src_file : src word list name
dst_file : output library file name
</pre>

* middle  
開始行、終了行を指定することでテキストファイルの中間を抽出することが可能。  
<pre>
Usage: middle [file_name] [start_line] [end_line]
</pre>

* mp4abduction  
ツイートのURLを渡すことで、そのツイートに動画が含まれていればそれを保存することが可能。  
（Twitterにおいて、画像の保存は容易に可能だが動画の保存は困難なため、ツイートに含まれる動画を取得したい場合はこのスクリプトを使用する。）  
<pre>
Usage: mp4abduction [tweet_url]
</pre>

* nowloading  
ロード中のアニメーションをloop_countで指定された回数表示する。
<pre>
Usage: nowloading [loop_count]
</pre>

* nsed  
input_fileに指定されたファイルをsed_patternに指定した正規表現で置換することが可能。  
このスクリプトを用いることで、<tag>.*</tag>というような複数行に跨る置換を行うことが可能になる。  
(e.g)  
nsed index.html "<script>.*</script>" "<script>alert("deleted");</script>"  
<pre>
Usage: nsed file before after
file   : input file name
before : before
after  : after
</pre>

* ols  
lsコマンドをファイルの種別にソートして出力。  
各種75個までは折り返して縦に出力されるため、目で追いやすい。  
-gオプションでgrep、-vオプションでgrep -vをまとめて可能。--lessで自動でlessにかけることができる。  
<pre>
Usage: ols [option]
d: dir
x: ex
n: others
1: one line
g [pattern]: grep
v [pattern]: grep  v
--less : show result by less
</pre>

* pgdb  
プロセスをデバッグすることが可能。  
pythonで実行可能ファイルに対してsocket通信をしている最中にinput関数等で処理をストップ、  
その間にpgdbに実行可能ファイルの名前を渡して実行すると、socket通信のデバッグを行うこともできる。  
リモートエクスプロイトでよくこの手法を用いる。  
<pre>
Usage: pgdb [file]
</pre>

* png  
外部への疎通確認をとるコマンド。  
引数を与えるとそのアドレスへの疎通を、引数無しで8.8.8.8とgoogle.comへの疎通を確認する。  
<pre>
Usage: png [ip_addr(def:8.8.8.8 & google.com)]
</pre>

* rmnoline  
空行を削除して出力する。  
<pre>
Usage: rmnoline [file_name] 
</pre>

* rmtmp  
カレントディレクトリに存在する拡張子がtmpになっているファイルをまとめて削除する。
<pre>
Usage: rmtmp
</pre>

* rp2  
ROPgadget探索スクリプト。  
countに1を与えるとpop数が1のgadgetを、countに2を与えるとpop数が2のgadgetを、countに-aもしくはallを与えると、pop数1~4のgadgetを出力する。  
<pre>
Usage: rp2 file count
file  : file name
count : pop count(-a/all: search 1-4 pop count)
</pre>

* sa  
一時的にカレントパスを保存するコマンド。  
$HOME/Documents/save/saveに保存されている。  
alias save="cat $HOME/Documents/save/save"  
というようなエイリアスをかけておくことでsaveと入力するだけで保存されているパスを確認できるようになるため便利。  
<pre>
Usage: sa
</pre>

* ve  
saveに保存されているパスへ移動する。
<pre>
Usage: ve
</pre>

* sedparag  
引数に与えた文字列が含まれる行から次の空行までを出力する。
<pre>
Usage: sedparag word
</pre>

* sharemount  
共有フォルダをマウントする。  
$HOME/Documents/sharemountディレクトリ内に  
sharemount.password  sharemount.username  
という二つのファイルを作成し、それぞれホストのコンピュータのユーザー名とパスワードを保存しておいてください。  
<pre>
Usage: sharemount [ip(def:192.168.44.1)]
</pre>

* sizecheck  
check_pathに指定されたパスに存在するファイル/ディレクトリのサイズをソートしてout_fileに出力する。  
主に使用するのはbash on Ubuntu on Windows。  
なぜなら、Windowsでフォルダのサイズを確認することはとても困難なため。  
<pre>
Usage: sizecheck check_path out_file
</pre>

* snecho  
空白を改行に置換して出力する。  
下記の二つを見比べるのが良いだろう。  
echo $(ls)  
snecho $(ls)  
<pre>
Usage: snecho word
</pre>

* sock  
引数に与えたファイルを4444ポートで待機させる。  
nc localhost 4444で接続/実行することが可能。  
既にそのポートで待機中のプログラムがあった場合、killする。  
<pre>
Usage: sock file
</pre>

* sym  
-fオプションに与えたファイルに存在するシンボルをpatternに与えた正規表現で抽出する。  
(e.g)  
sym -f a.out printf  
<pre>
Usage: sym [option] pattern
 -f : file_name
 no_use_option : default_libc
</pre>

* twitter  
CUIのツイッタークライアントを起動する。  
-aオプションでタイムラインファイルに現在のタイムラインを保存する。（こまめに閲覧しないとAPI制限で多量のツイートの取得ができなくなってしまうため、時間を長く開ける場合にはこのコマンドでとりあえず保存しておく必要がある。）  
twitterコマンドを引数無しで実行すると、前回の最後のツイートから続きを見ることが可能。  
$HOME/Documents/twitter内に  
nglist,oklistというファイルを作成することで、正規表現でNGワード,OKワードを設定することができる。  
<pre>
Usage: twitter [option]
[+]UsageOption:
   a: add_tl
   no_use_option: output
</pre>

* wecho  
引数に与えた色付き文字列を色無しに変換する。（色付きの状態だとパイプした際にエラーが起こることが稀にあり、その時に使用する）  
<pre>
Usage: wecho [option] [arg]
[+]Usage Option:
   n: not enter
</pre>

* whileline  
fileに与えたファイルの内容を一行ずつ、commandに与えたコマンドのvarに順次代入しながら全て実行する。  
<pre>
Usage: whileline file command
[+] UsageVar: var
EXAMPLE:
echo aaa > file_A
echo bbb > file_B
ls -1 | grep file\_.\* > argFile
whileline argFile "cat var"
</pre>

* whitecat  
色つき文字列を含むファイルを色無しでcatする。  
利用目的はwechoと同様。  
<pre>
Usage: whitecat file
</pre>

* del  
ターミナル上のカーソルがある行を無にする。  
単独で使用することは滅多に無い。  
後述のwritedelで使用されている。  
<pre>
Usage: del
</pre>

* writedel  
引数に指定された文字列を0.1秒だけ表示して消す。  
ターミナル上で実行することは滅多に無く、スクリプトで組んで使用することが多い。  
これを用いれば、一行のアニメーションを作成することが可能。  
nowloadingコマンドに使用されている。  
<pre>
Usage: writedel str...
</pre>

* xready  
エクスプロイトコードのテンプレートをカレントディレクトリに生成する。  
引数を与えるとそのファイル名で生成、引数無しでexploit.pyというファイル名で生成する。  
<pre>
Usage: xready [file(def:exploit.py)]
</pre>


