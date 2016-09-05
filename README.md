# Math PhD Students Database for Hackett University

This is a Ruby program that uses persistent data to organize data pertaining to Math PhD candidates and recipients of Hackett University. It is intended to be used as a data entry and retrieval system to keep track of the students' names, advisors, specialty, grades, etc.

## Database Schema

![Database Schema](schema.png)

## Features

_IMPORTANT_: If you are just testing the program for functionality and don't have any real entries to enter, then after running driver.rb, choose the "generate student data" from the main menu in the UI.


View and add information to students, advisors, classes, grades, fields (of math).

#### Viewing Entries

  * View all advisors, classes, fields, grades, or students
  * View advisors by field
  * View students by ID, name, advisor, specialty
  * View grades by student ID, class

#### Adding Entries

  * Add entries to advisors, classes, grades, or students

##### Caveats

   * If you do not enter a date of matriculation when entering data for a new student, it will automatically put the current day's date.
   * If you do not enter a timestamp date when entering data for a new grade, it will automatically put the current day's date.

#### Automated GPA Calculation

Here at Hackett U, we use the 4.0 grading scale. A student's GPA should not be updated manually, since it will be calculated automatically whenever a corresponding entry to the grades table is entered.

#### Automated Graduation Date Timestamp

A doctoral student of math is considered graduated once they have taken 8 graduate classes. A student's date of graduation should not be updated manually, since the program will automatically mark them as "graduated" once they have fulfilled the requirement.

## File Navigation

* **advisors.rb**: Contains functions to add advisors, view advisors, search advisors by field
* **classes.rb**: Contains functions to add classes, view classes
* **driver.rb**: Main file to run to execute any and all functions to manipulate the database
* **fields.rb**: Contains functions to view fields
* **hmps.db**: Database of Math PhDs at Hackett U.
* **grades.rb**: Contains functions to add grades, view grades, search grades by class, search grades by student ID
* **schema.png**: Image containing the schemas for the different tables in the database
* **students.rb**: Contains functions to add students, view students, search students by id, name, advisor, field

## Pre-Populated Tables and Entries

We have added entries prior to user entry to the database, as these fields, classes, and advisors existed prior to the creation of the database.

#### Fields


| ID  | Field Name    |
|---- |-------------- |
| 1   | Algebra       |
| 2   | Analysis      |
| 3   | Applied Math  |
| 4   | Logic         |
| 5   | Topology      |

#### Classes

| ID  | Name                      | Field   |
|---- |-------------------------- |-------  |
| 1   | Groups, Rings, Fields     | 1       |
| 2   | Homological Algebra       | 1       |
| 3   | Algebraic Geometry        | 1       |
| 4   | Measure Theory            | 2       |
| 5   | Harmonic Analysis         | 2       |
| 6   | Differentiable Manifolds  | 2       |
| 7   | Differential Equations    | 3       |
| 8   | Stochastic Processes      | 3       |
| 9   | Numerical Analysis        | 3       |
| 10  | Riemannian Geometry       | 4       |
| 11  | Complex Geometry          | 4       |
| 12  | Symplectic Geometry       | 4       |
| 13  | Metamathematics           | 5       |
| 14  | Recursion Theory          | 5       |
| 15  | Model Theory              | 5       |

#### Advisors

| ID  | Last Name   | First Name  | Field   |
|---- |-----------  |------------ |-------  |
| 1   | Blanda      | Adrienne    | 1       |
| 2   | Kassulke    | Grant       | 2       |
| 3   | Mertz       | Damaris     | 3       |
| 4   | Ratke       | Jerad       | 4       |
| 5   | Robel       | Stephan     | 5       |

# Closing Comments

Here are some features I would like to implement, given that I had enough time:

* view only graduated students
* view only current students
* edit graduation_timestamp trigger so that a student is only marked as graduated if they have actually passed (2.0+) 8 graduate classes
* proper update functions
* test for valid input

# Credits

Thank you to [Faker](https://github.com/stympy/faker), a Ruby gem that generates Fake names, etc. for generating the university name, advisor names, and (conditionally) student names.
