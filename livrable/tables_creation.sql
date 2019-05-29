DROP TABLE IF EXISTS pizzapp_address CASCADE;
DROP EXTENSION IF EXISTS postgis;
DROP TABLE IF EXISTS spatial_ref_sys CASCADE;


DO $$DECLARE r record;
BEGIN

    FOR r IN SELECT schemaname, tablename
          FROM pg_tables WHERE NOT schemaname IN ('pg_catalog', 'information_schema')
    LOOP
        EXECUTE 'DROP TABLE ' || quote_ident(r.schemaname) || '.' || quote_ident(r.tablename) || ' CASCADE;';
    END LOOP;

	FOR r IN SELECT sequence_schema, sequence_name
          FROM information_schema.sequences WHERE NOT sequence_schema IN ('pg_catalog', 'information_schema')
    LOOP
        EXECUTE 'DROP SEQUENCE '|| quote_ident(r.sequence_schema) || '.' || quote_ident(r.sequence_name) ||' ';
    END LOOP;
END$$;

CREATE EXTENSION postgis;

CREATE TABLE "public"."pizzapp_address"  (
	"id"             	serial NOT NULL,
	"address_one"    	varchar(400) NOT NULL,
	"address_two"    	varchar(400) NULL,
	"zip_code"       	varchar(20) NOT NULL,
	"city"           	varchar(100) NOT NULL,
	"country"        	varchar(100) NULL,
	"location"       	"public"."geometry" NULL,
	"google_place_id"	text NULL,
	"loc_address"    	text NULL,
	PRIMARY KEY("id")
);
ALTER TABLE "public"."pizzapp_address" OWNER TO "sandrine";


CREATE TABLE "public"."pizzapp_command"  (
	"id"               	serial NOT NULL,
	"delay"            	timestamp with time zone NULL,
	"is_active"        	boolean NOT NULL DEFAULT TRUE,
	"registration_date"	timestamp with time zone NOT NULL DEFAULT NOW(),
	"inactivity_date"  	timestamp with time zone NULL,
	"comment"          	text NULL,
	"employed_id"      	integer NULL,
	"supplier_id"      	integer NULL,
	PRIMARY KEY("id")
);
ALTER TABLE "public"."pizzapp_command" OWNER TO "sandrine";


CREATE TABLE "public"."pizzapp_commandline"  (
	"id"                	serial NOT NULL,
	"quantity"          	numeric(8,3) NULL,
	"delay"             	timestamp with time zone NOT NULL,
	"is_active"         	boolean NOT NULL DEFAULT TRUE,
	"registration_date" 	timestamp with time zone NOT NULL DEFAULT NOW(),
	"inactivity_date"   	timestamp with time zone NULL,
	"comment"           	text NULL,
	"command_id"        	integer NOT NULL,
	"component_id"      	integer NOT NULL,
	"unit_of_measure_id"	integer NOT NULL,
	PRIMARY KEY("id")
);
ALTER TABLE "public"."pizzapp_commandline" OWNER TO "sandrine";


CREATE TABLE "public"."pizzapp_component"  (
	"id"                	serial NOT NULL,
	"name"              	varchar(100) NOT NULL,
	"stock"             	numeric(8,3) NOT NULL DEFAULT 0,
	"in_command"        	numeric(8,3) NOT NULL DEFAULT 0,
	"reserved"        	    numeric(8,3) NOT NULL DEFAULT 0,
	"is_active"         	boolean NOT NULL DEFAULT TRUE,
	"registration_date" 	timestamp with time zone NOT NULL DEFAULT NOW(),
	"inactivity_date"   	timestamp with time zone NULL,
	"comment"           	text NULL,
	"unit_of_measure_id"	integer NOT NULL,
	PRIMARY KEY("id")
);
ALTER TABLE "public"."pizzapp_component" OWNER TO "sandrine";


CREATE TABLE "public"."pizzapp_componentprice"  (
	"id"                 	serial NOT NULL,
	"cost_price_currency"	varchar(3) NOT NULL DEFAULT 'EUR',
	"cost_price"         	numeric(7,2) NOT NULL,
	"is_active"          	boolean NOT NULL DEFAULT TRUE,
	"registration_date"  	timestamp with time zone NOT NULL DEFAULT NOW(),
	"inactivity_date"    	timestamp with time zone NULL,
	"comment"            	text NULL,
	"component_id"       	integer NOT NULL,
	"supplier_id"        	integer NOT NULL,
	PRIMARY KEY("id")
);
ALTER TABLE "public"."pizzapp_componentprice" OWNER TO "sandrine";


CREATE TABLE "public"."pizzapp_contact"  (
	"id"               	serial NOT NULL,
	"is_active"        	boolean NOT NULL DEFAULT TRUE,
	"registration_date"	timestamp with time zone NOT NULL DEFAULT NOW(),
	"inactivity_date"  	timestamp with time zone NULL,
	"comment"          	text NULL,
	"person_id"        	integer NOT NULL,
	"supplier_id"      	integer NOT NULL,
	PRIMARY KEY("id")
);
ALTER TABLE "public"."pizzapp_contact" OWNER TO "sandrine";
CREATE TABLE "public"."pizzapp_customer"  (
	"id"               	serial NOT NULL,
	"registration_date"	timestamp with time zone NOT NULL DEFAULT NOW(),
	"comment"          	text NULL,
	"person_id"        	integer NOT NULL,
	PRIMARY KEY("id")
);
ALTER TABLE "public"."pizzapp_customer" OWNER TO "sandrine";


CREATE TABLE "public"."pizzapp_employed"  (
	"id"               	serial NOT NULL,
	"is_active"        	boolean NOT NULL DEFAULT TRUE,
	"registration_date"	timestamp with time zone NOT NULL DEFAULT NOW(),
	"inactivity_date"  	timestamp with time zone NULL,
	"comment"          	text NULL,
	"person_id"        	integer NOT NULL,
	"pizzeria_id"      	integer NOT NULL,
	PRIMARY KEY("id")
);
ALTER TABLE "public"."pizzapp_employed" OWNER TO "sandrine";


CREATE TABLE "public"."pizzapp_employed_roles"  (
	"id"         	serial NOT NULL,
	"employed_id"	integer NOT NULL,
	"role_id"    	integer NOT NULL,
	PRIMARY KEY("id")
);
ALTER TABLE "public"."pizzapp_employed_roles" OWNER TO "sandrine";


CREATE TABLE "public"."pizzapp_order"  (
	"id"               	serial NOT NULL,
	"delay"            	timestamp with time zone NOT NULL,
	"is_active"        	boolean NOT NULL DEFAULT TRUE,
	"is_paid"        	boolean NOT NULL DEFAULT FALSE,
	"registration_date"	timestamp with time zone NOT NULL DEFAULT NOW(),
	"inactivity_date"  	timestamp with time zone NULL,
	"comment"          	text NULL,
	"customer_id"      	integer NOT NULL,
	"employed_id"      	integer NULL,
	"pizzeria_id"      	integer NOT NULL,
	"status_id"        	integer NOT NULL,
	PRIMARY KEY("id")
);
ALTER TABLE "public"."pizzapp_order" OWNER TO "sandrine";


CREATE TABLE "public"."pizzapp_orderline"  (
	"id"               	serial NOT NULL,
	"quantity"         	integer NOT NULL DEFAULT 1,
	"is_active"        	boolean NOT NULL DEFAULT TRUE,
	"registration_date"	timestamp with time zone NOT NULL DEFAULT NOW(),
	"inactivity_date"  	timestamp with time zone NULL,
	"comment"          	text NULL,
	"order_id"         	integer NOT NULL,
	"pizza_id"         	integer NOT NULL,
	PRIMARY KEY("id")
);
ALTER TABLE "public"."pizzapp_orderline" OWNER TO "sandrine";


CREATE TABLE "public"."pizzapp_payment"  (
	"id"               	serial NOT NULL,
	"montant_currency" 	varchar(3) NOT NULL DEFAULT 'EUR',
	"montant"          	numeric(7,2) NOT NULL,
	"is_active"        	boolean NOT NULL DEFAULT TRUE,
	"registration_date"	timestamp with time zone NOT NULL DEFAULT NOW(),
	"inactivity_date"  	timestamp with time zone NULL,
	"comment"          	text NULL,
	"order_id"         	integer NOT NULL,
	"payment_method_id"	integer NOT NULL,
	PRIMARY KEY("id")
);
ALTER TABLE "public"."pizzapp_payment" OWNER TO "sandrine";


CREATE TABLE "public"."pizzapp_paymentmethod"  (
	"id"         	serial NOT NULL,
	"short_name" 	varchar(20) NOT NULL,
	"description"	varchar(100) NULL,
	PRIMARY KEY("id")
);
ALTER TABLE "public"."pizzapp_paymentmethod" OWNER TO "sandrine";


CREATE TABLE "public"."pizzapp_person"  (
	"id"          	serial NOT NULL,
	"first_name"  	varchar(100) NULL,
	"last_name"   	varchar(100) NULL,
	"phone_number"	varchar(50) NULL,
	"email"       	varchar(50) NULL,
	"password"    	varchar(100) NULL,
	PRIMARY KEY("id")
);
ALTER TABLE "public"."pizzapp_person" OWNER TO "sandrine";


CREATE TABLE "public"."pizzapp_pizza"  (
	"id"               	serial NOT NULL,
	"name"             	varchar(100) NOT NULL,
	"price_currency"   	varchar(3) NOT NULL DEFAULT 'EUR',
	"price"            	numeric(7,2) NOT NULL,
	"is_active"        	boolean NOT NULL DEFAULT TRUE,
	"registration_date"	timestamp with time zone NOT NULL DEFAULT NOW(),
	"inactivity_date"  	timestamp with time zone NULL,
	"comment"          	text NULL,
	PRIMARY KEY("id")
);
ALTER TABLE "public"."pizzapp_pizza" OWNER TO "sandrine";


CREATE TABLE "public"."pizzapp_pizzacard"  (
	"id"               	serial NOT NULL,
	"name"             	varchar(100) NOT NULL,
	"is_active"        	boolean NOT NULL DEFAULT TRUE,
	"registration_date"	timestamp with time zone NOT NULL DEFAULT NOW(),
	"inactivity_date"  	timestamp with time zone NULL,
	"comment"          	text NULL,
	"employed_id"      	integer NOT NULL,
	"pizzeria_id"      	integer NOT NULL,
	PRIMARY KEY("id")
);
ALTER TABLE "public"."pizzapp_pizzacard" OWNER TO "sandrine";


CREATE TABLE "public"."pizzapp_pizzacard_pizzas"  (
	"id"          	serial NOT NULL,
	"pizzacard_id"	integer NOT NULL,
	"pizza_id"    	integer NOT NULL,
	PRIMARY KEY("id")
);
ALTER TABLE "public"."pizzapp_pizzacard_pizzas" OWNER TO "sandrine";


CREATE TABLE "public"."pizzapp_pizzaline"  (
	"id"                	serial NOT NULL,
	"quantity"          	numeric(8,3) NOT NULL,
	"is_active"         	boolean NOT NULL DEFAULT TRUE,
	"registration_date" 	timestamp with time zone NOT NULL DEFAULT NOW(),
	"inactivity_date"   	timestamp with time zone NULL,
	"comment"           	text NULL,
	"component_id"      	integer NOT NULL,
	"pizza_id"          	integer NOT NULL,
	"unit_of_measure_id"	integer NOT NULL,
	PRIMARY KEY("id")
);
ALTER TABLE "public"."pizzapp_pizzaline" OWNER TO "sandrine";


CREATE TABLE "public"."pizzapp_pizzeria"  (
	"id"        	serial NOT NULL,
	"name"      	varchar(100) NOT NULL,
	"address_id"	integer NOT NULL,
	PRIMARY KEY("id")
);
ALTER TABLE "public"."pizzapp_pizzeria" OWNER TO "sandrine";


CREATE TABLE "public"."pizzapp_role"  (
	"id"         	serial NOT NULL,
	"short_name" 	varchar(100) NOT NULL,
	"description"	text NULL,
	PRIMARY KEY("id")
);
ALTER TABLE "public"."pizzapp_role" OWNER TO "sandrine";


CREATE TABLE "public"."pizzapp_status"  (
	"id"         	serial NOT NULL,
	"short_name" 	varchar(20) NOT NULL,
	"description"	varchar(100) NULL,
	PRIMARY KEY("id")
);
ALTER TABLE "public"."pizzapp_status" OWNER TO "sandrine";


CREATE TABLE "public"."pizzapp_stockmovement"  (
	"id"                	serial NOT NULL,
	"quantity"          	numeric(8,3) NOT NULL DEFAULT 0,
	"stock_before"      	numeric(8,3) NOT NULL DEFAULT 0,
	"stock_after"       	numeric(8,3) NOT NULL DEFAULT 0,
	"is_active"         	boolean NOT NULL DEFAULT TRUE,
	"registration_date" 	timestamp with time zone NOT NULL DEFAULT NOW(),
	"inactivity_date"   	timestamp with time zone NULL,
	"comment"           	text NULL,
	"command_line_id"   	integer NULL,
	"component_id"      	integer NOT NULL,
	"order_line_id"     	integer NULL,
	"unit_of_measure_id"	integer NOT NULL,
	PRIMARY KEY("id")
);
ALTER TABLE "public"."pizzapp_stockmovement" OWNER TO "sandrine";


CREATE TABLE "public"."pizzapp_supplier"  (
	"id"               	serial NOT NULL,
	"company_name"     	varchar(100) NOT NULL,
	"phone_number"     	varchar(50) NULL,
	"email"            	varchar(50) NULL,
	"is_active"        	boolean NOT NULL DEFAULT TRUE,
	"registration_date"	timestamp with time zone NOT NULL DEFAULT NOW(),
	"inactivity_date"  	timestamp with time zone NULL,
	"comment"          	text NULL,
	"address_id"       	integer NULL,
	PRIMARY KEY("id")
);
ALTER TABLE "public"."pizzapp_supplier" OWNER TO "sandrine";


CREATE TABLE "public"."pizzapp_typeaddress"  (
	"id"         	serial NOT NULL,
	"type"       	varchar(100) NOT NULL,
	"address_id" 	integer NOT NULL,
	"customer_id"	integer NOT NULL,
	PRIMARY KEY("id")
);
ALTER TABLE "public"."pizzapp_typeaddress" OWNER TO "sandrine";


CREATE TABLE "public"."pizzapp_unitofmeasure"  (
	"id"         	serial NOT NULL,
	"short_name" 	varchar(20) NOT NULL,
	"description"	varchar(100) NULL,
	PRIMARY KEY("id")
);
ALTER TABLE "public"."pizzapp_unitofmeasure" OWNER TO "sandrine";



CREATE INDEX "pizzapp_address_google_place_id_like"
	ON "public"."pizzapp_address" (google_place_id);
CREATE INDEX "pizzapp_address_location_id"
	ON "public"."pizzapp_address" (location);
CREATE INDEX "pizzapp_command_employed_id"
	ON "public"."pizzapp_command" (employed_id);
CREATE INDEX "pizzapp_command_supplier_id"
	ON "public"."pizzapp_command" (supplier_id);
CREATE INDEX "pizzapp_commandline_command_id"
	ON "public"."pizzapp_commandline" (command_id);
CREATE INDEX "pizzapp_commandline_component_id"
	ON "public"."pizzapp_commandline" (component_id);
CREATE INDEX "pizzapp_commandline_unit_of_measure_id"
	ON "public"."pizzapp_commandline" (unit_of_measure_id);
CREATE INDEX "pizzapp_component_unit_of_measure_id"
	ON "public"."pizzapp_component" (unit_of_measure_id);
CREATE INDEX "pizzapp_componentprice_component_id"
	ON "public"."pizzapp_componentprice" (component_id);
CREATE INDEX "pizzapp_componentprice_supplier_id"
	ON "public"."pizzapp_componentprice" (supplier_id);
CREATE INDEX "pizzapp_contact_supplier_id"
	ON "public"."pizzapp_contact" (supplier_id);
CREATE INDEX "pizzapp_employed_pizzeria_id"
	ON "public"."pizzapp_employed" (pizzeria_id);
CREATE INDEX "pizzapp_employed_roles_employed_id"
	ON "public"."pizzapp_employed_roles" (employed_id);
CREATE INDEX "pizzapp_employed_roles_role_id"
	ON "public"."pizzapp_employed_roles" (role_id);
CREATE INDEX "pizzapp_order_customer_id"
	ON "public"."pizzapp_order" (customer_id);
CREATE INDEX "pizzapp_order_employed_id"
	ON "public"."pizzapp_order" (employed_id);
CREATE INDEX "pizzapp_order_pizzeria_id"
	ON "public"."pizzapp_order" (pizzeria_id);
CREATE INDEX "pizzapp_order_status_id"
	ON "public"."pizzapp_order" (status_id);
CREATE INDEX "pizzapp_orderline_order_id"
	ON "public"."pizzapp_orderline" (order_id);
CREATE INDEX "pizzapp_orderline_pizza_id"
	ON "public"."pizzapp_orderline" (pizza_id);
CREATE INDEX "pizzapp_payment_order_id"
	ON "public"."pizzapp_payment" (order_id);
CREATE INDEX "pizzapp_payment_payment_method_id"
	ON "public"."pizzapp_payment" (payment_method_id);
CREATE INDEX "pizzapp_paymentmethod_short_name"
	ON "public"."pizzapp_paymentmethod" (short_name);
CREATE INDEX "pizzapp_person_email"
	ON "public"."pizzapp_person" (email);
CREATE INDEX "pizzapp_pizza_name"
	ON "public"."pizzapp_pizza" (name);
CREATE INDEX "pizzapp_pizzacard_employed_id"
	ON "public"."pizzapp_pizzacard" (employed_id);
CREATE INDEX "pizzapp_pizzacard_pizzeria_id"
	ON "public"."pizzapp_pizzacard" (pizzeria_id);
CREATE INDEX "pizzapp_pizzacard_pizzas_pizza_id"
	ON "public"."pizzapp_pizzacard_pizzas" (pizza_id);
CREATE INDEX "pizzapp_pizzacard_pizzas_pizzacard_id"
	ON "public"."pizzapp_pizzacard_pizzas" (pizzacard_id);
CREATE INDEX "pizzapp_pizzaline_component_id"
	ON "public"."pizzapp_pizzaline" (component_id);
CREATE INDEX "pizzapp_pizzaline_pizza_id"
	ON "public"."pizzapp_pizzaline" (pizza_id);
CREATE INDEX "pizzapp_pizzaline_unit_of_measure_id"
	ON "public"."pizzapp_pizzaline" (unit_of_measure_id);
CREATE INDEX "pizzapp_pizzeria_address_id"
	ON "public"."pizzapp_pizzeria" (address_id);
CREATE INDEX "pizzapp_role_short_name"
	ON "public"."pizzapp_role" (short_name);
CREATE INDEX "pizzapp_status_short_name"
	ON "public"."pizzapp_status" (short_name);
CREATE INDEX "pizzapp_stockmovement_command_line_id"
	ON "public"."pizzapp_stockmovement" (command_line_id);
CREATE INDEX "pizzapp_stockmovement_component_id"
	ON "public"."pizzapp_stockmovement" (component_id);
CREATE INDEX "pizzapp_stockmovement_order_line_id"
	ON "public"."pizzapp_stockmovement" (order_line_id);
CREATE INDEX "pizzapp_stockmovement_unit_of_measure_id"
	ON "public"."pizzapp_stockmovement" (unit_of_measure_id);
CREATE INDEX "pizzapp_supplier_type_address_id"
	ON "public"."pizzapp_supplier" (address_id);
CREATE INDEX "pizzapp_typeaddress_address_id"
	ON "public"."pizzapp_typeaddress" (address_id);
CREATE INDEX "pizzapp_typeaddress_customer_id"
	ON "public"."pizzapp_typeaddress" (customer_id);
CREATE INDEX "pizzapp_unitofmeasure_short_name"
	ON "public"."pizzapp_unitofmeasure" (short_name);
ALTER TABLE "public"."pizzapp_address"
	ADD CONSTRAINT "pizzapp_address_google_place_id_key"
	UNIQUE ("google_place_id");
ALTER TABLE "public"."pizzapp_contact"
	ADD CONSTRAINT "pizzapp_contact_person_id_key"
	UNIQUE ("person_id");
ALTER TABLE "public"."pizzapp_customer"
	ADD CONSTRAINT "pizzapp_customer_person_id_key"
	UNIQUE ("person_id");
ALTER TABLE "public"."pizzapp_employed"
	ADD CONSTRAINT "pizzapp_employed_person_id_key"
	UNIQUE ("person_id");
ALTER TABLE "public"."pizzapp_employed_roles"
	ADD CONSTRAINT "pizzapp_employed_roles_employed_id_role_id_uniq"
	UNIQUE ("employed_id", "role_id");
ALTER TABLE "public"."pizzapp_paymentmethod"
	ADD CONSTRAINT "pizzapp_paymentmethod_short_name_key"
	UNIQUE ("short_name");
ALTER TABLE "public"."pizzapp_person"
	ADD CONSTRAINT "pizzapp_person_email_key"
	UNIQUE ("email");
ALTER TABLE "public"."pizzapp_pizza"
	ADD CONSTRAINT "pizzapp_pizza_name_key"
	UNIQUE ("name");
ALTER TABLE "public"."pizzapp_pizzacard_pizzas"
	ADD CONSTRAINT "pizzapp_pizzacard_pizzas_pizzacard_id_pizza_id_uniq"
	UNIQUE ("pizzacard_id", "pizza_id");
ALTER TABLE "public"."pizzapp_role"
	ADD CONSTRAINT "pizzapp_role_short_name_key"
	UNIQUE ("short_name");
ALTER TABLE "public"."pizzapp_status"
	ADD CONSTRAINT "pizzapp_status_short_name_key"
	UNIQUE ("short_name");
ALTER TABLE "public"."pizzapp_unitofmeasure"
	ADD CONSTRAINT "pizzapp_unitofmeasure_short_name_key"
	UNIQUE ("short_name");
ALTER TABLE "public"."pizzapp_command"
	ADD CONSTRAINT "pizzapp_command_supplier_id_fk_pizzapp_supplier_id"
	FOREIGN KEY("supplier_id")
	REFERENCES "public"."pizzapp_supplier"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_command"
	ADD CONSTRAINT "pizzapp_command_employed_id_fk_pizzapp_employed_id"
	FOREIGN KEY("employed_id")
	REFERENCES "public"."pizzapp_employed"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_commandline"
	ADD CONSTRAINT "pizzapp_commandline_unit_of_measure_id_fk_pizzapp_u"
	FOREIGN KEY("unit_of_measure_id")
	REFERENCES "public"."pizzapp_unitofmeasure"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_commandline"
	ADD CONSTRAINT "pizzapp_commandline_component_id_fk_pizzapp_c"
	FOREIGN KEY("component_id")
	REFERENCES "public"."pizzapp_component"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_commandline"
	ADD CONSTRAINT "pizzapp_commandline_command_id_fk_pizzapp_command_id"
	FOREIGN KEY("command_id")
	REFERENCES "public"."pizzapp_command"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_component"
	ADD CONSTRAINT "pizzapp_component_unit_of_measure_id_fk_pizzapp_u"
	FOREIGN KEY("unit_of_measure_id")
	REFERENCES "public"."pizzapp_unitofmeasure"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_componentprice"
	ADD CONSTRAINT "pizzapp_componentpri_supplier_id_fk_pizzapp_s"
	FOREIGN KEY("supplier_id")
	REFERENCES "public"."pizzapp_supplier"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_componentprice"
	ADD CONSTRAINT "pizzapp_componentpri_component_id_fk_pizzapp_c"
	FOREIGN KEY("component_id")
	REFERENCES "public"."pizzapp_component"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_contact"
	ADD CONSTRAINT "pizzapp_contact_supplier_id_fk_pizzapp_supplier_id"
	FOREIGN KEY("supplier_id")
	REFERENCES "public"."pizzapp_supplier"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_contact"
	ADD CONSTRAINT "pizzapp_contact_person_id_fk_pizzapp_person_id"
	FOREIGN KEY("person_id")
	REFERENCES "public"."pizzapp_person"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_customer"
	ADD CONSTRAINT "pizzapp_customer_person_id_fk_pizzapp_person_id"
	FOREIGN KEY("person_id")
	REFERENCES "public"."pizzapp_person"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_employed"
	ADD CONSTRAINT "pizzapp_employed_pizzeria_id_fk_pizzapp_pizzeria_id"
	FOREIGN KEY("pizzeria_id")
	REFERENCES "public"."pizzapp_pizzeria"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_employed"
	ADD CONSTRAINT "pizzapp_employed_person_id_fk_pizzapp_person_id"
	FOREIGN KEY("person_id")
	REFERENCES "public"."pizzapp_person"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_employed_roles"
	ADD CONSTRAINT "pizzapp_employed_roles_role_id_fk_pizzapp_role_id"
	FOREIGN KEY("role_id")
	REFERENCES "public"."pizzapp_role"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_employed_roles"
	ADD CONSTRAINT "pizzapp_employed_rol_employed_id_fk_pizzapp_e"
	FOREIGN KEY("employed_id")
	REFERENCES "public"."pizzapp_employed"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_order"
	ADD CONSTRAINT "pizzapp_order_status_id_fk_pizzapp_status_id"
	FOREIGN KEY("status_id")
	REFERENCES "public"."pizzapp_status"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_order"
	ADD CONSTRAINT "pizzapp_order_pizzeria_id_fk_pizzapp_pizzeria_id"
	FOREIGN KEY("pizzeria_id")
	REFERENCES "public"."pizzapp_pizzeria"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_order"
	ADD CONSTRAINT "pizzapp_order_employed_id_fk_pizzapp_employed_id"
	FOREIGN KEY("employed_id")
	REFERENCES "public"."pizzapp_employed"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_order"
	ADD CONSTRAINT "pizzapp_order_customer_id_fk_pizzapp_customer_id"
	FOREIGN KEY("customer_id")
	REFERENCES "public"."pizzapp_customer"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_orderline"
	ADD CONSTRAINT "pizzapp_orderline_pizza_id_fk_pizzapp_pizza_id"
	FOREIGN KEY("pizza_id")
	REFERENCES "public"."pizzapp_pizza"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_orderline"
	ADD CONSTRAINT "pizzapp_orderline_order_id_fk_pizzapp_order_id"
	FOREIGN KEY("order_id")
	REFERENCES "public"."pizzapp_order"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_payment"
	ADD CONSTRAINT "pizzapp_payment_payment_method_id_fk_pizzapp_p"
	FOREIGN KEY("payment_method_id")
	REFERENCES "public"."pizzapp_paymentmethod"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_payment"
	ADD CONSTRAINT "pizzapp_payment_order_id_fk_pizzapp_order_id"
	FOREIGN KEY("order_id")
	REFERENCES "public"."pizzapp_order"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_pizzacard"
	ADD CONSTRAINT "pizzapp_pizzacard_pizzeria_id_fk_pizzapp_pizzeria_id"
	FOREIGN KEY("pizzeria_id")
	REFERENCES "public"."pizzapp_pizzeria"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_pizzacard"
	ADD CONSTRAINT "pizzapp_pizzacard_employed_id_fk_pizzapp_employed_id"
	FOREIGN KEY("employed_id")
	REFERENCES "public"."pizzapp_employed"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_pizzacard_pizzas"
	ADD CONSTRAINT "pizzapp_pizzacard_pizzas_pizza_id_fk_pizzapp_pizza_id"
	FOREIGN KEY("pizza_id")
	REFERENCES "public"."pizzapp_pizza"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_pizzacard_pizzas"
	ADD CONSTRAINT "pizzapp_pizzacard_pi_pizzacard_id_fk_pizzapp_p"
	FOREIGN KEY("pizzacard_id")
	REFERENCES "public"."pizzapp_pizzacard"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_pizzaline"
	ADD CONSTRAINT "pizzapp_pizzaline_unit_of_measure_id_fk_pizzapp_u"
	FOREIGN KEY("unit_of_measure_id")
	REFERENCES "public"."pizzapp_unitofmeasure"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_pizzaline"
	ADD CONSTRAINT "pizzapp_pizzaline_pizza_id_fk_pizzapp_pizza_id"
	FOREIGN KEY("pizza_id")
	REFERENCES "public"."pizzapp_pizza"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_pizzaline"
	ADD CONSTRAINT "pizzapp_pizzaline_component_id_fk_pizzapp_component_id"
	FOREIGN KEY("component_id")
	REFERENCES "public"."pizzapp_component"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_pizzeria"
	ADD CONSTRAINT "pizzapp_pizzeria_address_id_fk_pizzapp_address_id"
	FOREIGN KEY("address_id")
	REFERENCES "public"."pizzapp_address"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_stockmovement"
	ADD CONSTRAINT "pizzapp_stockmovemen_unit_of_measure_id_fk_pizzapp_u"
	FOREIGN KEY("unit_of_measure_id")
	REFERENCES "public"."pizzapp_unitofmeasure"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_stockmovement"
	ADD CONSTRAINT "pizzapp_stockmovemen_order_line_id_fk_pizzapp_o"
	FOREIGN KEY("order_line_id")
	REFERENCES "public"."pizzapp_orderline"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_stockmovement"
	ADD CONSTRAINT "pizzapp_stockmovemen_component_id_fk_pizzapp_c"
	FOREIGN KEY("component_id")
	REFERENCES "public"."pizzapp_component"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_stockmovement"
	ADD CONSTRAINT "pizzapp_stockmovemen_command_line_id_fk_pizzapp_c"
	FOREIGN KEY("command_line_id")
	REFERENCES "public"."pizzapp_commandline"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_supplier"
	ADD CONSTRAINT "pizzapp_supplier_address_id_fk_pizzapp_address_id"
	FOREIGN KEY("address_id")
	REFERENCES "public"."pizzapp_address"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_typeaddress"
	ADD CONSTRAINT "pizzapp_typeaddress_customer_id_fk_pizzapp_customer_id"
	FOREIGN KEY("customer_id")
	REFERENCES "public"."pizzapp_customer"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
ALTER TABLE "public"."pizzapp_typeaddress"
	ADD CONSTRAINT "pizzapp_typeaddress_address_id_fk_pizzapp_address_id"
	FOREIGN KEY("address_id")
	REFERENCES "public"."pizzapp_address"("id")
	MATCH SIMPLE
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
	DEFERRABLE
	INITIALLY DEFERRED ;
