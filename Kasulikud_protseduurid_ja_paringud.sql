#Paringud
  #Leida kõik mänguasjad, mille praegune hinnaline väärtus on mingis vahemikus.
  SELECT nimi, brand, aasta FROM manguasi
  KEY JOIN hind
  WHERE praegune<x AND praegune>y;


  #Leida kõik mänguasjad, mille esialgne hinnaline väärtus on mingis vahemikus.
  SELECT nimi, brand, aasta FROM manguasi
  KEY JOIN hind
  WHERE algne<x AND algne>y;


  #Leida kõik mänguasjad mingis kategoorias.
  SELECT nimi, brand, aasta FROM manguasi
  KEY JOIN kategooria
  WHERE kategooria = ‘[antud kategooria]’;


  #Leida kõik mänguasjad, mille suurused ei ületa teatuid piire.
  SELECT nimi, brand, aasta FROM manguasjad
  KEY JOIN suurus
  WHERE korgus<x AND laius<y AND pikkus<z AND kaal<t;


  #Leida kõik mänguviisiga x mänguasjad.
  SELECT nimi, brand, aasta FROM manguasi
  KEY JOIN manguviis
  WHERE manguviis = ‘[antud manguviis]’;


#Protseduurid:
  #Lisa mänguasi, antud parameetritega.
  CREATE PROCEDURE sp_klubimangijad (IN a_klubi_nimi varchar(100))
  RESULT (
          nimi varchar(202),
          kuupaev date)
  BEGIN
  SELECT f_nimi(eesnimi, perenimi), CURRENT DATE
  FROM isikud KEY JOIN klubid
  WHERE nimi = a_klubi_nimi
  ORDER BY 1;
  END;


  #Eemalda mänguasi, mille nimi, bränd ja väljastamisaasta on antud.
  CREATE PROCEDURE sp_eemalda_manguasi(IN nimi varchar(255), IN brand varchar(255), IN aasta date)
      BEGIN
          DELETE FROM manguasi WHERE manguasi.nimi = nimi AND manguasi.brand = brand AND manguasi.aasta = aasta
      END;
