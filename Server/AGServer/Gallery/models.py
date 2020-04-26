from django.db import models

# Create your models here.
class Artist(models.Model):
	id = models.AutoField(primary_key = True)
	name = models.CharField(max_length = 120)
	
	
class Painting(models.Model):
	id = models.AutoField(primary_key = True)
	title = models.CharField(max_length = 255)
	year = models.CharField(max_length = 4)
