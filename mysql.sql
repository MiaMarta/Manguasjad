CREATE TABLE `manguasi` (
	`id` INT NOT NULL UNIQUE DEFAULT AUTOINCREMENT,
	`nimi` varchar(255) NOT NULL,
	`brand` varchar(255) NOT NULL,
	`aasta` DATE NOT NULL,
	PRIMARY KEY (`id`,`nimi`,`brand`,`aasta`)
);

CREATE TABLE `suurus` (
	`id` INT NOT NULL UNIQUE,
	`laius` FLOAT NOT NULL,
	`pikkus` FLOAT NOT NULL,
	`korgus` FLOAT NOT NULL,
	`kaal` FLOAT NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `kategooria` (
	`kategooria` varchar(255) NOT NULL UNIQUE,
	PRIMARY KEY (`kategooria`)
);

CREATE TABLE `tugevus` (
	`id` INT NOT NULL UNIQUE DEFAULT AUTOINCREMENT,
	`tugevus1` INT NOT NULL,
	`tugevus2` INT,
	`tyyp` varchar(255),
	PRIMARY KEY (`id`)
);

CREATE TABLE `manguviis` (
	`id` INT NOT NULL UNIQUE,
	PRIMARY KEY (`id`)
);

CREATE TABLE `tolge` (
	`id` INT NOT NULL UNIQUE DEFAULT AUTOINCREMENT,
	`keel` varchar(255) NOT NULL,
	`nimi` varchar(255) NOT NULL,
	PRIMARY KEY (`id`,`keel`,`nimi`)
);

CREATE TABLE `hind` (
	`id` INT NOT NULL UNIQUE,
	`praegune` FLOAT NOT NULL,
	`algne` FLOAT NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `manguasi_tolge` (
	`id_manguasi` INT NOT NULL,
	`id_tolge` INT NOT NULL,
	PRIMARY KEY (`id_manguasi`,`id_tolge`)
);

CREATE TABLE `manguasi_kategooria` (
	`manguasi_id` INT NOT NULL,
	`kategooria` varchar(255) NOT NULL,
	PRIMARY KEY (`manguasi_id`,`kategooria`)
);

ALTER TABLE `suurus` ADD CONSTRAINT `fk_suurus_manguasi` FOREIGN KEY (`id`) REFERENCES `manguasi`(`id`);

ALTER TABLE `tugevus` ADD CONSTRAINT `fk_tugevus_manguasi` FOREIGN KEY (`id`) REFERENCES `manguasi`(`id`);

ALTER TABLE `manguviis` ADD CONSTRAINT `fk_manguviis_manguasi` FOREIGN KEY (`id`) REFERENCES `manguasi`(`id`);

ALTER TABLE `hind` ADD CONSTRAINT `fk_hind_manguasi` FOREIGN KEY (`id`) REFERENCES `manguasi`(`id`);

ALTER TABLE `manguasi_tolge` ADD CONSTRAINT `fk_manguasi_tolge_manguasi` FOREIGN KEY (`id_manguasi`) REFERENCES `manguasi`(`id`);

ALTER TABLE `manguasi_tolge` ADD CONSTRAINT `fk_manguasi_tolge_tolge` FOREIGN KEY (`id_tolge`) REFERENCES `tolge`(`id`);

ALTER TABLE `manguasi_kategooria` ADD CONSTRAINT `fk_manguasi_kategooria_manguasi` FOREIGN KEY (`manguasi_id`) REFERENCES `manguasi`(`id`);

ALTER TABLE `manguasi_kategooria` ADD CONSTRAINT `fk_manguasi_kategooria_kategooria` FOREIGN KEY (`kategooria`) REFERENCES `kategooria`(`kategooria`);








