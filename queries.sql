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

-- MULTIPLE TABLES

-- Write queries (using JOIN) to answer the following questions
-- What animals belong to Melody Pond?
SELECT animal_name, full_name FROM animals 
JOIN owners ON animals.owner_id = owners.owner_id WHERE owners.owner_id = 4;
-- List of all animals that are pokemon (their type is Pokemon).
SELECT animal_name, species_name FROM animals 
JOIN species ON animals.species_id = species.species_id WHERE species.species_id = 1;
-- List all owners and their animals, remember to include those that don't own any animal.
SELECT animal_name, full_name FROM animals FULL
JOIN owners ON animals.owner_id = owners.owner_id;
-- How many animals are there per species?
SELECT COUNT(*), species_name FROM animals, species 
WHERE animals.species_id = species.species_id GROUP BY species_name;
-- List all Digimon owned by Jennifer Orwell.
SELECT animal_name, full_name FROM animals 
JOIN owners ON animals.owner_id = owners.owner_id 
WHERE full_name = 'Jennifer Orwell' and species_id = 2;
-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animal_name, full_name 
FROM animals JOIN owners ON animals.owner_id = owners.owner_id 
WHERE full_name = 'Dean Winchester' and escape_attempts = 0;
-- Who owns the most animals?
SELECT owners.full_name , COUNT(animal_name) AS total_animals 
FROM owners JOIN animals ON animals.owner_id=owners.owner_id 
GROUP BY owners.full_name ORDER BY total_animals DESC LIMIT 1;