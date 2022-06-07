from turtle import st
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from portfolioapp.api.serializers import PortfolioSerializer
from rest_framework.authtoken.models import Token
from rest_framework.response import Response
from rest_framework import status
from portfolioapp.models import Portfolio
from rest_framework.generics import ListAPIView
from rest_framework.authentication import TokenAuthentication

@api_view(['POST',])
@permission_classes((IsAuthenticated,))
def create_portfolio_view(request):
    account = request.user
    portfolio = Portfolio(user=account)

    if request.method == "POST":
        serializer = PortfolioSerializer(portfolio, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class ListPortfolioView(ListAPIView):
    serializer_class = PortfolioSerializer
    authentication_classes = (TokenAuthentication,)
    permission_classes = (IsAuthenticated,)
    def get_queryset(self):
        username = self.kwargs['slug']
        queryset = Portfolio.objects.all().filter(username = username)
        return queryset