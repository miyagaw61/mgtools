import sys, tweepy

CK = ''
CS = ''
AT = ''
AS = ''

auth = tweepy.OAuthHandler(CK, CS)
auth.set_access_token(AT, AS)
api = tweepy.API(auth)

status_id = sys.argv[1]

try:
	print api.get_status(status_id)
except:
	print 'error'
