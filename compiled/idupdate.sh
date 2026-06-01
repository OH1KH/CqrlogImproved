#!/bin/bash
clear
if [ $# -ne 2 ]; then
 echo "For updating QRZlog logid numbers to old qsos that you" 
 echo "have saved to QRZlog before you upgraded to version (142)"
 echo "[or higher] that supports QRZlog online logs upload."
 echo "(preferences/Online logs/QRZlog)."
 echo
 echo "You must first download QRZlog as adif file from QRZ.com"
 echo "'logname' is 'cqrlogXXX'"
 echo " where XXX is 3digit zero padded log number like 001"
 echo
 echo "Use: $0 <adif_file_name> <logname> [> /tmp/debug.txt]"
 echo
 echo "Start Cqrlog before running script if you have"
 echo "checked 'save log data to local machine' checkbox."
 echo "Keep Cqrlog running while this script runs!"
 echo
 echo "Otherwise check script variable 'sqlcmd' to correspond"
 echo "your SQL server settings and cqrlog database log number."
 echo "You do not need to start Cqrlog in that case."
 echo
 echo "You can direct output to debug text file adding arrow right"
 echo "followed by filename to the end of srcipt starting command line"
 exit
fi
 
header=""
qsook=0
qsofail=0
total=0

####This line below is used when localhost sql server is used.
####Check following:  username and password and cqrlog log number (3 digits from 001 upwards)
####Comment out sqlcmd-line below with "/sock" adding # to beginning of line
sqlcmd="mysql -ucqrlog -poh1kh $2 --skip-column-names -se "



####This line below is used when "save log data in local machine" is used. 
####Start cqrlog before running script it creates the database/sock file.
sqlcmd="mysql -S /home/$USER/.config/cqrlog/database/sock $2 --skip-column-names -se "

# subroutine to clean variables
function newqso(){ 
    record=""
    call=""
    dat=""
    tim=""
    band=""
    mode=""
    qrzid=""
    cqid=""
}

function idstoresize() {
 echo
 echo "Table id_store record count is now "$($sqlcmd"SELECT count(id) FROM id_store")"."
 echo
}

# loop begins------------------------
echo
echo "Updating connections between 'QRZlog_logid' and 'id_cqrlog_main' in table 'id_store'"
echo "-------------------------------------------------------------------------------------"
echo Reading ADIF file:
echo "    "$1 
echo Using MariaDB command line:
echo "    "$sqlcmd"<SQL command to execute>"
idstoresize
echo "--------------------------------------------------------------------------------------"
echo
echo "Enter to start, Ctrl+C to Quit"
read key
newqso
while IFS= read -r line || [[ -n "$line" ]]; do

 #Find qso data from ADIF file
    if grep -qi "call:" <<< "$line"; then
      call=${line##*">"}
    fi
    if grep -qi "band:" <<< "$line"; then
      band=${line##*">"}
    fi
    if grep -qi "mode:" <<< "$line"; then
      mode=${line##*">"}
    fi
    if grep -qi "qso_date:" <<< "$line"; then
      dat=${line##*">"}
      dat="${dat:0:4}"-"${dat:4:2}"-"${dat:6:2}"
    fi
    if grep -qi "time_off:" <<< "$line"; then
      tim=${line##*">"}
      tim="${tim:0:2}":"${tim:2:2}"
    fi
    if grep -qi "qrzlog_logid:" <<< "$line"; then
      qrzid=${line##*">"}
    fi
    
    # When eor found hande found data
    if grep -qi "<eor>" <<< "$line"; then
    total=$((total+1))
     #Try to find ADIF record qso from log database 
       cqid=$($sqlcmd"SELECT id_cqrlog_main FROM cqrlog_main WHERE qsodate='$dat' AND callsign='$call' AND time_off='$tim' AND band='$band' AND mode='$mode'")
       # both cqrlog_id and qrzlog_id found then update table id_store if there is not already qrzlog_id found
       if [ -n "$qrzid" ] && [ -n "$cqid" ]; then
         $sqlcmd"INSERT INTO id_store (id_cqrlog_main, qrz_logid) SELECT $cqid,'$qrzid' WHERE NOT EXISTS (SELECT 1 FROM id_store  WHERE id_cqrlog_main=$cqid AND qrz_logid='$qrzid')"
         echo $total QSO: $dat $tim $call $band $mode QRZlog_logid:$qrzid id_cqrlog_main:$cqid
         qsook=$((qsook+1))
       else
         echo $total QSO NOT FOUND: $dat $tim $call $band $mode QRZlog_logid:$qrzid
         qsofail=$((qsofail+1))
       fi

    #clean variables for next record
    newqso
    fi
    
done < "$1"

# loop ends------------------------
echo
echo "--------------------------------------------------------------"
echo "Passed $qsook and failed with $qsofail records from total $total of ADIF QSO records."
idstoresize
echo

exit

