from rest_framework import serializers
from .models import  Driver, Notification, ExplorePlaces, VehicleType
from django.contrib.auth.models import User
from .models import Vehicle, Route, Fare, Stop
from django.contrib.auth import authenticate



class VehicleSerializer(serializers.ModelSerializer):
     class Meta:
        model = Vehicle
        fields = '__all__'

class RouteSerializer(serializers.ModelSerializer):
    # vehicles = VehicleSerializer(many=True)
    class Meta:
        model = Route
        fields = '__all__'
class StopsSerializer(serializers.ModelSerializer):
    # vehicles = VehicleSerializer(many=True)
    class Meta:
        model = Stop
        fields = '__all__'

class FareSerializer(serializers.ModelSerializer):

    # routes = RouteSerializer(many=True)
    class Meta:
        model = Fare
        fields = '__all__'

class AllDataSerializer(serializers.Serializer):
    vehicles = VehicleSerializer(many=True, read_only=True)
    routes = RouteSerializer(many=True, read_only=True)
    fares = FareSerializer(many=True, read_only=True)
    stops = StopsSerializer(many = True, read_only=True) 



#user serializer
class DriverSerializer(serializers.ModelSerializer):
    class Meta:
        model = Driver
        fields = (
            'user_id','username','email', 'route_id','password','type' 
            
        )
class RegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = Driver
        fields = (
        'user_id','username','email','password'
        
            
        )
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        driver = driver.objects.create_user(validated_data['username'], validated_data['email'], validated_data['password'])

        return driver


class LoginSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField()

    def validate(self, data):
        driver = authenticate(**data)
        if driver and driver.is_active:
            return driver
        raise serializers.ValidationError('Incorrect Credentials Passed.')

class NotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Notification
        fields = (
            'title',
            'message',
            'created_at',
            'read'
            
            
        )
class ExplorePlacesSerializer(serializers.ModelSerializer):
    class Meta:
        model = ExplorePlaces
        fields = (
            'name',
            'location',
            'picture',
            'description'
            
            
        )
class VehicleTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = VehicleType
        fields = (
            'name',
            'picture',
            'description'
             )