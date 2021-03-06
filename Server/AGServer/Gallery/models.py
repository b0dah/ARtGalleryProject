from django.db import models

# Create your models here.

class Museum(models.Model):
	id = models.AutoField(primary_key = True)
	name = models.CharField(max_length = 300)
	country = models.CharField(max_length = 100)
	city = models.CharField(max_length = 100)
	description = models.CharField(max_length = 2000)
	logoImageTitle = models.CharField(max_length = 300)
	appearenceImageTitle = models.CharField(max_length = 300)
	
	def __str__(self):
		return self.name + ', ' + self.city + ', ' + self.country

class Artist(models.Model):
	id = models.AutoField(primary_key = True)
	name = models.CharField(max_length = 120)
	yearsOfLife = models.CharField(max_length = 20)
	country = models.CharField(max_length = 100)
	portraitImageTitle = models.CharField(max_length = 300)
	link = models.CharField(max_length = 500)
	biography = models.CharField(max_length = 5000)
	
	def __str__(self):
		return str(self.id) + '  ' + self.name
		
# Painting Style
class Genre(models.Model):
	name = models.CharField(max_length = 120, primary_key = True)
	
	def __str__(self):
		return self.name

	
class Painting(models.Model):
	id = models.AutoField(primary_key = True)
	title = models.CharField(max_length = 255)
	year = models.IntegerField()
	description = models.CharField(max_length = 5000)
	imageTitle = models.CharField(max_length = 300)
	physicalWidth = models.FloatField()
	physicalHeight = models.FloatField()
	link = models.CharField(max_length = 500)
	
	#Foreign Keys:
	author = models.ForeignKey(Artist, on_delete = models.SET_NULL, null=True)
	genre = models.ForeignKey(Genre, on_delete = models.SET_NULL, null = True)
	museumId = models.ForeignKey(Museum, on_delete=models.CASCADE)
	
	def __str__(self):
		return self.title + ',  ' + str(self.year)
