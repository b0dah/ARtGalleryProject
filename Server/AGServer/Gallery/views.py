from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.views import APIView

from .models import Museum, Painting
from .serializers import PaintingSerializer, MuseumSerializer
# Create your views here.

class PaintingView(APIView):
	
	def get(self, request):	# get-method for paiting listing
		museumId = request.query_params.get('museum_id')
		queryset = Painting.objects.all()
		
		# return the whole list of paintings
		serializer = PaintingSerializer(queryset, many = True)
		
		if museumId is not None: # return only related to the corresponding museum
			museumsPaintings = queryset.filter(id=museumId)
			serializer = PaintingSerializer(museumsPaintings, many = True)
		
		return Response({"paintings":serializer.data})
		
class MuseumView(APIView):
	
	def get(self, request):
		museums = Museum.objects.all()
		
		serializer = MuseumSerializer(museums, many = True)
		
		return Response({"museums": serializer.data})