/* Populate database with sample data. */

INSERT INTO animals(name, date_of_birth, escape_attempts, neutured, weight_kg) VALUES('Agumon', DATE '2020-02-03', '0', 'true', '10.23');
INSERT INTO animals(name, date_of_birth, escape_attempts, neutured, weight_kg) VALUES('Gabumon', DATE '2018-11-15', '2', 'true', '8');
INSERT INTO animals(name, date_of_birth, escape_attempts, neutured, weight_kg) VALUES('Pikachu', DATE '2021-01-07', '1', 'false', '15.04');
INSERT INTO animals(name, date_of_birth, escape_attempts, neutured, weight_kg) VALUES('Devimon', DATE '2017-05-12', '5', 'true', '11.0');

-- Updating and Deleting table animals
ALTER TABLE animals ADD species VARCHAR(50) NULL;
INSERT INTO animals(name, date_of_birth, escape_attempts, neutured, weight_kg) VALUES('Charmander', DATE '2020-08-08', '0', 'false', '20.0');
INSERT INTO animals(name, date_of_birth, escape_attempts, neutured, weight_kg) VALUES('Plantmon', DATE '2021-11-15', '2', 'true', '5.7');
INSERT INTO animals(name, date_of_birth, escape_attempts, neutured, weight_kg) VALUES('Squirtle', DATE '1993-04-02', '3', 'false', '12.13');
INSERT INTO animals(name, date_of_birth, escape_attempts, neutured, weight_kg) VALUES('Angemon', DATE '2005-06-12', '1', 'true', '45.0');
INSERT INTO animals(name, date_of_birth, escape_attempts, neutured, weight_kg) VALUES('Boarmon', DATE '2005-06-7', '7', 'true', '20.4');
INSERT INTO animals(name, date_of_birth, escape_attempts, neutured, weight_kg) VALUES('Blossom', DATE '1998-10-13', '3', 'true', '17.0');
INSERT INTO animals(name, date_of_birth, escape_attempts, neutured, weight_kg) VALUES('Ditto', DATE '2022-05-14', '4', 'true', '20.0');
