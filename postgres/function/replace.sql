-- replace array

CREATE OR REPLACE FUNCTION replace(in_text text, in_search text[], in_replace text[])
  RETURNS text AS
$BODY$
DECLARE
  v_i int DEFAULT 0;
  v_count int;
BEGIN
  v_count = array_length(in_search, 1);
  IF v_count != array_length(in_replace, 1) THEN
    RAISE EXCEPTION 'Length search array is not same replace array. Must equal count of elements.';
  END IF;

  FOR v_i IN 1 .. v_count LOOP
    in_text = replace(in_text, in_search[v_i], in_replace[v_i]);
  END LOOP;
  RETURN in_text;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

SELECT replace('$1 are $2?', ARRAY['$1', '$2'], ARRAY['How', 'you']);
-- How are you?