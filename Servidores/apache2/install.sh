#!/usr/bin/env bash
# -*- ENCODING: UTF-8 -*-
##
## @author     Raúl Caro Pastorino
## @copyright  Copyright © 2019 Raúl Caro Pastorino
## @license    https://wwww.gnu.org/licenses/gpl.txt
## @email      dev@fryntiz.es
## @web        https://.fryntiz.es
## @gitlab     https://gitlab.com/fryntiz
## @github     https://github.com/fryntiz
## @twitter    https://twitter.com/fryntiz
##
##             Guía de estilos aplicada:
## @style      https://github.com/fryntiz/Bash_Style_Guide

############################
##     INSTRUCCIONES      ##
############################
##

############################
##        FUNCIONES       ##
############################


apache2_descargar() {
    echo -e "$VE Descargando$RO Apache2$CL"
}

apache2_preconfiguracion() {
    echo -e "$VE Generando Pre-Configuraciones de$RO Apache2"
}

apache2_dependencias() {
    echo -e "$VE Instalando$RO Apache2$CL"
    local dependencias="apache2 libapache2-mod-perl2 libapache2-mod-php libapache2-mod-python"

    instalarSoftware "$dependencias"
}

apache2_propietarios() {
    ## Cambia el dueño
    echo -e "$VE Asignando dueños$CL"
    sudo chown www-data:www-data -R '/var/www'
    sudo chown root:root '/etc/apache2/ports.conf'

    ## Agrega el usuario al grupo www-data
    echo -e "$VE Añadiendo el usuario al grupo$RO www-data"
    sudo adduser "$USER" 'www-data'

    if [[ -d '/var/www/default' ]]; then
        sudo chown -R www-data:www-data "/home/$USER/GIT"
        sudo chmod g+s -R '/var/www/default'
    fi

    ## Cada archivo/directorio creado tomará el grupo www-data
    if [[ -d "/home/$USER/GIT" ]]; then
        sudo chown -R "$USER":www-data "/home/$USER/GIT"
        sudo chmod g+s -R "/home/$USER/GIT"
    fi

    if [[ -d "/home/$USER/git" ]]; then
        sudo chown -R "$USER":www-data "/home/$USER/git"
        sudo chmod g+s -R "/home/$USER/git"
    fi
}

apache2_permisos() {
    echo -e "$VE Asignando permisos$RO Configuración$CL"
    sudo chmod 750 '/etc/apache2/ports.conf'
    sudo chmod 750 '/etc/apache2/apache2.conf'

    echo -e "$VE Asignando permisos a$RO Hosts Virtuales$CL"
    sudo chmod ug+rw -R /var/www/*
    sudo chmod 700 '/var/www/.htpasswd'
    sudo chmod 700 '/var/www/private/.htaccess'
    sudo chmod 700 '/var/www/public/.htaccess'
    sudo chmod 700 '/var/www/private/CMS/.htaccess'
    sudo chmod 755 '/etc/apache2/'
    sudo chmod 755 -R '/etc/apache2/sites-available' '/etc/apache2/sites-enabled'
}

apache2_activar_modulos() {
    echo -e "$VE Activando módulos$RO"
    sudo a2enmod rewrite
    sudo a2enmod ssl
}

apache2_desactivar_modulos() {
    echo -e "$VE Desactivando módulos$RO"
    sudo a2dismod php5
}

apache2_postconfiguracion() {
    echo -e "$VE Generando Post-Configuraciones de Apache2"

    ## TODO → Controlar distribución, la ruta de destino cambia.
    sudo cp "$WORKSCRIPT/Apache2/etc/apache2/ports.conf" '/etc/apache2/apache2.conf'
}

apache2_ssl() {
    ## Instalar módulo SSL
    sudo a2enmod ssl
    reiniciarServicio apache2

    ## Comprobar que está activo y abierto el puerto
    netstat -nl | grep 443
    sudo iptables -nL | grep 443

    ## Crear certificado autofirmado
    if [[ ! -d /etc/apache2/ssl ]]; then
        sudo mkdir /etc/apache2/ssl
    fi

    sudo chmod 700 -R /etc/apache2/ssl

    ## Genero certificados para localhost en caso de no existir
    local existe=$(sudo ls /etc/apache2/ssl/localhost.key)
    local existe1=$(sudo ls /etc/apache2/ssl/localhost.csr)
    local existe2=$(sudo ls /etc/apache2/ssl/localhost.crt)
    if [[ ! "$existe" = '/etc/apache2/ssl/localhost.key' ]]; then
        if [[ ! "$existe1" = '/etc/apache2/ssl/localhost.csr' ]]; then
            sudo rm /etc/apache2/ssl/localhost.csr
        fi

        if [[ ! "$existe2" = '/etc/apache2/ssl/localhost.crt' ]]; then
            sudo rm /etc/apache2/ssl/localhost.crt
        fi

        sudo openssl genrsa -des3 -out /etc/apache2/ssl/localhost.key 4096
        sudo openssl req -new -key \
            /etc/apache2/ssl/localhost.key \
            -out /etc/apache2/ssl/localhost.csr

        sudo openssl x509 -req -days 5000 \
            -in /etc/apache2/ssl/localhost.csr \
            -signkey /etc/apache2/ssl/localhost.key \
            -out /etc/apache2/ssl/localhost.crt


        ## Muevo el .key para quitar que pida la contraseña
        sudo mv /etc/apache2/ssl/localhost.key /etc/apache2/ssl/localhostBACKUP.key
        sudo openssl rsa -in /etc/apache2/ssl/localhostBACKUP.key -out /etc/apache2/ssl/localhost.key
        sudo rm /etc/apache2/ssl/localhostBACKUP.key
    fi

    sudo chmod 600 -R /etc/apache2/ssl/

    if [[ "$ENV" = 'dev' ]]; then
        sudo a2ensite publico-ssl.conf
        sudo a2ensite privado-ssl.conf
        sudo a2ensite default-ssl.conf
    fi
}

##
## Agrega configuraciones de seguridad y permisos para los sitios virtuales.
##
apacheDefaultSiteSecurity() {
    ## Crear archivo de usuario con permisos para directorios restringidos
    echo -e "$VE Creando usuario con permisos en apache"
    sudo rm /var/www/.htpasswd 2>> /dev/null

    while [[ -z "$input_user" ]]; do
        read -p "Nombre de usuario para acceder a los sitios web privado → " input_user
    done

    echo -e "$VE Introduce la contraseña para los sitios web privados:$RO"
    sudo htpasswd -c /var/www/.htpasswd $input_user
}

##
## Borrar contenido de /var/www
##
apacheLimpiarSites() {
    sudo systemctl stop apache2
    echo -e "$VE Cuidado, esto puede$RO BORRAR$VE algo valioso$RO"
    read -p " ¿Quieres borrar todo el directorio /var/www/? s/N → " input
    if [[ "$input" = 's' ]] || [[ "$input" = 'S' ]]; then
        sudo rm -R /var/www/*
    else
        echo -e "$VE No se borra$RO /var/www$CL"
    fi
}

##
## Generar enlaces:
## ~/web a /var/www
## ~/git a /var/www/public/git
##
apacheGenerarEnlaces() {
    ## VOY POR AQUÍ:
    if [[ ! -h "/home/$USER/web" ]]; then
    ## Controlando que solo lo haga si origen y destino existe → nueva función global.

    echo -e "$VE Puedes generar un enlace en tu home ~/web hacia /var/www/html/Publico"
    read -p " ¿Quieres generar el enlace? s/N → " input
    if [[ "$input" = 's' ]] || [[ "$input" = 'S' ]]; then
        sudo ln -s '/var/www/html/Publico' "/home/$USER/web"
        sudo chown -R "$USER:www-data" "/home/$USER/web"
    else
        echo -e "$VE No se crea enlace desde ~/web a /var/www/html/Publico"
    fi

    clear
    echo -e "$VE Puedes crear un directorio para repositorios$RO GIT$VE en tu directorio personal"
    echo -e "$VE Una vez creado se añadirá un enlace al servidor web"
    echo -e "$VE Este será desde el servidor /var/www/html/Privado/GIT a ~/GIT$RO"
    read -p " ¿Quieres crear el directorio y generar el enlace? s/N → " input
    if [[ "$input" = 's' ]] || [[ "$input" = 'S' ]]; then
        if [[ ! -d "$HOME/GIT" ]]; then
            echo -e "$VE Creando directorio$RO $HOME/GIT$VE"
            mkdir "$HOME/GIT"
        fi

        ## Creando enlaces en el directorio Home
        if [[ ! -h '/var/www/html/Privado/GIT' ]]; then
            sudo ln -s "$HOME/GIT" '/var/www/html/Privado/GIT'
        fi

        if [[ ! -h "$HOME/git" ]] && [[ -h "$HOME/GIT" ]]; then
            sudo ln -s "$HOME/GIT" "$HOME/git"
        fi
    else
        echo -e "$VE No se crea enlaces ni directorio ~/GIT$CL"
    fi
}

apache2_instalar() {
    apacheLimpiarSites
    apache2_descargar
    apache2_preconfiguracion
    apache2_dependencias
    apache2_propietarios
    apache2_permisos
    apache2_activar_modulos
    apache2_desactivar_modulos
    apache2_ssl
    apacheDefaultSiteSecurity

    ## Reiniciar servidor Apache para aplicar configuración
    reiniciarServicio apache2

    ## Pregunta si generar enlace solo cuando falta uno de ellos
    if [[ ! -h "$HOME/git" ]] &&
       [[ ! -h "$HOME/GIT" ]] &&
       [[ ! -h "$HOME/web" ]]; then
        enlaces
    fi
}
