from django.shortcuts import render
from .serializers import routeSerializer, UserSerializer
from rest_framework.generics import ListAPIView
from rest_framework.views import APIView
from .models import User
from rest_framework.response import Response
from .models import Route
from rest_framework import status

# Create your views here.

class RouteList(ListAPIView):
    queryset = Route.objects.all()
    serializer_class = routeSerializer


class UserRecordView(APIView):
    def get(self, format=None):
        users = User.objects.all()
        serializer = UserSerializer(users, many=True)
        return Response(serializer.data)


    def post(self, request):
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid(raise_exception=ValueError):
            serializer.create(validated_data=request.data)
            return Response(
                serializer.data,
                status=status.HTTP_201_CREATED
            )
        return Response(
            {
                "error": True,
                "error_msg": serializer.error_messages,
            },
            status=status.HTTP_400_BAD_REQUEST
        )