CREATE OR REPLACE PACKAGE pkg_independent_etl_dw_currencies
AS  
   PROCEDURE LOAD_DW_CURRENCY;
   PROCEDURE LOAD_DW_DOERS_with_to_refcursor_func;
   PROCEDURE LOAD_DW_DOERS_with_to_cursor_number_func;
END pkg_independent_etl_dw_currencies;
