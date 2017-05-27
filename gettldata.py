import sys, tweepy

def writefile(buf_arg,file_name):
    with open(file_name, 'wb') as f:
        f.write(buf_arg)

if(sys.argv[1] == "-h"):
    print("Usage: python gettldata.py userid count\n\
 userid : user id\n\
 count  : tweet_count")
    sys.exit(0)

HOME = '/home/miyagaw61'

CK = open(HOME + '/Documents/twitter/twitter.CK', 'r').read()
CS = open(HOME + '/Documents/twitter/twitter.CS', 'r').read()
AT = open(HOME + '/Documents/twitter/twitter.AT', 'r').read()
AS = open(HOME + '/Documents/twitter/twitter.AS', 'r').read()

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

