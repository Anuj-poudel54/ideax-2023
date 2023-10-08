from django.db import models

# Create your models here.

class Language(models.Model):
    name = models.CharField(max_length=100, unique=True)

    def __str__(self) -> str:
        return self.name

    def __repr__(self) -> str:
        return self.name


class Word(models.Model):

    word = models.CharField(max_length=100, unique=True, null=False, blank=False)
    count = models.IntegerField(null=False, blank=False)
    lang = models.ForeignKey(Language, related_name='words', on_delete=models.CASCADE)  

    def __str__(self) -> str:
        return f"{self.word} : {self.count}"