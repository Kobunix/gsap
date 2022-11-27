#!/bin/sh


# THIS SCRIPT IS FREE FOR EVERYONE
# HOWEVER YOU NEED TO RESPECT THE AUTHOR OF THIS SCRIPT
# KEEP CREDITS AND MENTION THE USE OF THE SCRIPT
#
# Created by Kobunix <help@rootwork.eu>
#

# ================================================================
WHITE='\033[1;37m'
RED='\033[0;31m'
NC='\033[0m'
Black='\033[0;30m'
Green='\033[0;32m'
Yellow='\033[0;33m'
Blue='\033[0;34m'
Purple='\033[0;35m'
Cyan='\033[0;36m'
White='\033[0;37m'


BASE_APPS='curl ipset iptables iptables-persistent'
# ================================================================

clear

Error () {
	echo "${Green}#                            [Available Options]                            #"
	echo "${Green}============================================================================="
	echo "${Green}#                                                                           #${NC}"
	echo "${Green}#${WHITE}    --install         Install the needed packages\t\t\t    ${Green}#"
	echo "${Green}#${WHITE}    --uninstall       Uninstall GSAP\t\t\t\t\t    ${Green}#"
	echo "${Green}#${WHITE}    --updatetor       Update tor Exit nodes\t\t\t            ${Green}#"
	echo "${Green}#                                                                           #"
	echo "${Green}#${WHITE}    tor4              Apply tor network ban\t\t\t            ${Green}#"
	echo "${Green}#${WHITE}    tor6              Apply tor network ban\t\t\t            ${Green}#"
	echo "${Green}#${WHITE}    hostings          Apply hostings ban\t\t\t            ${Green}#"
	echo "${Green}#                                                                           #"
	echo "${Green}=============================================================================${NC}"
}


# ----------------------------------------------------------------------------------------------------
# @Uninstall 
# ----------------------------------------------------------------------------------------------------
UninstallGSAP () {

	echo "${RED}[Uninstall] ${WHITE}Uninstalling ipset rules. ${NC}"
	
	ipset flush tornetv4 > /dev/null 2>&1
	ipset flush tornetv6 > /dev/null 2>&1
	ipset flush common > /dev/null 2>&1

	ipset destroy tornetv4 > /dev/null 2>&1
	ipset destroy tornetv6 > /dev/null 2>&1
	ipset destroy common > /dev/null 2>&1

}

# ----------------------------------------------------------------------------------------------------
# @TorNetwork Functions
# ----------------------------------------------------------------------------------------------------

TOR_Rules () {
	iptables -A INPUT -m set --match-set tornet src -j DROP
}

TOR_Update_IPV4 () {
	curl 'https://lists.fissionrelays.net/tor/exits-ipv4.txt' | xargs -n 1 ipset -A tornetv4 > /dev/null 2>&1
	curl 'https://lists.fissionrelays.net/tor/relays-ipv4.txt' | xargs -n 1 ipset -A tornetv4 > /dev/null 2>&1
}

TOR_Update_IPV6 () {
	curl 'https://lists.fissionrelays.net/tor/exits-ipv6.txt' | xargs -n 1 ipset -A tornetv6 > /dev/null 2>&1
	curl 'https://lists.fissionrelays.net/tor/relays-ipv6.txt' | xargs -n 1 ipset -A tornetv6 > /dev/null 2>&1
}

# ----------------------------------------------------------------------------------------------------
# @Prereqs 
# ----------------------------------------------------------------------------------------------------

Install_Prereqs () {
	echo "${RED}[Install] ${WHITE}Checking for system updates ${NC}"
	apt-get update > /dev/null 2>&1
	echo "${RED}[Install] ${WHITE}Applying system upgrade (if available)${NC}"
	apt-get upgrade -y > /dev/null 2>&1
	echo "${RED}[Install] ${WHITE}Installing required APPS : '${BASE_APPS}' ${NC}"
	apt-get install -y ${BASE_APPS} > /dev/null 2>&1
	
	echo "${RED}[Install] ${WHITE}Creating ipset entry : tornetv4 ${NC}"
	ipset create tornetv4 iphash
	echo "${RED}[Install] ${WHITE}Creating ipset entry : tornetv6 ${NC}"
	ipset create tornetv6 hash:net family inet6
	echo "${RED}[Install] ${WHITE}Creating ipset entry : common ${NC}"
	ipset create common iphash
}

# ----------------------------------------------------------------------------------------------------
# @Header
# ----------------------------------------------------------------------------------------------------
Header () {
	echo "${Green}=============================================================================${NC}"
	echo "${Green}#${RED}      ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄               ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄      ${Green}#"
	echo "${Green}#${RED}     ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌             ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌     ${Green}#"
	echo "${Green}#${RED}     ▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀▀▀              ▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌     ${Green}#"
	echo "${Green}#${RED}     ▐░▌          ▐░▌                       ▐░▌       ▐░▌▐░▌       ▐░▌     ${Green}#"
	echo "${Green}#${RED}     ▐░▌ ▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌     ${Green}#"
	echo "${Green}#${RED}     ▐░▌▐░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌     ${Green}#"
	echo "${Green}#${RED}     ▐░▌ ▀▀▀▀▀▀█░▌ ▀▀▀▀▀▀▀▀▀█░▌ ▀▀▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀▀▀      ${Green}#"
	echo "${Green}#${RED}     ▐░▌       ▐░▌          ▐░▌             ▐░▌       ▐░▌▐░▌               ${Green}#"
	echo "${Green}#${RED}     ▐░█▄▄▄▄▄▄▄█░▌ ▄▄▄▄▄▄▄▄▄█░▌             ▐░▌       ▐░▌▐░▌               ${Green}#"
	echo "${Green}#${RED}     ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌             ▐░▌       ▐░▌▐░▌               ${Green}#"
	echo "${Green}#${RED}      ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀               ▀         ▀  ▀                ${Green}#"
	echo "${Green}=============================================================================${NC}"
	echo "${Green}#${White}                        Game Service - Anti Proxies                        ${Green}#"
	echo "${Green}#${White}                               Version 1.0.0                               ${Green}#"
	echo "${Green}#${White}                      By Kobunix <kobunix@rootwork.eu>                     ${Green}#"
	echo "${Green}=============================================================================${NC}"
}

if [ -z "$1" ]; then
	Header
	Error
else
	echo " "
	
	if [ "$1" = "--updatetor" ]; then
		echo "${RED}[tor4] ${WHITE}Updating list ${NC}"
		TOR_Update_IPV4 > /dev/null 2>&1
		TOR_Update_IPV6 > /dev/null 2>&1
	
	elif [ "$1" = "--install" ]; then
		Install_Prereqs

	elif [ "$1" = "--uninstall" ]; then
		UninstallGSAP

	else
		if [ "$1" = "tor4" ]; then
			
			echo "${RED}[tor4] ${WHITE}Applying rules for ipv4 ${NC}"
			iptables -A INPUT -m set --match-set tornetv4 src -j DROP

	    elif [ "$1" = "tor6" ]; then

	    	echo "${RED}[tor6] ${WHITE}Applying rules for ipv6 ${NC}"
			iptables -A INPUT -m set --match-set tornetv6 src -j DROP

	    elif [ "$1" = "hostings" ]; then
			echo "filled hostings"
		
		else
			Error
		fi
	fi
	echo " "
fi
