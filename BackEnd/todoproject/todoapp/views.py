from rest_framework import generics
from django.shortcuts import render
from .models import Task
from .serializers import TaskSerializer

# 레퍼런스 https://velog.io/@jcinsh/RetrieveUpdateDestroyView-%EC%9D%B4%ED%95%B4

# GET, POST
class TaskListCreate(generics.ListCreateAPIView):
    queryset = Task.objects.all()
    serializer_class = TaskSerializer

# UPDATE, DELETE
class TaskRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    queryset = Task.objects.all()
    serializer_class = TaskSerializer
