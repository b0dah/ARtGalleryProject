# Generated by Django 3.0.5 on 2020-04-29 18:13

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('Gallery', '0003_auto_20200429_1619'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='painting',
            name='museum_id',
        ),
    ]
