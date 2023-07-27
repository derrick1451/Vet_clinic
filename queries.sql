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
