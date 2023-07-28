/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE EXTRACT('Year' FROM date_of_birth) BETWEEN '2016' AND  '2019';
SELECT name FROM animals WHERE(neutered = true AND escape_attempts < 3);
SELECT date_of_birth FROM animals WHERE name IN ('Agumon','Pikachu');
SELECT name,escape_attempts FROM animals WHERE (weight_kg > 10.5);
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name NOT IN ('Gabumon');
SELECT * FROM animals WHERE (weight_kg >= 10.4 AND weight_kg <= 17.3 );

-- Inside a transaction update the animals table by setting the species column to unspecified
BEGIN;
UPDATE animals
SET species = 'unspecified';
ROLLBACK;

-- Inside a transaction
BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

-- Now, take a deep breath and... Inside a transaction delete all records in the animals table,
BEGIN;
DELETE FROM animals;
ROLLBACK;

-- Add save points
BEGIN;
delete from animals where date_of_birth >'2022-01-01';
SAVEPOINT sp1;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT sp1;
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

-- Write queries to answer the following questions
-- How many animals are there
SELECT COUNT(*) as total FROM animals;

-- How many animals have never tried to escape
SELECT COUNT(*) FROM animals WHERE escape_attempts=0;

-- What is the average weight of animals
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals
SELECT neutered, MAX(escape_attempts) FROM animals
GROUP BY  neutered;

-- What is the minimum and maximum weight of each type of animal
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;


-- What is the average number of escape attempts per animal type of those born between 1990 and 2000
SELECT species, AVG(escape_attempts),date_of_birth FROM animals
GROUP BY date_of_birth,species
HAVING EXTRACT(YEAR from date_of_birth) BETWEEN 1990 and 2000;


-- Write queries (using JOIN) to answer the following questions

-- What animals belong to Melody Pond?
SELECT full_name, name
FROM owners
INNER JOIN animals
ON owners.id = animals.owner_id
WHERE owners.full_name ='Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name,species.name
FROM species
INNER JOIN animals
ON species.id = animals.species_id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT full_name, name 
FROM owners
LEFT JOIN animals
ON owners.id = animals.owner_id;

-- How many animals are there per species
SELECT species.name,COUNT(species.id)
FROM species
INNER JOIN animals
ON species.id = animals.species_id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name 
FROM species
JOIN animals ON species.id = animals.species_id
INNER JOIN owners 
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape
SELECT animals.name,full_name
FROM owners
INNER JOIN animals
ON animals.owner_id = owners.id
WHERE animals.escape_attempts = 0 AND owners.full_name = 'Dean Winchester';

-- Who owns the most animals?
SELECT owners.full_name, COUNT(animals.id) AS animal_count
FROM owners 
JOIN animals  ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY COUNT(animals.id) DESC
LIMIT 1;



-- Write queries to answer the following:
-- Who was the last animal seen by William Tatcher?
SELECT animals.name, date_of_visit from animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit DESC
LIMIT 1;


-- How many different animals did Stephanie Mendez see?
SELECT COUNT(animals.id) FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name,species.name FROM vets
LEFT JOIN specializations ON specializations.vet_id = vets.id
LEFT JOIN species ON specializations.spec_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name
FROM visits 
JOIN animals ON animals.id = visits.animal_id
JOIN vets  ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez'
  AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

--   What animal has the most visits to vets
SELECT  animals.name, COUNT(animals.id) AS COUNT
from animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets  ON vets.id = visits.vet_id
GROUP BY animals.name
ORDER BY COUNT DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name, vets.name,MIN(visits.date_of_visit) FROM
animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets  ON vets.id = visits.vet_id
GROUP BY animals.name,vets.name ,visits.date_of_visit
HAVING vets.name = 'Maisy Smith'
ORDER BY visits.date_of_visit ASC
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name, vets.name, visits.date_of_visit,
MIN(visits.date_of_visit)
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets  ON vets.id = visits.vet_id
GROUP By animals.name, vets.name, visits.date_of_visit
ORDER BY visits.date_of_visit DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*)
FROM visits v
JOIN animals a ON a.id = v.animal_id
JOIN vets vt ON vt.id = v.vet_id
LEFT JOIN specializations s ON s.vet_id = vt.id AND s.spec_id = a.species_id
WHERE s.vet_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
select species.name,count(species.name) 
from visits,animals,vets,species where animals.id=visits.animal_id and visits.vet_id=vets.id 
and vets.name='Maisy Smith' and species.id=animals.species_id
group by  species.name
order by count(*) DESC
limit 1;