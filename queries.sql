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

-- JOIN TABLE VISITS
-- Write queries to answer the following

-- Who was the last animal seen by William Tatcher?
SELECT animal_name, vets.vets_name, v.visit_date 
FROM animals a JOIN visits v ON a.animal_id = v.animal_id 
JOIN vets ON vets.vet_id = v.vet_id 
WHERE vets.vet_id = 1 ORDER BY v.visit_date DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(a.animal_name), vets.vets_name 
FROM animals a JOIN visits v ON a.animal_id = v.animal_id 
JOIN vets ON vets.vet_id = v.vet_id 
WHERE vets.vets_name = 'Stephanie Mendez' GROUP BY vets.vets_name;

-- List all vets and their specialties, including vets with no specialties.
SELECT species.species_name, vets.vets_name 
FROM vets FULL JOIN specializations ON specializations.vet_id = vets.vet_id 
FULL JOIN species ON species.species_id = specializations.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.animal_name, vets.vets_name, visits.visit_date 
FROM vets FULL JOIN visits ON visits.vet_id = vets.vet_id 
FULL JOIN animals ON animals.animal_id = visits.animal_id 
WHERE vets.vets_name = 'Stephanie Mendez' AND visits.visit_date 
BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT COUNT(animals.animal_name), animals.animal_name
FROM vets JOIN visits ON visits.vet_id = vets.vet_id 
JOIN animals ON animals.animal_id = visits.animal_id 
GROUP BY animals.animal_name ORDER BY count DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT vets.vets_name, a.animal_name, visits.visit_date 
FROM vets JOIN visits ON visits.vet_id = vets.vet_id 
JOIN animals a ON a.animal_id = visits.animal_id 
WHERE vets.vets_name = 'Maisy Smith' ORDER BY visits.visit_date LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT a.animal_name AS animal,a.date_of_birth,a.escape_attempts,a.neutured,
a.weight_kg,species.species_name,vets.vets_name AS vet, vets.age,vets.date_of_graduation,v.visit_date 
FROM vets JOIN visits v ON v.vet_id = vets.vet_id JOIN animals a ON a.animal_id = v.animal_id 
JOIN species ON a.species_id = species.species_id ORDER BY v.visit_date DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT animals.animal_name as Animal, species.species_name AS species,
vets.name AS vet, vet_sp.species_name AS specialized
FROM vets JOIN visits ON vets.vet_id = visits.vet_id
JOIN animals ON visits.animal_id = animals.animal_id
JOIN species ON species.species_id = animals.species_id
JOIN specializations ON specializations.vet_id = vets.vet_id
JOIN species vet_sp ON vet_sp.id = specializations.species_id
WHERE species.id != vet_sp.id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.species_name AS species
FROM vets JOIN visits ON vets.vet_id = visits.vet_id
JOIN animals ON visits.animal_id = animals.animal_id
JOIN species ON species.species_id = animals.species_id
WHERE vets.vets_name = 'Maisy Smith' GROUP BY species LIMIT 1;