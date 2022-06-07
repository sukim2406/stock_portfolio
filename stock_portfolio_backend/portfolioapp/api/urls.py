from django.urls import path
from portfolioapp.api.views import create_portfolio_view, ListPortfolioView

app_name = "portfolioapp"

urlpatterns = [
    path('create/', create_portfolio_view, name="create"),
    path('<slug>/list/', ListPortfolioView.as_view(), name="list")
]