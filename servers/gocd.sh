#!/usr/bin/env bash
# -*- ENCODING: UTF-8 -*-
##
## @author     Raúl Caro Pastorino
## @copyright  Copyright © 2021 Raúl Caro Pastorino
## @license    https://wwww.gnu.org/licenses/gpl.txt
## @email      raul@fryntiz.dev
## @web        https://fryntiz.es
## @github     https://github.com/fryntiz
## @gitlab     https://gitlab.com/fryntiz
## @twitter    https://twitter.com/fryntiz
##
##             Applied Style Guide:
## @style      https://gitlab.com/fryntiz/bash-guide-style

############################
##      INSTRUCTIONS      ##
############################

gocd_download() {
    echo -e "$VE Descargando$RO GoCD$CL"
}

gocd_before_install() {
    echo -e "$VE Generando Pre-Configuraciones de$RO GoCD$CL"

    sudo groupadd gocd
    sudo usermod -a -G gocd "$USER"

    if [[ ! -d '/mnt/artifact-storage' ]]; then
        sudo mkdir '/mnt/artifact-storage'
        sudo chown go:go '/mnt/artifact-storage'
        sudo chmod ugo+rx -R '/mnt/artifact-storage'
        sudo chmod ug+w -R '/mnt/artifact-storage'
        sudo chmod g+s -R '/mnt/artifact-storage'
    fi
}

gocd_install() {
    echo -e "$VE Instalando$RO GoCD$CL"
    instalarSoftwareLista "${SOFTLIST}/servers/gocd.lst"
}

gocd_after_install() {
    echo -e "$VE Generando Post-Configuraciones de$RO GoCD$CL"

    echo -e "$VE Creando contraseña para el usuario$RO $USER$CL"
    sudo htpasswd -B -c /etc/go/authentication "${USER}"
    sudo chmod 755 /etc/go/authentication
    sudo chown go:go /etc/go/authentication

    echo -e "$VE Iniciando servidor, comprueba estado y pulsa cualquier tecla$CL"
    sudo systemctl start go-server go-agent
    sudo systemctl status go-*

    echo ""
    read -p "Pulsa cualquier INTRO para continuar" nullparam

    echo -e "$VE Comprueba puertos abiertos http y https:$RO 8153$AM y$RO 8154$CL"
    sudo watch netstat -plnt

    echo ""
    read -p "Pulsa cualquier INTRO para continuar" nullparam


    echo -e "$VE Actualizando$RO certificados$CL"
    sudo update-ca-certificates -f



    Entrar a la url **/go/admin/security/auth_configs**
    id → file_authentication
    plugin id → Password File Authentication
    password file path → /etc/go/authentication
    Allow only known users to login → False


    Cambiar el directorio de artifacts en la configuración:
    :8153/go/admin/config/server#!artifact-management

}

gocd_installer() {
    gocd_download
    gocd_before_install
    gocd_install
    gocd_after_install
}
