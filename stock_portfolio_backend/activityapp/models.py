
from django.db import models
from django.conf import settings
from portfolioapp.models import Portfolio
from django.db.models.signals import pre_save
from django.utils.text import slugify


# Create your models here.
class Activity(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='activity')
    portfolioSlug = models.CharField(max_length=50, blank=True)
    portfolio = models.ForeignKey(Portfolio, on_delete=models.CASCADE, related_name='activity', blank=True)
    title = models.CharField(max_length=50)
    qty = models.IntegerField(null=True)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    content = models.CharField(max_length=100)
    activity = models.CharField(max_length= 20)
    date = models.DateTimeField(auto_now=False, auto_now_add=False)
    slug = models.SlugField(blank=True, unique=True)
    username = models.CharField(max_length=30, blank=True)

def pre_save_activity_receiver(sender, instance, *args, **kwargs):
    if not instance.slug:
        instance.slug = slugify(instance.user.username + "-" + instance.date.strftime("%Y%m%d%H%M%S"))
        instance.portfolio = Portfolio.objects.get(slug=instance.portfolioSlug)
        instance.username = instance.user.username

pre_save.connect(pre_save_activity_receiver, sender=Activity)        
