from django.urls import path
from api import views
from .views import UserRecordView

urlpatterns = [
    path('routes', views.RouteList.as_view()),
    path('users', views.UserRecordView.as_view(), name="users")
]
