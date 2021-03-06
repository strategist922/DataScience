-- Show time needed to execute each command 
\timing on 

-- Make the output of relations look slightly nicer 
\pset border 2 

-- Echo all input taken from a script file 
-- using the \i command or the --file=... command line option 
\set ECHO all

-- 1. What is the category of the item (whose description is) 'BUDWEISER CAN'?

SELECT item_des,categ_name FROM item WHERE item_des='BUDWEISER CAN';

-- 2. How many fluid ounces are in the item 'HEINEKEN LAGER' and what is the category?

SELECT item_des,item_unt_qty,categ_name FROM item WHERE item_des='HEINEKEN LAGER';

-- 3. How many stores are there in the sample?


SELECT COUNT(store_num) AS number_of_store FROM store;


-- 4. How many departments are there in the sample?

SELECT COUNT(DISTINCT(dept_num)) AS number_of_department FROM item;

-- 5. How many stores in the sample are in New York state?

SELECT store_state,COUNT(store_num) AS number_of_store_in_NY FROM store WHERE store_state='NY' GROUP BY store_state;

-- 6. How many stores are there in the POS transactions?

SELECT COUNT(DISTINCT(store_num)) AS number_of_store_in_postrans FROM postrans;

-- 7. What is the range of POS transaction dates in the sample?

SELECT MIN(trans_date) AS start_dates,MAX(trans_date) AS end_dates FROM postrans;

-- 8. How many transaction entries are there from the WEGMANS MARKETPLACE store?

SELECT S.store_name,COUNT(*) AS transaction_entries_in_WEGMANS_MARKETPLACE_store 
FROM store AS S,postrans AS P 
WHERE P.store_num = S.store_num AND S.store_name='WEGMANS MARKETPLACE' GROUP BY S.store_name;

-- 9. Which stores (number, name, city and state), sorted by city and state, are not in the POS transactions?

SELECT S.store_num,S.store_name,S.store_city,S.store_state 
FROM STORE AS S 
WHERE S.store_num NOT IN (SELECT postrans.store_num FROM postrans) ORDER BY S.store_state,S.store_city;

-- 10. How much did the combined sample households spend during the first 15 days of 2014 versus the last 15 days of 2013?
(SELECT MIN(trans_date) AS start_date,MAX(trans_date) AS end_date,SUM(net_sales) AS sales
FROM postrans
WHERE trans_date>='2014-01-01'::DATE AND trans_date<'2014-01-16'::DATE)
UNION
(SELECT MIN(trans_date) AS start_date,MAX(trans_date) AS end_date,SUM(net_sales) AS sales
FROM postrans
WHERE trans_date>='2013-12-17'::DATE AND trans_date<'2014-01-01'::DATE);
