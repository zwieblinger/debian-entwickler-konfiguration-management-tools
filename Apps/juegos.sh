#!/usr/bin/env bash
# -*- ENCODING: UTF-8 -*-
##
## @author     Raúl Caro Pastorino
## @copyright  Copyright © 2019 Raúl Caro Pastorino
## @license    https://wwww.gnu.org/licenses/gpl.txt
## @email      public@raupulus.dev
## @web        https://raupulus.dev
## @gitlab     https://gitlab.com/raupulus
## @github     https://github.com/raupulus
##
##             Applied Style Guide:
## @style      https://gitlab.com/raupulus/bash-guide-style

############################
##      INSTRUCTIONS      ##
############################
##

###########################
##       FUNCIONES       ##
###########################
aplicaciones_juegos() {
    echo -e "$VE Juegos$CL"
    actualizarRepositorios

    repararGestorPaquetes

    instalarSoftwareLista "$SOFTLIST/Juegos/arcade.lst"
    instalarSoftwareLista "$SOFTLIST/Juegos/emuladores.lst"
    instalarSoftwareLista "$SOFTLIST/Juegos/estrategia.lst"
    instalarSoftwareLista "$SOFTLIST/Juegos/mesa.lst"
    instalarSoftwareLista "$SOFTLIST/Juegos/platforms.lst"

    repararGestorPaquetes
}
