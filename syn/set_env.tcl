set RTL_FILE        src
set working_design  default_top_name
set file_version    dc_v3
set do_scan	    0

set RPT_DIR         RPT
set OUT_DIR         OUT

set RPT_OUT  [format "%s%s" $RPT_DIR/ $file_version]
set DATA_OUT [format "%s%s" $OUT_DIR/ $file_version]

set lib_slow     slow
set lib_fast     fast 



