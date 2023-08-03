[![Maintainability](https://api.codeclimate.com/v1/badges/a98475bf9c466d5ca815/maintainability)](https://codeclimate.com/github/fryntiz/debian-developer-conf/maintainability)

# Skript zum Vorbereiten einer Debian-Programmierumgebung

Skript, um in kurzer Zeit eine funktionsfähige Umgebung zu haben und auch um die Konfiguration
die Konfiguration der verschiedenen Geräte, mit denen ich arbeite, zu synchronisieren.

Dieses Skript bereitet die Programmierumgebung, Anwendungen, Server, benutzerdefinierte Befehle, GUI, Vorlagen und Repositories vollständig vor,
Server, benutzerdefinierte Befehle, GUI, Vorlagen und Repositories in Debian Stable.

![Imagen de previsualización](docs/Preview.jpg)

Alle Einstellungen und Auswahlmöglichkeiten wurden nach meinem Geschmack festgelegt, Sie können jeden
Sie können jeden Teil, den Sie für dieses Skript wählen, unter der gleichen GPLv3-Lizenz anpassen.
GPLv3-Lizenz.

Wenn Sie einen Fehler finden oder feststellen, dass etwas besser funktionieren könnte, fügen Sie eine
Wenn Sie einen Fehler finden oder feststellen, dass etwas besser funktionieren könnte, fügen Sie ein **Issue** hinzu, das ich gerne bearbeiten und bewerten werde.

Sie können auch mit dem PR zusammenarbeiten, den Sie für angemessen halten, solange es in der
Zeile des Skripts steht und es nicht notwendig ist, das ganze Projekt auf den Kopf zu stellen.

En todo caso recomiendo usar la rama **Master** y si quieres colaborar crea un
**fork** y haz **PR** sobre la rama **dev** para valorar si formará parte de
la siguiente versión.

## Warnungen und Erklärungen für Entscheidungen

Wenn Sie keine **offiziellen Repositories** verwenden, Repositories mischen oder eine andere
andere als Debian Stable verwenden, dann **experimentieren** Sie auf eigene Gefahr.
Ihr eigenes Risiko.

Dieses Skript ist automatisiert und kann Einstellungen ändern, ohne dass Sie dazu aufgefordert werden.

Eine gute Idee wäre es, es nach der Erstellung eines Backups oder in einer virtuellen Maschine auszuführen, bis Sie sehen, dass das Skript
einer virtuellen Maschine auszuführen, bis Sie sehen, dass das gesamte Skript Ihren Bedürfnissen entspricht oder den Teil zu ändern, den Sie
oder ändern Sie den Teil, den Sie anders bevorzugen, indem Sie einen Fork dieses Repositorys erstellen.
dieses Repository.

Ich arbeite nach dem Prinzip der Modularität, so dass Sie nur den Teil des Skripts ausführen können, an dem Sie interessiert sind
und nicht auf das ganze Skript angewiesen sind.

Um zu vermeiden, dass es interaktiv ist und ständig Fragen stellt, setzen wir
"-y" als Standardparameter in **apt**, der Software in Form einer Abhängigkeit installieren kann
Abhängigkeit installieren und/oder das System in sehr extremen Fällen zerstören kann, obwohl ich wiederhole, dass mit offiziellen
dass bei offiziellen Repositories nichts Seltsames passieren sollte und wenn doch, können Sie es zur Korrektur melden.
melden Sie es zur Korrektur.

## Ziele

Schaffung einer maßgeschneiderten Arbeitsumgebung für die Entwicklung von Webanwendungen
nach den Präferenzen des Autors (https://github.com/raupulus).

Es ist so modular wie möglich aufgebaut, so dass es in manchen Fällen nicht notwendig ist, das
das komplette Skript auszuführen und nur den Teil, den man wirklich braucht (falls das der Fall ist).
Sie wirklich benötigen (falls dies der Fall ist).

Vorschaumenü für Anwendungen:

![Imagen de previsualización 1](docs/Apps.jpg)

Dies sind die wichtigsten Ziele:

- Terminals, bash und zsh konfigurieren
- Installation von Schriftarten
- Installation von Brackets, Atom, ninja IDE und Vim-Editoren mit Anpassungen
- IDEs installieren, wenn der Benutzer es wünscht
- Konfigurieren von System- und globalen Variablen
- Erweitern von Repositories aus stabilen und zuverlässigen Quellen
- Installieren Sie Konfigurationen und Anpassungen für das System und Programme im
HOME
- Abkürzungen und Anpassungen für die Arbeit mit Git, GitHub und GitLab installieren
- Installieren Sie Apache2, PostgreSQL, MariaDB Server
- Installieren Sie Programmiersprachen, Abhängigkeiten und Bibliotheken für → php,
python, nodejs, ruby, bash, zsh
- Installieren von WEB-Browsern für Entwickler wie Firefox Developer und
Firefox Nightly
- Installieren Sie Tools zur Fehlersuche in Websprachen
- Konfigurieren Sie grafische Schnittstellen

Vorschau-Menü Anpassen:

![Imagen de previsualización 1](docs/Personalización.png)

## Kompatible Distribution

Es ist nur für **Debian 9** (stable) gedacht und wird mit diesem stabilen Zweig aktualisiert.
mit diesem stabilen Zweig aktualisiert.

Auf anderen Zweigen und Distributionen kann es das System kaputt machen, um es zu portieren gibt es nicht allzu viele
Um es zu portieren, gibt es nicht allzu viele Komplikationen und man muss die Installation/Namen umbenennen
umbenennen und die Repositories entsprechend der Distribution einrichten. Die
Rest der Schritte sollte identisch sein.

Das gesamte Skript basiert auf .sh-Funktionen. Wenn Sie also diese Datei bearbeiten und an Ihre Distribution anpassen, wird
Wenn Sie diese Datei bearbeiten und an Ihre Distribution anpassen, können Sie ein gewisses Maß an Kompatibilität erreichen.
Kompatibilität.

## Modularität

Es wurde versucht, es modular zu gestalten, so dass es kaum notwendig ist, die
Skripte anzufassen, um Funktionen hinzuzufügen oder zu entfernen.

Die Idee ist, dass das Skript so wenige Fragen wie möglich stellt und dass es sich um relevante Entscheidungen handelt.
Entscheidungen.

## Skript ausführen

Es importante realizar todos los pasos desde bash. Si usas **zsh** cambia a
**bash** antes de ejecutarlo:

```bash
    bash
```

Primero instalamos GIT

```bash
    sudo apt install git
```

Clonamos el repositorio actual en nuestro equipo

```bash
    git clone https://github.com/raupulus/debian-developer-conf.git
```

Entramos y ejecutamos el script principal

```bash
    cd preparar_entorno
    ./main.sh
```

## Personalización

Agrega elementos gráficos al sistema, los configura para el usuario y activa.

- Fondo de pantalla
- Grub
- GDM
- Iconos
- Cursores crystalblue

Además también se añadieron iconos "paper", temas "flatpat" y la instalación de
cursores "**crystal**"

## Servidores

Se incorporan en la parte servidores instalación para apache2, postregsql,
mariadb, NodeJS, bind9 y docker.

![Imagen de previsualización 1](docs/Servidores.png)

### Apache 2

Se crean 3 servidores virtuales:

- Por defecto escuchando todo, con ruta /var/www/html
- Público como publico.local, con ruta /var/www/html/Publico
- Privado como privado.local, con ruta /var/www/html/Privado y contraseña
creada/generada en /var/www/.htpasswd

Todos por el puerto estándar, 80

### PHP

En este script para seguir rigurosamente la filosofía **Debian** apostando por
la seguridad que nos acostumbra y sobre todo la estabilidad la cual es bastante
conocida, optamos a seguir siempre con la versión más alta de sus repositorios
estables y oficiales libres.

Se instalan los siguientes paquetes básicos desde repositorios:

- php
- php-cli
- libapache2-mod-php

Se instalan los siguientes paquetes extras desde repositorios:

- php-gd
- php-curl
- php-pgsql
- php-sqlite3
- sqlite
- sqlite3
- php-intl
- php-mbstring
- php-xml
- php-xdebug
- php-json

Se instala Composer y algunos paquetes con este:

- composer

Se instalan las siguientes herramientas de fuentes externas:

- psysh → Un intérprete interactivo para aprender o hacer debug, incluyendo su
documentación accesible una vez dentro del mismo intérprete usando la palabra
reservada **doc** seguido de la función que solicitamos ayuda/información.

Se modifican los archivos de configuración para **Todas** las versiones de
PHP que se encuentren instaladas en el equipo. Estas modificaciones serán:

- timezone = 'UTC'
- error_reporting = E_ALL
- display_errors = On
- display_startup_errors = On
- max_execution_time = 180
- memory_limit = 128M
- upload_max_filesize = 512M
- post_max_size = 1024M

### PostgreSQL

Se instala la última versión stable de PostgreSQL (en el futuro se configuran
todas las versiones que pudieran estar instalada en el sistema), configura:

- intervalstyle = 'iso_8601
- timezone = 'UTC'

### MariaDB

Instala el cliente y el servidor para MariaDB (versión libre de MySQL)

También instala phpmyadmin para poder manipular/trabajar con estas bases de
datos de forma gráfica desde su interfaz web.

Una vez instalado plantea si quieres crear un usuario para desarrollar con el
nombre "**dev**" y con la contraseña en un principio "**dev**" dándole todos
los permisos de administración y manipulación a este usuario. No debe usarse
así en producción y se aconseja una vez finalizado el script cambiar la
contraseña de este usuario si habilitamos la posibilidad de conectar fuera de
localhost (para evitar que en sitios públicos puedan acceder, esto aún así es
poco probable además).

### Python

Contempla la instalación de Python2 y Python3 con sus gestores de paquetes
**pip** y **pip3**.

Además se instalan una serie de librerías normalmente recurridas.

### NodeJS

Instala NodeJS (tienen que estar los repositorios agregados) y además contempla
la instalación de algunos paquetes como ámbito global para poder corregir
sintaxis javascript en algunos IDE's y/o desde terminal.

También instala desde **npm** bower y los siguientes paquetes globales:

- eslint
- jscs
- compass
- stylelint
- bundled

## Lenguajes de Programación

Se plantea la instalación y configuración de los siguientes lenguajes:

- C
- C++
- go
- php
- python
- ruby
- nodejs

## Directorios

- Accesos_Directos → Contiene los accesos directos individuales para usuario
que van en ~/.local/share/applications
- Apache2 → Contenido para la estructura de apache
- Apps → Contiene scripts y configuraciones especiales para ciertas aplicaciones
- docs → Directorio con la documentación del proyecto e imágenes.
- fonts → Contiene un directorio por cada conjunto de fuentes similares
- Personalizar → Scripts para configurar la estética y comportamientos del sistema, cambiar fondos/temas/iconos/cursores y la instalación opcional de escritorios o window manager.
- conf → Contiene archivos de configuración o plantillas para generarlos
- tmp → Directorio donde se descargan los archivos temporales, se crea al
iniciar el script.
- Servidores → Instala y configura servidores.
- Lenguajes-Programacion → Instala y configura lenguajes de programación.
- Repositorios → Contiene las listas de repositorios para añadirlas al sistema
cuando se elige la opción de agregar repositorios.
- Desktops → Instala y configura escritorios o window manager

# Scripts

- funciones.sh → Contiene funciones globales y auxiliares para no repetir código
- configuraciones.sh → Establece aplicaciones determinadas.
- limpiador.sh → Este script limpia los directorios y archivos que pueden
causar más problemas en algún momento, esto existe para depurar principalmente
y su uso se desaconseja por ser áltamente arriesgado a perder datos.
- main.sh → Programa principal con menú para elegir paso a realizar

Dentro de Apps/

## IDEs

![Previsualización Menú IDEs](docs/IDEs.png)

  - Atom_IDE.sh → Instala el editor ATOM con su configuración y complementos
  - Brackets.sh → Instala y configura Brackets
  - Ninja-IDE.sh → Instala y configura Ninja IDE
  - aptanastudio.sh → (No implementado aún, en proceso)
  - netbeans.sh → (No implementado aún, en proceso)
  - phpstorm.sh → Instala y configura el IDE PhpStorm para Debian GNU/Linux
  - pycharm.sh → (No implementado aún, en proceso)
  - webstorm.sh → (No implementado aún, en proceso)
- bashit.sh → Instala y configura Bash-it
- DBeaver.sh → Instala y configura DBeaver
- Firefox.sh → Instala la versión para desarrolladores **Quantum** y la versión
en desarrollo principal **Nightly**
- GitKraken.sh → Instala y configura GitKraken
- Haroopad.sh → Instala y configura Haroopad
- i3wm.sh → Instala y configura gestor de ventanas i3wm
- OhMyZsh.sh → Instala y configura OhMyZsh
- Pencil-Project.sh → Instala y configura Pencil Project
- spacevim.sh → Instala y configura SpaceVim
- vim.sh → Instala y configura Vim

Estructura pendiente de ordenar, alguna información extra:

- Configurar_GIT.sh → Scripts para configurar la integración de GIT, GitHub y
GitLab
- Instalar_Software → Instala los programas indicados en la lista
"Software.lst" y algunos extras
- Personalización_GTK.sh → Genera fondos para grub, escritorio, gdm... y además
iconos, temas y cursores
- Tipografías.sh → Instala fuentes tipográficas
- Variables_Entorno.sh → Genera variables de entorno que seran globales en el
sistema

## Desktops y Windows Manager

Sección opcional que permite instalar y dejar configurado automáticamente el
estcritorio o window manager elegido.

Puedes leer más sobre los escritorios desde aquí:
https://github.com/raupulus/debian-developer-conf/Personalizar/Desktops/README.md

### i3 Window Manager

Instala y configura i3 Window Manager personalizando la barra de estado con i3pystatus y applets autoiniciados.

![Previsualización i3](docs/i3.png)

![Previsualización i3 con dos monitores](docs/i3-Dual_Monitor.png)

### Xmonad

### Openbox

## Comenzar con el script como usuario normal

```bash
cd $HOME
git clone https://github.com/raupulus/debian-developer-conf
```

## Comenzar con el script como root en vps

```bash
apt install git wget sudo
wget https://raw.githubusercontent.com/raupulus/debian-developer-conf/master/main-vps.sh -O /tmp/main-vps.sh
cd /tmp
chmod ugo+x main-vps.sh
./main-vps.sh
```
