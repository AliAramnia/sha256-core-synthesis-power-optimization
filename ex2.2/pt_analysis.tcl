##	+----------------------------------------------------------------
##	|		 Synthesis and Optimization of Digital Systems			|
##	|				Politecnico di Torino - TO - Italy				|
##	|						DAUIN - EDA GROUP						|
##	+----------------------------------------------------------------
##	|	author: Valentino Peluso									|
##	|	mail:	valentino.peluso@polito.it							|
##	|	title:	pt_analysis.tcl										|
##	+----------------------------------------------------------------
##	| 	Copyright 2026 DAUIN - EDA GROUP							|
##	+----------------------------------------------------------------

######################################################################
##
## SPECIFY LIBRARIES
##
######################################################################

# SOURCE SETUP FILE
source "./tech/STcmos65/synopsys_pt.setup"

# DEFINE OPTIONS
set report_default_significant_digits 6
set power_enable_analysis true

# SUPPRESS WARNING MESSAGES
suppress_message RC-004
suppress_message PTE-003
suppress_message UID-401
suppress_message ENV-003
suppress_message UITE-489
suppress_message CMD-041
suppress_message PLIB-166
suppress_message PLIB-167
suppress_message PTE-139
suppress_message NED-045
######################################################################
##
## READ DESIGN
##
######################################################################
# DEFINE CIRCUITS
set blockName sha256_core

# DEFINE INPUT FILES
set dir "./saved/${blockName}/synthesis"
set in_verilog_filename "${dir}/${blockName}_postsyn.v"
set in_sdc_filename "${dir}/${blockName}_postsyn.sdc"

# READ
read_verilog $in_verilog_filename
link_design $blockName
read_sdc $in_sdc_filename

set_ideal_network clk
set_ideal_network reset_n

update_timing -full
read_vcd ./sim/sha256_core.vcd -strip_path tb_sha256_core/dut
set_power_clock_scaling -period 2.5 [get_clocks clk]
update_power
report_power
set timing_path [get_timing_paths -nworst 1 -max_paths 1]
set slack [get_attribute $timing_path slack]

set area 0
foreach_in_collection cell [get_cells -hierarchical -filter "is_hierarchical == false"] {
    set area [expr {$area + [get_attribute $cell area]}]
}

puts "CLOCK_PERIOD = [get_attribute [get_clocks clk] period]"
puts "SLACK = $slack"
puts "AREA = $area"
set gates [get_cells -hierarchical -filter "is_hierarchical == false"]

set num_lvt 0
set num_svt 0
set num_hvt 0
set num_total 0

foreach_in_collection gate $gates {
    set ref_name [get_attribute $gate ref_name]
    incr num_total

    if {[string match "HS65_LL*" $ref_name]} {
        incr num_lvt
    } elseif {[string match "HS65_LS*" $ref_name]} {
        incr num_svt
    } elseif {[string match "HS65_LH*" $ref_name]} {
        incr num_hvt
    }
}

set perc_lvt [expr {100.0 * $num_lvt / $num_total}]
set perc_svt [expr {100.0 * $num_svt / $num_total}]
set perc_hvt [expr {100.0 * $num_hvt / $num_total}]

puts "LVT_PERCENT = $perc_lvt"
puts "SVT_PERCENT = $perc_svt"
puts "HVT_PERCENT = $perc_hvt"
exit