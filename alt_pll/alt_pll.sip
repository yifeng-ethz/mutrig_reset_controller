set_global_assignment -entity "alt_pll" -library "lib_alt_pll" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "alt_pll" -library "lib_alt_pll" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "alt_pll" -library "lib_alt_pll" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_alt_pll" -name SPD_FILE [file join $::quartus(sip_path) "alt_pll.spd"]

set_global_assignment -library "lib_alt_pll" -name MISC_FILE [file join $::quartus(sip_path) "alt_pll_sim/alt_pll.vho"]
