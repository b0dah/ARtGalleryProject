# Generated by Django 3.0.5 on 2020-05-01 08:56

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Gallery', '0011_auto_20200430_1807'),
    ]

    operations = [
        migrations.AddField(
            model_name='museum',
            name='description',
            field=models.CharField(default='description', max_length=2000),
            preserve_default=False,
        ),
    ]