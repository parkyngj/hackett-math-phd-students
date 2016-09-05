def add_student(lastname, firstname, advisor_id, field_id, matrdate = Time.now.strftime("%Y-%m-%d"))
  $database.execute("INSERT INTO students (last_name, first_name, advisor, field, matriculation_date) VALUES (?, ?, ?, ?, ?)", [lastname, firstname, advisor_id, field_id, matrdate])
end

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

def search_student_by_id(idnum)
  puts "================================\nSearch Students By ID: #{idnum}\n================================"
  selected_student = $database.execute("select students.id, students.last_name, students.first_name, advisors.last_name, fields.name, students.gpa, students.matriculation_date, students.graduation_date from students join advisors on students.advisor=advisors.id join fields on students.field=fields.id where students.id = ?", [idnum])

  refined_selected_student = []

  selected_student.each_with_index do |student|
    refined_student = student.drop_while {|k,v| k!= 0}
    refined_selected_student << refined_student
  end

  columns = ["Student ID", "Last Name", "First Name", "Advisor Last Name", "Specialty", "GPA", "Matriculation Date", "Graduation Date"]

  refined_selected_student.each_with_index do |student, idx|
    columns.each_with_index do |column, i|
      puts "#{column}: #{student[i][1]}"
    end

  puts "--------------------------------" if idx<refined_selected_student.length-1
  end
end

def search_students_by_name(lastname, firstname)
  puts "================================\nSearch Students By Name: #{lastname}, #{firstname}\n================================"
  selected_students = $database.execute("select students.id, students.last_name, students.first_name, advisors.last_name, fields.name, students.gpa, students.matriculation_date, students.graduation_date from students join advisors on students.advisor=advisors.id join fields on students.field=fields.id where students.last_name=? and students.first_name=?", [lastname, firstname])

  refined_selected_students = []

  selected_students.each_with_index do |student|
    refined_student = student.drop_while {|k,v| k!= 0}
    refined_selected_students << refined_student
  end

  columns = ["Student ID", "Last Name", "First Name", "Advisor Last Name", "Specialty", "GPA", "Matriculation Date", "Graduation Date"]

  refined_selected_students.each_with_index do |student, idx|
    columns.each_with_index do |column, i|
      puts "#{column}: #{student[i][1]}"
    end

  puts "--------------------------------" if idx<refined_selected_students.length-1
  end
end

def search_students_by_field(field_id)
  puts "================================\nSearch Students By Field ID: #{field_id}\n================================"
  selected_students = $database.execute("select students.id, students.last_name, students.first_name, advisors.last_name, fields.name, students.gpa, students.matriculation_date, students.graduation_date from students join advisors on students.advisor=advisors.id join fields on students.field=fields.id where students.field=?", [field_id])

  refined_selected_students = []

  selected_students.each_with_index do |student|
    refined_student = student.drop_while {|k,v| k!= 0}
    refined_selected_students << refined_student
  end

  columns = ["Student ID", "Last Name", "First Name", "Advisor Last Name", "Specialty", "GPA", "Matriculation Date", "Graduation Date"]

  refined_selected_students.each_with_index do |student, idx|
    columns.each_with_index do |column, i|
      puts "#{column}: #{student[i][1]}"
    end

  puts "--------------------------------" if idx<refined_selected_students.length-1
  end
end


def search_students_by_advisor(advisor_id)
  puts "================================\nSearch Students By Advisor ID: #{advisor_id}\n================================"
  selected_students = $database.execute("select students.id, students.last_name, students.first_name, advisors.last_name, fields.name, students.gpa, students.matriculation_date, students.graduation_date from students join advisors on students.advisor=advisors.id join fields on students.field=fields.id where students.advisor=?", [advisor_id])

  refined_selected_students = []

  selected_students.each_with_index do |student|
    refined_student = student.drop_while {|k,v| k!= 0}
    refined_selected_students << refined_student
  end

  columns = ["Student ID", "Last Name", "First Name", "Advisor Last Name", "Specialty", "GPA", "Matriculation Date", "Graduation Date"]

  refined_selected_students.each_with_index do |student, idx|
    columns.each_with_index do |column, i|
      puts "#{column}: #{student[i][1]}"
    end

  puts "--------------------------------" if idx<refined_selected_students.length-1
  end
end