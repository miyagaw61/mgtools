import sys, tweepy

HOME = '/home/miyagaw61'

CK = open(HOME + '/Documents/twitter/twitter.CK', 'r').read()
CS = open(HOME + '/Documents/twitter/twitter.CS', 'r').read()
AT = open(HOME + '/Documents/twitter/twitter.AT', 'r').read()
AS = open(HOME + '/Documents/twitter/twitter.AS', 'r').read()

auth = tweepy.OAuthHandler(CK, CS)
auth.set_access_token(AT, AS)
api = tweepy.API(auth)

status_id = sys.argv[1]

try:
	print api.get_status(status_id)
except:
	print 'error'

