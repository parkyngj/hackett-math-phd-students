def add_advisor(lastname, firstname, field_id)
  $database.execute("INSERT INTO advisors (last_name, first_name, field) VALUES (?, ?, ?)", [lastname, firstname, field_id])
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