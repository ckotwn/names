CREATE TABLE `taibnet_export` (
	kingdom VARCHAR(9) NOT NULL, 
	kingdom_c VARCHAR(5) NOT NULL, 
	phylum VARCHAR(21), 
	phylum_c VARCHAR(9), 
	class VARCHAR(22), 
	class_c VARCHAR(9), 
	`order` VARCHAR(23), 
	order_c VARCHAR(10), 
	family VARCHAR(24), 
	family_c VARCHAR(18), 
	name_code VARCHAR(42) NOT NULL, 
	name VARCHAR(93) NOT NULL, 
	genus VARCHAR(59) NOT NULL, 
	genus_c VARCHAR(16), 
	species VARCHAR(58), 
	infraspecies_marker VARCHAR(12), 
	infraspecies VARCHAR(32), 
	infraspecies2_marker VARCHAR(7), 
	infraspecies2 VARCHAR(19), 
	author VARCHAR(97), 
	author2 VARCHAR(57), 
	accepted_name_code VARCHAR(15) NOT NULL, 
	status_id DECIMAL(38, 0) NOT NULL, 
	is_accepted_name BOOL NOT NULL, 
	is_endemic BOOL, 
	is_marine BOOL, 
	alien_status DECIMAL(38, 0), 
	is_fossil BOOL, 
	common_name_c VARCHAR(135), 
	redlist_wang VARCHAR(2), 
	redlist_wang_ass VARCHAR(57), 
	redlist_chen VARCHAR(2), 
	iucn_code VARCHAR(2), 
	iucn_assessment VARCHAR(43), 
	iucn_dateassessed DATE, 
	iucn_id DECIMAL(38, 0), 
	coa_redlist_code VARCHAR(3), 
	cites_code VARCHAR(4), 
	redlist2017 VARCHAR(2), 
	redlist2017_note VARCHAR(100), 
	datelastmodified VARCHAR(10), 
	CHECK (is_accepted_name IN (0, 1)), 
	CHECK (is_endemic IN (0, 1)), 
	CHECK (is_marine IN (0, 1)), 
	CHECK (is_fossil IN (0, 1))
);
