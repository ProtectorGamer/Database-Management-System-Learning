-----------------------------------------------------------
-- task 1
-----------------------------------------------------------

DECLARE
    num NUMBER := &num;
BEGIN
    IF (MOD(num, 2) = 0) THEN
        DBMS_OUTPUT.PUT_LINE(num || ' is EVEN');
    END IF;

    IF (MOD(num, 2) != 0) THEN
        DBMS_OUTPUT.PUT_LINE(num || ' is ODD');
    END IF;
END;
/
-----------------------------------------------------------
-- 2nd way
-----------------------------------------------------------
DECLARE
    num NUMBER := &num;
    i   NUMBER;
    flag NUMBER := 0;
BEGIN
    IF num <= 1 THEN
        DBMS_OUTPUT.PUT_LINE(num || ' is NOT a prime number.');
    ELSE
        FOR i IN 2 .. num/2 LOOP
            IF MOD(num, i) = 0 THEN
                flag := 1;
                EXIT;
            END IF;
        END LOOP;

        IF flag = 0 THEN
            DBMS_OUTPUT.PUT_LINE(num || ' is a PRIME number.');
        ELSE
            DBMS_OUTPUT.PUT_LINE(num || ' is NOT a prime number.');
        END IF;
    END IF;
END;
/
-----------------------------------------------------------
-- task 3
-----------------------------------------------------------
DECLARE
    choice NUMBER := &choice;
BEGIN
    CASE choice
        WHEN 1 THEN 
            DBMS_OUTPUT.PUT_LINE('You selected: ADDITION');
            DBMS_OUTPUT.PUT_LINE('10 + 20 = ' || (10 + 20));

        WHEN 2 THEN 
            DBMS_OUTPUT.PUT_LINE('You selected: SUBTRACTION');
            DBMS_OUTPUT.PUT_LINE('20 - 10 = ' || (20 - 10));

        WHEN 3 THEN 
            DBMS_OUTPUT.PUT_LINE('You selected: MULTIPLICATION');
            DBMS_OUTPUT.PUT_LINE('10 * 20 = ' || (10 * 20));

        WHEN 4 THEN 
            DBMS_OUTPUT.PUT_LINE('You selected: DIVISION');
            DBMS_OUTPUT.PUT_LINE('20 / 10 = ' || (20 / 10));

        ELSE
            DBMS_OUTPUT.PUT_LINE('Invalid Choice! Enter 1-4.');
    END CASE;
END;
/
