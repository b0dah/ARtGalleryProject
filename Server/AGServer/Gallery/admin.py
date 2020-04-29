from django.contrib import admin

from .models import Artist, Painting, Museum
# Register your models here.

admin.site.register(Museum)
admin.site.register(Artist)
admin.site.register(Painting)

