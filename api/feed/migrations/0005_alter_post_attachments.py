# Generated by Django 4.0.4 on 2022-10-05 11:50

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('feed', '0004_alter_post_attachments'),
    ]

    operations = [
        migrations.AlterField(
            model_name='post',
            name='attachments',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='feed.document'),
        ),
    ]
