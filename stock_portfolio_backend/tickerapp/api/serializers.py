from rest_framework import serializers
from tickerapp.models import Ticker

class TickerCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Ticker
        fields = ['portfolioSlug', 'ticker', 'qty', 'averagePrice',  'currentPrice']

class TickerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Ticker
        fields = ['portfolioSlug', 'ticker', 'qty', 'averagePrice',  'currentPrice']

    def update(self):
        ticker = Ticker.objects.get(slug=(self.validated_data['ticker'] + "-" + self.validated_data['portfolioSlug']))
        newQty = ticker.qty + self.validated_data['qty']
        if(self.validated_data['qty'] > 0):
            newSubtotal = (ticker.averagePrice * ticker.qty) + (self.validated_data['averagePrice'] * self.validated_data['qty'])
        else:
            newSubtotal = (ticker.averagePrice * ticker.qty) + (ticker.averagePrice * self.validated_data['qty'])
        newAveragePrice = newSubtotal / newQty
        ticker.qty = newQty
        ticker.averagePrice = newAveragePrice
        ticker.save()

