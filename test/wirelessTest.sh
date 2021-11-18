#!/bin/sh

export POSIXLY_CORRECT=yes
export LC_NUMERIC=en_US.UTF-8

IP=$1

help() {
      echo "Your device needs to be connected via USB."
        echo "You need to provide you ip as an argument"
    }

connect_wireless() {
      adb connect $IP
  }

setup_connection() {
      adb tcpip 5555
  }

main() {
      echo "Plug your device in, when you are ready to continue push any button..."
        read -r -p "Press any button:" VOID
	  setup_connection && connect_wireless
	    echo "Now you can disconnect your device and run your app."
	}

    main
