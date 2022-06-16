from rest_framework import serializers
from activityapp.models import Activity

class ActivitySerializer(serializers.ModelSerializer):
    class Meta:
        model = Activity
        fields = ['portfolioSlug', 'activity', 'content', 'date', 'price', 'qty', 'title']