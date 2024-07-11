class Pizza {
  final String image;
  final String title;
  final String subtitle;
  final String description;
  final double price;
  int quantity;
  final int index;

  Pizza({
    required this.index,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.price,
    required this.quantity,
  });
}

List<Pizza> pizzas = [
  Pizza(
    index: 0,
    image: 'assets/images/margherita.png',
    title: 'Margherita',
    subtitle: 'Classic delight',
    description: 'This pizza celebrates the rich and bold flavors of black olives paired with a medley of cheeses. The deep, earthy taste of black olives harmonizes beautifully with the creamy, melted cheeses.',
    price: 8.99,
    quantity: 1,
  ),
  Pizza(
    index: 1,
    image: 'assets/images/pepperoni.png',
    title: 'Pepperoni',
    subtitle: 'Spicy and cheesy',
    description: 'The combination of perfectly melted mozzarella cheese, tangy tomato sauce, and a crispy yet chewy crust creates a harmonious balance that leaves you wanting more. ',
    price: 10.99,
    quantity: 0,
  ),
  Pizza(
    index: 2,
    image: 'assets/images/veggie.png',
    title: 'Veggie Supreme',
    subtitle: 'Garden fresh',
    description: 'This pizza showcases the perfect combination of shrimp and cheese, with gooey melted cheeses complementing the savory shrimp toppings for a truly indulgent experience.',
    price: 9.99,
    quantity: 2,
  ),
  Pizza(
    index: 3,
    image: 'assets/images/bbq_chicken.png',
    title: 'BBQ Chicken',
    subtitle: 'Smoky and savory',
    description: 'The combination of perfectly melted mozzarella cheese, tangy tomato sauce, and a crispy yet chewy crust creates a harmonious balance that leaves you wanting more. ',
    price: 11.99,
    quantity: 3,
  ),
  Pizza(
    index: 4,
    image: 'assets/images/hawaiian.png',
    title: 'Hawaiian',
    subtitle: 'Tropical treat',
    description: 'A sweet and savory combination of pineapple and ham.',
    price: 10.49,
    quantity: 0,
  ),
  Pizza(
    index: 4,
    image: 'assets/images/meat_lovers.png',
    title: 'Meat Lovers',
    subtitle: 'Hearty and satisfying',
    description: 'A meat lover\'s dream with sausage, ham, pepperoni, and bacon.',
    price: 12.99,
    quantity: 1,
  ),
];
