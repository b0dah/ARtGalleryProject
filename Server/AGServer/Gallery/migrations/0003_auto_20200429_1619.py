# Generated by Django 3.0.5 on 2020-04-29 16:19

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('Gallery', '0002_museum'),
    ]

    operations = [
        migrations.AddField(
            model_name='artist',
            name='portraitImageTitle',
            field=models.CharField(default='portrait.jpg', max_length=300),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='artist',
            name='yearsOfLife',
            field=models.CharField(default='ADD SMT', max_length=20),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='painting',
            name='author_id',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='Gallery.Artist'),
        ),
        migrations.AddField(
            model_name='painting',
            name='description',
            field=models.CharField(default='ADD SMT', max_length=1000),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='painting',
            name='genre',
            field=models.CharField(default='ADD SMT', max_length=50),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='painting',
            name='imageTitle',
            field=models.CharField(default='00000000', max_length=300),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='painting',
            name='museum_id',
            field=models.ForeignKey(default='0000', on_delete=django.db.models.deletion.CASCADE, to='Gallery.Museum'),
            preserve_default=False,
        ),
    ]