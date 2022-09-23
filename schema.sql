/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

CREATE TABLE animals(
    id BIGSERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts int NOT NULL,
    neutured boolean NOT NULL,
    weight_kg decimal NOT NULL,
    species VARCHAR(50) NULL,
 );

--  Multiple tables

-- Create a table named owners with the following columns:
CREATE TABLE owners(
    owner_id BIGSERIAL PRIMARY KEY NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    age int NOT NULL,
)

-- Create a table named species with the following columns
CREATE TABLE species(
    species_id BIGSERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
);

-- Modify animals table
ALTER TABLE animals ALTER COLUMN id TYPE BIGSERIAL PRIMARY KEY;
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD species_id int NULL;
ALTER TABLE animals ADD owner_id int NULL;

-- ADD JOIN TABLE VISITS
-- Create vets table
CREATE TABLE vets(
    vet_id BIGSERIAL PRIMARY KEY NOT NULL,
    vets_name VARCHAR(80) NOT NULL,
    age int NOT NULL,
    date_of_graduation DATE NOT NULL
);

-- Create join table called specialization
CREATE TABLE specializations (
	vet_id INT,
	species_id INT,
	PRIMARY KEY (vet_id, species_id),
	FOREIGN KEY (vet_id) REFERENCES vets(vet_id),
	FOREIGN KEY (species_id) REFERENCES species(species_id)
);

-- Create a "join table" called visits
CREATE TABLE visits (
	vet_id INT,
	animal_id INT,
    visit_date date,
	PRIMARY KEY (vet_id, animal_id, visit_date),
	FOREIGN KEY (vet_id) REFERENCES vets(vet_id),
	FOREIGN KEY (animal_id) REFERENCES animals(animal_id)
);
