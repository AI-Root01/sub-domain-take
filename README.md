# Subdo-Take.sh ⚔️

> Script Bash para detectar subdominios y posibles subdomain takeover rápido y efectivo.

---

## 🔥 Qué hace

- Usa **sublist3r** y **amass** para buscar subdominios.  
- Filtra duplicados.  
- Revisa subdominios activos con **httprobe**.  
- Detecta vulnerabilidades de takeover con **takeover**.

Ideal para usuarios de **Kali**, **Parrot** y cualquier distro Linux orientada a pentesting.

---

## 🛠️ Requisitos

- bash  
- sublist3r  
- amass  
- httprobe  
- takeover  
- wordlist `rockyou.txt` en `/usr/share/wordlists/`

---

## 🚀 Uso

```bash
chmod +x subdo-take.sh
./subdo-take.sh dominio.com

