set_global_assignment -entity "alt_pll_reconfig" -library "lib_alt_pll_reconfig" -name IP_TOOL_NAME "altera_pll_reconfig"
set_global_assignment -entity "alt_pll_reconfig" -library "lib_alt_pll_reconfig" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "alt_pll_reconfig" -library "lib_alt_pll_reconfig" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_alt_pll_reconfig" -name SPD_FILE [file join $::quartus(sip_path) "alt_pll_reconfig.spd"]

set_global_assignment -library "lib_alt_pll_reconfig" -name MISC_FILE [file join $::quartus(sip_path) "alt_pll_reconfig_sim/alt_pll_reconfig.vhd"]
set_global_assignment -library "lib_alt_pll_reconfig" -name MISC_FILE [file join $::quartus(sip_path) "alt_pll_reconfig_sim/altera_pll_reconfig/altera_pll_reconfig_top.v"]
set_global_assignment -library "lib_alt_pll_reconfig" -name MISC_FILE [file join $::quartus(sip_path) "alt_pll_reconfig_sim/altera_pll_reconfig/altera_pll_reconfig_core.v"]
set_global_assignment -library "lib_alt_pll_reconfig" -name MISC_FILE [file join $::quartus(sip_path) "alt_pll_reconfig_sim/altera_pll_reconfig/altera_std_synchronizer.v"]
