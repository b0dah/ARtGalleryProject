# Generated by Django 3.0.5 on 2020-05-02 15:53

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('Gallery', '0013_auto_20200501_1743'),
    ]

    operations = [
        migrations.RenameField(
            model_name='painting',
            old_name='imagePath',
            new_name='imageTitle',
        ),
    ]
