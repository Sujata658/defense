# Generated by Django 4.1.7 on 2023-03-08 05:20

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0003_route_stops'),
    ]

    operations = [
        migrations.AddField(
            model_name='fare',
            name='vehicle',
            field=models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, to='api.vehicle'),
            preserve_default=False,
        ),
    ]