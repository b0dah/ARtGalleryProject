from django.contrib import admin

from .models import Artist, Painting
# Register your models here.

admin.site.register(Artist)
admin.site.register(Painting)
