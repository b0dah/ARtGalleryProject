# Generated by Django 3.0.5 on 2020-04-30 18:07

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Gallery', '0010_auto_20200430_1621'),
    ]

    operations = [
        migrations.AddField(
            model_name='painting',
            name='physicalHeight',
            field=models.FloatField(default=0.0),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='painting',
            name='physicalWidth',
            field=models.FloatField(default=0.0),
            preserve_default=False,
        ),
    ]
