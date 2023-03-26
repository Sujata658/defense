from django.contrib import admin
from .models import  Driver, Notification, ExplorePlaces, VehicleType, Vehicle, Fare, Route, Stop

# Register your models here.
admin.site.register(Vehicle)
admin.site.register(Fare)
admin.site.register(Route)
admin.site.register(Driver)
admin.site.register(Notification)
admin.site.register(ExplorePlaces)
admin.site.register(VehicleType)
admin.site.register(Stop)