from rest_framework import serializers
from portfolioapp.models import Portfolio

class PortfolioSerializer(serializers.ModelSerializer):
    class Meta:
        model = Portfolio
        fields = ['title', 'cash']

class PortfolioCashUpdateSerializer(serializers.ModelSerializer):

    qty = serializers.IntegerField(write_only=True)
    averagePrice = serializers.DecimalField(decimal_places=2, max_digits=10, write_only=True)

    class Meta:
        model = Portfolio
        fields = ['qty', 'averagePrice', 'slug']
    
    def save(self):
        portfolio = Portfolio.objects.get(slug=self.validated_data['slug'])
        print(portfolio.cash)
        print((self.validated_data['qty'] * self.validated_data['averagePrice']))
        cash = portfolio.cash - (self.validated_data['qty'] * self.validated_data['averagePrice'])
        print(cash)
        portfolio.cash = cash
        portfolio.save()