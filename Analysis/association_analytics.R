# GamePad Gaussians - Association Analytics
# Created: 2017-03-07

# Initialize libraries
library(arules)
library(arulesViz)

# Support
itemFrequency(keypress_transactions)

# Frequent n-itemsets
itemsets <- apriori(keypress_transactions, parameter = list(minlen = 1, maxlen = 5, support = 0.00001, target="frequent itemsets"))
summary(itemsets)

session_associations <- inspect(head(sort(itemsets, by = "support"), 100))
session_associations

# Write data
# write.table(x = global_associations, file = "J4_global_associations.tsv", sep = "\t")


# Interval subsets
#interval_itemsets <- apriori(trans[2237:2972], parameter = list(minlen = 1, maxlen = 5, support = 0.00001, target="frequent itemsets"))
#summary(interval_itemsets)

#inspect(head(sort(interval_itemsets, by = "support"), 100))

