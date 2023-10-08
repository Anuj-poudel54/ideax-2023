from django.urls import path, include
from api.views import WordList


urlpatterns = [
    path('', include('rest_framework.urls')),
    path('data', WordList.as_view())
] 
