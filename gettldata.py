import sys, tweepy

def writefile(buf_arg,file_name):
    with open(file_name, 'wb') as f:
        f.write(buf_arg)

CK = ''
CS = ''
AT = ''
AS = ''

auth = tweepy.OAuthHandler(CK, CS)
auth.set_access_token(AT, AS)
api = tweepy.API(auth)

#user_id = sys.argv[1]
user_id = sys.argv[1]
count = str(sys.argv[2])

try:
    for status in api.user_timeline(screen_name=user_id, count=count)[::-1]:
        print(status)

except:
    print 'error'
