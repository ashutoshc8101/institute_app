# Generated by Django 4.1 on 2022-09-18 20:24

from django.conf import settings
from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('feed', '0001_initial'),
    ]

    operations = [
        migrations.RenameModel(
            old_name='Feed',
            new_name='Post',
        ),
    ]
