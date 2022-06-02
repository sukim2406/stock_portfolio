from rest_framework import serializers
from accountapp.models import Account

class RegistrationSerializer(serializers.ModelSerializer):
    password2 = serializers.CharField(style={'input_type': 'password'}, write_only=True)

    class Meta:
        model = Account
        fields = ['email', 'username', 'password', 'password2', 'alpaca_api_key', 'alpaca_secret_key']
        extra_kwargs = {
            'password': {'write_only':True}
        }
    
    def save(self):
        account = Account(
            email = self.validated_data['email'],
            username = self.validated_data['username'],
            alpaca_api_key = self.validated_data['alpaca_api_key'],
            alpaca_secret_key = self.validated_data['alpaca_secret_key'],
        )
        password = self.validated_data['password']
        password2 = self.validated_data['password2']

        if password != password2:
            raise serializers.ValidationError({'password': 'Passwords must match'})
        
        account.set_password(password)
        account.save()
        
        return account


class AccountPropertiesSerializer(serializers.ModelSerializer):
    class Meta:
        model = Account
        fields = ['pk', 'email', 'username', 'alpaca_api_key', 'alpaca_secret_key']
        

class AccountUpdateSerializer(serializers.ModelSerializer):
    password2 = serializers.CharField(style={'input_type': 'password'}, write_only=True)

    class Meta:
        model =Account
        fields = ['pk', 'email', 'username', 'password', 'password2', 'alpaca_api_key', 'alpaca_secret_key']
    
    def save(self):
        account = Account.objects.get(username=self.validated_data['username'])
        password = self.validated_data['password']
        password2 = self.validated_data['password2']
        alpaca_api_key = self.validated_data['alpaca_api_key']
        alpaca_secret_key = self.validated_data['alpaca_secret_key']

        if password != password2:
            raise serializers.ValidationError({'password': 'Passwords must match'})
        
        account.set_password(password)
        account.save()