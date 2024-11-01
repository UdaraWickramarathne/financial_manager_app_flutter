class Transaction {
  final String title;
  final String category;
  final double amount;
  final String date;
  final bool isIncome;

  Transaction({
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
    required this.isIncome,
  });
}

List<Transaction> transactions = [
  Transaction(
    title: 'COD BO 6',
    category: 'Entertainment',
    amount: 20000,
    date: '2024-06-04', // '04 June' => '2024-06-04'
    isIncome: false,
  ),
  Transaction(
    title: 'Ice Cream',
    category: 'Food',
    amount: 100,
    date: '2024-06-04',
    isIncome: false,
  ),
  Transaction(
    title: 'Grocery Shopping',
    category: 'Food',
    amount: 1500,
    date: '2024-10-01', // '01 October' => '2024-10-01'
    isIncome: false,
  ),
  Transaction(
    title: 'Gym Membership',
    category: 'Health',
    amount: 3000,
    date: '2024-10-05', // '05 October' => '2024-10-05'
    isIncome: false,
  ),
  Transaction(
    title: 'Bus Fare',
    category: 'Transport',
    amount: 250,
    date: '2024-10-06', // '06 October' => '2024-10-06'
    isIncome: false,
  ),
  Transaction(
    title: 'Concert Tickets',
    category: 'Entertainment',
    amount: 4000,
    date: '2024-10-10', // '10 October' => '2024-10-10'
    isIncome: false,
  ),
  Transaction(
    title: 'Children’s Toys',
    category: 'Kids',
    amount: 80,
    date: '2024-10-12', // '12 October' => '2024-10-12'
    isIncome: false,
  ),
  Transaction(
    title: 'Shopping Spree',
    category: 'Shopping',
    amount: 2500,
    date: '2024-10-15', // '15 October' => '2024-10-15'
    isIncome: false,
  ),
  Transaction(
    title: 'Salary Received',
    category: 'Income',
    amount: 50000,
    date: '2024-10-20', // '20 October' => '2024-10-20'
    isIncome: true,
  ),
  Transaction(
    title: 'Dinner Out',
    category: 'Food',
    amount: 1200,
    date: '2024-10-22', // '22 October' => '2024-10-22'
    isIncome: false,
  ),
];
