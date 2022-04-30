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
  #parameetrid grupeeritud vastavate tulpadega
  #manguasi - kategooria - tolge - tugevus - hind - manguviis - suurus
  CREATE PROCEDURE sp_lisa_manguasi (
                                     IN manguasi_nimi varchar(255), IN manguasi_brand varchar(255), IN manguasi_aasta date,
                                     IN kategooria_kategooria varchar(255),
                                     IN tolge_keel varchar(255), IN tolge_nimi varchar(255),
                                     IN tugevus_tugevus1 integer, IN tugevus_tugevus2 integer, IN tugevus_tyyp varchar(255),
                                     IN hind_praegune float, IN hind_algne float,
                                     IN manguviis_manguviis varchar(255),
                                     IN suurus_laius float, IN suurus_pikkus float, IN suurus_korgus float, IN suurus_kaal float
                                    )
    BEGIN
      INSERT INTO manguasi (nimi, brand, aasta)
      INSERT INTO tugevus (tugevus1, tugevus2, tyyp)
      VALUES (tugevus_tugevus1, tugevus_tugevus2, tugevus_tyyp);
      INSERT INTO hind (praegune, algne)
      VALUES (hind_praegune, hind_algne);
      INSERT INTO manguviis (manguviis)
      VALUES (manguviis_manguviis);
      INSERT INTO suurus (laius, pikkus, korgus, kaal)
      VALUES (suurus_laius, suurus_pikkus, suurus_korgus, suurus_kaal);
      
      WHERE tolge.nimi = tolge_nimi AND tolge.keel = tolge_keel;
      WHERE kategooria.kategooria = kategooria_kategooria;
    END;


  #Eemalda mänguasi, mille nimi, bränd ja väljastamisaasta on antud.
  CREATE PROCEDURE sp_eemalda_manguasi(IN nimi varchar(255), IN brand varchar(255), IN aasta date)
      BEGIN
          DELETE FROM manguasi WHERE manguasi.nimi = nimi AND manguasi.brand = brand AND manguasi.aasta = aasta
      END;
