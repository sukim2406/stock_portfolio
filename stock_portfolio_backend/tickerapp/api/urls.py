from django.urls import path
from tickerapp.api.views import create_ticker_view, AlpacaTickerList, alpaca_limit_buy_view, alpaca_limit_sell_view, update_ticker_view, delete_ticker_view

app_name="tickerapp"

urlpatterns = [
    path('create/', create_ticker_view, name='add'),
    path('<slug>/list/', AlpacaTickerList.as_view(), name='list'),
    path('alpaca-quickbuy/', alpaca_limit_buy_view, name='quickbuy'),
    path('alpaca-quicksell/', alpaca_limit_sell_view, name='quicksell'),
    path('<slug>/update/', update_ticker_view, name='update'),
    path('<slug>/delete/', delete_ticker_view, name='delete'), 
]