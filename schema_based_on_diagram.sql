CREATE DATABASE medical_database;

-- TABLE patients
CREATE TABLE patients (id BIGSERIAL PRIMARY KEY, name VARCHAR(120), date_of_birth DATE);

-- TABLE medical histories
CREATE TABLE medical_histories (id BIGSERIAL PRIMARY KEY, admitted_at TIMESTAMP, patient_id INT REFERENCES patients(id), status VARCHAR(120));

-- TABLE invoices
CREATE TABLE invoices (id BIGSERIAL PRIMARY KEY, total_amount INT, generated_at TIMESTAMP, payed_at TIMESTAMP, medical_history_id INT REFERENCES medical_histories(id));

-- TABLE invoice_items
CREATE TABLE invoice_items (id BIGSERIAL PRIMARY KEY, unit_price INT, quantity INT, total_price INT, invoice_id INT REFERENCES invoices(id), treatment_id INT);

-- TABLE treatments
CREATE TABLE treatments(id BIGSERIAL PRIMARY KEY, type VARCHAR(120), name VARCHAR(120));

-- ALTER TABLE invoice items since I forgot to create it while creating the table
ALTER TABLE invoice_items ADD CONSTRAINT invoice_item_treatment_id_fk FOREIGN KEY(treatment_id) REFERENCES treatments(id);

-- The indexes that I created.
CREATE INDEX index_invoice_medic_history_invoice ON invoices(medical_history_id);

CREATE INDEX index_id_patient_medic_history ON medical_histories(patient_id);

CREATE INDEX index_invoice_items_id ON invoice_items(invoice_id);

CREATE INDEX index_treatment_id ON invoice_items(treatment_id);

-- ALTER INT TO DECIMAL

ALTER TABLE invoices
ALTER COLUMN total_amount type DECIMAL(10,2);
-- ALTER INT TO DECIMAL

ALTER TABLE invoice_items
ALTER COLUMN quantity type DECIMAL(10,2);
-- ALTER INT TO DECIMAL

ALTER TABLE invoice_items 
ALTER COLUMN unit_price type DECIMAL(10,2);

-- CREATE JOIN TABLE BETWEEN MEDICAL HISTORY AND TREATMENTS
CREATE TABLE medical_histories_treatment(
treatment_id INT, 
CONSTRAINT treatment_id FOREIGN KEY (treatment_id) REFERENCES treatments(id), medical_history_id INT, 
CONSTRAINT medical_history_id FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id), 
PRIMARY KEY (treatment_id, medical_history_id)
);

-- CREATE INDEX
CREATE INDEX medical_histories_treatments_medical_history_id ON medical_histories_treatment(medical_history_id);
CREATE INDEX medical_histories_treatments_treatment_id ON medical_histories_treatment(treatment_id);