def add_class(classname, field_id)
  $database.execute("INSERT INTO classes (name, field) VALUES (?, ?)", [classname, field_id])
end

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
