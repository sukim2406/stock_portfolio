from distutils.log import Log
from django.urls import path
from accountapp.api.views import registration_view, logout_view, Login, account_detail_view, account_update_view, account_delete_view, alpaca_account_view, alpaca_get_positions_view

app_name = "accountapp"

urlpatterns = [
    path('register/', registration_view, name="register"),
    path('logout/', logout_view, name="logout"),
    path('login/', Login.as_view(), name="login"),
    path('detail/', account_detail_view, name="detail"),
    path('update/', account_update_view, name="update"),
    path('delete/', account_delete_view, name="delete"),
    path('alpaca/', alpaca_account_view, name="alpacaAccount"),
    path('alpaca-positions/', alpaca_get_positions_view, name="alpacaPositions"),
]