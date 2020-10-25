#!/bin/bash

case ${1} in
	pre)
		sudo modprobe -r r8168
		;;

	post)
		sudo modprobe r8168
		;;
esac
