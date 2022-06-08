from tkinter import CASCADE
from django.db import models
from portfolioapp.models import Portfolio
from django.utils.text import slugify
from django.db.models.signals import pre_save
from django.conf import settings
from accountapp.models import Account
# Create your models here.

class Ticker(models.Model):
    qty = models.IntegerField()
    averagePrice = models.DecimalField(decimal_places=2, max_digits=10)
    portfolioSlug = models.CharField(max_length=50, blank=True)
    ticker = models.CharField(max_length=4, blank=True)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='ticker', blank=True)
    portfolio = models.ForeignKey(Portfolio, on_delete=models.CASCADE, related_name='ticker', blank=True)
    slug = models.SlugField(blank=True, unique=True)
    username = models.CharField(max_length=30)
    currentPrice = models.DecimalField(decimal_places=2, max_digits=10, blank=True, null=True)
    
    def __str__(self):
        return self.slug

    def set_current_price(self, price):
        self.currentPrice = price

def pre_save_ticker_receiver(sender, instance, *args, **kwargs):
    if not instance.slug:
        instance.user = Account.objects.get(username=instance.username)
        instance.portfolio = Portfolio.objects.get(slug=instance.portfolioSlug)
        instance.slug = slugify(instance.ticker + "-" + instance.portfolio.slug)

pre_save.connect(pre_save_ticker_receiver, sender=Ticker)