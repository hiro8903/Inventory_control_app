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

create_paint("トリョウ01", 1, 1, 5000, "kg", 50)
create_paint("トリョウ02", 1, 1, 6000, "kg", 55)
create_paint("トリョウ03", 2, 1, 7000, "kg", 60)
create_paint("トリョウ04", 3, 2, 8000, "kg", 65)
create_paint("トリョウ05", 3, 2, 9000, "kg", 70)
create_paint("トリョウ06", 4, 2, 10000, "kg", 75)

# # 発注作成
# def create_order(order_on, paint_id, quantity, desired_on)
#   Order.create!(order_on: order_on, paint_id: paint_id, quantity: quantity, desired_on: desired_on )
# end

# create_order(Date.today, 1, 10000, Date.today.next_month)
# create_order(Date.today, 2, 10000, "")
# create_order(Date.today, 3, 10000, Date.today.next_month)
# create_order(Date.today, 4, 10000, Date.today.next_month)
# create_order(Date.today, 5, 10000, Date.today.next_month)
# create_order(Date.today.prev_month, 1, 20000, Date.today.end_of_month)
# create_order(Date.today.prev_month, 2, 20000, Date.today.end_of_month)
# create_order(Date.today.prev_month, 3, 20000, Date.today.end_of_month)
# create_order(Date.today.prev_month, 4, 20000, Date.today.end_of_month)
# create_order(Date.today.prev_month, 5, 20000, Date.today.end_of_month)
# create_order(Date.today.prev_month(n = 3), 1, 30000, Date.today.end_of_month)
# create_order(Date.today.prev_month(n = 3), 2, 30000, Date.today.end_of_month)
# create_order(Date.today.prev_month(n = 3), 3, 30000, Date.today.end_of_month)
# create_order(Date.today.prev_month(n = 3), 4, 30000, Date.today.end_of_month)
# create_order(Date.today.prev_month(n = 3), 5, 30000, Date.today.end_of_month)
# create_order(Date.today.prev_month(n = 4), 1, 40000, Date.today.end_of_month)
# create_order(Date.today.prev_month(n = 4), 2, 40000, Date.today.end_of_month)
# create_order(Date.today.prev_month(n = 4), 3, 40000, Date.today.end_of_month)
# create_order(Date.today.prev_month(n = 4), 4, 40000, Date.today.end_of_month)
# create_order(Date.today.prev_month(n = 4), 5, 40000, Date.today.end_of_month)

# # 回答作成
# def create_answer(answer_on, quantity, note, order_id)
#   Answer.create!(answer_on: answer_on, quantity: quantity, note: note, order_id: order_id )
# end

# create_answer(Date.today.next_month, 10000, "", 1)
# create_answer(Date.today.next_month, 1000, "", 2)
# create_answer(Date.today.prev_month(n = 3), 9000, "", 2)
# create_answer("", 9000, "10月末入荷予定", 3)

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

def create_order(order_on, quantity, desired_on, paint_id, answer_quantity, delivery_quantity)
  @order = Order.create!(order_on: order_on, quantity: quantity, desired_on: desired_on, paint_id: paint_id, )
  @answer = @order.answers.build(quantity: answer_quantity)
  @answer.save
  @delivery = @answer.deliverys.build(quantity: delivery_quantity)
  @delivery.save
end


create_order(Date.today.ago(3.days), 1000, Date.today.ago(3.days).next_month, 1, 1000, 1000)
create_order(Date.today.ago(2.days), 2000, Date.today.ago(2.days).next_month, 2, 2000, 2000)
