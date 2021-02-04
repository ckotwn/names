#!/bin/bash
# Generate datasheets for packaging as DwC-A.
# Assuming MySQL/MariaDB.
#
# ATTENTION: Use accompanying my-extra.cnf to indicate proper user and database.
#
# by Chihjen Ko

CURRENT_DIR=$(pwd)
PACKAGES=("dwca-taibnet-all")

mysql --defaults-extra-file=my-extra.cnf < taibnet-clean-line-breaks.sql

for P in ${PACKAGES[@]}; do
  mkdir $P
  mysql --defaults-extra-file=my-extra.cnf < "$P-taxon.sql" > $CURRENT_DIR/dwca-taibnet-all/taxon.txt
  mysql --defaults-extra-file=my-extra.cnf < "$P-description.sql" > $CURRENT_DIR/dwca-taibnet-all/description.txt
  mysql --defaults-extra-file=my-extra.cnf < "$P-vernacularName.sql" > $CURRENT_DIR/dwca-taibnet-all/vernacularName.txt
done
