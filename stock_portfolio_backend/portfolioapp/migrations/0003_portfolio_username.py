# Generated by Django 4.0.5 on 2022-06-07 11:59

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('portfolioapp', '0002_portfolio_cash'),
    ]

    operations = [
        migrations.AddField(
            model_name='portfolio',
            name='username',
            field=models.CharField(blank=True, max_length=30),
        ),
    ]