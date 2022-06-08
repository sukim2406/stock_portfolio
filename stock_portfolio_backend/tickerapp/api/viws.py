from email.mime import base
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from tickerapp.api.serializers import TickerSerializer
from rest_framework.generics import ListAPIView
from rest_framework.authentication import TokenAuthentication
from tickerapp.models import Ticker
from accountapp.models import Account
import requests, json


@api_view(['POST'])
@permission_classes((IsAuthenticated,))
def add_ticker_view(request):
    try:
        account = request.user
    except Account.DoesNotExist:
        return Response(status = status.HTTP_404_NOT_FOUND)

    if request.method == "POST":
        serializer = TickerSerializer(data=request.data)

        if serializer.is_valid():
            headers = {'APCA-API-KEY-ID': account.alpaca_api_key, 'APCA-API-SECRET-KEY': account.alpaca_secret_key}
            account_url = "https://data.alpaca.markets/v2/stocks/{}/snapshot".format(serializer.validated_data['ticker'])
            r = requests.get(account_url, headers=headers)
            data = json.loads(r.content)
            if(r.status_code == 200):
                serializer.validated_data['currentPrice'] = data['latestTrade']['p']
                serializer.save()
                return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class AlpacaTickerList(ListAPIView):
    serializer_class = TickerSerializer
    authentication_classes = (TokenAuthentication,)
    permission_classes = (IsAuthenticated,)
    def get_queryset(self):
        portfolioSlug = self.kwargs['slug']
        queryset = Ticker.objects.all().filter(portfolioSlug = portfolioSlug)
        for query in queryset:
            headers = {'APCA-API-KEY-ID': query.user.alpaca_api_key, 'APCA-API-SECRET-KEY': query.user.alpaca_secret_key}
            account_url = "https://data.alpaca.markets/v2/stocks/{}/snapshot".format(query.ticker)
            r = requests.get(account_url, headers=headers)
            data = json.loads(r.content)
            if(r.status_code == 200):
                query.set_current_price(data['latestTrade']['p'])
        return queryset