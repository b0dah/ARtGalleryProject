from rest_framework import serializers

from .models import Museum, Artist, Painting

class ArtistSerializer(serializers.ModelSerializer):
	class Meta:
		model = Artist
		fields = ['id', 'name', 'yearsOfLife', 'country', 'portraitImagePath']

class PaintingSerializer(serializers.ModelSerializer):
		
	#Foreign Keys:
	museum_id = serializers.PrimaryKeyRelatedField(queryset=Museum.objects.all())
	author = ArtistSerializer(many=False, read_only = True)
	
	# META
	class Meta:
		model = Painting
		
		fields = ('id', 'title', 'year', 'description', 'genre', 'imagePath', 'physicalWidth', 'physicalHeight', 'museum_id', 'author')
	
	def create(self, validated_data):
		return Paiting.objects.create(**validated_data)
	

class MuseumSerializer(serializers.ModelSerializer):
	
	class Meta:
		model = Museum 
		
		fields = ['id', 'name', 'country', 'city', 'description', 'logoImagePath', 'appearenceImagePath']
