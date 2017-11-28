import sys, tweepy, re

if(sys.argv[1] == "-h"):
    print("Usage: python gettweetdata.py statusid\n\
 statusid : tweet's status id")
    sys.exit(0)

n_regex = re.compile(r"\n")

HOME = '/home/miyagaw61'
CK = open(HOME + '/mgtools/conf/twitter/twitter.CK').read()
CS = open(HOME + '/mgtools/conf/twitter/twitter.CS').read()
AT = open(HOME + '/mgtools/conf/twitter/twitter.AT').read()
AS = open(HOME + '/mgtools/conf/twitter/twitter.AS').read()

CK = n_regex.sub("", CK)
CS = n_regex.sub("", CS)
AT = n_regex.sub("", AT)
AS = n_regex.sub("", AS)

auth = tweepy.OAuthHandler(CK, CS)
auth.set_access_token(AT, AS)
api = tweepy.API(auth)

status_id = sys.argv[1]

try:
    print(api.get_status(status_id))
except:
    print('error')

