def child_age(my_age)
  my_age / 2
end

def current_money(my_age)
  child_age(my_age) ** 2
end

def remaining_years(my_age)
  65 - child_age(my_age)
end

def estimate_money(my_age)
  current_money(my_age) * remaining_years(my_age)
end

my_age = 50
p estimate_money(my_age)