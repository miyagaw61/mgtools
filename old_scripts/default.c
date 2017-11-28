#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <regex.h>

int strncpy_s(char*, char*, int);
int* wordsearch(char*, char*);
char *sedonece(char*, char*, char*);
char *sedall(char*, char*, char*);
int strcnt(char*, char*);
int split_bak(char*, char**, char*);
char **split(char*, char**, char*);

int main(void){
	return 0;
}

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
