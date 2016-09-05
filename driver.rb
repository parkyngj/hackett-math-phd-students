# User interface file for Math PhD Students Database

require 'sqlite3'
require 'csv'
require_relative 'students'
require_relative 'advisors'
require_relative 'classes'
require_relative 'grades'
require_relative 'fields'

$database = SQLite3::Database.new("hmps.db")
$database.results_as_hash = true

$database.execute("CREATE TABLE IF NOT EXISTS students(
  id INTEGER PRIMARY KEY,
  last_name VARCHAR(255),
  first_name VARCHAR(255),
  advisor INT,
  field INT,
  gpa FLOAT,
  matriculation_date DATE,
  graduation_date DATE,
  FOREIGN KEY (advisor) REFERENCES advisors(id)
  FOREIGN KEY (field) REFERENCES fields(id)
  )"
)

$database.execute("CREATE TABLE IF NOT EXISTS advisors(
  id INTEGER PRIMARY KEY,
  last_name VARCHAR(255),
  first_name VARCHAR(255),
  field INT,
  FOREIGN KEY (field) REFERENCES fields(id)
  )"
)

$database.execute("CREATE TABLE IF NOT EXISTS classes(
  id INTEGER PRIMARY KEY,
  name VARCHAR(255),
  field INT,
  FOREIGN KEY (field) REFERENCES fields(id)
  )"
)

$database.execute("CREATE TABLE IF NOT EXISTS grades(
  id INTEGER PRIMARY KEY,
  student INT,
  class INT,
  grade FLOAT,
  date_given DATE,
  FOREIGN KEY (student) REFERENCES students(id),
  FOREIGN KEY (class) REFERENCES classes(id)
  )"
)

$database.execute("CREATE TABLE IF NOT EXISTS fields(
  id INTEGER PRIMARY KEY,
  name VARCHAR(255)
  )"
)

# PRE-POPULATE fields TABLE

$database.execute(
  "INSERT INTO fields (name)
  SELECT 'Algebra'
  WHERE NOT EXISTS (SELECT 1 FROM fields WHERE name='Algebra');"
  )

$database.execute(
  "INSERT INTO fields (name)
  SELECT 'Analysis'
  WHERE NOT EXISTS (SELECT 1 FROM fields WHERE name='Analysis');"
  )

$database.execute(
  "INSERT INTO fields (name)
  SELECT 'Applied Math'
  WHERE NOT EXISTS (SELECT 1 FROM fields WHERE name='Applied Math');"
  )

$database.execute(
  "INSERT INTO fields (name)
  SELECT 'Logic'
  WHERE NOT EXISTS (SELECT 1 FROM fields WHERE name='Logic');"
  )

$database.execute(
  "INSERT INTO fields (name)
  SELECT 'Topology'
  WHERE NOT EXISTS (SELECT 1 FROM fields WHERE name='Topology');"
  )

# PRE-POPULATE advisors TABLE

$database.execute(
  "INSERT INTO advisors (last_name, first_name, field)
  SELECT 'Blanda', 'Adrienne', 1
  WHERE NOT EXISTS (SELECT 1 FROM advisors WHERE last_name='Blanda' AND first_name='Adrienne' AND field='1');
  "
  )

$database.execute(
  "INSERT INTO advisors (last_name, first_name, field)
  SELECT 'Kassulke', 'Grant', 2
  WHERE NOT EXISTS (SELECT 1 FROM advisors WHERE last_name='Kassulke' AND first_name='Grant' AND field='2');
  "
  )

$database.execute(
  "INSERT INTO advisors (last_name, first_name, field)
  SELECT 'Mertz', 'Damaris', 3
  WHERE NOT EXISTS (SELECT 1 FROM advisors WHERE last_name='Mertz' AND first_name='Damaris' AND field='3');
  "
  )

$database.execute(
  "INSERT INTO advisors (last_name, first_name, field)
  SELECT 'Ratke', 'Jerad', 4
  WHERE NOT EXISTS (SELECT 1 FROM advisors WHERE last_name='Ratke' AND first_name='Jerad' AND field='4');
  "
  )

$database.execute(
  "INSERT INTO advisors (last_name, first_name, field)
  SELECT 'Robel', 'Stephan', 5
  WHERE NOT EXISTS (SELECT 1 FROM advisors WHERE last_name='Robel' AND first_name='Stephan' AND field='5');
  "
  )

# PRE-POPULATE classes TABLE

$database.execute(
  "INSERT INTO classes (name, field)
  SELECT 'Groups, Rings, Fields', 1
  WHERE NOT EXISTS (SELECT 1 FROM classes WHERE name='Groups, Rings, Fields' AND field='1');
  "
  )

$database.execute(
  "INSERT INTO classes (name, field)
  SELECT 'Homological Algebra', 1
  WHERE NOT EXISTS (SELECT 1 FROM classes WHERE name='Homological Algebra' AND field='1');
  "
  )

$database.execute(
  "INSERT INTO classes (name, field)
  SELECT 'Algebraic Geometry', 1
  WHERE NOT EXISTS (SELECT 1 FROM classes WHERE name='Algebraic Geometry' AND field='1');
  "
  )

$database.execute(
  "INSERT INTO classes (name, field)
  SELECT 'Measure Theory', 2
  WHERE NOT EXISTS (SELECT 1 FROM classes WHERE name='Measure Theory' AND field='2');
  "
  )

$database.execute(
  "INSERT INTO classes (name, field)
  SELECT 'Harmonic Analysis', 2
  WHERE NOT EXISTS (SELECT 1 FROM classes WHERE name='Harmonic Analysis' AND field='2');
  "
  )

$database.execute(
  "INSERT INTO classes (name, field)
  SELECT 'Differentiable Manifolds', 2
  WHERE NOT EXISTS (SELECT 1 FROM classes WHERE name='Differentiable Manifolds' AND field='2');
  "
  )

$database.execute(
  "INSERT INTO classes (name, field)
  SELECT 'Differential Equations', 3
  WHERE NOT EXISTS (SELECT 1 FROM classes WHERE name='Differential Equations' AND field='3');
  "
  )

$database.execute(
  "INSERT INTO classes (name, field)
  SELECT 'Stochastic Processes', 3
  WHERE NOT EXISTS (SELECT 1 FROM classes WHERE name='Stochastic Processes' AND field='3');
  "
  )

$database.execute(
  "INSERT INTO classes (name, field)
  SELECT 'Numerical Analysis', 3
  WHERE NOT EXISTS (SELECT 1 FROM classes WHERE name='Numerical Analysis' AND field='3');
  "
  )

$database.execute(
  "INSERT INTO classes (name, field)
  SELECT 'Riemannian Geometry', 4
  WHERE NOT EXISTS (SELECT 1 FROM classes WHERE name='Riemannian Geometry' AND field='4');
  "
  )

$database.execute(
  "INSERT INTO classes (name, field)
  SELECT 'Complex Geometry', 4
  WHERE NOT EXISTS (SELECT 1 FROM classes WHERE name='Complex Geometry' AND field='4');
  "
  )

$database.execute(
  "INSERT INTO classes (name, field)
  SELECT 'Symplectic Geometry', 4
  WHERE NOT EXISTS (SELECT 1 FROM classes WHERE name='Symplectic Geometry' AND field='4');
  "
  )

$database.execute(
  "INSERT INTO classes (name, field)
  SELECT 'Metamathematics', 5
  WHERE NOT EXISTS (SELECT 1 FROM classes WHERE name='Metamathematics' AND field='5');
  "
  )

$database.execute(
  "INSERT INTO classes (name, field)
  SELECT 'Recursion Theory', 5
  WHERE NOT EXISTS (SELECT 1 FROM classes WHERE name='Recursion Theory' AND field='5');
  "
  )

$database.execute(
  "INSERT INTO classes (name, field)
  SELECT 'Model Theory', 5
  WHERE NOT EXISTS (SELECT 1 FROM classes WHERE name='Model Theory' AND field='5');
  "
  )

# triggers

# trigger to automatically set graduation date after student has taken 8 classes

$database.execute(
  "CREATE TRIGGER IF NOT EXISTS set_grad_date AFTER INSERT ON grades
  WHEN 8=(SELECT count(*) FROM grades WHERE student=(SELECT student FROM grades WHERE id=(select max(id) from grades)))
  BEGIN
    UPDATE students SET graduation_date=(SELECT date_given FROM grades WHERE id=(select max(id) FROM grades)) WHERE id=(SELECT student FROM grades WHERE id=(SELECT max(id) FROM grades));
  END;
  "
  )

# trigger to automatically calculate a student's gpa after a student takes a class

$database.execute(
  "CREATE TRIGGER IF NOT EXISTS gpa_calc AFTER INSERT ON grades
  BEGIN
    UPDATE students
    SET gpa=(SELECT sum(grade) FROM grades total WHERE student=(SELECT student FROM grades WHERE id=(SELECT max(id) FROM grades)))/(SELECT count(*) FROM grades WHERE student=(SELECT STUDENT FROM grades WHERE id=(SELECT max(id) FROM grades)))
    WHERE id=(SELECT STUDENT FROM grades WHERE id=(SELECT max(id) FROM grades));
  END;
  "
  )

# functions for adding entries

def add_student(lastname, firstname, advisor_id, field_id, matrdate = Time.now.strftime("%Y-%m-%d"))
  $database.execute("INSERT INTO students (last_name, first_name, advisor, field, matriculation_date) VALUES (?, ?, ?, ?, ?)", [lastname, firstname, advisor_id, field_id, matrdate])
end

def add_grade(student_id, class_id, grade, date = Time.now.strftime("%Y-%m-%d"))
  $database.execute("INSERT INTO grades (student, class, grade, date_given) VALUES (?, ?, ?, ?)", [student_id, class_id, grade, date])
end

def add_class(classname, field_id)
  $database.execute("INSERT INTO classes (name, field) VALUES (?, ?)", [classname, field_id])
end

def add_advisor(lastname, firstname, field_id)
  $database.execute("INSERT INTO advisors (last_name, first_name, field) VALUES (?, ?, ?)", [lastname, firstname, field_id])
end

# functions for viewing entries

add_student('Park', "David", 1, 1)
add_student('Stokes', "Nathan", 2, 2, "2015-05-18")

def view_students
  puts "================================\nALL STUDENTS\n================================"
  select_query = $database.execute("select students.id, students.last_name, students.first_name, advisors.last_name, fields.name, students.gpa, students.matriculation_date, students.graduation_date from students join advisors on students.advisor=advisors.id join fields on students.field=fields.id;")

  refined_select_query = []

  select_query.each_with_index do |student|
    refined_student = student.drop_while {|k,v| k!= 0}
    refined_select_query << refined_student
  end

  columns = ["Student ID", "Last Name", "First Name", "Advisor", "Specialization", "GPA", "Matriculation Date", "Graduation Date"]

  refined_select_query.each_with_index do |student, idx|
    columns.each_with_index do |column, i|
      puts "#{column}: #{student[i][1]}"
    end

  puts "--------------------------------" if idx<select_query.length-1
  end
end


def view_advisors
  puts "================================\nALL ADVISORS\n================================"
  select_query = $database.execute("select advisors.id, advisors.last_name, advisors.first_name, fields.name from advisors join fields on advisors.field = fields.id;")

  columns = ["Advisor ID", "Last Name", "First Name", "Specialization"]


  select_query.each_with_index do |prof, idx|
    columns.each_with_index do |column, i|
      puts "#{column}: #{prof.values[i]}"
    end

  puts "--------------------------------" if idx<select_query.length-1
  end
end

view_advisors

def view_classes
  puts "================================\nALL CLASSES\n================================"
  select_query = $database.execute("select classes.id, classes.name, fields.name from classes join fields where classes.field=fields.id;")

  refined_select_query = []

  select_query.each_with_index do |cla|
    refined_class = cla.drop_while {|k,v| k!= 0}
    refined_select_query << refined_class
  end

  columns = ["Course ID", "Course Name", "Field of Math"]

  refined_select_query.each_with_index do |cla, idx|
    columns.each_with_index do |column, i|
      puts "#{column}: #{cla[i][1]}"
    end

  puts "--------------------------------" if idx<select_query.length-1
  end
end


def view_fields
  puts "================================\nALL FIELDS\n================================"
  all_fields = $database.execute("SELECT * FROM fields")
  
  columns = ["Field ID", "Field Name"]

  all_fields.each_with_index do |field, idx|
    columns.each_with_index do |column, i|
      puts "#{column}: #{field.values[i]}"
    end
    puts "--------------------------------" if idx<all_fields.length-1
  end
end

add_grade(1, 4, 3.5)
8.times do add_grade(2, 9, 3.7, "2015-12-14") end

def view_grades
  puts "================================\nALL GRADES\n================================"
  select_query = $database.execute("select grades.id, students.id, students.last_name, students.first_name, classes.name, grades.grade, grades.date_given from grades join students on grades.student = students.id join classes on grades.class = classes.id;")

  refined_select_query = []

  select_query.each_with_index do |student|
    refined_student = student.drop_while {|k,v| k!= 0}
    refined_select_query << refined_student
  end

  columns = ["Grade Entry ID", "Student ID", "Last Name", "First Name", "Class", "Grade", "Date Given"]

  refined_select_query.each_with_index do |grade, idx|
    columns.each_with_index do |column, i|
      puts "#{column}: #{grade[i][1]}"
    end

  puts "--------------------------------" if idx<select_query.length-1
  end
end

# more pinpointed functions for viewing entries

def view_student_by_id(idnum)
  selected_student = $database.execute("SELECT * FROM students WHERE id=?", [idnum])

  students_schema = $database.execute("PRAGMA table_info(students)")

  students_columns_ary = []
  students_schema.each do |column|
    students_columns_ary << column['name']
  end

  students_columns_ary.each_with_index do |column, idx|
    puts "#{column} : #{selected_student[0][idx]}"
  end  
end

def view_student_by_name(lastname, firstname)
  selected_student = $database.execute("SELECT * FROM students WHERE last_name = ? AND first_name = ?", [lastname, firstname])

  students_schema = $database.execute("PRAGMA table_info(students)")

  students_columns_ary = []
  students_schema.each do |column|
    students_columns_ary << column['name']
  end

  students_columns_ary.each_with_index do |column, idx|
    puts "#{column} : #{selected_student[0][idx]}"
  end
end

def view_students_by_field(field_id)
  selected_students = $database.execute("SELECT * FROM students WHERE field = ?", [field_id])
  students_schema = $database.execute("PRAGMA table_info(students)")

  students_columns_ary = []
  students_schema.each do |column|
    students_columns_ary << column['name']
  end

  selected_students.each_with_index do |student, idx|
    students_columns_ary.each_with_index do |column, i|
      puts "#{column} : #{student.values[i]}"
    end
    puts "----------------"
  end
end

def view_students_by_advisor(advisor_id)
  selected_students = $database.execute("SELECT * FROM students WHERE advisor=?", [advisor_id])
  students_schema = $database.execute("PRAGMA table_info(students)")

  students_columns_ary = []
  students_schema.each do |column|
    students_columns_ary << column['name']
  end

  selected_students.each_with_index do |student, idx|
    students_columns_ary.each_with_index do |column, i|
      puts "#{column} : #{student.values[i]}"
    end
    puts "----------------"
  end
end

def view_student_grades(student_id)
  selected_grades = $database.execute("SELECT * FROM grades WHERE student=?", [student_id])
  grades_schema = $database.execute("PRAGMA table_info(grades)")

  grades_columns_ary = []
  grades_schema.each do |column|
    grades_columns_ary << column['name']
  end

  selected_grades.each_with_index do |grade, idx|
    grades_columns_ary.each_with_index do |column, i|
      puts "#{column} : #{grade.values[i]}"
    end
    puts "----------------"
  end
end