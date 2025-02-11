from flask import Flask, request

app = Flask(__name__)

VERIFY_TOKEN = 'myToken'

@app.route('/webhook', methods=['GET'])
def verify():
    mode = request.args.get('hub.mode')
    token = request.args.get('hub.verify_token')
    challenge = request.args.get('hub.challenge')
    if mode == 'subscribe' and token == VERIFY_TOKEN:
        return challenge, 200
    else:
        return 'Forbidden', 403  

@app.route('/webhook', methods=['POST'])
def receive_message():
    data = request.get_json()
    print("Received message:", data)  # Logs for debugging
    return 'EVENT_RECEIVED', 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3000)
