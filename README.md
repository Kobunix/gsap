# GS:AP - Game Service Anti-Proxies

This tool will prevent external proxies to access the entiere network of your server(s).
This is a beta version, fixes and options will come in future.

## How to install ?
- Download the script with your server : **`wget https://github.com/Kobunix/gsap/blob/main/antiproxies.sh`**
- Give file execution rights : **`chmod +x antiproxies.sh`**
- Start the script with **`sh antiproxies.sh --install`** to install the required dependencies. 

## How to uninstall ?
Simply run the command : **`sh antiproxies.sh --uninstall`**
And remove the script : **`rm antiproxies.sh`**

## Script Use
**`sh antiproxies.sh --updatetor`**  => To update tor network lists (Exits & Relays) on ipv4/6

**`sh antiproxies.sh tor4`**  => Apply ban on IPv4 for Tor Network

**`sh antiproxies.sh tor6`**  => Apply ban on IPv6 for Tor Network


### Respect my work and credit me if you use it.
### Contact me as needed : kobunix@rootwork.eu
