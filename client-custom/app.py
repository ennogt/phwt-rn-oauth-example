from flask import Flask, redirect, url_for, session, render_template, request
from authlib.integrations.flask_client import OAuth
import os
from dotenv import load_dotenv
load_dotenv()

app = Flask(__name__)
app.secret_key = os.environ.get('FLASK_SECRET_KEY')

PORT = 5040
USERINFO_URL = 'http://127.0.0.1:5000/api/me'

oauth = OAuth(app)
authServer = oauth.register(
    name='authServer',
    client_id=os.environ.get('CLIENT_ID'),
    client_secret=os.environ.get('CLIENT_SECRET'),
    authorize_url='http://127.0.0.1:5000/oauth/authorize',
    authorize_params=None,
    access_token_url='http://127.0.0.1:5000/oauth/token',
    access_token_params=None,
    refresh_token_url=None,
    redirect_uri=f'http://127.0.0.1:{PORT}/callback',
    client_kwargs={'scope': 'profile'},
)

@app.route('/', methods=['GET'])
def homepage():
    user = session.get('user')
    return render_template('home.html', user=user)

@app.route('/login' , methods=['POST'])
def login():
    redirect_uri = url_for('authorize', _external=True)
    return authServer.authorize_redirect(redirect_uri)

@app.route('/callback', methods=['GET'])
def authorize():
    token = authServer.authorize_access_token()
    resp = authServer.get(USERINFO_URL)
    print(f"Response: {resp.json()}")
    user_info = resp.json()
    session['user'] = user_info
    return redirect('/')

@app.route('/logout', methods=['POST'])
def logout():
    session.pop('user', None)
    return redirect('/')

if __name__ == '__main__':
    app.run(port=PORT, debug=True)
