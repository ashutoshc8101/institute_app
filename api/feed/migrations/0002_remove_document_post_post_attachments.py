# Generated by Django 4.0.4 on 2022-10-05 11:37

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('feed', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='document',
            name='post',
        ),
        migrations.AddField(
            model_name='post',
            name='attachments',
            field=models.ManyToManyField(to='feed.document'),
        ),
    ]
