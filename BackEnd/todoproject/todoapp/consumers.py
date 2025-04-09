import json
from channels.generic.websocket import AsyncWebsocketConsumer

class TodoConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        await self.accept()  # WebSocket 연결 수락
        await self.send(text_data=json.dumps({
            'message': 'WebSocket connect success!'
        }))

    async def disconnect(self, close_code):
        print("WebSocket 연결 종료")

    async def receive(self, text_data):
        data = json.loads(text_data)
        print(f"수신 데이터: {data}")
        await self.send(text_data=json.dumps({
            'response': '서버에서 처리한 메시지'
        }))