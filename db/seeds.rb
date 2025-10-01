puts "\n== Seeding the database =="

# Create classrooms
math_class = Classroom.create!(name: "Math Class")
science_class = Classroom.create!(name: "Science Class")

# Create users with proper password encryption
# Math classroom users
math_teacher = User.create!(
  classroom: math_class,
  email: 'teacher@mathclass.com',
  password: 'password',
  user_type: 'teacher'
)

math_student = User.create!(
  classroom: math_class,
  email: 'student@mathclass.com',
  password: 'password',
  user_type: 'student'
)

# Science classroom user
science_student = User.create!(
  classroom: science_class,
  email: 'student@scienceclass.com',
  password: 'password',
  user_type: 'student'
)

# Create some echoes
Echo.create!(
  classroom: math_class,
  name: "Welcome to Math Class!",
  private: false
)

Echo.create!(
  classroom: math_class,
  name: "Today's homework assignment",
  private: false
)

Echo.create!(
  classroom: math_class,
  name: "Private teacher note",
  private: true
)

puts "Created #{Classroom.count} classrooms"
puts "Created #{User.count} users"
puts "Created #{Echo.count} echoes"
