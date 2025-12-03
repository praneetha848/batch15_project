{{ config(materialized='table') }}

WITH supplier_parts AS (
SELECT s.SUPPKEY,s.NAME,
s.nationkey AS nation_key,
s.acctbal AS account_balance,
PS.availqty AS available_quantity,
PS.supplycost AS supply_cost,
p.partkey AS part_key,
p.name AS part_name,
p.mfgr AS part_manufacturer,
p.brand AS part_brand,
p.type AS part_type,
p.p_size AS part_size,
p.container AS part_container,
p.retailprice AS part_retail_price
FROM {{ref('stg_supplier')}} s
JOIN {{ref('stg_partsupp')}} ps
ON s.suppkey= ps.suppkey
JOIN {{ref('stg_part')}} p
ON ps.partkey= p.partkey
)
SELECT * FROM supplier_parts