INSERT INTO pizzapp_role (id, short_name, description) VALUES
(1, 'supervisor', 'supervisor role'),
(2, 'administrator', 'administrator role'),
(3, 'operator', 'operator role'),
(4, 'pizzaiolo', 'pizzaiolo role'),
(5, 'deliver', 'deliver role');

INSERT INTO pizzapp_address (id, address_one, zip_code, city, location, google_place_id, loc_address) VALUES
(1, '11 boulevard de verdun', '01300', 'belley', ST_MakePoint(45.760918, 5.686596), 'ChIJ7X66Dy0Ti0cROeAG4sHlcbw', '11 boulevard de verdun 01300 belley'),
(2, '12 boulevard de verdun', '01300', 'belley', ST_MakePoint(45.7606954, 5.6869109), 'EiwxMiBCb3VsZXZhcmQgZGUgVmVyZHVuLCAwMTMwMCBCZWxsZXksIEZyYW5jZSIaEhgKFAoSCc3IsAQtE4tHEZAdWNIMa_EoEAw', '12 boulevard de verdun 01300 belley'),
(3, '13 boulevard de verdun', '01300', 'belley', ST_MakePoint(45.7611091, 5.6866318), 'ChIJtZf2EC0Ti0cRFrnjBc2uQcE', '13 boulevard de verdun 01300 belley'),
(4, '14 boulevard de verdun', '01300', 'belley', ST_MakePoint(45.760647, 5.6869401), 'ChIJKQc7Ai0Ti0cRt1-pmsWAOW0', '14 boulevard de verdun 01300 belley'),
(5, '15 boulevard de verdun', '01300', 'belley', ST_MakePoint(45.7609308, 5.6869321), 'ChIJv6HXHC0Ti0cRdZ2U1B6wShw', '15 boulevard de verdun 01300 belley');

INSERT INTO pizzapp_pizzeria (id, name, address_id) VALUES
(1, 'pizzeria peone', 1),
(2, 'pizzeria napoleon', 4);

INSERT INTO pizzapp_person (id, first_name, last_name, phone_number, email, password) VALUES
(1, 'alfred', 'hitch', '+33 6 52 99 33 66', 'alfred.hitch@gmail.com', 'pbkdf2_sha256$150000$uNbsggi8waUw$YE8GY74/du2qRVSbQT+TaFdmSkYzno/b1VEukUbftAo='),
(2, 'camille', 'deter', '', 'camille.deter@gmail.com', 'pbkdf2_sha256$150000$uNbsggi8waUw$YE8GY74/du2qRVSbQT+TaFdmSkYzno/b1VEukUbftAo='),
(3, 'claudio', 'cappell', '+33 6 52 99 33 62', 'claudio.capel@gmail.com', 'pbkdf2_sha256$150000$uNbsggi8waUw$YE8GY74/du2qRVSbQT+TaFdmSkYzno/b1VEukUbftAo='),
(4, 'tartine', 'hubbert', '+33 6 52 99 33 64', 'tartine.hubert@gmail.com', 'pbkdf2_sha256$150000$uNbsggi8waUw$YE8GY74/du2qRVSbQT+TaFdmSkYzno/b1VEukUbftAo='),
(5, 'madeleine', 'bizz', '', 'madeleine.bizz@gmail.com', 'pbkdf2_sha256$150000$uNbsggi8waUw$YE8GY74/du2qRVSbQT+TaFdmSkYzno/b1VEukUbftAo=');

INSERT INTO pizzapp_customer (id, person_id, comment) VALUES
(1, 1, ''),
(2, 3, '');

INSERT INTO pizzapp_typeaddress (id, type, address_id, customer_id) VALUES
(1, 'house', 2, 1),
(2, 'delivery', 3, 2);

INSERT INTO pizzapp_employed (id, person_id, pizzeria_id) VALUES
(1, 2, 1),
(2, 4, 2);

INSERT INTO pizzapp_employed_roles (employed_id, role_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5);


INSERT INTO pizzapp_supplier (id, company_name, phone_number, email, address_id) VALUES
(1, 'metra', '+33 4 50 42 25 24', 'metra-belley@gmail.com', 5);

INSERT INTO pizzapp_contact (id, person_id, supplier_id) VALUES
(1, 5, 1);

INSERT INTO pizzapp_unitofmeasure (id, short_name, description) VALUES
(1, 'liter', ' by liter'),
(2, 'kg', 'by weight'),
(3, 'unit', 'by piece');

INSERT INTO pizzapp_component (id, name, unit_of_measure_id, stock, in_command, reserved) VALUES
(1, 'cheese', 2, 9.73, 0, 0.18),
(2, 'tomatoes sauce', 1, 2.85, 2, 0.15),
(3, 'ham', 2, 5.80, 0, 0.10),
(4, 'box', 3, 97, 50, 3),
(5, 'dough', 3, 77, 20, 3);

INSERT INTO pizzapp_componentprice (id, component_id, cost_price, supplier_id) VALUES
(1, 1, 2.5, 1),
(2, 2, 5.2, 1),
(3, 3, 3.5, 1),
(4, 4, 0.25, 1),
(5, 5, 0.75, 1);

INSERT INTO pizzapp_pizza (id, name, price) VALUES
(1, 'marguaret', 8.20),
(2, 'ham', 9.00),
(3, 'ham-chees', 9.50);

INSERT INTO pizzapp_pizzaline (pizza_id, component_id, unit_of_measure_id, quantity) VALUES
(1, 5, 3, 1),
(1, 2, 1, 0.05),
(1, 1, 2, 0.06),
(1, 4, 3, 1),
(2, 5, 3, 1),
(2, 2, 1, 0.05),
(2, 1, 2, 0.06),
(2, 3, 2, 0.10),
(2, 4, 3, 1),
(3, 5, 3, 1),
(3, 2, 1, 0.05),
(3, 3, 2, 0.10),
(3, 1, 2, 0.15),
(3, 4, 3, 1);

INSERT INTO pizzapp_pizzacard (id, name, pizzeria_id, employed_id) VALUES
(1, 'summer card', 1, 1),
(2, 'year card', 2, 2);

INSERT INTO pizzapp_pizzacard_pizzas (pizzacard_id, pizza_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 2),
(2, 3);

INSERT INTO pizzapp_status (id, short_name, description) VALUES
(1, 'not_started', 'not started'),
(2, 'in_progress', 'in progress'),
(3, 'in_stand', 'in stand of delivery'),
(4, 'deliver', 'deliver'),
(5, 'canceled', 'canceled');

INSERT INTO pizzapp_order (id, status_id, customer_id, employed_id, pizzeria_id, delay) VALUES
(1, 1, 1, 1, 1, '2019-05-31 12:00:00.000000+00'),
(2, 2, 2, 1, 1, '2019-05-31 12:00:00.000000+00'),
(3, 5, 1, 1, 1, '2019-05-31 12:00:00.000000+00'),
(4, 4, 2, 2, 2, '2019-05-31 12:00:00.000000+00');

INSERT INTO pizzapp_orderline (id, order_id, pizza_id) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 3, 2),
(5, 4, 1),
(6, 4, 2),
(7, 4, 3);

INSERT INTO pizzapp_paymentmethod (id, short_name, description) VALUES
(1, 'cb', 'bank card'),
(2, 'cash', 'cash'),
(3, 'check', 'bank check');

INSERT INTO pizzapp_payment (payment_method_id, order_id, montant) VALUES
(1, 1, 17.20),
(2, 2, 8.20),
(3, 4, 26.70);

INSERT INTO pizzapp_command (id, supplier_id, employed_id) VALUES
(1, 1, 1),
(2, 1, 1),
(3, 1, 2);

INSERT INTO pizzapp_commandline (id, command_id, component_id, unit_of_measure_id, quantity, delay) VALUES
(1, 1, 1, 2, 10, '2019-05-28 12:00:00.000000+00'),
(2, 1, 2, 1, 3, '2019-05-28 12:00:00.000000+00'),
(3, 1, 3, 2, 6, '2019-05-28 12:00:00.000000+00'),
(4, 1, 4, 3, 100, '2019-05-28 12:00:00.000000+00'),
(5, 1, 5, 3, 80, '2019-05-28 12:00:00.000000+00'),
(6, 2, 2, 1, 2, '2019-06-02 12:00:00.000000+00'),
(7, 2, 4, 3, 50, '2019-06-02 12:00:00.000000+00'),
(8, 3, 5, 3, 20, '2019-06-03 12:00:00.000000+00');

INSERT INTO pizzapp_stockmovement (component_id, order_line_id, command_line_id, unit_of_measure_id, quantity, stock_before, stock_after) VALUES
(1, Null, 1, 2, 10, 0, 10),
(2, Null, 2, 1, 3, 0, 3),
(3, Null, 3, 2, 6, 0, 6),
(4, Null, 4, 3, 100, 0, 100),
(5, Null, 5, 3, 80, 0, 80),
(5, 5, Null, 3, 1, 80, 79),
(2, 5, Null, 1, 0.05, 3, 2.95),
(1, 5, Null, 2, 0.06, 10, 9.94),
(4, 5, Null, 3, 1, 100, 99),
(5, 6, Null, 3, 1, 79, 78),
(2, 6, Null, 1, 0.05, 2.95, 2.90),
(1, 6, Null, 2, 0.06, 9.94, 9.88),
(3, 6, Null, 2, 0.10, 6, 5.9),
(4, 6, Null, 3, 1, 99, 98),
(5, 7, Null, 3, 1, 78, 77),
(2, 7, Null, 1, 0.05, 2.90, 2.85),
(1, 7, Null, 2, 0.15, 9.88, 9.73),
(3, 7, Null, 2, 0.10, 5.9, 5.8),
(4, 7, Null, 3, 1, 98, 97);

