USE test;

DROP TABLE IF EXISTS example;

CREATE TABLE example(
  id INT NOT NULL,
  text1 VARCHAR(32) NOT NULL,
  text2 VARCHAR(32) NOT NULL DEFAULT 'foo'
);

SELECT * FROM example;

INSERT INTO example (id) VALUES(1);
# Fail since text1 doesn't have a default value
INSERT INTO example (text1) VALUES('test');
# Fail since id doesn't have a default value


# In MySQL, implicit defaults are determined as follows:

# For numeric types, the default is typically zero.
# For date and time types, the default is the appropriate “zero” value for the type. (This actually a bit more complicated for fields with the type TIMESTAMP.)
# For string types (other than ENUM), the default value is the empty string. For ENUM, the default is the first enumeration value.


DROP TABLE IF EXISTS example;

CREATE TABLE example(
  id INT,
  text1 VARCHAR(32),
  text2 VARCHAR(32) NULL DEFAULT 'foo'
);

SELECT * FROM example;

INSERT INTO example (id) VALUES(1);
# id = 1 text1 = NULL
INSERT INTO example (text1) VALUES('test');
# id = NULL text2 test


SELECT * FROM example;

















