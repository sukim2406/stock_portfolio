from django.contrib import admin

# Register your models here.
from tickerapp.models import Ticker

admin.site.register(Ticker)