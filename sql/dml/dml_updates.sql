UPDATE s_spell
SET descr = higher_levels
WHERE descr IS NULL
AND higher_levels IS NOT NULL; -- test w/ Mass Heal

