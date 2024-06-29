from flask import Flask, redirect, url_for, session, render_template, request
from authlib.integrations.flask_client import OAuth
import os
from dotenv import load_dotenv
load_dotenv()

PORT = 5050
USERINFO_URL = 'https://api.github.com/user'

app = Flask(__name__)
app.secret_key = os.environ.get('FLASK_SECRET_KEY', os.urandom(24))

oauth = OAuth(app)
github = oauth.register(
    name='github',
    client_id=os.environ.get('CLIENT_ID'),
    client_secret=os.environ.get('CLIENT_SECRET'),
    authorize_url='https://github.com/login/oauth/authorize',
    authorize_params=None,
    access_token_url='https://github.com/login/oauth/access_token',
    access_token_params=None,
    refresh_token_url=None,
    redirect_uri=f'http://localhost:{PORT}/callback',
    client_kwargs={'scope': 'user:email'},
)

@app.route('/', methods=['GET'])
def homepage():
    user = session.get('user')
    return render_template('home.html', user=user)

@app.route('/login' , methods=['POST'])
def login():
    redirect_uri = url_for('authorize', _external=True)
    return github.authorize_redirect(redirect_uri)

@app.route('/callback', methods=['GET'])
def authorize():
    token = github.authorize_access_token()
    resp = github.get(USERINFO_URL)
    user_info = resp.json()
    session['user'] = user_info
    return redirect('/')

@app.route('/logout', methods=['POST'])
def logout():
    session.pop('user', None)
    return redirect('/')

if __name__ == '__main__':
    app.run(port=PORT, debug=True)
