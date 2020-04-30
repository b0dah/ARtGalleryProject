from django.db import models

# Create your models here.

class Museum(models.Model):
	id = models.AutoField(primary_key = True)
	name = models.CharField(max_length = 300)
	country = models.CharField(max_length = 100)
	city = models.CharField(max_length = 100)
	imageTitle = models.CharField(max_length = 300)
	
	def __str__(self):
		return self.name + ', ' + self.city + ', ' + self.country

class Artist(models.Model):
	id = models.AutoField(primary_key = True)
	name = models.CharField(max_length = 120)
	yearsOfLife = models.CharField(max_length = 20)
	country = models.CharField(max_length = 100)
	portraitImageTitle = models.CharField(max_length = 300)
	
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
	year = models.CharField(max_length = 4)
	description = models.CharField(max_length = 1000)
	imageTitle = models.CharField(max_length = 300)
	
	#Foreign Keys:
	author = models.ForeignKey(Artist, on_delete = models.SET_NULL, null=True)
	genre = models.ForeignKey(Genre, on_delete = models.SET_NULL, null = True)
	museum_id = models.ForeignKey(Museum, on_delete=models.CASCADE)
	
	def __str__(self):
		return self.title + ',  ' + str(self.year)
