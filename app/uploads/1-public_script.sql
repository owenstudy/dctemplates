
        drop table dm_template_veri;
        create table dm_template_veri(module_name varchar2(100), table_name varchar2(100),
        column_name varchar2(100),veri_code varchar2(100),veri_result number);
        
        Create Or Replace Function F_IS_NUMBER (STR_NUMBER Varchar2)
                    Return Number
                Is
                    V_RESULT   Integer;
                    V_NUMBER   Number;
                Begin
                    V_RESULT := 1;
                    V_NUMBER := To_number (STR_NUMBER);
                    V_RESULT := 0;
                    Return (V_RESULT);
                Exception
                    When Others
                    Then
                        V_RESULT := 1;
                        Return (V_RESULT);
                End;

                /
        
    CREATE OR REPLACE Function F_IS_DATE (STR_DATE Varchar2)
                Return Number
            Is
                V_RESULT   Integer;
                V_DATE     Date;
                errornum integer; 
            Begin
                V_RESULT := 1;
                errornum := 0;
                for i in 1..4 loop
                    begin 
                        if errornum = 0 then 
                          V_DATE := To_date (STR_DATE, 'mm/dd/yyyy');
                          v_result :=0;
                          exit;
                        end if; 
                        if errornum = 1 then                         
                          V_DATE := To_date (STR_DATE, 'yyyy/mm/dd');
                          v_result :=0;
                          exit;
                        end if;
                        if errornum = 2 then                         
                          V_DATE := To_date (STR_DATE, 'yyyy/mm/dd HH24:MI:ss');
                          v_result :=0;
                          exit;     
                        end if;
                        if errornum = 3 then                                           
                          V_DATE := To_date (STR_DATE, 'yyyy/mm/dd HH24:MI:ssss');
                          v_result :=0;
                          exit;                 
                        end if;   
                     exception
                       when others then 
                           errornum :=errornum+1;
                           V_RESULT := 1;
                     end;
                end loop ;
                Return (V_RESULT);
            Exception
                When Others
                Then
                    V_RESULT := 1;
                    Return (V_RESULT);
            End;

            /
        