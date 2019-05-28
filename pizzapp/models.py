from django.db import models
from phonenumber_field.modelfields import PhoneNumberField
from django.contrib.gis.db import models as gis_models
from djmoney.models.fields import MoneyField


class Role(models.Model):
    short_name = models.CharField(
        max_length=100,
        unique=True,
        help_text="The person role."
    )
    description = models.TextField(
        null=True,
        help_text="The description role."
    )


class Address(models.Model):
    title = models.CharField(
        null=True,
        max_length=100,
        help_text="The address title."
    )
    address_one = models.CharField(
        max_length=400,
        help_text="The first address line."
    )
    address_two = models.CharField(
        max_length=400,
        null=True,
        help_text="The second address line."
    )
    zip_code = models.CharField(
        max_length=20,
        help_text="The address zip code."
    )
    city = models.CharField(
        max_length=100,
        help_text="The city."
    )
    country = models.CharField(
        null=True,
        max_length=100,
        help_text="The country."
    )
    location = gis_models.PointField(
        help_text="The longitude et latitude point for the point_of_sale.",
        geography=False,
        null=True
    )
    google_place_id = models.TextField(
        unique=True,
        null=True,
        help_text="The place id from google api."
    )
    loc_address = models.TextField(
        null=True,
        help_text="The located address from api google."
    )


class Pizzeria(models.Model):
    name = models.CharField(
        max_length=100,
        help_text="The pizzeria name."
    )
    address = models.ForeignKey(
        Address,
        on_delete=models.CASCADE,
        help_text="The address for this pizzeria."
    )


class Person(models.Model):
    first_name = models.CharField(
        max_length=100,
        null=True,
        help_text="The first name."
    )
    last_name = models.CharField(
        max_length=100,
        null=True,
        help_text="The last name."
    )
    phone_number = PhoneNumberField(
        max_length=50,
        null=True,
        help_text="The phone number."
    )
    email = models.EmailField(
        max_length=50,
        unique=True,
        null=True,
        help_text="The phone number."
    )
    password = models.CharField(
        max_length=100,
        null=True,
        help_text="The user password."
    )


class Customer(models.Model):
    person = models.OneToOneField(
        Person,
        on_delete=models.CASCADE,
        help_text="The person corresponding to this customer."
    )
    registration_date = models.DateTimeField(
        auto_now_add=True,
        help_text="The registration date."
    )
    comment = models.TextField(
        null=True,
        help_text="The eventual comment."
    )


class TypeAddress(models.Model):
    type = models.CharField(
        max_length=100,
        help_text="The type of address."
    )
    address = models.ForeignKey(
        Address,
        on_delete=models.PROTECT,
        help_text="The address for this pizzeria."
    )
    customer = models.ForeignKey(
        Customer,
        on_delete=models.PROTECT,
        help_text="The customer for this type address."
    )


class Employed(models.Model):
    person = models.OneToOneField(
        Person,
        on_delete=models.CASCADE,
        help_text="The person corresponding to this employed."
    )
    roles = models.ManyToManyField(
        Role,
        help_text="The role of this user."
    )
    pizzeria = models.ForeignKey(
        Pizzeria,
        on_delete=models.CASCADE,
        help_text="The pizzeria where working the employed."
    )
    is_active = models.BooleanField(
        default=True,
        help_text="The boolean for activity."
    )
    registration_date = models.DateTimeField(
        auto_now_add=True,
        help_text="The registration date."
    )
    inactivity_date = models.DateTimeField(
        null=True,
        help_text="The date for inactivity declaration."
    )
    comment = models.TextField(
        null=True,
        help_text="The eventual comment."
    )


class Supplier(models.Model):
    company_name = models.CharField(
        max_length=100,
        help_text="The company name."
    )
    phone_number = PhoneNumberField(
        max_length=50,
        null=True,
        help_text="The phone number."
    )
    email = models.EmailField(
        max_length=50,
        null=True,
        help_text="The phone number."
    )
    address = models.ForeignKey(
        Address,
        null=True,
        on_delete=models.CASCADE,
        help_text="The address for this supplier."
    )
    is_active = models.BooleanField(
        default=True,
        help_text="The boolean for activity."
    )
    registration_date = models.DateTimeField(
        auto_now_add=True,
        help_text="The registration date."
    )
    inactivity_date = models.DateTimeField(
        null=True,
        help_text="The date for inactivity declaration."
    )
    comment = models.TextField(
        null=True,
        help_text="The eventual comment."
    )


class Contact(models.Model):
    person = models.OneToOneField(
        Person,
        on_delete=models.CASCADE,
        help_text="The person corresponding to this contact."
    )
    supplier = models.ForeignKey(
        Supplier,
        on_delete=models.CASCADE,
        help_text="The supplier of the contact."
    )
    is_active = models.BooleanField(
        default=True,
        help_text="The boolean for activity."
    )
    registration_date = models.DateTimeField(
        auto_now_add=True,
        help_text="The registration date."
    )
    inactivity_date = models.DateTimeField(
        null=True,
        help_text="The date for inactivity declaration."
    )
    comment = models.TextField(
        null=True,
        help_text="The eventual comment."
    )


class UnitOfMeasure(models.Model):
    short_name = models.CharField(
        max_length=20,
        unique=True,
        help_text="Unique label for a unit of measure."
    )
    description = models.CharField(
        null=True,
        max_length=100,
        help_text="Description for the unit of measure."
    )


class Component(models.Model):
    name = models.CharField(
        max_length=100,
        help_text="The component name."
    )
    unit_of_measure = models.ForeignKey(
        UnitOfMeasure,
        on_delete=models.PROTECT,
        help_text="The unit of measure."
    )
    stock = models.DecimalField(
        max_digits=8,
        decimal_places=3,
        default=0,
        help_text="The stock of the component."
    )
    in_command = models.DecimalField(
        max_digits=8,
        decimal_places=3,
        default=0,
        help_text="The quantity in command for the component."
    )
    is_active = models.BooleanField(
        default=True,
        help_text="The boolean for activity."
    )
    registration_date = models.DateTimeField(
        auto_now_add=True,
        help_text="The registration date."
    )
    inactivity_date = models.DateTimeField(
        null=True,
        help_text="The date for inactivity declaration."
    )
    comment = models.TextField(
        null=True,
        help_text="The eventual comment."
    )


class ComponentPrice(models.Model):
    component = models.ForeignKey(
        Component,
        on_delete=models.CASCADE,
        help_text="The component."
    )
    cost_price = MoneyField(
        max_digits=7,
        decimal_places=2,
        default_currency='EUR',
        help_text="Price of the component."
    )
    supplier = models.ForeignKey(
        Supplier,
        on_delete=models.CASCADE,
        help_text="The supplier."
    )
    is_active = models.BooleanField(
        default=True,
        help_text="The boolean for activity."
    )
    registration_date = models.DateTimeField(
        auto_now_add=True,
        help_text="The registration date."
    )
    inactivity_date = models.DateTimeField(
        null=True,
        help_text="The date for inactivity declaration."
    )
    comment = models.TextField(
        null=True,
        help_text="The eventual comment."
    )


class Pizza(models.Model):
    name = models.CharField(
        max_length=100,
        unique=True,
        help_text="The pizza name."
    )
    price = MoneyField(
        max_digits=7,
        decimal_places=2,
        default_currency='EUR',
        help_text="Price of the pizza."
    )
    is_active = models.BooleanField(
        default=True,
        help_text="The boolean for activity."
    )
    registration_date = models.DateTimeField(
        auto_now_add=True,
        help_text="The registration date."
    )
    inactivity_date = models.DateTimeField(
        null=True,
        help_text="The date for inactivity declaration."
    )
    comment = models.TextField(
        null=True,
        help_text="The eventual comment."
    )


class PizzaLine(models.Model):
    pizza = models.ForeignKey(
        Pizza,
        on_delete=models.CASCADE,
        help_text="The pizza."
    )
    component = models.ForeignKey(
        Component,
        on_delete=models.PROTECT,
        help_text="The supplier."
    )
    unit_of_measure = models.ForeignKey(
        UnitOfMeasure,
        on_delete=models.PROTECT,
        help_text="The unit of measure."
    )
    quantity = models.DecimalField(
        max_digits=8,
        decimal_places=3,
        help_text="The quantity of the component."
    )
    is_active = models.BooleanField(
        default=True,
        help_text="The boolean for activity."
    )
    registration_date = models.DateTimeField(
        auto_now_add=True,
        help_text="The registration date."
    )
    inactivity_date = models.DateTimeField(
        null=True,
        help_text="The date for inactivity declaration."
    )
    comment = models.TextField(
        null=True,
        help_text="The eventual comment."
    )


class PizzaCard(models.Model):
    name = models.CharField(
        max_length=100,
        help_text="The pizza card name."
    )
    pizzas = models.ManyToManyField(
        Pizza,
        help_text="The list of pizzas for the pizza card."
    )
    pizzeria = models.ForeignKey(
        Pizzeria,
        on_delete=models.CASCADE,
        help_text="The pizzeria concerned by the pizza card."
    )
    employed = models.ForeignKey(
        Employed,
        on_delete=models.PROTECT,
        help_text="The employed registrering the pizza card."
    )
    is_active = models.BooleanField(
        default=True,
        help_text="The boolean for activity."
    )
    registration_date = models.DateTimeField(
        auto_now_add=True,
        help_text="The registration date."
    )
    inactivity_date = models.DateTimeField(
        null=True,
        help_text="The date for inactivity declaration."
    )
    comment = models.TextField(
        null=True,
        help_text="The eventual comment."
    )


class Status(models.Model):
    short_name = models.CharField(
        max_length=20,
        unique=True,
        help_text="Unique label for a order status."
    )
    description = models.CharField(
        null=True,
        max_length=100,
        help_text="Description for the order status."
    )


class Order(models.Model):
    status = models.ForeignKey(
        Status,
        on_delete=models.PROTECT,
        help_text="The status."
    )
    customer = models.ForeignKey(
        Customer,
        on_delete=models.CASCADE,
        help_text="The customer."
    )
    employed = models.ForeignKey(
        Employed,
        null=True,
        on_delete=models.PROTECT,
        help_text="The employed whose valid the command."
    )
    pizzeria = models.ForeignKey(
        Pizzeria,
        on_delete=models.CASCADE,
        help_text="The pizzeria."
    )
    delay = models.DateTimeField(
        help_text="The date for order delivery."
    )
    is_active = models.BooleanField(
        default=True,
        help_text="The boolean for activity."
    )
    registration_date = models.DateTimeField(
        auto_now_add=True,
        help_text="The registration date."
    )
    inactivity_date = models.DateTimeField(
        null=True,
        help_text="The date for inactivity declaration."
    )
    comment = models.TextField(
        null=True,
        help_text="The eventual comment."
    )


class OrderLine(models.Model):
    order = models.ForeignKey(
        Order,
        on_delete=models.CASCADE,
        help_text="The order."
    )
    pizza = models.ForeignKey(
        Pizza,
        on_delete=models.PROTECT,
        help_text="The pizza."
    )
    quantity = models.IntegerField(
        default=1,
        help_text="The quantity of the pizza."
    )
    is_active = models.BooleanField(
        default=True,
        help_text="The boolean for activity."
    )
    registration_date = models.DateTimeField(
        auto_now_add=True,
        help_text="The registration date."
    )
    inactivity_date = models.DateTimeField(
        null=True,
        help_text="The date for inactivity declaration."
    )
    comment = models.TextField(
        null=True,
        help_text="The eventual comment."
    )


class Command(models.Model):
    supplier = models.ForeignKey(
        Supplier,
        on_delete=models.CASCADE,
        help_text="The supplier."
    )
    employed = models.ForeignKey(
        Employed,
        on_delete=models.PROTECT,
        help_text="The employed whose valid the command."
    )
    delay = models.DateTimeField(
        help_text="The date for command delivery. This information can be set generally in command or individually in "
                  "command line"
    )
    is_active = models.BooleanField(
        default=True,
        help_text="The boolean for activity."
    )
    registration_date = models.DateTimeField(
        auto_now_add=True,
        help_text="The registration date."
    )
    inactivity_date = models.DateTimeField(
        null=True,
        help_text="The date for inactivity declaration."
    )
    comment = models.TextField(
        null=True,
        help_text="The eventual comment."
    )


class CommandLine(models.Model):
    command = models.ForeignKey(
        Command,
        on_delete=models.CASCADE,
        help_text="The command."
    )
    component = models.ForeignKey(
        Component,
        on_delete=models.CASCADE,
        help_text="The supplier."
    )
    unit_of_measure = models.ForeignKey(
        UnitOfMeasure,
        on_delete=models.PROTECT,
        help_text="The unit of measure."
    )
    quantity = models.DecimalField(
        max_digits=8,
        decimal_places=3,
        null=True,
        help_text="The quantity of the component."
    )
    delay = models.DateTimeField(
        help_text="The date for command delivery. This information can be set generally in command or individually in "
                  "command line"
    )
    is_active = models.BooleanField(
        default=True,
        help_text="The boolean for activity."
    )
    registration_date = models.DateTimeField(
        auto_now_add=True,
        help_text="The registration date."
    )
    inactivity_date = models.DateTimeField(
        null=True,
        help_text="The date for inactivity declaration."
    )
    comment = models.TextField(
        null=True,
        help_text="The eventual comment."
    )


class StockMovement(models.Model):
    component = models.ForeignKey(
        Component,
        on_delete=models.CASCADE,
        help_text="The component."
    )
    order_line = models.ForeignKey(
        OrderLine,
        on_delete=models.CASCADE,
        null=True,
        help_text="The order line responsive of the movement."
    )
    command_line = models.ForeignKey(
        CommandLine,
        on_delete=models.CASCADE,
        null=True,
        help_text="The supplier command line responsive of the movement."
    )
    unit_of_measure = models.ForeignKey(
        UnitOfMeasure,
        on_delete=models.PROTECT,
        help_text="The unit of measure."
    )
    quantity = models.DecimalField(
        max_digits=8,
        decimal_places=3,
        default=0,
        help_text="The quantity of the component."
    )
    stock_before = models.DecimalField(
        max_digits=8,
        decimal_places=3,
        default=0,
        help_text="The stock of the component before the movement."
    )
    stock_after = models.DecimalField(
        max_digits=8,
        decimal_places=3,
        default=0,
        help_text="The quantity of the component after the movement."
    )
    is_active = models.BooleanField(
        default=True,
        help_text="The boolean for activity."
    )
    registration_date = models.DateTimeField(
        auto_now_add=True,
        help_text="The registration date."
    )
    inactivity_date = models.DateTimeField(
        null=True,
        help_text="The date for inactivity declaration."
    )
    comment = models.TextField(
        null=True,
        help_text="The eventual comment."
    )


class PaymentMethod(models.Model):
    short_name = models.CharField(
        max_length=20,
        unique=True,
        help_text="Unique label for a payment method."
    )
    description = models.CharField(
        null=True,
        max_length=100,
        help_text="Description for the payment method."
    )


class Payment(models.Model):
    payment_method = models.ForeignKey(
        PaymentMethod,
        on_delete=models.PROTECT,
        help_text="The payment method."
    )
    order = models.ForeignKey(
        Order,
        on_delete=models.CASCADE,
        help_text="The order."
    )
    montant = MoneyField(
        max_digits=7,
        decimal_places=2,
        default_currency='EUR',
        help_text="The montant of payment."
    )
    is_active = models.BooleanField(
        default=True,
        help_text="The boolean for activity."
    )
    registration_date = models.DateTimeField(
        auto_now_add=True,
        help_text="The registration date."
    )
    inactivity_date = models.DateTimeField(
        null=True,
        help_text="The date for inactivity declaration."
    )
    comment = models.TextField(
        null=True,
        help_text="The eventual comment."
    )


