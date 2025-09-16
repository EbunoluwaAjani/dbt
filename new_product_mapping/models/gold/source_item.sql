With dedup_query as
(Select *,
ROW_NUMBER() OVER (PARTITION BY id ORDER BY UPDATETIME DESC) as dedup_id
FROM {{ source('source', 'item') }})

select id, name, category, updatetime from dedup_query
where dedup_id =1
