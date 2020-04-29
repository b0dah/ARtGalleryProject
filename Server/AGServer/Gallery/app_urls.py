from django.urls import path

from .views import PaintingView, MuseumView

app_name = 'Gallery'

urlpatterns = [
	path('paintings', PaintingView.as_view()),
	path('museums', MuseumView.as_view())
]