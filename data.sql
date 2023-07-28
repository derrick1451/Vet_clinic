/* Populate database with sample data. */

INSERT INTO animals (name,date_of_birth,weight_kg,neutered,escape_attempts) VALUES ('Agumon','2020-02-03',10.23,true,0);
INSERT INTO animals (name,date_of_birth,weight_kg,neutered,escape_attempts) VALUES ('Gabumon','2018-11-15',8,true,2);
INSERT INTO animals (name,date_of_birth,weight_kg,neutered,escape_attempts) VALUES ('Pikachu','2021-01-07',15.04,false,1);
INSERT INTO animals (name,date_of_birth,weight_kg,neutered,escape_attempts) VALUES ('Devimon','2017-05-12',11,true,5);

-- Insert the following data
INSERT INTO animals (name,date_of_birth,weight_kg,neutered,escape_attempts) VALUES ('Charmander','2020-02-08',-11,false,0);
INSERT INTO animals (name,date_of_birth,weight_kg,neutered,escape_attempts) VALUES ('Plantmon','2021-11-15',-5.7,true,2);
INSERT INTO animals (name,date_of_birth,weight_kg,neutered,escape_attempts) VALUES ('Squirtle','1993-04-02',-12.13,false,3);
INSERT INTO animals (name,date_of_birth,weight_kg,neutered,escape_attempts) VALUES ('Angemon','2005-06-12',-45,true,1);

INSERT INTO animals (name,date_of_birth,weight_kg,neutered,escape_attempts) VALUES ('Boarmon','2005-06-07',20.4,true,7);
INSERT INTO animals (name,date_of_birth,weight_kg,neutered,escape_attempts) VALUES ('Blossom','1998-10-13',17,true,3);
INSERT INTO animals (name,date_of_birth,weight_kg,neutered,escape_attempts) VALUES ('Ditto','2022-05-14',22,true,4);

-- Insert the following data into the owners table
INSERT INTO owners (full_name,age) VALUES ('Sam Smith',34),('Jennifer Orwell',19),('Bob',45),('Melody Pond',77),('Dean Winchester',14),('Jodie Whittaker',38);

-- Insert the following data into the species table
INSERT INTO species (name) VALUES ('Pokemon'),('Digimon');

-- Modify your inserted animals so it includes the species_id value
UPDATE animals
SET species_id = species.id
FROM species
WHERE (animals.name LIKE '%mon' AND species.name = 'Digimon')
   OR (animals.name NOT LIKE '%mon' AND species.name = 'Pokemon');

--    Modify your inserted animals to include owner information (owner_id)
UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE owners.full_name IN ('Sam Smith', 'Jennifer Orwell', 'Bob', 'Melody Pond', 'Dean Winchester')
  AND (
    (animals.name = 'Agumon' AND owners.full_name = 'Sam Smith')
    OR (animals.name IN ('Gabumon', 'Pikachu') AND owners.full_name = 'Jennifer Orwell')
    OR (animals.name IN ('Devimon', 'Plantmon') AND owners.full_name = 'Bob')
    OR (animals.name IN ('Charmander', 'Squirtle', 'Blossom') AND owners.full_name = 'Melody Pond')
    OR (animals.name IN ('Angemon', 'Boarmon') AND owners.full_name = 'Dean Winchester')
  );

  -- Insert the following data for vets
  INSERT INTO vets (name,age,date_of_graduation) VALUES ('William Tatcher',45,'2000-04-23'),('Maisy Smith',26,'2019-01-17'),('Stephanie Mendez',64,'1981-05-04'),('Jack Harkness',38,'2008-06-08');

  -- Insert the following data for specializations:
  INSERT INTO specializations (vet_id,spec_id) VALUES (1,1),(3,2),(3,1),(4,2);

  -- Insert the following data for visits:
  INSERT INTO visits (animal_id,vet_id,date_of_visit) VALUES (1,1,'2020-05-24'),(1,3,'2020-07-22'),(2,4,'2021-02-02'),(3,2,'2020-01-05'),
  (3,2,'2020-03-08'),(3,2,'2020-05-14'),(4,3,'2021-05-04'),(5,4,'2021-02-24'),(6,2,'2019-12-21'),(6,1,'2020-08-10'),(6,2,'2021-04-07'),
  (7,3,'2019-09-29'),(8,4,'2020-10-03'),(8,4,'2020-11-04'),(9,2,'2019-01-24'),(9,2,'2019-05-15'),(9,2,'2020-02-27'),(9,2,'2020-08-03'),
  (10,3,'2020-05-24'),(10,1,'2021-01-11');