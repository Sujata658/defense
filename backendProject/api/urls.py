from django.urls import path, include
from api import views
from knox import views as knox_views





urlpatterns = [
  
    path('routes', views.RoutesList.as_view(), name="Route"),
    path('fare', views.FareList.as_view(), name="Fares"),
    path('vehicle', views.VehicleList.as_view(), name="Vehicle"),
    path('data', views.AllDataView.as_view(), name="Data"),
    path('trueformat', views.custom_view.as_view(), name="True Formatted Data"),
    path('falseformat', views.custom_view2.as_view(), name="False formatted Data"),
    path('drivers', views.DriverView.as_view(), name="Drivers"),
    path('signup', views.SignupApi.as_view(), name="Sign In"),
    path('notifications', views.NotificationList.as_view(), name="notifications get"),
    path('exploreplaces', views.ExplorePlacesList.as_view(), name="Explore Places"),
    path('vehiclestype', views.VehicleTypeList.as_view(), name="Vehicles"),
    # path('api-auth', include('rest_framework.urls'), name="Auth"),
    path('login/', views.LoginApi.as_view(), name='login'),
    path('logout/', knox_views.LogoutView.as_view(), name='logout'),
    path('logoutall/', knox_views.LogoutAllView.as_view(), name='logoutall'),
]
