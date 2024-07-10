from website.app import create_app

import os
os.environ["AUTHLIB_INSECURE_TRANSPORT"] = "1"

app = create_app({
    'SECRET_KEY': 'secret',
    'OAUTH2_REFRESH_TOKEN_GENERATOR': True,
    'SQLALCHEMY_TRACK_MODIFICATIONS': False,
    'SQLALCHEMY_DATABASE_URI': 'sqlite:///db.sqlite',
})

if __name__ == '__main__':
    app.run(debug=True)