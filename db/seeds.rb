# 部署作成
def create_department(name)
  Department.create!(name: name)
end

create_department("購買部")
create_department("製造部A")
create_department("製造部B")
create_department("製造部C")

# 仕入先作成
def create_manufacturer(name)
  Manufacturer.create!(name: name)
end

create_manufacturer("メーカーA")
create_manufacturer("メーカーB")
create_manufacturer("メーカーC")
create_manufacturer("メーカーD")

# 仕入先作成
def create_supplier(name)
  Supplier.create!(name: name)
end

create_supplier("仕入先A")
create_supplier("仕入先B")
create_supplier("仕入先C")
create_supplier("仕入先D")

# 塗料作成
def create_paint(name, manufacturer_id, supplier_id, unit_price, unit, ordering_point)
  Paint.create!(name: name, manufacturer_id: manufacturer_id, supplier_id: supplier_id, unit_price: unit_price , unit: unit, ordering_point: ordering_point)
end

create_paint("トリョウ01", 1, 1, 5.0, "g", 50000)
create_paint("トリョウ02", 1, 1, 6.0, "g", 55000)
create_paint("トリョウ03", 2, 1, 7.0, "g", 60000)
create_paint("トリョウ04", 3, 2, 8.0, "g", 65000)
create_paint("トリョウ05", 3, 2, 9.0, "g", 70000)
create_paint("トリョウ06", 4, 2, 10.0, "g", 75000)

# 発注作成
def create_order(order_on, paint_id, quantity, desired_on)
  Order.create!(order_on: order_on, paint_id: paint_id, quantity: quantity, desired_on: desired_on )
end

create_order(Date.today, 1, 10000, Date.today.next_month)
create_order(Date.today, 2, 10000, Date.today.next_month)
create_order(Date.today, 3, 10000, Date.today.next_month)
create_order(Date.today, 4, 10000, Date.today.next_month)
create_order(Date.today, 5, 10000, Date.today.next_month)
create_order(Date.today.prev_month, 1, 10000, Date.today.end_of_month)

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


