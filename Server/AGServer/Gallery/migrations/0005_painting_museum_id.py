# Generated by Django 3.0.5 on 2020-04-29 18:25

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('Gallery', '0004_remove_painting_museum_id'),
    ]

    operations = [
        migrations.AddField(
            model_name='painting',
            name='museum_id',
            field=models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, to='Gallery.Museum'),
            preserve_default=False,
        ),
    ]
