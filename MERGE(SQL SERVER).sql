MERGE target_table USING source_table 
ON merge_condition 
WHEN MATCHED 
    THEN update_statement 
WHEN NOT MATCHED 
    THEN insert_statement 
WHEN NOT MATCHED BY SOURCE  
    THEN DELETE; 
