# Generated by Django 4.0.4 on 2022-09-07 19:11

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('medical', '0002_medicalhistory_appointment'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='appointment',
            name='acceptance',
        ),
        migrations.AddField(
            model_name='appointment',
            name='status',
            field=models.CharField(choices=[('IN PROGRESS', 'In progress'), ('REJECTED', 'Rejected'), ('ACCEPTED', 'Accepted')], default=1, max_length=30),
        ),
    ]
