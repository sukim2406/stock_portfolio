from os import stat
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from tickerapp.api.serializers import TickerSerializer, TickerCreateSerializer
from rest_framework.generics import ListAPIView
from rest_framework.authentication import TokenAuthentication
from tickerapp.models import Ticker
from accountapp.models import Account
import requests, json


@api_view(['POST'])
@permission_classes((IsAuthenticated,))
def create_ticker_view(request):
    try:
        account = request.user
        ticker = Ticker(user=account)
    except Account.DoesNotExist:
        return Response(status = status.HTTP_404_NOT_FOUND)

    if request.method == "POST":
        serializer = TickerCreateSerializer(ticker, data=request.data)

        if serializer.is_valid():
            headers = {'APCA-API-KEY-ID': account.alpaca_api_key, 'APCA-API-SECRET-KEY': account.alpaca_secret_key}
            account_url = "https://data.alpaca.markets/v2/stocks/{}/snapshot".format(serializer.validated_data['ticker'])
            r = requests.get(account_url, headers=headers)
            data = json.loads(r.content)
            if(r.status_code == 200):
                serializer.validated_data['currentPrice'] = data['latestTrade']['p']
                print(serializer.validated_data)
                try:
                    serializer.save()
                    return Response(serializer.data, status=status.HTTP_201_CREATED)
                except Exception as e:
                    print('hihi')
                    print(e)
                    return Response(serializer.errors, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
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


@api_view(['POST'])
@permission_classes((IsAuthenticated,))
def alpaca_limit_buy_view(request):
    try:
        account = request.user
    except Account.DoesNotExist:
        return Response(status = status.HTTP_404_NOT_FOUND)

    if request.method == "POST":
        serializer = TickerSerializer(data=request.data)
        
        if serializer.is_valid():
            body = {
                'symbol': serializer.data['ticker'].upper(),
                'qty': serializer.data['qty'],
                'side': 'buy',
                'type': 'limit',
                'time_in_force': 'gtc',
                'limit_price': serializer.data['averagePrice'],
            }
            headers = {'APCA-API-KEY-ID': account.alpaca_api_key, 'APCA-API-SECRET-KEY': account.alpaca_secret_key}
            live_url = "https://api.alpaca.markets"
            paper_url = "https://paper-api.alpaca.markets"
            base_url = ""
            if(account.paper_account):
                base_url = paper_url
            else:
                base_url = live_url
            order_url = "{}/v2/orders".format(base_url)
            # account_url = "https://data.alpaca.markets/v2/orders".format(serializer.validated_data['ticker'])
            r = requests.post(order_url, headers=headers, json=body)
            data = json.loads(r.content)
            if(r.status_code == 200):
                return Response(data=data, status=status.HTTP_201_CREATED)
    
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST'])
@permission_classes((IsAuthenticated,))
def alpaca_limit_sell_view(request):
    try:
        account = request.user
    except Account.DoesNotExist:
        return Response(status = status.HTTP_404_NOT_FOUND)

    if request.method == "POST":
        serializer = TickerSerializer(data=request.data)
        
        if serializer.is_valid():
            body = {
                'symbol': serializer.data['ticker'].upper(),
                'qty': serializer.data['qty'],
                'side': 'sell',
                'type': 'limit',
                'time_in_force': 'gtc',
                'limit_price': serializer.data['averagePrice'],
            }
            headers = {'APCA-API-KEY-ID': account.alpaca_api_key, 'APCA-API-SECRET-KEY': account.alpaca_secret_key}
            live_url = "https://api.alpaca.markets"
            paper_url = "https://paper-api.alpaca.markets"
            base_url = ""
            if(account.paper_account):
                base_url = paper_url
            else:
                base_url = live_url
            order_url = "{}/v2/orders".format(base_url)
            # account_url = "https://data.alpaca.markets/v2/orders".format(serializer.validated_data['ticker'])
            r = requests.post(order_url, headers=headers, json=body)
            data = json.loads(r.content)
            if(r.status_code == 200):
                return Response(data=data, status=status.HTTP_201_CREATED)
    
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['PUT',])
@permission_classes((IsAuthenticated,))
def update_ticker_view(request, slug):
    try:
        ticker = Ticker.objects.get(slug=slug)
    except:
        return Response(status=status.HTTP_404_NOT_FOUND)
    
    user = request.user
    if ticker.user != user:
        return Response(status=status.HTTP_401_UNAUTHORIZED)

    if request.method == 'PUT':
        serializer = TickerSerializer(ticker, data=request.data)
        if serializer.is_valid():
            serializer.update()
            return Response(status=status.HTTP_200_OK)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['DELETE',])
@permission_classes((IsAuthenticated,))
def delete_ticker_view(request, slug):
    try:
        ticker = Ticker.objects.get(slug=slug)
    except:
        return Response(status=status.HTTP_404_NOT_FOUND)

    user = request.user
    if ticker.user != user:
        return Response(status=status.HTTP_401_UNAUTHORIZED)

    if request.method == 'DELETE':
        operation = ticker.delete()
        if(operation):
            return Response(status=status.HTTP_200_OK)
        else:
            return Response(status=status.HTTP_400_BAD_REQUEST)
