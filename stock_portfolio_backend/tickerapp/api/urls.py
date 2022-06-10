from django.urls import path
from tickerapp.api.viws import create_ticker_view, AlpacaTickerList, alpaca_quick_order_view, update_ticker_view

app_name="tickerapp"

urlpatterns = [
    path('create/', create_ticker_view, name='add'),
    path('<slug>/list/', AlpacaTickerList.as_view(), name='list'),
    path('quickorder/', alpaca_quick_order_view, name='quickorder'),
    path('<slug>/update/', update_ticker_view, name='update')
]