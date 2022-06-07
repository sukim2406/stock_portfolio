from re import U
from django.db import models
from django.conf import settings
from django.db.models.signals import pre_save
from django.utils.text import slugify

# Create your models here.
class Portfolio(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    username = models.CharField(max_length=30, blank=True)
    title = models.CharField(max_length=50, unique=True)
    cash = models.DecimalField(decimal_places=2, max_digits=10)
    slug = models.SlugField(blank=True, unique=True)

def pre_save_portfolio_receiver(sender, instance, *args, **kwargs):
    if not instance.slug:
        instance.slug = slugify(instance.user.username +"-"+ instance.title)
        instance.username = instance.user.username

pre_save.connect(pre_save_portfolio_receiver, sender=Portfolio)
