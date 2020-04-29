from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.views import APIView

from .models import Museum, Painting
from .serializers import PaintingSerializer, MuseumSerializer
# Create your views here.

class PaintingView(APIView):
	
	def get(self, request):	# get-method for paiting listing
		paintings = Painting.objects.all()
		
		serializer = PaintingSerializer(paintings, many = True)
		
		return Response({"paintings":serializer.data})
		
class MuseumView(APIView):
	
	def get(self, request):
		museums = Museum.objects.all()
		
		serializer = MuseumSerializer(museums, many = True)
		
		return Response({"museums": serializer.data})