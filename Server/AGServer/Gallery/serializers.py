from rest_framework import serializers

from .models import Museum, Artist, Painting

class ArtistSerializer(serializers.ModelSerializer):
	class Meta:
		model = Artist
		fields = ['id', 'name', 'yearsOfLife', 'country', 'portraitImageTitle']

class PaintingSerializer(serializers.ModelSerializer):
		
	#Foreign Keys:
	museumId = serializers.PrimaryKeyRelatedField(queryset=Museum.objects.all())
	author = ArtistSerializer(many=False, read_only = True)
	
	# META
	class Meta:
		model = Painting
		
		fields = ('id', 'title', 'year', 'description', 'genre', 'imageTitle', 'physicalWidth', 'physicalHeight', 'museumId', 'author')
	
	def create(self, validated_data):
		return Paiting.objects.create(**validated_data)
	

class MuseumSerializer(serializers.ModelSerializer):
	
	class Meta:
		model = Museum 
		
		fields = ['id', 'name', 'country', 'city', 'description', 'logoImageTitle', 'appearenceImageTitle']
