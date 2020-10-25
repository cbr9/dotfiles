# close all open windows gracefully without closing the Desktop environment
WIN_IDs=$(wmctrl -l | grep -vwE "Desktop$|kde-panel$" | cut -f1 -d' ')
for i in $WIN_IDs
do 
	wmctrl -ic "$i"
done

# Keep checking and waiting until all windows are closed (you probably don't need this section)
while test $WIN_IDs
do 
    sleep 0.1
    WIN_IDs=$(wmctrl -l | grep -vwE "Desktop$|kde-panel$" | cut -f1 -d' ')
done 

sleep 3
systemctl poweroff
