import sys, tweepy, re, os

def writefile(buf_arg,file_name):
    with open(file_name, 'wb') as f:
        f.write(buf_arg)

CK = 'JaBCMafqgxW6g3ismku4NQpFf'
CS = '2fJu5sU8ESQV08KiPyALFYTXVQkSnQTz9lizTDFnZSHdK8GPlZ'
AT = '2473741867-QNEei8GMk2YCJMtgS1ZoKNYJbyLuBwpqSRzMTRQ'
AS = 'gPrnZnKo7dgAnKNmRR64ncjfjqUrYdnLkh5L0x7zPARdR'

auth = tweepy.OAuthHandler(CK, CS)
auth.set_access_token(AT, AS)
api = tweepy.API(auth)

tl = api.home_timeline(count=sys.argv[1])
tl.reverse()
nglist = open('/home/miyagaw/Documents/nglist' , 'r').read()
nglist = nglist.split('\n')
oklist = open('/home/miyagaw/Documents/oklist' , 'r').read()
oklist = oklist.split('\n')
#print('hoge\nnglist: ' + str(nglist) + '\noklist: ' + str(oklist))
for status in tl:
    #if(status.favorite_count > 0 or status.retweet_count > 0 or len(re.findall(oklist[i], status.text.encode('utf_8'))) > 0):
    i = 0
    ngflg = 0
    okflg = 0
    while(i < len(nglist)-1):
        if(len(re.findall(nglist[i].decode('utf_8'), status.text)) > 0):
            ngflg = 1
        i = i + 1
    i = 0
    while(i < len(oklist)-1):
        if(len(re.findall(oklist[i].decode('utf_8'), status.text)) > 0):
#            print("-----------------------------------------------------------------------------------------------------------------------------------------------")
#            print('[+] okflg on !!!!')
            #print('[+] status.text: ' + status.text.encode('utf_8'))
#            print('[+] oklist[i]: ' + oklist[i])
            ngflg = 0
            okflg = 1
        i = i + 1
#    print('favorite: ' + str(status.favorite_count))
#    print('retweet: '  + str(status.retweet_count))
#    print('okflg: '    + str(okflg))
#    print('ngflg: '    + str(ngflg))
    if(status.favorite_count > 0 or status.retweet_count > 0 or okflg > 0):
        lastid = int(open('/home/miyagaw/Documents/lastid', 'r').read())
        if(status.id > lastid-40000000000000):
            if(ngflg == 0):
                print("-----------------------------------------------------------------------------------------------------------------------------------------------")
                if(status.in_reply_to_status_id != None):
                    namelist   = []
                    screenlist = []
                    textlist   = []
                    rep = api.get_status(status.in_reply_to_status_id)
                    namelist.append(rep.user.name)
                    screenlist.append(rep.user.screen_name)
                    textlist.append(rep.text)
                    while(rep.in_reply_to_status_id != None):
                        rep = api.get_status(rep.in_reply_to_status_id)
                        namelist.append(rep.user.name)
                        screenlist.append(rep.user.screen_name)
                        textlist.append(rep.text)
                    namelist.reverse()
                    screenlist.reverse()
                    textlist.reverse()
                    print('[-]' + namelist[0].encode('utf_8') + ' @' + screenlist[0].encode('utf_8'))
                    print(textlist[0].encode('utf_8'))
                    i = 1
                    while(i < len(namelist)):
                        print(' | \n' + ' -> [+]' + namelist[i].encode('utf_8') + ' @' +  screenlist[1].encode('utf_8'))
                        print(textlist[i].encode('utf_8'))
                        i = i + 1
                    print(' | \n' + ' -> [+]' + status.user.name.encode('utf_8') + ' @' +  status.user.screen_name.encode('utf_8'))
                    print(status.text.encode('utf_8'))
                else:
                    print('[+]' + status.user.name.encode('utf_8') + ' @' +  status.user.screen_name.encode('utf_8'))
                    print(status.text.encode('utf_8'))
os.system('echo ' + str(tl[len(tl)-1].id) + ' > ~/Documents/lastid')