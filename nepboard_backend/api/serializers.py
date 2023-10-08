
from rest_framework import serializers
from api.models import Word

class WordSerializer(serializers.ModelSerializer):
    class Meta:
        model = Word
        fields = ['word','count','lang']