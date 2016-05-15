from authomatic.providers import *
from authomatic.providers.openid import *

class Steam(OpenID):
    identifier = 'http://steamcommunity.com/openid'

CONFIG = {
    'steam': {
        'class_': Steam,
    }
}