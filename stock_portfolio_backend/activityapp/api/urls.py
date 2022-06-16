from django.urls import path
from activityapp.api.views import create_activity_view, ListActivityView

app_name = "activityapp"

urlpatterns = [
    path('create/', create_activity_view, name="create"),
    path('<slug>/list/', ListActivityView.as_view(), name="list"),
]