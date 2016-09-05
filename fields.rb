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