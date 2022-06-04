from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated, AllowAny
from accountapp.api.serializers import RegistrationSerializer, AccountPropertiesSerializer, AccountUpdateSerializer
from rest_framework.authtoken.models import Token
from rest_framework.response import Response
from rest_framework import status
from rest_framework.authtoken.views import ObtainAuthToken
from accountapp.models import Account
import requests, json

@api_view(['POST',])
@permission_classes((AllowAny, ))
def registration_view(request):
    if request.method =='POST':
        serializer = RegistrationSerializer(data=request.data)
        data = {}

        if serializer.is_valid():
            account = serializer.save()
            data['response'] = "successfully registered a new user"
            data['email'] = account.email
            data['username'] = account.username
            token = Token.objects.get(user=account).key
            data['token'] = token

            return Response(status=status.HTTP_200_OK, data=data)
        else:
            data = serializer.errors
            return Response(status=status.HTTP_400_BAD_REQUEST, data=data)
        
        # return Response(data)


@api_view(['POST',])
@permission_classes((IsAuthenticated, ))
def logout_view(request):
    request.user.auth_token.delete()
    return Response(status=status.HTTP_200_OK)


class Login(ObtainAuthToken):
    def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(data=request.data, context={'request': request})
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        token, created = Token.objects.get_or_create(user=user)
        return Response({
            'token': token.key,
            'user': user.username,
        })


@api_view(['GET',])
@permission_classes((IsAuthenticated, ))
def account_detail_view(request):
    try:
        account = request.user
    except Account.DoesNotExist:
        return Response(status = status.HTTP_404_NOT_FOUND)
    
    if request.method == 'GET':
        serializer = AccountPropertiesSerializer(account)
        return Response(serializer.data)


@api_view(['PUT',])
@permission_classes((IsAuthenticated, ))
def account_update_view(request):
    try:
        account = request.user
    except Account.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)
    
    if request.method == 'PUT':
        serializer = AccountUpdateSerializer(account, data=request.data)
        data = {}
        if serializer.is_valid():
            serializer.save()
            data['response'] = "account update successful"
            return Response(data=data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['DELETE',])
@permission_classes((IsAuthenticated, ))
def account_delete_view(request):
    try:
        account = request.user
    except Account.DoesNotExist:
        return Response(status = status.HTTP_404_NOT_FOUND)
    
    if request.method == 'DELETE':
        operation = account.delete()
        data = {}
        if operation:
            data["success"] = "delete successful"
        else:
            data["failure"] = "delete unsuccessful"
        
        return Response(data=data)


@api_view(['GET',])
@permission_classes((IsAuthenticated, ))
def alpaca_account_view(request):
    try:
        account = request.user
    except Account.DoesNotExist:
        return Response(status = status.HTTP_404_NOT_FOUND)
    
    if request.method == 'GET':
        serializer = AccountPropertiesSerializer(account)
        base_url = "https://api.alpaca.markets"
        account_url = "{}/v2/account".format(base_url)
        r = requests.get(account_url, headers={'APCA-API-KEY-ID': serializer.data['alpaca_api_key'], 'APCA-API-SECRET-KEY': serializer.data['alpaca_secret_key']})
        data = json.loads(r.content)
        return Response(data=data)
