from rest_framework import serializers

from .models import Museum, Artist, Painting

class ArtistSerializer(serializers.ModelSerializer):
	class Meta:
		model = Artist
		fields = ['id', 'name', 'yearsOfLife', 'country', 'portraitImageTitle']

	
	
	

class PaintingSerializer(serializers.ModelSerializer):
#	id = serializers.IntegerField()
#	title = serializers.CharField(max_length = 255)
#	year = serializers.CharField(max_length = 4)
#	
#	description = serializers.CharField(max_length = 1000)
#	genre = serializers.CharField(max_length = 50)
#	imageTitle = serializers.CharField(max_length = 300)
		
	#Foreign Keys:
	museum_id = serializers.PrimaryKeyRelatedField(queryset=Museum.objects.all())
	author = ArtistSerializer(many=False, read_only = True)
	
	# META
	class Meta:
		model = Painting
		
		fields = ('id', 'title', 'year', 'description', 'genre', 'imageTitle', 'museum_id', 'author')
	
	def create(self, validated_data):
		return Paiting.objects.create(**validated_data)
	

class MuseumSerializer(serializers.Serializer):
	id = serializers.IntegerField()
	name = serializers.CharField(max_length = 300)
	country = serializers.CharField(max_length = 100)
	city = serializers.CharField(max_length = 100)
	imageTitle = serializers.CharField(max_length = 300)
