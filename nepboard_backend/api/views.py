from django.shortcuts import render
from rest_framework.generics import ListCreateAPIView
from api.serializers import WordSerializer
from api.models import Word
from rest_framework.permissions import AllowAny
# Create your views here.


class WordList(ListCreateAPIView):
    queryset = Word.objects.all()
    serializer_class = WordSerializer
    permission_classes = [AllowAny]


