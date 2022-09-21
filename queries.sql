/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE EXTRACT(year FROM date_of_birth) BETWEEN 2016 AND 2019;
SELECT * FROM animals WHERE neutured = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals where neutured = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- Updating the animal table
BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species = '';

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth::date > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = (weight_kg * -1);
ROLLBACK TO SAVEPOINT SP1;
UPDATE animals SET weight_kg = (weight_kg * -1) WHERE weight_kg = (weight_kg * -1);
COMMIT;
SELECT * FROM animals;

-- Write queries to answer the following questions:

-- How many animals are there?
SELECT COUNT(name) FROM animals;
-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT MAX(escape_attempts), neutered FROM animals GROUP BY neutered;
-- What is the minimum and maximum weight of each type of animal?
SELECT MIN(weight_kg), MAX(weight_kg), species FROM animals GROUP BY species;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000? 
SELECT AVG(escape_attempts) , species FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

