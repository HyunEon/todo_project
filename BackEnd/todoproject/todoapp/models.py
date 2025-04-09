from django.db import models

class Task(models.Model):
    title = models.CharField(max_length=200)  # 제목
    description = models.TextField(blank=True, null=True)  # 설명 (공백으로 생성 가능)
    is_completed = models.BooleanField(default=False)  # 완료 여부
    duedate = models.DateTimeField(blank=True, null=True) # 목표 시간 (공백으로 생성 가능)
    created_at = models.DateTimeField(auto_now_add=True) # 생성 시점 (auto_now_Add = 데이터 생성 시 값 업데이트)
    updated_at = models.DateTimeField(blank=True, null=True) # 수정 시점

    def __str__(self):
        return self.title  # 관리자 페이지에서 표시될 텍스트