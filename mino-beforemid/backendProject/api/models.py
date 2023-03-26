from django.db import models

# Create your models here.

class Route(models.Model):
    starting_point = models.CharField( max_length=50)
    final_point = models.CharField( max_length=50)
    checkpoints =  models.CharField(max_length=50)


class User(models.Model):
    username = models.CharField( max_length=50)
    password = models.CharField( max_length=10)