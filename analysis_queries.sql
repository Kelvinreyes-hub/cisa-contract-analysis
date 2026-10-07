-- CISA FY2025 Contract Spending Analysis
-- Source: USAspending.gov transaction-level contract data

-- 1. Top contract recipients
SELECT
  recipient_name,
  COUNT(*) AS transaction_count,
  ROUND(SUM(federal_action_obligation), 2) AS net_obligations
FROM `contract-analysis-509121.security_portfolio.Cisa_contract_transactions`
WHERE action_date BETWEEN '2024-10-01' AND '2025-09-30'
GROUP BY recipient_name
ORDER BY net_obligations DESC
LIMIT 15;


-- 2. Largest service categories
SELECT
  product_or_service_code_description,
  COUNT(*) AS transaction_count,
  ROUND(SUM(federal_action_obligation), 2) AS net_obligations
FROM `contract-analysis-509121.security_portfolio.Cisa_contract_transactions`
WHERE action_date BETWEEN '2024-10-01' AND '2025-09-30'
  AND product_or_service_code_description IS NOT NULL
GROUP BY product_or_service_code_description
ORDER BY net_obligations DESC
LIMIT 15;


-- 3. Competition type
SELECT
  COALESCE(extent_competed, 'Not reported') AS competition_type,
  COUNT(*) AS transaction_count,
  ROUND(SUM(federal_action_obligation), 2) AS net_obligations
FROM `contract-analysis-509121.security_portfolio.Cisa_contract_transactions`
WHERE action_date BETWEEN '2024-10-01' AND '2025-09-30'
GROUP BY competition_type
ORDER BY net_obligations DESC;


-- 4. Monthly obligations
SELECT
  FORMAT_DATE('%Y-%m', action_date) AS month,
  COUNT(*) AS transaction_count,
  ROUND(SUM(federal_action_obligation), 2) AS net_obligations
FROM `contract-analysis-509121.security_portfolio.Cisa_contract_transactions`
WHERE action_date BETWEEN '2024-10-01' AND '2025-09-30'
GROUP BY month
ORDER BY month;
