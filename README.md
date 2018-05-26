mgtools - many many console scripts for miyagaw61
=================================================

**miyagaw61本人にとって使いやすいことを第一目的として作成さているためもう使ってないスクリプトも残ってるしREADME.mdの更新めんどくさくてサボってるしコミットも適当です。**  
**現在はこのリポジトリは運用されていません。後継として[chikuwansible](https://github.com/miyagaw61/chikuwansible)というリポジトリが存在します。こちらを使ってください。**

mgtoolsディレクトリにPATHを通すだけで使用可能になります。  
基本的に、mgtoolsディレクトリ内のファイルしか勝手に書き換えることはありません。  
なので、mgtoolsを導入しても環境を壊すことはありません。  

- [install](README.md#install)
- [tutorial](README.md#tutorial)

報告
----

古いスクリプトはold_scriptsディレクトリに  
CTF用のスクリプトはctfに  
Pythonスクリプトはpythonに移動しました。

install  
-------  
  
```  
git clone https://github.com/miyagaw61/mgtools.git $HOME/repos/mgtools  
```  
  
tutorial  
--------  

* コマンド多すぎて全部書くのめんどくさいので個人的によく使うやつだけ最初の方に書きます。使い方は各々のhelpを見てください。

    - calc
    - cecho
    - docker2
    - kp
    - middle
    - snecho
    - wcat
    - wecho
    - whileline
    - pyenv_update

* calc  
計算ツール。  
複数の進数表現を用いての計算/ビット演算を行うことができる。  
単独の数値を渡すことで進数変換用としても使用可能。  
(e.g)  
calc 1+2 -> 3  
calc 2\*3 -> 6  
calc 2*(1+3) -> 8  
calc 10 x -> 0xa  
calc 0xa -> 10  
calc 10 x -> 1010b  
calc 0b1010 -> 10  
calc 2+0xa -> 12  
calc 0x2+0xa -> 12  
calc 2+0xa+0xa -> 22  
calc 2+0xa+0b1010 -> 22  
calc "0b1100&0b1010" b -> 1000b  
```  
Usage: calc [x/b/i] [expr]  
default: to_int  
x: to_hex  
b: to_bin  
i: intaractive_mode  
```  
  
* cecho  
引数に与えられた文字列に色を付けて出力する。  
青と黒が両方とも頭文字bで泣く泣く黒をkuroにした。  
fをつけるとファイル用になる。（正確には太字らしい）  
```  
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
```  
  
* docker2  
dockerのラッパーコマンド。  
alias d="docker2"とエイリアスをかけてあげると便利。  
d 1　で停止しているコンテナの起動  
d 0　で起動しているコンテナの停止  
d x　で起動中のコンテナのterminalを起動  
d r　でrun（d rだけでコマンド実行すると、run専用のヘルプが見れる。）  
d d　でデーモン起動（d dだけでコマンド実行すると、デーモン起動専用のヘルプが見れる。）  
```  
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
```  
  
* kp  
プロセスをfzfによるTUIでkillすることが可能。  
```  
Usage: kp
```  
  
* middle  
開始行、終了行を指定することでテキストファイルの中間を抽出することが可能。  
```  
Usage: middle [file_name] [start_line] [end_line]  
```  
  
* snecho  
空白を改行に置換して出力する。  
下記の二つを見比べるのが良いだろう。  
echo $(ls)  
snecho $(ls)  
```  
Usage: snecho [arg]
```  
  
* wcat
テキストファイル内部の制御文字を全て削除してクリーンな出力を行う。
```  
Usage: wcat [file]
```  
  
* wecho  
引数に与えた色付き文字列を色無しに変換する。（色付きの状態だとパイプした際にエラーが起こることが稀にあり、その時に使用する）  
```  
Usage: wecho [option] [arg]  
[+]Usage Option:  
   n: not enter  
```  
  
* whileline  
fileに与えたファイルの内容を一行ずつ、commandに与えたコマンドのvarに順次代入しながら全て実行する。  
```  
Usage: whileline file command  
[+] UsageVar: var  
EXAMPLE:  
echo aaa > file_A  
echo bbb > file_B  
ls -1 | grep file_.* > argFile  
whileline argFile "cat var"  
```  
  
* pyenv_update  
pyenv/pyenv-virtualenvのPythonバージョンを一斉にバージョンアップする。
```
Usage: pyenv_updage [python2_version] [python3_version]
```
  
* aslr  
現在のaslrをチェック、変更。  
```  
Usage: aslr [option]  
NoUseOptions : check now aslr  
on           : aslr on  
off          : aslr off  
```  
  
* binsed  
バイナリレベルでの置換。  
```  
Usage: binsed [file_name] [before] [after] 
```  
  
* bkup  
バックアップコマンド。  
バックアップ元、バックアップ先のディレクトリを変更したい場合は、コードの中のrsyncの文の引数を各自で書き換えてください。  
```  
Usage: bkup  
```  
  
* rst  
bkupコマンドの逆を行うコマンド。  
bkupとrstを使うことで、容易にバックアップとリストアを行う事が可能になる。  
bkupコマンドを書き換えた場合は、こちらも書き換えてください。  
```  
Usage: rst  
```  
  
* chkbmap  
キーボード配列を変更する。  
jp配列,us配列,Dvorak配列に対応。  
リクエストして頂ければバリエーションを増やします。  
```  
Usage: chkbmap [kbmap_symbol]  
[+]UsageSymbol:  
jp: Japan  
us: USA  
dv: Dvorak  
```  
  
* def  
シェルスクリプトのテンプレートを引数に与えたファイル名で生成。  
```  
Usage: def file_name  
```  
  
* defc  
C言語のテンプレートを引数に与えたファイル名で生成。  
```  
Usage: def file_name  
```  
  
* dirmk  
dirmkコマンドで作成したディレクトリは、パスのベースネームを入力するだけでそこへ飛べるようになる。  
（内部的にはcdirファイルに追加するだけ。このコマンドを使わなくてもcdirファイルに追記すればベースネームで飛べるようになる。）  
使用するにはbashrcに  
source $HOME/repos/mgtools/cdir  
を追記する必要がある。  
```  
Usage: dirmk file  
```  
  
* dirrm  
dirmkコマンドで作成したディレクトリを削除するときはこのコマンドを使用する。  
（このコマンドを使用せずに普通にrm -rfコマンドで削除しても問題は無い（cdirが汚なくなるだけ））  
```  
usage: dirrm file  
```  
  
* c  
cファイルをvimで編集する。ただし、引数として与える文字列は、.cを書かなくても良い。  
```  
Usage: c [file]  
```  
  
* g  
gccのラッパーコマンド。  
デフォルトの出力ファイルがa.outではなく、拡張子の.cを取り除いたファイル名になる。  
また、オプションでセキュリティ機構を容易に設定してコンパイルを行うことが可能。  
gc.confにオプションを書いておけば以降何度も指定する必要が無い。  
また、.cをつけなくても自動で付与してくれる。  
自動で-W -Wall -I /home/mgtools/include/ -I ./includeが付与される。  
```  
Usage: g [options] [C_file]  
[+]UsageOptions:  
   64  
   32  
   sspoff/canaryoff  
   depoff/nxoff  
   pie  
   fullrelro  
   dbg  
  
[+]EXAMPLE:  
   (bash) ls  
   include/ main.c canvas.c memory.c  
   (bash) ls include  
   canvas.h memory.h  
   (bash) g main canvas.c memory.c  
   (bash) ls  
   include/ main main.c canvas.c memory.c  
   (bash) g 32 depoff main.c canvas.c memory.c  
   (bash) ls  
   include/ main main.c canvas.c memory.c  
   (bash) file main  
   Intel 80386  
   (bash) gdb main  
   (gdb-peda) checksec  
   NX: disable  
```  
  
* x  
gを用いてコンパイル->実行というフローを自動で行う。  
```  
Usage: x [options] [C_file]  
[+]UsageOptions:  
   64  
   32  
   sspoff/canaryoff  
   depoff/nxoff  
   pie  
   fullrelro  
   dbg  
```  
  
* getfile  
オプションでファイルの種類を種別して表示することが可能。  
主にシェルスクリプト作成用のコマンドで、普段のlsの代わりには後述のols/lse/lsrコマンドを用いる。  
```  
Usage: getfile [option]  
[+]UsageOption:  
d: dir  
x: exe  
o: others  
a: all  
```  
  
* gettldata.py  
引数にユーザー名/ツイート数を与えることで、そのユーザーのタイムラインを取得。  
これ以降Twitter系のスクリプトが紹介されることがあるが、いずれも  
$HOME/Documents/twitter内に  
twitter.AS  twitter.AT  twitter.CK  twitter.CS  
という,APIキー等を保存した4つのファイルが必要。  
```  
Usage: python gettldata.py userid count  
userid : user id  
count  : tweet_county  
```  
  
* gettweetdata.py  
引数にツイートの固有のID（URLに書いてある）を与えることで、そのツイートのJSONデータを取得。  
```  
Usage: python gettweetdata.py statusid  
statusid : tweet's status id  
```  
  
* git2  
gitのラッパーコマンド。   
一番最初に「 git2 add_alias 」をしておくと幸せになれる。  
(giから始まるaliasが使用可能になる)  
"ac"を含むコマンド（ac, acm, acp, etc...)を使用時でかつコミットするファイルが一つのみの時、  
"update hogehoge"というコミットメッセージを入力すると"[update]file_name : hogehoge"となり、  
"bugfix hogehoge"で"[bugfix]file_name : hogehoge"、  
"new hogehoge"で"[new]file_name : hogehoge"  
というコミットメッセージを自動で生成してくれる。  
(update, bugfix, newはそれぞれu, b, nと省略可能)  
また、branchを引数に与える場合、masterはmと省略可能。  
```  
Usage: git2 [clone] [add [file]] [branch]  
            [branch [existed_branch]] [branch -a] [branch rmremote] [branch [not_existed_branch]  
]  
            [commit] [merge [branch]] [push [branch]] [cm [branch]] [cp [branch]]  
            [cmp [branch]] [ac [file]] [acm [file] [branch]] [acp [file] [branch]]  
            [acmp [file] [branch]] [rmindex] [add_alias]  
 clone : _____________________ super clone  
 status: _____________________ super status  
 add [file]: _________________ super add  
 diff [file]: ________________ super diff  
 branch: _____________________ show branch  
 branch -a: __________________ show branch all  
 branch -d [branch]: _________ delete branch  
 branch [existed_branch]: ____ checkout  
 branch [not_existed_branch]:_ create branch -> checkout  
 branch rmremote: ____________ git remote prune origin  
 commit: _____________________ super commit  
 merge [branch]: _____________ checkout -> merge preview_branch -> checkout preview_branch  
 push [branch]: ______________ checkout [branch] -> push -> checkout preview_branch  
 cm [branch]: ________________ git2 commit -> git2 merge [branch]  
 cp [branch]: ________________ git2 commit -> git2 push [branch]  
 cmp [branch]: _______________ git2 commit -> git2 merge [branch] -> git2 push  
 mp [branch]: ________________ git2 merge [branch] -> git2 push  
 ac [file]: __________________ git2 add [file] -> git2 commit  
 acm [file] [branch]: ________ git2 add [file] -> git2 commit -> git2 merge [branch]  
 acp [file] [branch]: ________ git2 add -> git2 commit -> git2 push  
 acmp [file] [branch]: _______ git2 add [file] -> git2 commit -> git2 merge [branch] -> git2 pus  
h  
 rmindex [file]: _____________ git2 rm --cache [file]  
 add_alias: __________________ add aliases to $HOME/.bashrc ( You have to check below.  
 )  
  
 [+]You can use these default aliases:  
 s: status  
 a: add  
 b: branch  
 c: commit  
 m: merge  
 p: push  
  
 [+]You can use these after use add_alias option:  
 gi:     git2  
 gis:    git2 status  
 gif     git2 diff  
 gia:    git2 add  
 gic:    git2 commit  
 gim:    git2 merge  
 gip:    git2 push  
 gib:    git2 branch  
 gicm:   git2 cm  
 gicp:   git2 cp  
 gicmp:  git2 cmp  
 gimp:   git2 mp  
 giac:   git2 ac  
 giacm:  git2 acm  
 giacp:  git2 acp  
 giacmp: git2 acmp  
```  
  
* hashdiff  
ディレクトリAとディレクトリBの内部を再帰的にハッシュ比較し、一致すればTrueを、一致しなければFalseを文字列として返す。  
最後にオプションとしてcheckを追加することで、ファイルとして比較結果を出力。  
今回はただのパスの羅列で、上下の行に関連性が無いため、後述のwatchdiffコマンドを用いると見やすい。  
```  
Usage: hashdiff [path1] [path2] [option]  
[+]UsageOption:  
check: check_diff_file  
```  
  
* watchdiff  
diffの結果として吐かれたファイルの不一致の部分だけが見れるようになる。（-U 0オプションをつけてdiffした場合と同じになる）  
```  
age: ./watchdiff [-h] -a argA [-b argB] [-c argC] expr...  
 -h        show help  
 -a [argA] set arg1  
 -b [argB] set arg2  
 -c [argC] set arg3  
 expr      set expr  
```  
  
* index2ts  
  
```  
Usage: index2ts [index.m3u8_file]  
```  
  
* ipcalc.py  
IPアドレスを計算するスクリプト。  
(e.g)  
python ipcalc.py ip 192.168.11.1 mask 255.255.255.0  
```  
Usage: ipcalc [option]  
[+]UsageOption: 
ip [int_ip]: ip_addr  
ipb [bin_ip]: ip_addr  
mask [int_mask]: subnetmask  
```  
  
* libcstrings  
共有ライブラリ内の文字列を検索することが可能。  
-fオプション無しで、デフォルトの共有ライブラリを使用する。  
（デフォルトは各自でコードを書き換えてください。）  
```  
Usage: libcstrings [option] [strings]  
default: defalut_libc  
-f [libc_name]: use_notDefault_libc  
```  
  
* lse  
lsの結果をファイルの種類別にソートし、番号を付与する。  
付与された番号を入力することで、ディレクトリならcd、実行可能ファイルなら実行、テキストファイルならcatを自動で実行する。  
（後述のfコマンドで付与された番号のファイルの絶対パスを取得することが可能。また、実行可能ファイルをcatしたい場合や、テキストファイルをvimした場合などは、後述の末尾がfのスクリプト群を使用。）  
lseコマンドを使用するためには、"source $HOME/repos/mgtools/numcd.alias"の$HOME/.bashrcへの追記と$HOME/Documents/numcd/ディレクトリの作成が事前に必要。  
```  
Usage: lse [option] [clm_num(default: 3)]  
[+]UsageOptions:  
h: help  
d: dir  
x: exe  
o: others  
a: all  
g: grep [$1: arg]  
```  
  
* f  
lseコマンドで付与された番号を引数に渡すことで、そのファイルの絶対パスを取得することが可能。  
```  
Usage: f number  
number : lse number  
```  
  
* catf  
lseコマンドで付与された番号を引数に渡すことで、そのファイルをcatすることが可能。  
```  
Usage: catf number  
number : lse numbe  
```  
  
* vif  
lseコマンドで付与された番号を引数に渡すことで、そのファイルをvimすることが可能。  
```  
Usage: vif number  
number : lse number  
```  
  
* rmf  
lseコマンドで付与された番号を引数に渡すことで、そのファイルをrmすることが可能。  
```  
Usage: rmf number  
number : lsenumber  
```  
  
* lsr  
lsコマンドの結果をpercolに渡す。  
エンター後のreadでそのファイルに対して行うコマンドを入力できる。  
このコマンドを使用するにはpercolの導入が必要。（inisial_settingのallinstall内部に導入コマンドが書いてある。）  
```  
Usage: lsr [option]  
[+]UsageOption:  
d: dir  
x: exe  
o: others  
a: all  
```  
  
* m  
2と3だけ見るman。  
```  
Usage m [str]  
```  
  
* makeLib  
src_fileに与えたファイルを一行ずつ取得し、それぞれを最小文字数min、最大文字数maxで全パターン組み合わせ、dst_fileに出力する。  
これを用いれば、ワードリストから辞書攻撃用の辞書を生成することが可能。  
（johnを開発したチームが提供している辞書攻撃用のファイルはpasswordは存在していてもpasswordAは存在していないが、これを用いればpasswordAも含む辞書を作成することが可能。）  
※このコマンドを使用して生成した辞書を用いた攻撃を外部に対して行っても私は責任を負いません。  
※削除要請があり次第、リモートリポジトリから削除します。  
```  
Usage: makeLib [min] [max] [src_file] [dst_file]  
min      : min char num  
max      : max char num  
src_file : src word list name  
dst_file : output library file name  
```  
  
* mp4abduction  
ツイートのURLを渡すことで、そのツイートに動画が含まれていればそれを保存することが可能。  
（Twitterにおいて、画像の保存は容易に可能だが動画の保存は困難なため、ツイートに含まれる動画を取得したい場合はこのスクリプトを使用する。）  
```  
Usage: mp4abduction [tweet_url]  
```  
  
* nowloading  
ロード中のアニメーションをloop_countで指定された回数表示する。  
```  
Usage: nowloading [loop_count]  
```  
  
* nsed  
input_fileに指定されたファイルをsed_patternに指定した正規表現で置換することが可能。  
このスクリプトを用いることで、`<tag>.*</tag>`というような複数行に跨る置換を行うことが可能になる。  
(e.g)  
`nsed index.html "<script>.*</script>" "<script>alert("deleted");</script>"`

```  
Usage: nsed file before after  
file   : input file name  
before : before  
after  : after  
```  
  
* ols  
lsコマンドをファイルの種別にソートして出力。  
各種75個までは折り返して縦に出力されるため、目で追いやすい。  
-gオプションでgrep、-vオプションでgrep -vをまとめて可能。--lessで自動でlessにかけることができる。  
```  
Usage: ols [option]  
d: dir  
x: ex  
n: others  
1: one line  
g [pattern]: grep  
v [pattern]: grep  v  
--less : show result by less  
```  
  
* pgdb  
プロセスをデバッグすることが可能。  
pythonで実行可能ファイルに対してsocket通信をしている最中にinput関数等で処理をストップ、  
その間にpgdbに実行可能ファイルの名前を渡して実行すると、socket通信のデバッグを行うこともできる。  
リモートエクスプロイトでよくこの手法を用いる。  
```  
Usage: pgdb [file]  
```  
  
* png  
外部への疎通確認をとるコマンド。  
引数を与えるとそのアドレスへの疎通を、引数無しで8.8.8.8とgoogle.comへの疎通を確認する。  
```  
Usage: png [ip_addr(def:8.8.8.8 & google.com)]  
```  
  
* rmnoline  
空行を削除して出力する。  
```  
Usage: rmnoline [file_name] 
```  
  
* rmtmp  
カレントディレクトリに存在する拡張子がtmpになっているファイルをまとめて削除する。  
```  
Usage: rmtmp  
```  
  
* rp2  
ROPgadget探索スクリプト。  
countに1を与えるとpop数が1のgadgetを、countに2を与えるとpop数が2のgadgetを、countに-aもしくはallを与えると、pop数1~4のgadgetを出力する。  
```  
Usage: rp2 file count  
file  : file name  
count : pop count(-a/all: search 1-4 pop count)  
```  
  
* sa  
一時的にカレントパスを保存するコマンド。  
$HOME/Documents/save/saveに保存されている。  
alias save="cat $HOME/Documents/save/save"  
というようなエイリアスをかけておくことでsaveと入力するだけで保存されているパスを確認できるようになるため便利。  
```  
Usage: sa  
```  
  
* ve  
saveに保存されているパスへ移動する。  
```  
Usage: ve  
```  
  
* sedparag  
引数に与えた文字列が含まれる行から次の空行までを出力する。  
```  
Usage: sedparag word  
```  
  
* sharemount  
共有フォルダをマウントする。  
$HOME/Documents/sharemountディレクトリ内に  
sharemount.password  sharemount.username  
という二つのファイルを作成し、それぞれホストのコンピュータのユーザー名とパスワードを保存しておいてください。  
```  
Usage: sharemount [ip(def:192.168.44.1)]  
```  
  
* sizecheck  
check_pathに指定されたパスに存在するファイル/ディレクトリのサイズをソートしてout_fileに出力する。  
主に使用するのはbash on Ubuntu on Windows。  
なぜなら、Windowsでフォルダのサイズを確認することはとても困難なため。  
```  
Usage: sizecheck check_path out_file  
```  
  
* sock  
引数に与えたファイルを4444ポートで待機させる。  
nc localhost 4444で接続/実行することが可能。  
既にそのポートで待機中のプログラムがあった場合、killする。  
```  
Usage: sock file  
```  
  
* sym  
-fオプションに与えたファイルに存在するシンボルをpatternに与えた正規表現で抽出する。  
(e.g)  
sym -f a.out printf  
```  
Usage: sym [option] pattern  
 -f : file_name  
 no_use_option : default_libc  
```  
  
* twitter  
CUIのツイッタークライアントを起動する。  
-aオプションでタイムラインファイルに現在のタイムラインを保存する。（こまめに閲覧しないとAPI制限で多量のツイートの取得ができなくなってしまうため、時間を長く開ける場合にはこのコマンドでとりあえず保存しておく必要がある。）  
twitterコマンドを引数無しで実行すると、前回の最後のツイートから続きを見ることが可能。  
$HOME/Documents/twitter内に  
nglist,oklistというファイルを作成することで、正規表現でNGワード,OKワードを設定することができる。  
```  
Usage: twitter [option]  
[+]UsageOption:  
   a: add_tl  
   no_use_option: output  
```  
  
* whitecat  
色つき文字列を含むファイルを色無しでcatする。  
利用目的はwechoと同様。  
```  
Usage: whitecat file  
```  
  
* del  
ターミナル上のカーソルがある行を無にする。  
単独で使用することは滅多に無い。  
後述のwritedelで使用されている。  
```  
Usage: del  
```  
  
* writedel  
引数に指定された文字列を0.1秒だけ表示して消す。  
ターミナル上で実行することは滅多に無く、スクリプトで組んで使用することが多い。  
これを用いれば、一行のアニメーションを作成することが可能。  
nowloadingコマンドに使用されている。  
```  
Usage: writedel str...  
```  
  
* xready  
エクスプロイトコードのテンプレートをカレントディレクトリに生成する。  
引数を与えるとそのファイル名で生成、引数無しでexploit.pyというファイル名で生成する。  
```  
Usage: xready [file(def:exploit.py)]  
```  
  
* md  
マークダウン記法でテキストを編集する際に自動で行末にスペース二つを入れてくれる編集コマンド。  
内部では$EDITOR環境変数が存在すれば$EDITORを用いて編集し、無ければvimを使う仕様になっているので、  
vim以外を使いたい方はexport EDITOR=emacsとかしてください。  
enertライブラリを使っているので、導入してください。(https://github.com/miyagaw61/enert)
```  
Usage md [file]  
```  
