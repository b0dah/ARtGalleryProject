# Generated by Django 3.0.5 on 2020-05-02 16:35

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('Gallery', '0016_auto_20200502_1617'),
    ]

    operations = [
        migrations.RenameField(
            model_name='painting',
            old_name='museum_id',
            new_name='museumId',
        ),
    ]
