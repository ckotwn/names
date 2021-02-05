#!/bin/bash
#
# Delete all "copy" tables in taibnet db.
# Make sure the user has appropriate privileges.

USER=$1

# Dump redundant tables.
mysqldump -u $USER -p taibnet \
  00e \
  experts_copy \
  families_20180509 \
  families_apg4pre_20170531 \
  families_copy_20170804 \
  scientific_names2 \
  scientific_names3 \
  scientific_names_20161221 \
  scientific_names_20161226 \
  scientific_names_20161227 \
  scientific_names_20170417 \
  scientific_names_20180514 \
  scientific_names_20191030 \
  table_specieslist_02 \
  table_specieslist_20160722 \
  table_specieslist_20161221 \
  table_specieslist_20161227 \
  tree_copy \
  treeclass_copy \
  treefamily_copy \
  treegenus_copy \
  treekingdom_copy \
  treeorder_copy \
  treephylum_copy \
  treetop_table_copy \
  view_getchinesen_copy \
> copies.sql

# Run taibnet-clean-up.sql.
mysql -u $USER -p taibnet < taibnet-clean-up.sql

# Import the latest dump from the official site.
mysql -u $USER -p taibnet < taibnet-export.sql
mysqlimport --ignore-lines=1 --fields-terminated-by='\t' --local -u $USER -p taibnet taibnet_export.csv

