proc custom_report {num_paths path_type} {

    if {$path_type == "in2reg"} {
        set paths [get_timing_paths -from [all_inputs] -to [all_registers] -nworst $num_paths -max_paths $num_paths -delay_type max -slack_lesser_than 100]
    } elseif {$path_type == "reg2reg"} {
        set paths [get_timing_paths -from [all_registers] -to [all_registers] -nworst $num_paths -max_paths $num_paths -delay_type max -slack_lesser_than 100]
    } elseif {$path_type == "reg2out"} {
        set paths [get_timing_paths -from [all_registers] -to [all_outputs] -nworst $num_paths -max_paths $num_paths -delay_type max -slack_lesser_than 100]
    } else {
        puts "ERROR: path_type must be in2reg, reg2reg, or reg2out"
        return
    }

    set report_lines [list]

    foreach_in_collection path $paths {
        set startpoint [get_attribute $path startpoint]
        set endpoint [get_attribute $path endpoint]
        set slack [get_attribute $path slack]
        set points [get_attribute $path points]

        set startpoint_name [get_attribute $startpoint full_name]
        set endpoint_name [get_attribute $endpoint full_name]

        set cells_in_path [list]
        set total_power 0

        foreach_in_collection point $points {
            set obj [get_attribute $point object]
            set obj_class [get_attribute $obj object_class]

            if {$obj_class == "pin"} {
                set cell [get_cells -of_objects $obj]

                if {[sizeof_collection $cell] > 0} {
                    set cell_name [get_attribute $cell full_name]

                    if {[lsearch $cells_in_path $cell_name] < 0} {
                        lappend cells_in_path $cell_name

                        set internal_power [get_attribute $cell internal_power]
                        set switching_power [get_attribute $cell switching_power]
                        set leakage_power [get_attribute $cell leakage_power]

                        set cell_power [expr {$internal_power + $switching_power + $leakage_power}]
                        set total_power [expr {$total_power + $cell_power}]
                    }
                }
            }
        }

        set num_cells [llength $cells_in_path]
        lappend report_lines [list $startpoint_name $endpoint_name $slack $num_cells $total_power]
    }

    set sorted_lines [lsort -real -decreasing -index 4 $report_lines]

    puts "<startpoint> <endpoint> <slack> <num_of_cells_in_path> <sum_of_tot_power_of_cells_in_path>"

    foreach line $sorted_lines {
        puts "[lindex $line 0] [lindex $line 1] [lindex $line 2] [lindex $line 3] [lindex $line 4]"
    }
}