from rest_framework import serializers
from tickerapp.models import Ticker

class TickerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Ticker
        fields = ['portfolioSlug', 'ticker', 'qty', 'averagePrice', 'username', 'currentPrice', 'user']
