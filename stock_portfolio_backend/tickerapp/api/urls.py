from django.urls import path
from tickerapp.api.viws import add_ticker_view, AlpacaTickerList

app_name="tickerapp"

urlpatterns = [
    path('add/', add_ticker_view, name='add'),
    path('<slug>/list/', AlpacaTickerList.as_view(), name='list')
]