#include <iostream>
#include <vector>
#include <memory>
using namespace std;

// main class for the program
class Product {
protected:
    string name;
    double price;
    int stock;

public:
    Product(string n, double p, int s) : name(n), price(p), stock(s) {}
    virtual ~Product() {}

    bool isAvailable() const { return stock > 0; }
    void updateStock(int amount) { stock += amount; }

    virtual double calculateDiscount() {
        return price;
    }

    virtual void getDetails() const = 0;
};

// vollyball subclass
class Volleyball : public Product {
    string material;
    int size;
    string netType;

public:
    Volleyball(string n, double p, int s, string m, int sz, string nt)
        : Product(n, p, s), material(m), size(sz), netType(nt) {}

    void getDetails() const override {
        cout << name << " | " << material
             << " | Size " << size
             << " | Net: " << netType << endl;
    }
};
//SoccerItem subclass
class SoccerItem : public Product {
    string material;
    int teamSize;

public:
    SoccerItem(string n, double p, int s, string m, int t)
        : Product(n, p, s), material(m), teamSize(t) {}

    double calculateDiscount() override {
        if (teamSize >= 10)
            return price * 0.8;
        return price;
    }

    void getDetails() const override {
        cout << name << " | " << material
             << " | Team Size: " << teamSize << endl;
    }
};

class Category {
    string name;
    vector<shared_ptr<Product>> products;

public:
    Category(string n) : name(n) {}

    void addProduct(shared_ptr<Product> p) {
        products.push_back(p);
    }

    void browseProducts() const {
        for (auto &p : products)
            p->getDetails();
    }
};

int main() {
    Category indoor("Indoor Sports");
    indoor.addProduct(make_shared<Volleyball>(
        "Pro Volleyball", 30.0, 10, "Leather", 5, "Professional"));

    Category outdoor("Outdoor Sports");
    outdoor.addProduct(make_shared<SoccerItem>(
        "Soccer Ball", 25.0, 20, "Synthetic", 11));

    indoor.browseProducts();
    outdoor.browseProducts();

    return 0;
}