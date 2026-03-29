--Q1
SELECT customers.customer_id, customers.email, campaign_sends.customer_id, campaign_sends.send_date
FROM EXERCISE9.PUBLIC.customers_d customers
JOIN EXERCISE9.PUBLIC.campaign_sends ON customers.customer_id = campaign_sends.customer_id;


--Q2
SELECT customers.email, cs.customer_id,
    CASE
        WHEN cc.send_id IS NOT NULL THEN TRUE
        ELSE FALSE
    END AS clicked
FROM EXERCISE9.PUBLIC.customers_d customers
JOIN EXERCISE9.PUBLIC.campaign_sends cs ON customers.customer_id = cs.customer_id
LEFT JOIN EXERCISE9.PUBLIC.clicks cc ON cs.send_id = cc.send_id;

--Q3
SELECT 
cs.send_id,
    CASE 
        WHEN cl.send_id IS NOT NULL THEN TRUE
        ELSE FALSE
    END AS clicked
FROM EXERCISE9.PUBLIC.campaign_sends cs
LEFT JOIN EXERCISE9.PUBLIC.clicks cl 
    ON cs.send_id = cl.send_id;
--Q4
--this one is looking for an antijoin where there isn't a send id for the clicks table. 
SELECT cs.send_id
FROM EXERCISE9.PUBLIC.campaign_sends cs
LEFT JOIN EXERCISE9.PUBLIC.clicks cl ON cs.send_id = cl.send_id
WHERE cl.click_id IS NULL;
--Q5
SELECT  c.email
FROM EXERCISE9.PUBLIC.customers_d c
LEFT JOIN EXERCISE9.PUBLIC.campaign_sends cs ON c.customer_id = cs.customer_id
WHERE cs.send_date IS NULL --this checks for the empty values