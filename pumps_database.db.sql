BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "lang" (
	"id_lang"	INTEGER,
	"iso_code"	TEXT UNIQUE,
	"lang"	TEXT UNIQUE,
	"alias_lang"	TEXT UNIQUE,
	PRIMARY KEY('id_lang' AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "category" (
	"id_category"	INTEGER,
	"id_parent"	INTEGER,
	"category_alias"	TEXT UNIQUE,
	PRIMARY KEY("id_category" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "category_lang" (
	"id_category"	INTEGER,
	"id_lang"	INTEGER,
	"category"	TEXT,
	FOREIGN KEY("id_category") REFERENCES "category"("id_category") ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY("id_lang") REFERENCES "lang"("id_lang") ON UPDATE CASCADE ON DELETE CASCADE,
	UNIQUE('id_category','id_lang')
);
CREATE TABLE IF NOT EXISTS "feature" (
	"id_feature"	INTEGER,
	"feature_alias"	TEXT UNIQUE,
	PRIMARY KEY('id_feature' AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "feature_value" (
	"id_feature_value"	INTEGER,
	"id_feature"	INTEGER,
	"feature_value_alias"	TEXT,
	FOREIGN KEY("id_feature") REFERENCES "feature"("id_feature") ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY('id_feature_value' AUTOINCREMENT),
	UNIQUE("id_feature","feature_value_alias")
);
CREATE TABLE IF NOT EXISTS "equipment" (
	"id_equipment"	INTEGER,
	"marking"	TEXT UNIQUE,
	PRIMARY KEY('id_equipment' AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "category_equipment" (
	"id_equipment"	INTEGER,
	"id_category"	INTEGER,
	FOREIGN KEY("id_category") REFERENCES "category"("id_parent") ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY("id_equipment") REFERENCES "equipment"("id_equipment") ON UPDATE CASCADE ON DELETE CASCADE,
	UNIQUE('id_equipment','id_category')
);
CREATE TABLE IF NOT EXISTS "attribute_group" (
	"id_attribute_group"	INTEGER,
	"group_alias"	TEXT UNIQUE,
	PRIMARY KEY('id_attribute_group' AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "attribute" (
	"id_attribute"	INTEGER,
	"id_attribute_group"	INTEGER,
	"attribute_alias"	TEXT,
	PRIMARY KEY('id_attribute' AUTOINCREMENT),
	FOREIGN KEY("id_attribute_group") REFERENCES "attribute_group"("id_attribute_group") ON UPDATE CASCADE ON DELETE CASCADE,
	UNIQUE('id_attribute_group','attribute_alias')
);
CREATE TABLE IF NOT EXISTS "combination" (
	"id_combination"	INTEGER,
	"id_equipment"	INTEGER,
	PRIMARY KEY('id_combination' AUTOINCREMENT),
	FOREIGN KEY("id_equipment") REFERENCES "equipment"("id_equipment") ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS "combination_attribute" (
	"id_attribute"	INTEGER,
	"id_combination"	INTEGER,
	FOREIGN KEY("id_attribute") REFERENCES "attribute"("id_attribute") ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY("id_combination") REFERENCES "combination"("id_combination") ON UPDATE CASCADE ON DELETE CASCADE,
	UNIQUE('id_attribute','id_combination')
);
CREATE TABLE IF NOT EXISTS "feature_combination" (
	"id_feature"	INTEGER,
	"id_combination"	INTEGER,
	"id_feature_value"	INTEGER,
	FOREIGN KEY("id_combination") REFERENCES "combination"("id_combination") ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY("id_feature") REFERENCES "feature"("id_feature") ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY("id_feature_value") REFERENCES "feature_value"("id_feature_value") ON UPDATE CASCADE ON DELETE CASCADE,
	UNIQUE('id_feature','id_combination','id_feature_value')
);
CREATE TABLE IF NOT EXISTS "combination_lang" (
	"id_combination"	INTEGER,
	"id_lang"	INTEGER,
	"description"	TEXT,
	"short_description"	TEXT,
	FOREIGN KEY("id_combination") REFERENCES "combination"("id_combination") ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY("id_lang") REFERENCES "lang"("id_lang") ON UPDATE CASCADE ON DELETE CASCADE,
	UNIQUE('id_combination','id_lang')
);
INSERT INTO "lang" VALUES (1,'uk','українська','ukrainian');
INSERT INTO "lang" VALUES (2,'ru','русский','russian');
INSERT INTO "category" VALUES (1,0,'pumps');
INSERT INTO "category" VALUES (2,1,'centrifugal pump');
INSERT INTO "category" VALUES (3,1,'gear pump');
INSERT INTO "category" VALUES (4,2,'sectional type NM');
INSERT INTO "category" VALUES (5,2,'scroll type NM');
INSERT INTO "category_lang" VALUES (1,1,'насоси');
INSERT INTO "category_lang" VALUES (1,2,'насосы');
INSERT INTO "category_lang" VALUES (2,1,'насос відцентровий');
INSERT INTO "category_lang" VALUES (2,2,'насос центробежный');
INSERT INTO "category_lang" VALUES (3,1,'насос шестеренчастий');
INSERT INTO "category_lang" VALUES (3,2,'насос шестеренный');
INSERT INTO "category_lang" VALUES (4,1,'насос секційний типу НМ');
INSERT INTO "category_lang" VALUES (4,2,'насос секционный типа НМ');
INSERT INTO "category_lang" VALUES (5,1,'насос спиральний типу НМ');
INSERT INTO "category_lang" VALUES (5,2,'насос спиральный типа НМ');
INSERT INTO "feature" VALUES (1,'H0');
INSERT INTO "feature" VALUES (2,'b');
INSERT INTO "feature_value" VALUES (1,1,'246.7');
INSERT INTO "feature_value" VALUES (2,1,'248.7');
INSERT INTO "feature_value" VALUES (3,2,'16.8e-6');
INSERT INTO "feature_value" VALUES (4,2,'7.61e-6');
INSERT INTO "equipment" VALUES (1,'nm_2500_230');
INSERT INTO "category_equipment" VALUES (1,1);
INSERT INTO "category_equipment" VALUES (1,2);
INSERT INTO "category_equipment" VALUES (1,5);
INSERT INTO "attribute_group" VALUES (1,'rotor');
INSERT INTO "attribute_group" VALUES (2,'D2');
INSERT INTO "attribute" VALUES (1,1,'0.5');
INSERT INTO "attribute" VALUES (2,1,'0.7');
INSERT INTO "attribute" VALUES (3,2,'425');
INSERT INTO "attribute" VALUES (4,2,'405');
INSERT INTO "combination" VALUES (1,1);
INSERT INTO "combination" VALUES (2,1);
INSERT INTO "combination" VALUES (3,1);
INSERT INTO "combination_attribute" VALUES (1,1);
INSERT INTO "combination_attribute" VALUES (3,1);
INSERT INTO "combination_attribute" VALUES (2,2);
INSERT INTO "combination_attribute" VALUES (4,2);
INSERT INTO "combination_attribute" VALUES (1,3);
INSERT INTO "combination_attribute" VALUES (4,3);
INSERT INTO "feature_combination" VALUES (1,1,1);
INSERT INTO "feature_combination" VALUES (2,1,3);
INSERT INTO "feature_combination" VALUES (1,2,2);
INSERT INTO "feature_combination" VALUES (2,2,4);
INSERT INTO "combination_lang" VALUES (1,2,'Насос магистральный НМ 2500-230, Dк=425 мм, n=2973 об/хв','НМ 2500-230');
INSERT INTO "combination_lang" VALUES (1,1,'Насос магістральний НМ 2500-230, Dк=425 мм, n=2973 об/мин','НМ 2500-230');
INSERT INTO "combination_lang" VALUES (2,2,'Насос магистральный НМ 2500-230, Dк=405 мм, n=2973 об/мин','НМ 2500-230');
INSERT INTO "combination_lang" VALUES (2,1,'Насос магістральний НМ 2500-230, Dк=405 мм, n=2973 об/хв','НМ 2500-230');
COMMIT;
