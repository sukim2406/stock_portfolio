from rest_framework import serializers
from tickerapp.models import Ticker

class TickerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Ticker
        fields = ['portfolioSlug', 'ticker', 'qty', 'averagePrice', 'username', 'currentPrice', 'user']

    def update(self):
        ticker = Ticker.objects.get(slug=(self.validated_data['ticker'] + "-" + self.validated_data['portfolioSlug']))
        newQty = ticker.qty + self.validated_data['qty']
        newSubtotal = (ticker.averagePrice * ticker.qty) + (self.validated_data['averagePrice'] * self.validated_data['qty'])
        newAveragePrice = newSubtotal / newQty
        print(newAveragePrice)
        ticker.qty = newQty
        ticker.averagePrice = newAveragePrice
        ticker.save()
