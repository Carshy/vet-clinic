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
)

-- Modify animals table
ALTER TABLE animals ALTER COLUMN id TYPE BIGSERIAL PRIMARY KEY;
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD species_id int NULL;
ALTER TABLE animals ADD owner_id int NULL;
