# Generated by Django 2.1.2 on 2019-05-21 16:03

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('pizzapp', '0002_auto_20190521_1438'),
    ]

    operations = [
        migrations.RenameField(
            model_name='supplier',
            old_name='type_address',
            new_name='address',
        ),
        migrations.AlterField(
            model_name='command',
            name='inactivity_date',
            field=models.DateTimeField(help_text='The date for inactivity declaration.', null=True),
        ),
        migrations.AlterField(
            model_name='commandline',
            name='inactivity_date',
            field=models.DateTimeField(help_text='The date for inactivity declaration.', null=True),
        ),
        migrations.AlterField(
            model_name='component',
            name='inactivity_date',
            field=models.DateTimeField(help_text='The date for inactivity declaration.', null=True),
        ),
        migrations.AlterField(
            model_name='componentprice',
            name='inactivity_date',
            field=models.DateTimeField(help_text='The date for inactivity declaration.', null=True),
        ),
        migrations.AlterField(
            model_name='contact',
            name='inactivity_date',
            field=models.DateTimeField(help_text='The date for inactivity declaration.', null=True),
        ),
        migrations.AlterField(
            model_name='employed',
            name='inactivity_date',
            field=models.DateTimeField(help_text='The date for inactivity declaration.', null=True),
        ),
        migrations.AlterField(
            model_name='order',
            name='inactivity_date',
            field=models.DateTimeField(help_text='The date for inactivity declaration.', null=True),
        ),
        migrations.AlterField(
            model_name='orderline',
            name='inactivity_date',
            field=models.DateTimeField(help_text='The date for inactivity declaration.', null=True),
        ),
        migrations.AlterField(
            model_name='payment',
            name='inactivity_date',
            field=models.DateTimeField(help_text='The date for inactivity declaration.', null=True),
        ),
        migrations.AlterField(
            model_name='pizza',
            name='inactivity_date',
            field=models.DateTimeField(help_text='The date for inactivity declaration.', null=True),
        ),
        migrations.AlterField(
            model_name='pizzacard',
            name='inactivity_date',
            field=models.DateTimeField(help_text='The date for inactivity declaration.', null=True),
        ),
        migrations.AlterField(
            model_name='pizzaline',
            name='inactivity_date',
            field=models.DateTimeField(help_text='The date for inactivity declaration.', null=True),
        ),
        migrations.AlterField(
            model_name='stockmovement',
            name='inactivity_date',
            field=models.DateTimeField(help_text='The date for inactivity declaration.', null=True),
        ),
        migrations.AlterField(
            model_name='supplier',
            name='company_name',
            field=models.CharField(help_text='The company name.', max_length=100),
        ),
        migrations.AlterField(
            model_name='supplier',
            name='inactivity_date',
            field=models.DateTimeField(help_text='The date for inactivity declaration.', null=True),
        ),
    ]
