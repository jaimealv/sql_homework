SELECT card_holder.id, card_holder.name, credit_card.card_number, credit_card.cardholder_id, 
	transactions.card_number
FROM card_holder
LEFT JOIN credit_card ON card_holder.id = credit_card.cardholder_id
LEFT JOIN transactions ON transactions.card_number = credit_card.card_number
GROUP BY card_holder.id, card_holder.name, credit_card.card_number, transactions.card_number
ORDER BY card_holder.name;


-- Isolate transactions of each cardholder by credit card
SELECT card_holder.id, card_holder.name, 
	transactions.card_number, COUNT(card_holder.id)
FROM card_holder
LEFT JOIN credit_card ON card_holder.id = credit_card.cardholder_id
LEFT JOIN transactions ON transactions.card_number = credit_card.card_number
GROUP BY card_holder.id, card_holder.name, transactions.card_number
ORDER BY card_holder.name;

-- Top 100 highest transactions during the time 7am to 9am
SELECT  amount, date
FROM transactions
WHERE date_part('hour',transactions.date) >= 7 AND date_part('hour',transactions.date) <= 9 
ORDER BY amount DESC
LIMIT 100

-- Transactions of less than $2.00 for each cardholder
SELECT card_holder.name, COUNT(transactions.amount) small_transactions
FROM card_holder
LEFT JOIN credit_card ON card_holder.id = credit_card.cardholder_id
LEFT JOIN transactions ON transactions.card_number = credit_card.card_number
WHERE transactions.amount < 2
GROUP BY card_holder.name
ORDER BY card_holder.name;

-- Amount of transactions of less than $2.00 for each merchant
SELECT merchant.merchant_name, COUNT(transactions.amount) small_transaction
FROM merchant
LEFT JOIN transactions ON merchant.id = transactions.merchant_id
WHERE transactions.amount < 2
GROUP BY merchant.merchant_name
ORDER BY merchant.merchant_name

-- Collect transaction data for cardholder IDs 2 & 8
SELECT card_holder.id, transactions.date, transactions.amount
FROM card_holder
LEFT JOIN credit_card ON card_holder.id = credit_card.cardholder_id
LEFT JOIN transactions ON transactions.card_number = credit_card.card_number
WHERE card_holder.id = 2
GROUP BY card_holder.id, transactions.date, transactions.amount
ORDER BY transactions.date;

-- Collect transaction data for cardholder ID 25 from January to June
SELECT card_holder.id, transactions.date, transactions.amount
FROM card_holder
LEFT JOIN credit_card ON card_holder.id = credit_card.cardholder_id
LEFT JOIN transactions ON transactions.card_number = credit_card.card_number
WHERE card_holder.id = 25 AND date_part('month',transactions.date) >= 1 AND date_part('month',transactions.date) <= 6 
GROUP BY card_holder.id, transactions.date, transactions.amount
ORDER BY transactions.date;

-- Collect all transactions for all cardholders
SELECT card_holder.id, transactions.amount
FROM card_holder
LEFT JOIN credit_card ON card_holder.id = credit_card.cardholder_id
LEFT JOIN transactions ON transactions.card_number = credit_card.card_number
GROUP BY card_holder.id, transactions.amount
ORDER BY card_holder.id;

