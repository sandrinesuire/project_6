# Generated by Django 2.1.2 on 2019-05-21 18:16

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('pizzapp', '0003_auto_20190521_1603'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='stockmovement',
            name='datetime',
        ),
        migrations.AlterField(
            model_name='commandline',
            name='command',
            field=models.ForeignKey(help_text='The command.', on_delete=django.db.models.deletion.CASCADE, to='pizzapp.Command'),
        ),
        migrations.AlterField(
            model_name='stockmovement',
            name='quantity',
            field=models.DecimalField(decimal_places=3, default=0, help_text='The quantity of the component.', max_digits=8),
        ),
        migrations.AlterField(
            model_name='stockmovement',
            name='stock_after',
            field=models.DecimalField(decimal_places=3, default=0, help_text='The quantity of the component after the movement.', max_digits=8),
        ),
        migrations.AlterField(
            model_name='stockmovement',
            name='stock_before',
            field=models.DecimalField(decimal_places=3, default=0, help_text='The stock of the component before the movement.', max_digits=8),
        ),
    ]