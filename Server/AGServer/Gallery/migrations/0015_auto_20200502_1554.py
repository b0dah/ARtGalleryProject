# Generated by Django 3.0.5 on 2020-05-02 15:54

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('Gallery', '0014_auto_20200502_1553'),
    ]

    operations = [
        migrations.RenameField(
            model_name='artist',
            old_name='portraitImagePath',
            new_name='portraitImageTitle',
        ),
        migrations.RenameField(
            model_name='museum',
            old_name='appearenceImagePath',
            new_name='appearenceImageTitle',
        ),
        migrations.RenameField(
            model_name='museum',
            old_name='logoImagePath',
            new_name='logoImageTitle',
        ),
    ]