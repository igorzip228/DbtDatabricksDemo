{{ config(materialized='table') }}

WITH new_table AS (
    SELECT 
        e.id,
        e.name,
        e.salary,
        ed.department,
        ed.hire_date,
        ed.position
    FROM 
        {{ source('databricks_source', 'employee') }} e
    LEFT JOIN 
        {{ source('databricks_source', 'employee_details') }} ed 
        ON e.id = ed.employee_id
)

SELECT 
    id,
    name,
    salary,
    department,
    hire_date,
    position
FROM new_table
ORDER BY id