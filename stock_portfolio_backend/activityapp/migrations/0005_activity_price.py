# Generated by Django 4.0.5 on 2022-06-16 11:35

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('activityapp', '0004_activity_username'),
    ]

    operations = [
        migrations.AddField(
            model_name='activity',
            name='price',
            field=models.DecimalField(decimal_places=2, default=100, max_digits=10),
            preserve_default=False,
        ),
    ]