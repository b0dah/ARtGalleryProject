from rest_framework import serializers

from .models import Museum, Painting

class PaintingSerializer(serializers.Serializer):
	id = serializers.IntegerField()
	title = serializers.CharField(max_length = 255)
	year = serializers.CharField(max_length = 4)
	
	def create(self, validated_data):
		return Paiting.objects.create(**validated_data)
	

class MuseumSerializer(serializers.Serializer):
	id = serializers.IntegerField()
	name = serializers.CharField(max_length = 300)
	country = serializers.CharField(max_length = 100)
	city = serializers.CharField(max_length = 100)
	imageTitle = serializers.CharField(max_length = 300)
