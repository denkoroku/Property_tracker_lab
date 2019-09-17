DROP TABLE IF EXISTS properties;

CREATE TABLE properties(
  ID SERIAL4 PRIMARY KEY,
  address VARCHAR(255),
  value INT,
  no_of_bedrooms INT,
  build VARCHAR(255)
);
