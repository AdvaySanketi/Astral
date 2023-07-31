def send_sms():
    import os

    account_sid = os.environ['AC061b1e05add28b71b6b93ef23242edf3']
    auth_token = os.environ['8f52ed648f1190886ddfc503e1a64a6c']

    from twilio.rest import Client
    client = Client(account_sid, auth_token)

    message = client.messages \
        .create(
            body='Network Anomaly Detected. Take action immediately',
            from_ =  9679257467,
            to = 9679257467
        )

    print(message.sid)
