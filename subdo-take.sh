#!/bin/bash

# Comprobar si se proporcionó un dominio
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <dominio>"
    exit 1
fi

DOMINIO=$1
SUBDOMINIOS_FILE="subdominios.txt"
POTENTIAL_TAKEOVER_FILE="takeover.txt"
SUBDOMAIN_TAKEOVER_FILE="subdomain_takeover.txt"

# Crear o limpiar archivos de salida
> $SUBDOMINIOS_FILE
> $POTENTIAL_TAKEOVER_FILE
> $SUBDOMAIN_TAKEOVER_FILE

echo "Reconocimiento de subdominios para $DOMINIO..."

# Usar sublist3r para encontrar subdominios
sublist3r -d $DOMINIO -o $SUBDOMINIOS_FILE

# Usar amass para encontrar más subdominios
amass enum -d $DOMINIO -o $SUBDOMINIOS_FILE -w /usr/share/wordlists/rockyou.txt

# Filtrar subdominios únicos
sort -u $SUBDOMINIOS_FILE -o $SUBDOMINIOS_FILE

echo "Subdominios encontrados:"
cat $SUBDOMINIOS_FILE

# Comprobar posibles subdomain takeover
echo "Comprobando posibles subdomain takeover..."

while read -r SUBDOMINIO; do
    # Comprobar si el subdominio está vivo
    httprobe -c 10 -t 5000 $SUBDOMINIO | grep "200" | awk '{print $1}' > tmp.txt

    if [ -s tmp.txt ]; then
        echo "$SUBDOMINIO está vivo"

        # Comprobar si el subdominio es susceptible a takeover
        if ! host $SUBDOMINIO | grep "has address"; then
            echo "$SUBDOMINIO podría ser susceptible a takeover" >> $POTENTIAL_TAKEOVER_FILE
        fi
    else
        echo "$SUBDOMINIO no está vivo"
    fi
done < $SUBDOMINIOS_FILE

# Comprobar subdomain takeover con takeover
while read -r SUBDOMINIO; do
    # Comprobar si el subdominio es susceptible a takeover
    if takeover -d $SUBDOMINIO | grep "Vulnerable"; then
        echo "$SUBDOMINIO es vulnerable a subdomain takeover" >> $SUBDOMAIN_TAKEOVER_FILE
    fi
done < $SUBDOMINIOS_FILE

# Mostrar resultados de takeover
if [ -s $POTENTIAL_TAKEOVER_FILE ]; then
    echo "Posibles subdomain takeover encontrados:"
    cat $POTENTIAL_TAKEOVER_FILE
else
    echo "No se encontraron posibles subdomain takeover."
fi

if [ -s $SUBDOMAIN_TAKEOVER_FILE ]; then
    echo "Subdomain takeover encontrados:"
    cat $SUBDOMAIN_TAKEOVER_FILE
else
    echo "No se encontraron subdomain takeover."
fi
