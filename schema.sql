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
