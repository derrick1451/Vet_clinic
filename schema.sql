/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name varchar(100) NOT NULL,
    date_of_birth  DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered  BOOLEAN,
    weight_kg DECIMAL (18, 2) 
);
