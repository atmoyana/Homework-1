from abc import ABC, abstractmethod

#main class for the program
class Product(ABC):
    def __init__(self, name, price, stock):
        self._name = name
        self._price = price
        self._stock = stock

    def is_available(self):
        return self._stock > 0

    def update_stock(self, amount):
        self._stock += amount

    @abstractmethod
    def get_details(self):
        pass

    def calculate_discount(self):
        return self._price


#Vollyball subclass
class Volleyball(Product):
    def __init__(self, name, price, stock, material, size, net_type):
        super().__init__(name, price, stock)
        self.material = material
        self.size = size
        self.net_type = net_type

    def get_details(self):
        return f"{self._name} | {self.material} | Size {self.size} | Net: {self.net_type}"


#SoccerItem subclass
class SoccerItem(Product):
    def __init__(self, name, price, stock, material, team_size):
        super().__init__(name, price, stock)
        self.material = material
        self.team_size = team_size

    def calculate_discount(self):
        if self.team_size >= 10:
            return self._price * 0.8
        return self._price

    def get_details(self):
        return f"{self._name} | {self.material} | Team Size: {self.team_size}"


class Category:
    def __init__(self, name):
        self.name = name
        self.products = []

    def add_product(self, product):
        self.products.append(product)

    def browse_products(self):
        for p in self.products:
            print(p.get_details())

# Example used
indoor = Category("Indoor Sports")
vb = Volleyball("Pro Volleyball", 30, 10, "Leather", 5, "Professional")
indoor.add_product(vb)

outdoor = Category("Outdoor Sports")
soccer = SoccerItem("Soccer Ball", 25, 20, "Synthetic", 11)
outdoor.add_product(soccer)

indoor.browse_products()
outdoor.browse_products()