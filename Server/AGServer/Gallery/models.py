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
	
	def __str__(self):
		return str(self.id) + '  ' + self.name
	
	
class Painting(models.Model):
	id = models.AutoField(primary_key = True)
	title = models.CharField(max_length = 255)
	year = models.CharField(max_length = 4)
	
	def __str__(self):
		return self.title + ',  ' + str(self.year)
