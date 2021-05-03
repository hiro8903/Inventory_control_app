# 部署作成
def create_department(name)
  Department.create!(name: name)
end

create_department("購買部")
create_department("製造部A")
create_department("製造部B")
create_department("製造部C")

# メーカー作成
def create_manufacturer(name)
  Manufacturer.create!(name: name)
end

create_manufacturer("メーカーA")
create_manufacturer("メーカーB")
create_manufacturer("メーカーC")
create_manufacturer("メーカーD")

# ユーザー作成

User.create!(name: "Example User",
            email: "example@railstutorial.org",
            password: "foobar",
            password_confirmation: "foobar",
            admin: true,
            department_id: 1)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  department_id = rand(2..4)
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password,
    department_id: department_id)
end


