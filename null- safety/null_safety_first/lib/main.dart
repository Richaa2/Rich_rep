// Sound Null Safety

// Positional mandatory  = f(int x)
// Positional optional   = f([int x])
// Named optional        = f({int x})
// Named mandatory       = ???

void main() {
  var pizza = Pizza(name: 'Spring');
  print(pizza.printPizza());
}

class Pizza {
  final int id;
  final String name;
  final double? price;

  Pizza({
    //this.id,
    required this.name,
    this.price = 10,
  }) : id = 1;

  String printPizza() {
    print('Coocking pizza...');
    return 'Pizza ($id): $name, price ${price ?? 'No price'}';
  }
}
