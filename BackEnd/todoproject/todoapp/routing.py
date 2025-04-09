from django.urls import path
from todoapp.consumers import TodoConsumer

websocket_urlpatterns = [
    path('ws/some_path/', TodoConsumer.as_asgi()),  # WebSocket 연결 경로
]