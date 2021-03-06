-- FIXME? El uso de \i da error en el RPM, nada grave, se usa un work-around

\i ./create.sql

\connect almidondemo

-- *********************************
-- * Parte esencial de almidon     *
-- *********************************

\i ../core/sql/alm.tables.sql
GRANT SELECT ON alm_access,alm_column,alm_role,alm_table,alm_user TO almidondemowww;
GRANT ALL ON alm_access,alm_column,alm_role,alm_table,alm_user TO almidondemo;


-- *********************************
-- * Parte del demo                *
-- ********************************* 

-- tablas demo
DROP TABLE IF EXISTS agenda CASCADE;
CREATE TABLE agenda (idagenda serial PRIMARY KEY, agenda varchar(500), fecha date, lugar varchar(120), texto text, organiza varchar(500));
ALTER TABLE agenda OWNER TO almidondemo;

DROP TABLE IF EXISTS doc CASCADE;
CREATE TABLE doc (iddoc serial PRIMARY KEY, doc varchar(500), portada varchar(500), descripcion text, archivo varchar(500));
ALTER TABLE doc OWNER TO almidondemo;

DROP TABLE IF EXISTS enlace CASCADE;
CREATE TABLE enlace (idenlace serial PRIMARY KEY, enlace varchar(500), url varchar(600), texto text, imagen varchar(500));
ALTER TABLE enlace OWNER TO almidondemo;

DROP TABLE IF EXISTS galeria CASCADE;
CREATE TABLE galeria (idgaleria serial PRIMARY KEY, galeria varchar(500), fecha date);
ALTER TABLE galeria OWNER TO almidondemo;

DROP TABLE IF EXISTS foto CASCADE;
CREATE TABLE foto (idfoto serial PRIMARY KEY, idgaleria integer REFERENCES galeria, foto varchar(500), imagen varchar(500));
ALTER TABLE foto OWNER TO almidondemo;

DROP TABLE IF EXISTS noticia CASCADE;
CREATE TABLE noticia (idnoticia serial PRIMARY KEY, noticia varchar(500), fecha date, texto text, foto varchar(500), fotocdn varchar(500), archivo varchar(500));
ALTER TABLE noticia OWNER TO almidondemo;

DROP TABLE IF EXISTS pagina CASCADE;
CREATE TABLE pagina (idpagina serial PRIMARY KEY, pagina varchar(500), foto varchar(500), descripcion text);
ALTER TABLE pagina OWNER TO almidondemo;

DROP TABLE IF EXISTS email CASCADE;
CREATE TABLE email (domain varchar(256), login varchar(32), ctld varchar(8), observaciones text, PRIMARY KEY (domain,login,ctld));
ALTER TABLE email OWNER TO almidondemo;

GRANT SELECT ON agenda,doc,enlace,galeria,foto,noticia,pagina,email TO almidondemowww;

INSERT INTO agenda (agenda, fecha, lugar, texto, organiza) VALUES ('Quijote de la Mancha', '2007-10-13', 'En un lugar de la Mancha', 'Es, pues, de saber, que este sobredicho hidalgo, los ratos que estaba ocioso (que eran los más del año) se daba a leer libros de caballerías con tanta afición y gusto, que olvidó casi de todo punto el ejercicio de la caza.', 'UCA IAS');
INSERT INTO agenda (agenda, fecha, lugar, texto, organiza) VALUES ('Que trata de la primera salida', '2007-10-13', 'Puerto Lapice', 'Estos pensamientos le hicieron titubear en su propósito; mas pudiendo más su locura que otra razón alguna, propuso de hacerse armar caballero del primero que topase, a imitación de otros muchos que así lo hicieron, según él había leído en los libros que tal le tenían. En lo de las armas blancas pensaba limpiarlas de manera, en teniendo lugar, que lo fuesen más que un armiño: y con esto se quietó y prosiguió su camino, sin llevar otro que el que su caballo quería, creyendo que en aquello consistía la fuerza de las aventuras. Yendo, pues, caminando nuestro flamante aventurero, iba hablando consigo mismo, y diciendo.', 'Wkipedia');

INSERT INTO doc (doc, portada, descripcion, archivo) VALUES ('Memorias 2005', '', '', NULL);
INSERT INTO doc (doc, portada, descripcion, archivo) VALUES ('Portada Memorias 2005', '', '', NULL);
INSERT INTO doc (doc, portada, descripcion, archivo) VALUES ('Memorias 2002', '', '', NULL);
INSERT INTO doc (doc, portada, descripcion, archivo) VALUES ('Memorias 2002', '', '', NULL);
INSERT INTO doc (doc, portada, descripcion, archivo) VALUES ('Memorias 2002', '', '', NULL);

INSERT INTO enlace (enlace, url, texto, imagen) VALUES ('Google', 'http://www.google.com/', '', '1207951914_logo.gif');
INSERT INTO enlace (enlace, url, texto, imagen) VALUES ('Yahoo!', 'http://www.yahoo.com/', '', '1207951982_y3.gif');

INSERT INTO galeria (galeria, fecha) VALUES ('Galeria de ejemplos', NULL);

INSERT INTO foto (idgaleria, foto, imagen) VALUES (1, 'Ballons San Diego', 'balloons_2_bg_060504.jpg');
INSERT INTO foto (idgaleria, foto, imagen) VALUES (1, 'Playa Ocaso', 'beach_3_bg_010503.jpg');
INSERT INTO foto (idgaleria, foto, imagen) VALUES (1, 'Mar Big Sur', 'bigsur_28_bg_101203.jpg');
INSERT INTO foto (idgaleria, foto, imagen) VALUES (1, 'Lago de Canda', 'canada_40_bg_061904.jpg');
INSERT INTO foto (idgaleria, foto, imagen) VALUES (1, 'Zoom de chips de computadora', 'chips_3_bg_102602.jpg');
INSERT INTO foto (idgaleria, foto, imagen) VALUES (1, 'Ciudad en Irlanda', 'ireland_37_bg_070504.jpg');
INSERT INTO foto (idgaleria, foto, imagen) VALUES (1, 'Ciudad desconocida', 'roadtrip_23_bg_021604.jpg');
INSERT INTO foto (idgaleria, foto, imagen) VALUES (1, 'Frutas en fondo oscuro', 'fruit_2_bg_020203.jpg');
INSERT INTO foto (idgaleria, foto, imagen) VALUES (1, 'Granos de café', 'coffee_01_bg_031106.jpg');
INSERT INTO foto (idgaleria, foto, imagen) VALUES (1, 'Treboles de Irlanda', 'ireland_102_bg_061602.jpg');

INSERT INTO noticia (noticia, fecha, texto, foto) VALUES ('Don Quijote Primera Parte Capítulo Dos', '2007-10-13', 'Hechas, pues, estas prevenciones, no quiso aguardar más tiempo a poner en efecto su pensamiento, apretándole a ello la falta que él pensaba que hacía en el mundo su tardanza, según eran los agravios que pensaba deshacer, tuertos que enderezar, sinrazones que enmendar, y abusos que mejorar, y deudas que satisfacer; y así, sin dar parte a persona alguna de su intención, y sin que nadie le viese, una mañana, antes del día (que era uno de los calurosos del mes de Julio), se armó de todas sus armas, subió sobre Rocinante, puesta su mal compuesta celada, embrazó su adarga, tomó su lanza, y por la puerta falsa de un corral, salió al campo con grandísimo contento y alborozo de ver con cuánta facilidad había dado principio a su buen deseo. Mas apenas se vió en el campo, cuando le asaltó un pensamiento terrible, y tal, que por poco le hiciera dejar la comenzada empresa: y fue que le vino a la memoria que no era armado caballero, y que, conforme a la ley de caballería, ni podía ni debía tomar armas con ningún caballero; y puesto qeu lo fuera, había de llevar armas blancas, como novel caballero, sin empresa en el escudo, hasta que por su esfuerzo la ganase.', '');
INSERT INTO noticia (noticia, fecha, texto, foto) VALUES ('Casi todo aquel día caminó sin acontecerle', '2007-10-13', 'Autores hay que dicen que la primera aventura que le avino fue la de PuertoLápice; otros dicen que la de los molinos de viento; pero lo que yo he podido averiguar en este caso, y lo que he hallado escrito en los anales de la Mancha, es que él anduvo todo aquel día, y al anochecer, su rocín y él se hallaron cansados y muertos de hambre; y que mirando a todas partes, por ver si descubriría algún castillo o alguna majada de pastores donde recogerse, y adonde pudiese remediar su mucha necesidad, vió no lejos del camino por donde iba una venta, que fue como si viera una estrella, que a los portales, si no a los alcázares de su redención, le encaminaba. Dióse priesa a caminar, y llegó a ella a tiempo que anochecía. Estaban acaso a la puerta dos mujeres mozas, de estas que llaman del partido, las cuales iban a Sevilla con unos arrieros, que en la venta aquella noche acertaron a hacer jornada; y como a nuestro aventurero todo cuanto pensaba, veía o imaginaba, le parecía ser hecho y pasar al modo de lo que había leído, luego que vió la venta se le representó que era un castillo con sus cuatro torres y chapiteles de luciente plata, sin faltarle su puente levadizo y honda cava, con todos aquellos adherentes que semejantes castillos se pintan.
Fuese llegando a la venta (que a él le parecía castillo), y a poco trecho de ella detuvo las riendas a Rocinante, esperando que algún enano se pusiese entre las almenas a dar señal con alguna trompeta de que llegaba caballero al castillo; pero como vió que se tardaban, y que Rocinante se daba priesa por llegar a la caballeriza, se llegó a la puerta de la venta, y vió a las dos distraídas mozas que allí estaban, que a él le parecieron dos hermosas doncellas, o dos graciosas damas, que delante de la puerta del castillo se estaban solazando. En esto sucedió acaso que un porquero, que andaba recogiendo de unos rastrojos una manada de puercos (que sin perdón así se llaman), tocó un cuerno, a cuya señal ellos se recogen, y al instante se le representó a D. Quijote lo que deseaba, que era que algún enano hacía señal de su venida, y así con extraño contento llegó a la venta y a las damas, las cuales, como vieron venir un hombre de aquella suerte armado, y con lanza y adarga, llenas de miedo se iban a entrar en la venta; pero Don Quijote, coligiendo por su huida su miedo, alzándose la visera de papelón y descubriendo su seco y polvoso rostro, con gentil talante y voz reposada les dijo: non fuyan las vuestras mercedes, nin teman desaguisado alguno, ca a la órden de caballería que profeso non toca ni atañe facerle a ninguno, cuanto más a tan altas doncellas, como vuestras presencias demuestran.', '');

INSERT INTO pagina (idpagina, pagina, foto, descripcion) VALUES (1, 'Qué es almidón?', '1207951790_almidon-logo-by-AtmaComunicaciones.png', 'Almidón es una plataforma de desarrollo y hospedaje web desarrollado por Guegue∞, cuyo componente más popular es un sistema de manejo de contenido (CMS) que permite un desarrollo sólido de un sitio web, una administración sencilla, rápida, y un sitio web con buen desempeño. Actualmente en su mayoría escrito para Linux usando PHP, Apache y Postgresql, pero siendo probado y usado en distintas plataformas. Publicado bajo la licencia open source GPL v3, puede obtenerse en http://trac.almidon.org/');
INSERT INTO pagina (idpagina, pagina, foto, descripcion) VALUES (2, 'Qué ondas con almidón?', '', 'La cosa es ver qué hacemos con el? seguimos con php? dejamos smarty? mejoramos el aspecto gráfico del administrador? quiénes quieren participar? Estrategias para el desarrollo open source de almidón.');
INSERT INTO pagina (idpagina, pagina, foto, descripcion) VALUES (3, 'Reunión sobre...', '', 'Después de algunas platicas con algunos de ustedes, decidimos hacer una reunion para platicar del tema, la asistencia es abierta. y aunque hay mas o menos una agenda, me gustaria mantenerla abierta.');
INSERT INTO pagina (idpagina, pagina, foto, descripcion) VALUES (4, 'Licencia GPL', '', 'A inicio de año sacamos almidon como GPL, recién en abril lo documentamos mejor y lo hicimos instalable (a un dificil, pero ya se puede), ahora incluiremos un demo, para que no haya que desarrollar todo un sistema solo para ver como funciona.');
INSERT INTO pagina (idpagina, pagina, foto, descripcion) VALUES (5, 'Más información...', '', 'Wiki: http://almidon.org/
Trac: http://trac.almidon.org/
Demo: http://demo.almidon.org/');

INSERT INTO email (login,domain,ctld) VALUES ('bob','example.com','');
INSERT INTO email (login,domain,ctld) VALUES ('alice','example.org','');
INSERT INTO email (login,domain,ctld) VALUES ('ingrid','example.net','');
INSERT INTO email (login,domain,ctld) VALUES ('bob','example.com','ni');
INSERT INTO email (login,domain,ctld) VALUES ('alice','example.org','ni');
INSERT INTO email (login,domain,ctld) VALUES ('ingrid','example.net','ni');
INSERT INTO email (login,domain,ctld) VALUES ('alice','example.org','gt');
INSERT INTO email (login,domain,ctld) VALUES ('bob','example.com','gt');
INSERT INTO email (login,domain,ctld) VALUES ('ingrid','example.net','gt');
INSERT INTO email (login,domain,ctld) VALUES ('alice','example.org','info');

-- usuarios demo
INSERT INTO alm_user VALUES ('demo', 'read', 'fe01ce2a7fbac8fafaed7c982a04e229', 'Demo', 'demo@example.com');
INSERT INTO alm_user VALUES ('alice', NULL, 'fe01ce2a7fbac8fafaed7c982a04e229', 'Alice', 'alice@example.com');

-- tablas a las cuales el acceso se puede personalizar
INSERT INTO alm_table (idalm_table, alm_table, orden, rank) VALUES ('pagina', 'Paginas', 'pagina', 1);
INSERT INTO alm_table (idalm_table, alm_table, orden, rank) VALUES ('doc', 'Documentos', 'doc', 2);
INSERT INTO alm_table (idalm_table, alm_table, orden, rank) VALUES ('enlace', 'Enlaces', 'enlace', 3);
INSERT INTO alm_table (idalm_table, alm_table, orden, rank) VALUES ('galeria', 'Galerias', 'galeria', 4);
INSERT INTO alm_table (idalm_table, alm_table, orden, rank) VALUES ('foto', 'Fotos', 'foto', 5);
INSERT INTO alm_table (idalm_table, alm_table, orden, rank) VALUES ('agenda', 'Agenda', 'agenda', 6);
INSERT INTO alm_table (idalm_table, alm_table, orden, rank) VALUES ('noticia', 'Noticias', 'fecha', 7);
INSERT INTO alm_table (idalm_table, alm_table, orden, rank) VALUES ('email', 'Email', 'login,domain,ctld', 8);

-- 'control total' para 'alice' en 'pagina'
INSERT INTO alm_access VALUES ('full', 'alice', 'pagina');

-- campos para tables.class.php
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('foto', 'pagina', 'image', 0, false, '', 'Foto', NULL, NULL);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('descripcion', 'pagina', 'text', 0, false, '', 'Descripcion', NULL, NULL);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('fecha', 'galeria', 'date', 0, false, '', 'Fecha', NULL, NULL);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('idgaleria', 'foto', 'int', 0, false, 'galeria', 'Galeria', NULL, NULL);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('fecha', 'agenda', 'date', 0, false, '', 'Fecha', '', NULL);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('lugar', 'agenda', 'varchar', 120, false, '', 'Lugar', '', NULL);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('texto', 'agenda', 'text', 0, false, '', 'Evento', '', NULL);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('organiza', 'agenda', 'varchar', 500, false, '', 'Organizado por', '', NULL);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('archivo', 'doc', 'file', 0, false, '', 'Archivo', '', NULL);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('portada', 'doc', 'image', 0, false, '', 'Imagen', '', NULL);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('descripcion', 'doc', 'xhtml', 0, false, '', 'Descripcion', '', NULL);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('fecha', 'noticia', 'datenull', 0, false, '', 'Fecha', '', NULL);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('texto', 'noticia', 'text', 0, false, '', 'Texto', '', NULL);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('foto', 'noticia', 'image', 0, false, '', 'Foto', '', NULL);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('url', 'enlace', 'varchar', 600, false, '', 'Direccion web', '', NULL);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('texto', 'enlace', 'text', 0, false, '', 'Texto', '', NULL);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('imagen', 'enlace', 'image', 0, false, '', 'Imagen', '', NULL);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('idagenda', 'agenda', 'serial', 0, true, '', 'ID', '', 1);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('agenda', 'agenda', 'varchar', 500, false, '', 'Titulo', '', 2);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('iddoc', 'doc', 'serial', 0, true, '', 'ID', '', 1);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('doc', 'doc', 'varchar', 500, false, '', 'Titulo', '', 2);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('idenlace', 'enlace', 'serial', 0, true, '', 'ID', '', 1);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('enlace', 'enlace', 'varchar', 500, false, '', 'Titulo', '', 2);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('idfoto', 'foto', 'serial', 0, true, '', 'ID', NULL, 1);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('foto', 'foto', 'varchar', 500, false, '', 'Titulo', NULL, 2);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('imagen', 'foto', 'image', 0, false, '', 'Foto', '100,300x300', 3);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('idgaleria', 'galeria', 'serial', 0, true, '', 'ID', NULL, 1);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('galeria', 'galeria', 'varchar', 500, false, '', 'Titulo', NULL, 2);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('idnoticia', 'noticia', 'serial', 0, true, '', 'ID', '', 1);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('noticia', 'noticia', 'varchar', 500, false, '', 'Titulo', '', 2);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('idpagina', 'pagina', 'serial', 0, true, '', 'ID', NULL, 1);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('pagina', 'pagina', 'varchar', 500, false, '', 'Titulo', NULL, 2);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank, search) VALUES ('login', 'email', 'varchar', 32, true, '', 'Login', NULL, 1, true);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank, search) VALUES ('domain', 'email', 'varchar', 128, true, '', 'Domain', NULL, 2, true);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('ctld', 'email', 'varchar', 8, true, '', 'cTLD', NULL, 3);
INSERT INTO alm_column (idalm_column, idalm_table, type, size, pk, fk, alm_column, extra, rank) VALUES ('observaciones', 'email', 'text', 0, false, '', 'cTLD', NULL, 4);
