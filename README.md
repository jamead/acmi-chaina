ACMI Frontend Platform - Chain A 

Gateware for ACMI Frontend.  Uses custom Artix/PicoZed board as the hardware platform.    Responsible for all ACMI related safety tasks 

Uses the DESY FWK FPGA Firmware Framework https://fpgafw.pages.desy.de/docs-pub/fwk/index.html

Clone with --recurse-submodules to get the FWK repos

git clone --recurse-submodules https://github.com/jamead/acmi-chaina

Setup Environment: make env (first time only)

To build firmware make cfg=hw project (Sets up project)

make cfg=hw gui (Open in Vivado)

make cfg=hw build (Builds bit file)


