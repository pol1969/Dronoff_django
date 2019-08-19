from django.urls import path

from .views import index, other_page, BBLoginView, profile

app_name = 'main'
urlpatterns = [
        path('<str:page>/', other_page, name='other'),
        path('', index, name='index'),
        path('accounts/login/',BBLoginView.as_view(), name='login'),
        path('accounts/pofile/',profile, name='profile'),
        ]
