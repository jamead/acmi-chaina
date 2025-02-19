################################################################################
# Main tcl for project
################################################################################

# ==============================================================================
proc init {} {
   addSrcModule app ${::fwfwk::ProjectPath}/src/hw/tcl/main.tcl

  # DESY RDL, address space configuration
  set ::fwfwk::addr::TypesToGen {vhdl h map adoc}
  set ::fwfwk::addr::TypesToAdd {vhdl}

}

# ==============================================================================
proc setSources {} {
}

# ==============================================================================
proc setAddressSpace {} {
  #addAddressSpace ::fwfwk::AddressSpace "pl_regs" ARRAY {C0 0x00800000 8M} app::AddressSpace

}

# ==============================================================================
proc doOnCreate {} {
}

# ==============================================================================
proc doOnBuild {} {
}

# ==============================================================================
proc setSim {} {
}
