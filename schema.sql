/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name varchar(100) NOT NULL,
    date_of_birth  DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered  BOOLEAN,
    weight_kg DECIMAL (18, 2) 
);
-- alter the TABLE and and new column
ALTER TABLE animals
ADD COLUMN species varchar(100);

-- Create a table named owners with the following columns
CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name varchar(100) NOT NULL,
    age INT NOT NULL
);

-- Create a table named species with the following columns
CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name varchar(100) NOT NULL
);

-- Modify animals table
-- Remove column species
ALTER TABLE animals
DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals
ADD COLUMN species_id INT;


-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id)
REFERENCES species(id)
ON DELETE CASCADE;

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals
ADD COLUMN owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_owner
FOREIGN KEY (owner_id)
REFERENCES owners(id)
ON DELETE CASCADE;


-- Create a table named vets with the following columns
CREATE TABLE vets (
   id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name varchar(100) NOT NULL,
age INT NOT NULL,
date_of_graduation DATE NOT NULL 
);

-- There is a many-to-many relationship between the tables species and vets: a vet can specialize in multiple species, and a species can have multiple vets specialized in it. Create a "join table" called specializations to handle this relationship.

CREATE TABLE specializations (
    vet_id INT,
    spec_id INT,
    PRIMARY KEY (vet_id,spec_id)
);

-- There is a many-to-many relationship between the tables animals and vets: an animal can visit multiple vets and one vet can be visited by multiple animals. Create a "join table" called visits to handle this relationship, it should also keep track of the date of the visit.

CREATE TABLE visits (
    animal_id INT,
    vet_id INT,
    PRIMARY KEY (vet_id,animal_id)
);

-- add foreign keys on the specializations table
ALTER TABLE specializations
ADD CONSTRAINT fk_spec
FOREIGN KEY (spec_id)
REFERENCES species(id)
ON DELETE CASCADE;

ALTER TABLE specializations
ADD CONSTRAINT fk_vets
FOREIGN KEY (vet_id)
REFERENCES vets(id)
ON DELETE CASCADE;
