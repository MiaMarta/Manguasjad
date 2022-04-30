#Paringud
  #Leida kõik mänguasjad, mille praegune hinnaline väärtus on mingis vahemikus.
  #Allolevas näites 5..10 vahel
  SELECT nimi, brand, aasta FROM manguasi
  KEY JOIN hind
  WHERE praegune<10 AND praegune>0;


  #Leida kõik mänguasjad, mille esialgne hinnaline väärtus on mingis vahemikus.
  #Allolevas näites 0..20 vahel
  SELECT nimi, brand, aasta FROM manguasi
  KEY JOIN hind
  WHERE algne<20 AND algne>0;


  #Leida kõik mänguasjad mingis kategoorias.
  #Allolevas näites "Strateegia"
  SELECT nimi, brand, aasta FROM manguasi
  KEY JOIN manguasi_kategooria
  WHERE kategooria = 'Strateegia';


  #Leida kõik mänguasjad, mille suurused ei ületa teatuid piire.
  #Allolevas näites peab olema kõik väiksem kui 5.
  SELECT nimi, brand, aasta FROM manguasi
  KEY JOIN suurus
  WHERE korgus<5 AND laius<5 AND pikkus<5 AND kaal<5;


  #Leida kõik mänguviisiga x mänguasjad.
  #Allolevas näites mänguviisiga "Üksteise vastu".
  SELECT nimi, brand, aasta FROM manguasi
  KEY JOIN manguasi_manguviis
  WHERE manguviis = 'Üksteise vastu';


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
      VALUES (manguasi_nimi, manguasi_brand, manguasi_aasta);
      INSERT INTO tugevus (tugevus1, tugevus2, tyyp)
      VALUES (tugevus_tugevus1, tugevus_tugevus2, tugevus_tyyp);
      INSERT INTO hind (praegune, algne)
      VALUES (hind_praegune, hind_algne);
      INSERT INTO manguviis (manguviis)
      VALUES (manguviis_manguviis);
      INSERT INTO suurus (laius, pikkus, korgus, kaal)
      VALUES (suurus_laius, suurus_pikkus, suurus_korgus, suurus_kaal);
      
      INSERT INTO manguasi_tolge (id_tolge)
      VALUES ((SELECT id FROM tolge WHERE tolge.keel = tolge_keel AND tolge.nimi = tolge_nimi));
      INSERT INTO manguasi_kategooria (kategooria)
      VALUES (kategooria_kategooria);
    END;

  #Lisa mänguasjale tõlge.
  CREATE OR REPLACE PROCEDURE sp_lisa_tolge(
    IN manguasi_nimi varchar(255), IN manguasi_brand varchar(255), IN manguasi_aasta date,
    IN tolge_keel varchar(255), IN tolge_nimi varchar(255)
  )
  BEGIN
    DECLARE d_tolge_id integer;
    DECLARE d_manguasi_id integer;
    SELECT id INTO d_manguasi_id FROM manguasi WHERE nimi = manguasi_nimi AND brand = manguasi_brand AND aasta = manguasi_aasta;
    IF (EXISTS (SELECT keel, nimi FROM tolge WHERE keel = tolge_keel AND nimi = tolge_nimi)) THEN    
      SELECT id into d_tolge_id FROM tolge WHERE keel = tolge_keel AND nimi = tolge_nimi;
      INSERT INTO manguasi_tolge (manguasi_id, tolge_id) VALUES (d_manguasi_id, d_tolge_id);
      RETURN;
    END IF;
    INSERT INTO tolge (keel, nimi) VALUES (tolge_keel, tolge_nimi);
    SELECT @@identity INTO d_tolge_id;
    INSERT INTO manguasi_tolge (manguasi_id, tolge_id) VALUES (d_manguasi_id, d_tolge_id);
  END;

  #Eemalda mänguasi, mille nimi, bränd ja väljastamisaasta on antud.
  CREATE PROCEDURE sp_eemalda_manguasi(IN nimi varchar(255), IN brand varchar(255), IN aasta date)
      BEGIN
          DELETE FROM manguasi WHERE manguasi.nimi = nimi AND manguasi.brand = brand AND manguasi.aasta = aasta
      END;
