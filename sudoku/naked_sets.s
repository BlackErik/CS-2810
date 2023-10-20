                .global naked_sets, single_pass, gather_set, clear_others
                .text

# gather_set(board, group, key) ->
#   set of pencil marks for cells identified by key
gather_set:
                ret

# clear_others(board, group, key, set) ->
#    0: nothing changed
#    1: something changed
clear_others:
                ret

# single_pass(board, group) ->
#   0: nothing change
#   1: something changed
single_pass:
                ret

# naked_sets(board, table) ->
#   0: nothing changed
#   1: something changed
naked_sets:
                ret
