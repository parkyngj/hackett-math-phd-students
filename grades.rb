def add_grade(student_id, class_id, grade, date = Time.now.strftime("%Y-%m-%d"))
  $database.execute("INSERT INTO grades (student, class, grade, date_given) VALUES (?, ?, ?, ?)", [student_id, class_id, grade, date])
end

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

def view_student_grades(student_id)
  puts "================================\nSearch Grades By Student ID: #{student_id}\n================================"
  selected_grades = $database.execute("select grades.id, classes.name, grades.grade, grades.date_given from grades join classes on grades.class = classes.id where grades.student=?", [student_id])

  refined_selected_grades = []

  selected_grades.each_with_index do |grade|
    refined_grade = grade.drop_while {|k,v| k!= 0}
    refined_selected_grades << refined_grade
  end

  columns = ["Grade Entry ID", "Class", "Grade", "Date Given"]

  refined_selected_grades.each_with_index do |grade, idx|
    columns.each_with_index do |column, i|
      puts "#{column}: #{grade[i][1]}"
    end

  puts "--------------------------------" if idx<refined_selected_grades.length-1
  end
end