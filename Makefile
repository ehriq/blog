dev:
	rm -fr dev/
	hugo serve -wDF -d dev/

prod:
	hugo 
