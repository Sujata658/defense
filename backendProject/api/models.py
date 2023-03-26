from django.db import models
import uuid
from django.contrib.postgres.fields import ArrayField

# Create your models here.

from django.db import models

class Vehicle(models.Model):
    name = models.CharField(max_length=100)
    type = models.CharField(max_length=100)

    def __str__(self):
      return self.name
class Route(models.Model):
    vehicle = models.ForeignKey(Vehicle, on_delete=models.CASCADE)
    name = models.CharField(max_length=100)
    starting_point = models.CharField(max_length=100)
    final_point = models.CharField(max_length=100)
    


    def __str__(self):
      return self.name
    

class Stop(models.Model):
    route = models.ForeignKey(Route, on_delete=models.CASCADE, related_name='stops')
    name = models.CharField(max_length=255)
    latitude = models.DecimalField(max_digits=9, decimal_places=6)
    longitude = models.DecimalField(max_digits=9, decimal_places=6)
    distance = models.IntegerField()

    def __str__(self):
        return self.name

class Fare(models.Model):
    route = models.ForeignKey(Route, on_delete=models.CASCADE)
   
    start_location = models.CharField(max_length=100)
    end_location = models.CharField(max_length=100)
    fare = models.DecimalField(max_digits=6, decimal_places=2)

    def __str__(self):
      return self.start_location
    



class Driver(models.Model):
    user_id=models.UUIDField(default=uuid.uuid4, primary_key=True,  max_length=36)
    username = models.CharField( max_length=50)
    password = models.CharField( max_length=10)
    email = models.EmailField( max_length=20)
    route_id = models.CharField(max_length=50)
    type = models.CharField( max_length=50)
    # vehicle_number = models.CharField(max_length=50)

    def __str__(self):
      return self.username

class Notification(models.Model):
    title = models.CharField( max_length=20)
    message = models.CharField( max_length=100)
    created_at = models.DateTimeField(auto_now_add=True)
    read = models.BooleanField(default=False)

    def __str__(self):
      return self.title


class ExplorePlaces(models.Model):
    name = models.CharField(max_length=50)
    location = models.CharField(max_length=50)
    picture = models.ImageField(upload_to='./images')
    description = models.CharField( max_length=250)

    def __str__(self):
      return self.name
    
class VehicleType(models.Model):
    name = models.CharField(max_length=50)
    picture = models.ImageField(upload_to='./images')
    description = models.CharField( max_length=250)

    def __str__(self):
      return self.name
    