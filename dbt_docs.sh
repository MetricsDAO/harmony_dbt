echo ""
echo "
 ______   ______   _________  
|_   _  .|_   _   |  _   _  | 
  | |  . \ | |_) ||_/ | | \_| 
  | |  | | |  __ .    | |     
 _| |_.' /_| |__) |  _| |_    
|______.'|_______/  |_____|
_____________________________________________________"
echo ""
echo "#1. Generating docs..."
echo ""
dbt docs generate
echo ""
echo "#2. Serving docs..."
echo ""
dbt docs serve --port 8080