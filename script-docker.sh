#!/bin/bash
# greenInfra.sh
#
#
# Versão 0.1: Install requirements system for install Docker,Install docker.

# JC GreenMind, 04 Jun de 2019
#

if test "$USER" != "root"
  then
    echo Você precisa executar esse script como super usuario
    echo "Uso: #$(basename "$0") [OPÇÔES]"
    exit 0
  fi

MENSAGEM_USO="
Uso: $(basename "$0") [OPÇÔES]

OPÇÕES:
  -ir, --install-requirements Install requirements for Docker
  -id, --install-docker       Install Docker
  -in, --install-nginx        Install nginx
  -im, --install-mariadb      Install MariaDB

  -h, --help         Mostra esta tela de ajuda e sai
  -V, --version      Mostra a versão do programa e sai
"

# Tratamento das opções de linha de comando
while test -n "$1"
do
	case "$1" in
		-ir | --install-requirements)
			apt-get install -y python3-pip
      pip3 install docker-compose
      exit 0
    ;;

    -id | --install-docker)
			curl -fsSL https://get.docker.com | bash
      exit 0
		;;

    -in | --install-nginx)
			apt-get update
      apt-get install -y nginx
      exit 0
		;;

    -im | --install-mariadb)
			apt-get update
      apt-get install -y mariadb-server mariadb-client
      echo "Deseja realizar secure installation Y (Yes) - N (No)"
        read opcao;
        if [ $opcao == "y" | $opcao == "Y"];
        then
          mysql_secure_installation
          clear
          echo "Configuraçõs de seguraça terminadas!"
          exit 0\
        elif [ $opcao == "n" | $opcao == "N"];
        then
           echo "Não realizar o secure installation pode trazer problemas de segurança"
           exit 0
        else;
         then
         echo "Cuidado com a senha padrão"
        fi
      exit 0
		;;

    -u | --update)
		  apt-get update
      exit 0
		;;

		-h | --help)
			echo "$MENSAGEM_USO"
			exit 0
		;;

		-V | --version)
			echo -n $(basename "$0")
			# Extrai a versao diretamente dos cabeçalhos do programa
			grep '^# Versão ' "$0" | tail -1 | cut -d : -f 1 | tr -d \#
			exit 0
		;;

		*)
			echo Opção invalida: $1
			exit 1
		;;
	esac

	shift
done
