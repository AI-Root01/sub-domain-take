# Subdo-Take.sh

> Script Bash para reconocimiento de subdominios y detección automática de posibles subdomain takeover.

---

## Descripción

Este script automatiza la enumeración de subdominios y verifica vulnerabilidades de subdomain takeover en un dominio objetivo. Usa herramientas populares como **sublist3r**, **amass**, **httprobe** y **takeover** para maximizar la cobertura y precisión.

Ideal para pentesters y profesionales de ciberseguridad que buscan un escaneo rápido y efectivo desde la terminal.

---

## Requisitos

- bash (Linux / macOS)  
- [sublist3r](https://github.com/aboul3la/Sublist3r)  
- [amass](https://github.com/OWASP/Amass)  
- [httprobe](https://github.com/tomnomnom/httprobe)  
- [takeover](https://github.com/m4ll0k/takeover)  
- wordlist `rockyou.txt` en `/usr/share/wordlists/`  

---

## Uso

```bash
chmod +x subdo-take.sh
./subdo-take.sh <dominio>

