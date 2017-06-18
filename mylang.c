/* eval.c                               */  
/* 数式を構文解析し、解を求める         */  
/* コマンドライン第1引数として          */  
/* シングルクォートで囲んで文字列を渡す */  
#include <stdio.h>  
#include <stdlib.h>  
#include <string.h>  
#include <ctype.h>  
#include <regex.h>
  
#define STR_LENGTH 256  
  
enum token {NUMBER = 1, OPERATER = 2, LEFTPAREN = 3, RIGHTPAREN = 4};  
//トークンの種類を定義する列挙型  
  
struct count {  //トークン別に数をカウントする構造体  
    int leftparen;  //カッコ  
    int number;         //数  
    int operater;       //演算子  
    int sign;               //符号  
    int rightparen; //カッコとじ  
};  

int var[256], i, n;
FILE *fp;
unsigned char buf[10000], *p;
char ptmp[256];
char ptmp2[256];
char tmp[256];
char tmp2[256];
char tmparr[256];
char tmparr2[256];
char emp[256];
int l;
char exp[STR_LENGTH];

int strncpy_s(char*, char*, int);
int wordindex(char*, char*);
int* wordsearch(char*, char*);
char *sedonece(char*, char*, char*);
char *sedall(char*, char*, char*);
int strcnt(char*, char*);
int split_bak(char*, char**, char*);
char **split(char*, char**, char*);
  
char *mystrrep(char str1[STR_LENGTH], const char *str2, const char *str3);  
int isoperator(char c);  
char *getoperator(char *exp);  
int gettoken(char *str, char *token);  
int check(char *exp);  
int calc(char *str, int i);  
int eval(char *str);  
  
/* 
 * 関数名:main 
 * コマンドライン引数:式として計算したい文字列 
 * 機能:文字列を解析し、式として計算、値を返す 
 * 返り値:引数エラー 
 */  

int main(int argc, const char **argv)
{
    if (argc < 2) {
        printf("Usage: mylang [src_code]");
        return 1;
    }
 
    // プログラムファイルの読み込み.
    fp = fopen(argv[1], "rt"); // テキストモードでファイルを開く.
    if (fp == NULL) {
        printf("fopen error : %s\n", argv[1]);
        return 1;
    }
    i = fread(buf, 1, 10000, fp);
    fclose(fp);
    if (i >= 10000) {
        printf("too large file : %s\n", argv[1]);
        return 1;
    }
    buf[i] = 0; // 終端マークを書いておく.
 
    // 変数の初期化(なんと親切なプログラミング言語).
    for (i = 0; i < 256; i++)
        var[i] = 0;
 
    // 実行開始.
	//p = &buf[0];
	strncpy_s(ptmp, sedall(buf, "\\ ", ""), 256);
	strncpy_s(ptmp2, sedall(ptmp, "\n\n", "\n"), 256);
    p = &ptmp2[0];
    for (;;) {
		n = wordindex(p, "\n");
		strncpy_s(tmp, emp, 256);
		strncpy_s(tmp, p, n+1);
        if (tmp[0] == 0) {
			break; // ファイル終端.
		}
        if (tmp[0] == '\n') { // 空行.
            p++;
            continue;
        }
		if(strcnt(tmp, "=") > 0){
			l = wordindex(tmp, "=");
		}else if(strcnt(tmp, "\\(") > 0){
			l = wordindex(tmp, "\\(");
		}
		if(wordindex(tmp, "(\\+|\\-|\\*|\\/)") > -1){
			for(i = 0x61; i < 0x62; i++){
				tmparr[0] = i;
				if(wordindex(&tmp[l+1], tmparr) > -1){
					strncpy_s(tmparr, emp, 256);
					sprintf(tmparr, "%d", var[i]);
					strncpy_s(tmparr2, emp, 256);
					tmparr2[0] = i;
					strncpy_s(tmp2, sedall(&tmp[l+1], tmparr2, tmparr), 256);
					strncpy_s(&tmp[l+1], tmp2, 256);
				}
			}
			sprintf(exp, "(%s)", &tmp[l+1]);
			var[tmp[0]] = eval(exp);
			p += n+1;
			continue;
		}else if(wordindex(tmp, "\\=") > -1){
			sprintf(exp, "(%s)", &tmp[l+1]);
			var[tmp[0]] = eval(exp);
			p += n+1;
			continue;
		}
        if (tmp[0] == 'p' && tmp[1] == 'r' ) { // 最初の2文字しか調べてない(手抜き).
            printf("%d\n", var[tmp[l+1]]);
            p += n+1;
            continue;
        }
        printf("syntax error : %.10s\n", tmp);
        return 1;
    }
    return 0;
}

/* 
 * 関数名:mystrrep 
 * 引数:文字列str1、文字列中の置換したい文字列str2、置換する文字列str3 
 * 機能:str1中の最初のstr2パターンをstr3に置換する 
 * 返り値:置換した先頭のアドレス 
 */  
char *mystrrep(char str1[STR_LENGTH], const char *str2, const char *str3){  
    char temp[STR_LENGTH], *p;  //一時保存配列tempとポインタ操作用変数p  
      
    if (strlen(str1) - strlen(str2) + strlen(str3) >= STR_LENGTH){  
        //置換しても領域をオーバーしないかチェック  
        printf("置換後の文字数が多すぎます\n");  //オーバーする場合は処理を終了  
        return NULL;  
    }  
      
    p = str1;   //置換を行う  
    if (p = strstr(p, str2)){   //str2のパターンが見つかる時真  
        strcpy(temp, p + strlen(str2)); //置換される文字以降を一時保存  
        *p = '\0';  //str2が現れる地点で文字列を切る  
        strcat(str1, str3); //str3を繋げたあとに  
        strcat(str1, temp); //元の文字列のstr2パターン以降を戻す  
    }  
    return p;  
}  
  
  
/* 
 * 関数名:isoperator 
 * 引数:１文字 
 * 機能:引数の文字が演算子かであるかどうか判定する 
 *      判定するのは加減乗除 
 * 返り値:演算子であった場合1、そうでない時0 
 */  
int isoperator(char c){  
    if (c == '+' || c == '-' || c == '*' || c == '/')  
        return 1;  
    else  
        return 0;  
}  
  
  
/* 
 * 関数名:getoperator 
 * 引数:計算式を指し示すポインタ 
 * 機能:計算式中の最初に現れる演算子の位置を求める 
 *      カッコ内の演算子は判定しない 
 * 返り値:演算子の位置のポインタ 
 */  
char *getoperator(char *exp){  
    int i, count = 0;  
      
    for (i = 0; (count != 0 || exp[i] != ')') && exp[i] != '\0'; i++){  
        //現在検証中の式の外部のカッコとじまで探す  
        //エラー回避用に文字列終端でも終了  
        if (count == 0 && isoperator(exp[i])){  
            //カッコ内ではない演算子の時返す  
            return &exp[i];  
        } else if (exp[i] == '('){  
            //式中のカッコがある場合カウントする  
            count++;  
        } else if (exp[i] == ')'){  
            //対応するカッコで外れる  
            count--;  
        }  
    }  
    return NULL;  
}  
  
  
/* 
 * 関数名:gettoken 
 * 引数:分解対象の文字列str、分解したトークンを格納する文字列token 
 * 機能:文字列strから、カッコ、数字、演算子のいずれかを切り出す、末尾だとヌル文字 
 * 返り値:切り出されたトークンに対応する整数 
 *        (数字:1、演算子:2、カッコ:3、カッコとじ:4、それ以外はその文字のASCIIコード) 
 */  
int gettoken(char *str, char *token){  
    int i = 0, j = 0;   //文字列操作用変数i  
    while (str[i] == ' ')   //スペースを読み飛ばす  
        i++;  
    if (str[i] == '('){ //カッコを発見した場合  
        strcpy(token, "(");  
        return LEFTPAREN;  
          
    } else if (str[i] == ')'){  //カッコとじを発見した場合  
        strcpy(token, ")");  
        return RIGHTPAREN;  
      
    } else if (isdigit(str[i])){    //数字を発見した場合  
        while (isdigit(str[i])){    //数である文字列部分を切り出す  
            token[j] = str[i];  
            i++;  
            j++;  
        }  
        token[i] = '\0';  
        return NUMBER;      //数字であることを返す  
          
    } else if (isoperator(str[i])){ //演算子を発見した場合  
        sprintf(token, "%c", str[i]);   //演算子を格納  
        return OPERATER;  
    } else {  
        return str[i];  
    }  
}  
  
  
/* 
 * 関数名:check 
 * 引数:数式の文字列 
 * 機能:数式が正規表現となっているかチェックする 
 * 返り値:正規表現の時0、そうでない時は1を返す 
 */  
int check(char *exp){  
    int n, n0 = -1;  
    //取得したトークンの種類を格納するn  
    //前のトークンの値を保存するn0  
    char token[10]; //トークンを格納する文字列、数字9ケタまで  
    struct count c; //トークンを種類別にカウントする構造体  
    memset((void *)&c, 0, sizeof(struct count));    //構造体初期化  
      
    while (*exp != '\0'){   //文字列終端でストップ  
        switch(n = gettoken(exp, token)){   //トークンを取得、種類により分岐  
        case NUMBER:    //数である時、式の先頭か、演算子または'('の後である  
            if (n0 == -1 || n0 == OPERATER || n0 == LEFTPAREN){  
                c.number++;  
            } else {    //そうでないなら構文エラー  
                printf("式の構文エラー\n");  
                return 1;  
            }  
            break;  
              
        case OPERATER:  //演算子である場合、')'の後か、数の後である、符号時の判定も行う  
            if (n0 == RIGHTPAREN || n0 == NUMBER){  
                c.operater++;  
            } else if ((token[0] == '+' || token[0] == '-') && (n0 == -1 || n0 == LEFTPAREN)){  
                //演算子が+か-である場合、式の先頭か')'の後なら負符号である  
                c.sign++;  
            } else {  
                printf("式の構文エラー\n");  
                return 1;  
            }  
            break;  
              
        case LEFTPAREN: //'('である場合、式の先頭か演算子の後か'('の後である  
            if (n0 == -1 || n0 == OPERATER || n0 == LEFTPAREN){  
                c.leftparen++;  
            } else {  
                printf("式の構文エラー\n");  
                return 1;  
            }  
            break;  
              
        case RIGHTPAREN:    //')'である場合、数の後か')'の後である  
            if (n0 == NUMBER || n0 == RIGHTPAREN){  
                c.rightparen++;  
            } else {  
                printf("式の構文エラー\n");  
                return 1;  
            }  
            break;  
          
        case '\0':  //ヌル文字の場合  
            break;  
          
        default:  
            //取得したトークンが、式に関するものかヌル文字でない場合もエラー  
            printf("式の構文エラー\n");  
            return 1;  
        }  
        n0 = n;  
        if (c.leftparen - c.rightparen < 0){ //'('より')'が多く現れたら、その時点で構文エラー  
            printf("式の構文エラー\n");  
            return 1;  
        }  
        exp = exp + strlen(token);  //次のトークンを取得するためにexpを進める  
    }  
    if (n != NUMBER && n != RIGHTPAREN){    //式末尾は数か')'でないといけない  
        if (c.leftparen - c.rightparen != 0){   //カッコの数も合っているかチェック  
            printf("式の構文エラー\n");  
            return 1;  
        }  
    }  
      
    //ここまでのチェックにひっかからなければ、正規表現  
    return 0;  
}  
  
  
/* 
 * 関数名:calc 
 * 引数:式文字列、演算子の位置を示す変数 
 * 機能:演算子の種類に従い、左右の値で計算する 
 *      計算の終了した式は答えの値で置換する 
 * 返り値:演算子により計算された式の値 
 */  
int calc(char *str, int i){  
    int j = i, k,  temp = 0, a, b;  
    //式中を配列で操作するための添え字j  
    //文字列置換字に使うループ用変数k  
    //式の値を保存する変数temp  
    //式の左辺、右辺の値を保存するa,b  
      
    char exp[STR_LENGTH], val[10];  
    //演算している式を保存する文字列exp  
    //値を文字列として使用するval  
      
    char *pl, *pr, *next;  
    //左辺の値の先頭pl、右辺の値の終端pr  
    //右辺の先の演算子をチェックする時に使うnext  
      
    while(1){   //左辺の値を検索する  
        j--;  
        if (str[j] == ')'){ //左辺終端がカッコとじである場合  
            while (str[j] != '('){  
                //カッコまで進めて、evalで左辺値を求める  
                j--;  
                if (j == -1){   //式の範囲をはみださないようにjの値をチェック  
                    printf("式の構文エラー\n左辺の値が取得できませんでした\n");  
                    exit(1);  
                }  
            }  
            pl = str + j;   //左辺値の先頭を保存  
            a = eval(pl);  
            //左辺の値は得たので、ループを抜ける  
            break;  
              
        } else if (isdigit(str[j])){    //数だった場合  
            while (isdigit(str[j - 1])){    //数の先頭までずらしてatoi  
                j--;  
                if (j == 0){    //式の範囲をはみださないようにjの値をチェック  
                    printf("式の構文エラー\n左辺の値が取得できませんでした\n");  
                    exit(1);  
                }  
            }  
            pl = str + j;   //左辺の先頭を保存  
            a = atoi(pl);   //値を取得して、ループを抜ける  
            break;  
        } else if (str[j] == '('){  //演算子が式先頭のマイナスだった場合  
            a = 0;  //左辺値は0として演算すればよい  
            pl = str + j + 1;  
            break;  
        }  
    }  
      
    j = i;  //今度は右辺の値を格納する  
    while (str[j] != ')'){  //最大で右辺終端まで  
        j++;  
        if (str[j] == '('){ //右辺がカッコである場合  
            pr = str + j;   //右辺値の値先頭アドレスを保存  
            if (str[i] == '+' || str[i] == '-'){    //現在の式の演算子が加減である場合、先の乗除をチェックする  
                if ((next = getoperator(pr)) != NULL){  //右辺の先に乗除がないか  
                    switch(*next){  
                    case '*':  
                    case '/':  
                        b = calc(pr, next - pr);    //乗除があった場合、先に計算  
                        break;  
                    case '+':  
                    case '-':  
                        b = eval(pr);   //そうでないなら、普通に右辺値を求める  
                    }  
                } else {    //演算子がない場合  
                    b = eval(pr);   //右辺値を求める  
                }  
            } else {    //演算子自体が乗除なら、前から計算するので値をもらう  
                b = eval(pr);  
            }  
              
            //右辺値終端を式の終わりと見るため  
            //右辺値の終端を探す  
            if (str[j] == '('){ //右辺先頭がカッコである場合  
                while (str[j] != ')'){  
                    j++;  
                    if (str[j] == '\0'){  
                        printf("式の構文エラー\n右辺の値が取得できませんでした\n");  
                        exit(1);  
                    }  
                }  
            } else if (isdigit(str[j])){  
                while (isdigit(str[j + 1]))  
                    j++;  
            } else {  
                printf("式の構文エラー\n右辺の値が取得できませんでした\n");  
                exit(1);  
            }  
            //このときstr + jは右辺値の終端を指す  
            break;  
              
        } else if (isdigit(str[j])){    //右辺値が数の場合  
            pr = str + j;   //右辺値先頭を保存  
            if (str[i] == '+' || str[i] == '-'){  
                if ((next = getoperator(pr)) != NULL){  //同じく右辺の先の乗除をチェック  
                    switch(*next){  
                    case '*':  
                    case '/':  
                        b = calc(pr, next - pr);    //先に計算  
                        break;  
                    case '+':  
                    case '-':  
                        b = atoi(pr);   //右辺値を求める  
                    }  
                } else {  
                    b = atoi(pr);   //atoiで数を求める  
                }  
            } else {  
                b = atoi(pr);   //自身の演算が乗除であった場合、先に計算  
            }  
              
            if (str[j] == '('){ //右辺先頭がカッコである場合  
                while (str[j] != ')'){  
                    j++;  
                    if (str[j] == '\0'){  
                        printf("式の構文エラー\n右辺の値が取得できませんでした\n");  
                        exit(1);  
                    }  
                }  
            } else if (isdigit(str[j])){  
                while (isdigit(str[j + 1]))  
                    j++;  
            } else {  
                printf("式の構文エラー\n右辺の値が取得できませんでした\n");  
                exit(1);  
            }  
            break;  
        }  
    }  
      
    //右辺、左辺の値を受け取ったので演算する  
    switch(str[i]){  
    case '+':  
        temp = a + b;  
        break;  
    case '-':  
        temp = a - b;  
        break;  
    case '*':  
        temp = a * b;  
        break;  
    case '/':  
        if (b == 0){    //0による割り算を回避  
            printf("0による除算が行われました\n");  
            exit(1);  
        } else {  
            temp = a / b;  
        }  
        break;  
    }  
      
    //計算の終わった式を消去する  
    //左辺値の先頭が式の始まり、右辺値の計算より、str + jが終端である  
    k = 0;  
    while (pl + k <= str + j){   //まずは演算した式をexpにコピー  
        exp[k] = pl[k];  
        k++;  
    }  
    exp[k] = '\0';  
      
    if (temp >= 0){  //値を文字列に写す  
        sprintf(val, "%d", temp);  
    } else {  
        sprintf(val, "(%d)", temp);  
    }  
      
    mystrrep(str, exp, val);    //置換  
    return temp;  
}  
  
  
/* 
 * 関数名:eval 
 * 引数:計算したい文字列 
 * 機能:文字列を数式として計算し、処理する、再帰処理にも用いる 
 *      最終的に、引数として渡した計算式も答えの値で置換される 
 * 返り値:計算された式の値 
 */  
int eval(char *str){  
    int i, temp, count = 0;  
    //ループ用変数i、演算結果を保存するtemp、カッコのカウント用count  
    char *p, exp[20], val[10];  
    //ポインタ操作用p、演算した式exp、値を文字列として使用するval  
	
	for(i = 0; i < 256; i++){
		if('a' <= str[i] <= 'z'){
		}
	}

	//printf("str: %s\n", str);
      
    p = str + 1;    //式先頭は'('なので、必ず１つずらす  
    temp = atoi(p); //もしカッコ内が数だけの場合のため保存  
      
    do {    //式中のカッコを探す(先に計算しておく)  
        if (*p == '('){ //カッコを見つけた場合  
            if ((temp = eval(p)) < 0){   //evalを適用  
                count++;  
                //負数だった場合カッコつきで置換されるので１つカウント  
            }  
        } else if (*p == ')'){  //カッコとじが現れた場合  
            count--;  
            //式終端のカッコとじか判定するためにカウントを減らす  
        } else if (*p == '\0'){  
            printf("式の構文エラー、カッコの位置が不正です\n");  
            exit(1);  
        }  
        p++;    //式中のポインタを１つ進める  
    } while (count != 0 || *p != ')');  
    //式終端のカッコとじの場合のみループを抜ける  
      
    while ((p = getoperator(str + 1)) != NULL){ //演算子を求め計算していく  
        temp = calc(str, p - str);  
    }  
      
    count = 0;  
    i = 0;  
    //evalで計算していた式を、答えで置換するために  
    //式先頭と対応するカッコまでをexpに保存  
    do {  
        if (str[i] == '('){  
            count++;  
        } else if (str[i] == ')'){  
            count--;  
        } else if (str[i] == '\0'){  
            printf("式の構文エラー、カッコの位置が不正です\n");  
            exit(1);  
        }  
        exp[i] = str[i];  
        i++;  
    } while (count != 0);   //式終了のカッコまでループ  
    exp[i] = '\0';  
      
    if (temp >= 0){  //答えで置換するためにvalに数文字列を作る  
        sprintf(val, "%d", temp);  
    } else {  
        sprintf(val, "(%d)", temp);  
    }  
    mystrrep(str, exp, val);    //関数calcでも行っているが、値で式を置換  
      
    return temp;  
}  

/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////

char **split(char *arg_buf, char **lst, char *str){
	static char buf[256];
	strncpy_s(buf, arg_buf, 256);
	int n = 0;
	char *tmp;
	tmp = strtok(buf, str);
	while(tmp != NULL){
		*(lst+(n/sizeof(int*))) = tmp;
		tmp = strtok(NULL, str);
		n += sizeof(int*);
	}
	return lst;
}

int strcnt(char *buf, char *str){
	char buf2[256];
	strncpy_s(buf2, buf, 256);
	int *tmp;
	int count = 0;
	tmp = strtok(buf2, str);
	while(tmp != NULL){
		count++;
		tmp = strtok(NULL, str);
	}
	return count-1;
}

int* wordsearch(char* buf_arg, char* before_arg){
	char buf[256];
	char emp[256] = "";
	strncpy(buf, buf_arg, 255);
	buf[255] = '\0';
	const char regex[256];
	strncpy(regex, before_arg, 255);
	char *tmp;
	size_t nmatch = 10;
	regmatch_t pmatch[nmatch];
	regex_t regexBuf;
	int startIndex = 0;
	int endIndex = 0;
	int i = 0;
	if(regcomp(&regexBuf, regex, REG_EXTENDED | REG_NEWLINE) != 0){
		return -1;
	}
	if(regexec(&regexBuf, buf, nmatch, pmatch, 0) != 0){
		return -1;
	}

	startIndex = pmatch[0].rm_so;
	endIndex = pmatch[0].rm_eo - 1;

	int ans[2] = {startIndex, endIndex};

	return ans;
}

char* sedonece(char* buf_arg, char* before_arg, char* after_arg){
	char buf[256];
	char emp[256] = "";
	strncpy(buf, buf_arg, 255);
	buf[255] = '\0';
	const char regex[256];
	strncpy(regex, before_arg, 255);
	char *after = after_arg;
	char *tmp;
	size_t nmatch = 10;
	regmatch_t pmatch[nmatch];
	regex_t regexBuf;
	static char ans[256];
	strncpy(ans, emp, sizeof(emp));
	int startIndex = 0;
	int endIndex = 0;
	int i = 0;
	if(regcomp(&regexBuf, regex, REG_EXTENDED | REG_NEWLINE) != 0){
		printf("Failed\n");
		return 1;
	}
	if(regexec(&regexBuf, buf, nmatch, pmatch, 0) != 0){
		printf("NoMatch\n");
		return 1;
	}

	startIndex = pmatch[0].rm_so;
	endIndex = pmatch[0].rm_eo - 1;

	while(i != endIndex+1){
		if(startIndex == i){ sprintf(ans, "%s%s", ans, after);
			i = i + endIndex - startIndex + 1;
			continue;
		}
		sprintf(ans, "%s%c", ans, buf[i]);
		i++;
	}
	sprintf(ans, "%s%s", ans, &buf[i]);
	regfree(&regexBuf);
	return ans;
}

char *sedall(char *buf_arg, char *before_arg, char *after_arg){
	static char buf[256];
	char ans[256];
	char emp[256] = "";
	strncpy(buf, buf_arg, 255);
	buf[255] = '\0';
	while(strstr(buf, before_arg) != NULL){
		strncpy(ans, buf, 255);
		ans[255] = '\0';
		strncpy(ans, sedonece(buf, before_arg, after_arg), 255);
		strncpy(buf, ans, 255);
		buf[255] = '\0';
	}
	return buf;
}

int strncpy_s(char* buf, char* str , int n){
	strncpy(buf, str, n);
	buf[n-1] = '\0';
	return 0;
}


int wordindex(char* buf_arg, char* before_arg){
	char buf[256];
	char emp[256] = "";
	strncpy(buf, buf_arg, 255);
	buf[255] = '\0';
	const char regex[256];
	strncpy(regex, before_arg, 255);
	char *tmp;
	size_t nmatch = 10;
	regmatch_t pmatch[nmatch];
	regex_t regexBuf;
	int startIndex = 0;
	int endIndex = 0;
	int i = 0;
	if(regcomp(&regexBuf, regex, REG_EXTENDED | REG_NEWLINE) != 0){
		return -1;
	}
	if(regexec(&regexBuf, buf, nmatch, pmatch, 0) != 0){
		return -1;
	}

	startIndex = pmatch[0].rm_so;
	endIndex = pmatch[0].rm_eo - 1;

	return startIndex;
}

