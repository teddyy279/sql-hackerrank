SELECT <các_cột_không_xoay>, [cột_1], [cột_2], ...
FROM (
    SELECT <cột_nguồn>
    FROM <bảng_gốc>
) AS SourceTable
PIVOT (
    <hàm_tổng_hợp>(<cột_giá_trị>)
    FOR <cột_muốn_xoay> IN ([cột_1], [cột_2], ...)
) AS PivotTable;
