/* 
  1. Download and extract the old database dump
    <= http://bit.ly/taibnet-20191215 (167MB)
    
  2. Load records from taibnet-20191215.sql */

/* Delete empty records */
/* This should apply to the following tables:
  details_20161226bk, details_20161227, details_20180104, details_old */
DELETE FROM details
WHERE cites_code IS NULL
  AND coa_dateassessed IS NULL
  AND coa_redlist_code IS NULL
  AND datelastmodified IS NULL
  AND diagnosis IS NULL
  AND diagnosis_c IS NULL
  AND distribution IS NULL
  AND distribution_c IS NULL
  AND habitat IS NULL
  AND habitat_c IS NULL
  AND iucn_assessment IS NULL
  AND iucn_code IS NULL
  AND iucn_dateassessed IS NULL
  AND iucn_group IS NULL
  AND iucn_id IS NULL
  AND lastmodifiedby IS NULL
  AND redlist_chen IS NULL
  AND redlist_nsc IS NULL
  AND redlist_wang IS NULL
  AND redlist_wang_ass IS NULL
  AND utility IS NULL
  AND utility_c IS NULL;

  /* Delete the primary key column of details_old, and load records from details_201* */
ALTER TABLE details_old DROP PRIMARY KEY;

/* Insert into details_old_d Select * from details_* */
INSERT INTO details_old SELECT * FROM details_20161226bk;
INSERT INTO details_old SELECT * FROM details_20161227;
INSERT INTO details_old SELECT * FROM details_20180104;
DROP TABLE details_20161226bk, details_20161227, details_20180104;

DELETE FROM details_old
WHERE cites_code IS NULL
  AND coa_dateassessed IS NULL
  AND coa_redlist_code IS NULL
  AND datelastmodified IS NULL
  AND diagnosis IS NULL
  AND diagnosis_c IS NULL
  AND distribution IS NULL
  AND distribution_c IS NULL
  AND habitat IS NULL
  AND habitat_c IS NULL
  AND iucn_assessment IS NULL
  AND iucn_code IS NULL
  AND iucn_dateassessed IS NULL
  AND iucn_group IS NULL
  AND iucn_id IS NULL
  AND lastmodifiedby IS NULL
  AND redlist_chen IS NULL
  AND redlist_nsc IS NULL
  AND redlist_wang IS NULL
  AND redlist_wang_ass IS NULL
  AND utility IS NULL
  AND utility_c IS NULL;
  
/* Remove duplicates in details_old
  https://www.sqlshack.com/different-ways-to-sql-delete-duplicate-rows-from-a-sql-table/ */

  -- Turns out there are no duplicated name_code. To investigate.

/* Consolidating genus vernacular names */
DELETE FROM genus_chinese_copy WHERE genus_c IS NULL;
DELETE FROM genus_chinese WHERE genus_c IS NULL;
CREATE TABLE genus_vernacular LIKE genus_chinese;
ALTER TABLE genus_vernacular DROP PRIMARY KEY, CHANGE auto_id auto_id int;
ALTER TABLE genus_vernacular DROP KEY `3`;
INSERT INTO genus_vernacular SELECT * FROM genus_chinese_copy;
INSERT INTO genus_vernacular SELECT * FROM genus_chinese;
DROP TABLE genus_chinese;
DROP TABLE genus_chinese_copy;
ALTER TABLE genus_vernacular DROP `auto_id`;
ALTER TABLE genus_vernacular AUTO_INCREMENT = 1;
ALTER TABLE `genus_vernacular` ADD `id` int UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;
CREATE TABLE genus_vernacular_zhTW LIKE genus_vernacular;
INSERT INTO genus_vernacular_zhtw (family_id, genus, genus_c)
SELECT DISTINCT family_id, genus, genus_c
FROM genus_vernacular;
DROP TABLE genus_vernacular;

/* Consolidating suggest links */
ALTER TABLE suggestedlinks DROP PRIMARY KEY, CHANGE auto_id auto_id int;
INSERT INTO suggestedlinks SELECT * FROM suggestedlinks_copy;
CREATE TABLE suggested_links LIKE suggestedlinks_copy;
INSERT INTO suggested_links (id, linkurl, linkurl_eng, suggested_link_name, suggested_link_name_eng, icon)
SELECT DISTINCT id, linkurl, linkurl_eng, suggested_link_name, suggested_link_name_eng, icon FROM suggestedlinks;
DROP TABLE suggestedlinks_copy;
DROP TABLE suggestedlinks;

DELETE FROM suggested_links -- these are duplicates
WHERE auto_id IN (24, 20, 26, 25, 17, 21, 23);

/* Consolidating news as names_updates */
CREATE TABLE names_updates LIKE news;
INSERT INTO news (inshort, indate, content) SELECT inshort, indate, content FROM news_copy;
INSERT INTO names_updates (inshort, indate, content) SELECT DISTINCT inshort, indate, content FROM news GROUP BY inshort, indate;
DROP TABLE news, news_copy;

DROP TABLE fishdelete; -- no record or referece from the php webapp.
DROP TABLE families_del_original;

/* Drop "copy" tables */
DROP TABLE 00e, experts_copy, families_20180509, families_apg4pre_20170531, families_copy_20170804, scientific_names2, scientific_names3, scientific_names_20161221, scientific_names_20161226, scientific_names_20161227, scientific_names_20170417, scientific_names_20180514, scientific_names_20191030, table_specieslist_02, table_specieslist_20160722, table_specieslist_20161221, table_specieslist_20161227, tree_copy, treeclass_copy, treefamily_copy, treegenus_copy, treekingdom_copy, treeorder_copy, treephylum_copy, treetop_table_copy, view_getchinesen_copy;

/* out-dated copy and duplicates */
DROP TABLE IF EXISTS guestboard_copy;

