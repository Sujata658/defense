from django.shortcuts import render
from .serializers import  NotificationSerializer, ExplorePlacesSerializer, VehicleTypeSerializer, RegisterSerializer, LoginSerializer, DriverSerializer, VehicleSerializer, RouteSerializer, FareSerializer, AllDataSerializer, StopsSerializer
from rest_framework.generics import ListAPIView
from rest_framework.views import APIView
from .models import Driver
from rest_framework import permissions
from rest_framework.response import Response
from .models import  Notification, ExplorePlaces, VehicleType, Fare, Route, Vehicle, Stop
from rest_framework import status,  generics, permissions
from knox.models import AuthToken
from rest_framework.decorators import api_view
from django.contrib.auth import login
from rest_framework.authtoken.serializers import AuthTokenSerializer
from knox.views import LoginView as KnoxLoginView
# from django.contrib.auth.views import LoginView, LogoutView

# Create your views here.





class VehicleList(APIView):
    def get(self, format = None):
        vehicles = Vehicle.objects.all()
        serializer = VehicleSerializer(vehicles, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = Vehicle(data= request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
class StopsList(APIView):
    def get(self, format = None):
        stops = Stop.objects.all()
        serializer = StopsSerializer(stops, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = Stop(data= request.data,)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
class RoutesList(APIView):
    def get(self, format = None):
        routes = Route.objects.all()
        serializer = RouteSerializer(routes, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = RouteSerializer(data= request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
class FareList(APIView):
    def get(self, format = None):
        fare = Fare.objects.all()
        serializer = FareSerializer(fare, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = FareSerializer(data= request.data, many =True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    

class AllDataView(APIView):
    def get(self, request):
        data = {
            'vehicles': Vehicle.objects.all(),
            'routes': Route.objects.all(),
            'fares': Fare.objects.all(),
        }
        serializer = AllDataSerializer(data)
        return Response(serializer.data)
    

# class custom_view(APIView):

#  def get(self, request):
#     # Get all the vehicles
#     vehicles = Vehicle.objects.all()
#     vehicles_data = []
#     # For each vehicle, get its routes and fares
#     for vehicle in vehicles:
#         routes = Route.objects.filter(vehicle=vehicle)
#         fares = Fare.objects.filter(route__in=routes)
#         # Serialize the data for the vehicle, its routes and fares
#         vehicle_data = VehicleSerializer(vehicle).data
#         routes_data = RouteSerializer(routes, many=True).data
#         fares_data = FareSerializer(fares, many=True).data
#         # Append the routes and fares data to the vehicle data
#         vehicle_data['routes'] = routes_data
#         vehicle_data['fares'] = fares_data
#         # Append the vehicle data to the list of vehicles data
#         vehicles_data.append(vehicle_data)
#     # Return the list of vehicles data
#     return Response({'vehicles': vehicles_data})


class custom_view(APIView):
    def get(self, request):
        # Get all the vehicles
        vehicles = Vehicle.objects.all()
        vehicles_data = []
        # For each vehicle, get its routes and fares
        for vehicle in vehicles:
            routes = Route.objects.filter(vehicle=vehicle)
            routes_data = []
            # For each route, get its stops and fares
            for route in routes:
                stops = Stop.objects.filter(route=route)
                fares = Fare.objects.filter(route=route)
                # Serialize the data for the route, its stops and fares
                route_data = RouteSerializer(route).data
                stops_data = StopsSerializer(stops, many=True).data
                fares_data = FareSerializer(fares, many=True).data
                # Append the stops and fares data to the route data
                route_data['stops'] = stops_data
                route_data['fares'] = fares_data
                # Append the route data to the list of routes data
                routes_data.append(route_data)
            # Serialize the data for the vehicle and its routes
            vehicle_data = VehicleSerializer(vehicle).data
            vehicle_data['routes'] = routes_data
            # Append the vehicle data to the list of vehicles data
            vehicles_data.append(vehicle_data)
        # Return the list of vehicles data
        return Response({'vehicles': vehicles_data})
class custom_view2(APIView):
    def get(self, request):
        # Get all the vehicles
        vehicles = Vehicle.objects.all()
        vehicles_data = []
        # For each vehicle, get its routes and fares
        for vehicle in vehicles:
            routes = Route.objects.filter(vehicle=vehicle)
            
            routes_data = []
            # For each route, get its stops and fares
            for route in routes:
                stops = Stop.objects.filter(route=route)
                
                # Serialize the data for the route, its stops and fares
                route_data = RouteSerializer(route).data
                stops_data = StopsSerializer(stops, many=True).data
                
                # Append the stops and fares data to the route data
                route_data['stops'] = stops_data
                
                # Append the route data to the list of routes data
                routes_data.append(route_data)
            # Serialize the data for the vehicle and its routes
            fares = Fare.objects.filter(route=route)
            fares_data = FareSerializer(fares, many=True).data
            route_data['fares'] = fares_data
            routes_data.append(route_data)
            vehicle_data = VehicleSerializer(vehicle).data
            vehicle_data['routes'] = routes_data
            # Append the vehicle data to the list of vehicles data
            vehicles_data.append(vehicle_data)
        # Return the list of vehicles data
        return Response({'vehicles': vehicles_data})

    
class NotificationList(APIView):
    def get(self, format = None):
        notifications = Notification.objects.all()
        serializer = NotificationSerializer(notifications, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = NotificationSerializer(data= request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
class ExplorePlacesList(APIView):
    def get(self, format = None):
        places = ExplorePlaces.objects.all()
        serializer = ExplorePlacesSerializer(places, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = ExplorePlacesSerializer(data= request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
class VehicleTypeList(APIView):
    def get(self, format = None):
        vehicles = VehicleType.objects.all()
        serializer = VehicleTypeSerializer(vehicles, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = VehicleTypeSerializer(data= request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    
class DriverView(APIView):
    def get(self, format=None):
        drivers = Driver.objects.all()
        serializer = DriverSerializer(drivers, many=True)
        return Response(serializer.data)


    def post(self, request):
        serializer = DriverSerializer(data=request.data)
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


# Register API
class SignupApi(generics.GenericAPIView):
    serializer_class = RegisterSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        driver = serializer.save()
        return Response({
            "driver": DriverSerializer(driver, context=self.get_serializer_context()).data,
            "token": AuthToken.objects.create(driver)[1]
        })


class LoginApi(generics.GenericAPIView):
    serializer_class = LoginSerializer

    def post(self, request):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        driver = serializer.validated_data
        return Response({
            "driver": DriverSerializer(driver, context=self.get_serializer_context()).data,
            "token": AuthToken.objects.create(driver)[1]
        })