from django.urls import path
from tickerapp.api.viws import add_ticker_view, AlpacaTickerList, alpaca_quick_order_view

app_name="tickerapp"

urlpatterns = [
    path('add/', add_ticker_view, name='add'),
    path('<slug>/list/', AlpacaTickerList.as_view(), name='list'),
    path('quickorder/', alpaca_quick_order_view, name='quickorder'),

]