from rest_framework import serializers
from .models import Route, User


class routeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Route
        fields = ['starting_point', 'final_point', 'checkpoints']

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = (
            'username',
            'password'
        )