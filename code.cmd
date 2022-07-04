#                                               #
#    Tecnology typical to the 1980s CMOS        #
#                                               #
#        2D CMOS 250nm tecnology node           #
#                                               #
#                                               #
#################################################
math coord.ucs
#-----------------------Declare intial grid-----------------------#

#-----------------------X-axis VERTICAL DIRECTION-----------------------#
line x location= 0.0      spacing= 3.0<nm>     tag= SiTop               
line x location= 0.5<um>  spacing= 20.0<nm>                      
line x location= 1.2<um>  spacing= 0.5<um>     tag= SiBottom                        

#-----------------------Y-axis HORIZONTAL DIRECTION-----------------------#
line y location= 0.0      spacing= 20.0<nm>  tag= Left         
line y location= 1.5<um>  spacing= 20.0<nm>  tag= Right

#-----------------------Silicon substrate-----------------------#
region Silicon xlo= SiTop xhi= SiBottom ylo= Left yhi= Right
init concentration= 8.4e+18<cm-3>       field= Boron
AdvancedCalibration
#-----------------------Epitaxial layer growth(P-)-----------------------#
deposit material= {Silicon} type= isotropic time= 1 rate= {1} Boron concentration=6e16<cm-3>
diffuse temp=1100<C> time=20<min>

#-----------------------N-well Implentation-----------------------#

#-------------- Growing Screen Oxide--------------#
gas_flow name= O2_1_N2_1 pressure= 1<atm> flowO2= 1.2<l/min> flowN2= 1.0<l/min>
diffuse temperature= 950<C>  time= 6.739<min> gas.flow= O2_1_N2_1
set OxideThick 40<nm>

#--------------N-Well(phosphorus)Implementation--------------#
mask name = NMOS    segments = {0 0.8 } negative
photo mask = NMOS thickness = 0.5<um>
implant  phosphorus  dose= 1e+13<cm-2>  energy= 70<keV> tilt= 0 rotation= 0  
diffuse temperature= 950<C> time= 15<min>
#N-Well Depth is 0.5<um>
struct tdr = screenshot_1
strip      Photoresist

#-----------------------Boron Implantation Prior LOCOS OXIDATION (Field Areas Doping)-----------------------#
mask name = P_Prior segments = {0.1 0.7 0.8 1.5 } negative
photo mask = P_Prior thickness = 0.5<um>
implant  Boron  dose= 2.0e13<cm-2>  energy= 20<keV> tilt= 0 rotation= 0  
struct tdr = screenshot_2
strip      Photoresist

#-----------------------LOCOS OXIDATION-----------------------#

#-------------- Growing pad oxide--------------#
gas_flow name= O2_1_N2_1 pressure= 1<atm> flowO2= 1.2<l/min> flowN2= 1.0<l/min>
diffuse temperature= 950<C>  time= 6.739<min> gas.flow= O2_1_N2_1
set OxideThick 40<nm>

#--- Nitride layer deposition ---#
deposit Nitride isotropic thickness= 80<nm>
mask name = LOCOS  segments = {0.1 0.7 0.8 1.4 } negative
photo mask = LOCOS thickness = 1<um>
struct tdr= screenshot_3
etch Nitride anisotropic thickness= 0.08
struct tdr= screenshot_4
# Growing Heavy LOCOS oxide
gas_flow name= O2_1_N2_1 pressure= 1<atm> flowH2O= 1.2<l/min> flowN2= 1.0<l/min>
diffuse temperature= 1100<C>  time= 8<min> gas.flow= O2_1_N2_1
struct tdr= screenshot_5
strip      Photoresist
strip Nitride

#-----------------------NMOS Boron-Channel-implantation-----------------------#
mask name= Thershold_adjustment segments = {0 0.1 0.7 1.5} negative
photo mask = Thershold_adjustment thickness = 0.5
implant  Boron  dose= 5.0e12<cm-2>  energy= 10<keV> tilt= 0 rotation= 0  
struct tdr = screenshot_6
strip      Photoresist

#-----------------------PMOS Phosphorus-Channel-implantation-----------------------#
mask name= Th_adj1 segments = {0 0.8 1.4 1.5 } negative
photo mask = Th_adj1 thickness = 0.5
implant  Phosphorus  dose= 5.0e12<cm-2>  energy= 30<keV> tilt= 0 rotation= 0  
struct tdr = screenshot_7
strip      Photoresist

#-----------------------Polysilicon gate deposition-----------------------#
deposit material= {PolySilicon} type= anisotropic time= 1 rate= {0.05}
struct tdr = screenshot_8
# Polysilicon gate pattern
mask name = gate_mask segments = {0.3 0.5 1 1.2 } negative
photo mask = gate_mask thickness = 0.5
etch material = {PolySilicon} type = anisotropic time = 1 rate= {0.05}
struct tdr= screenshot_9
strip      Photoresist

#-----------------------N-Doping LDD-----------------------#
mask name = n-well segments = {0 0.1 0.3 0.5 0.7 0.8 0.8 1.5} negative
photo mask = n-well thickness = 0.5
implant  Phosphorus  dose = 5.0e13<cm-2>  energy = 10<keV> tilt = 0 rotation = 0  
struct tdr= screenshot_10
strip Photoresist
struct tdr = screenshot_11

#-----------------------P-Doping LDD-----------------------#
mask name= p-well segments = {0 0.8 1 1.2 1.4 1.5} negative
photo mask = p-well thickness = 0.5
struct tdr = screenshot_12
implant  Boron  dose = 5.0e13<cm-2>  energy = 2<keV> tilt = 0 rotation = 0  
strip Photoresist
struct tdr = screenshot_13

#-----------------------Spacers(Sidewalls Gate Oxides)& Polygate-reoxidation-----------------------#
deposit material= {Oxide} type = isotropic thickness = 4.8<nm>
struct tdr = screenshot_14
mask name= G-mask segments = {0.3 0.5 1 1.2 } negative
photo mask = G-mask thickness = 0.5
etch material = {Oxide} type = anisotropic thickness = 4.8<nm>
struct tdr = screenshot_15
strip Photoresist
struct tdr = screenshot_16

#-----------------------N+ Doping Source & Drain-----------------------#
mask name = PMOS segments = {0 0.1 0.3 0.5 0.7 0.8 0.8 1.5} negative
photo mask = PMOS thickness = 0.5
struct tdr = screenshot_17
implant  Phosphorus  dose = 3.0e15<cm-2>  energy = 10<keV> tilt = 0 rotation = 0  
struct tdr = screenshot_18
strip Photoresist
struct tdr = screenshot_19

#-----------------------P+ Doping Source & Drain-----------------------#
mask name= p-well segments = {0 0.8 1 1.2 1.4 1.5} negative
photo mask = p-well thickness = 0.5
struct tdr = screenshot_20
implant   Boron  dose = 3.0e15<cm-2>  energy = 5<keV> tilt = 0 rotation = 0  
struct tdr = screenshot_21
strip Photoresist
struct tdr = screenshot_22

#-----------------------remove oxide,expose Source & Drain before metalization-----------------------#
mask name= G-mask1 segments = {0 0.2 0.29 0.51 0.6 0.9 0.99 1.21 1.27 1.5} negative
photo mask = G-mask1 thickness = 0.5
etch material = {Oxide} type = anisotropic thickness = 20<nm>
struct tdr = screenshot_23
strip Photoresist
struct tdr = screenshot_24

#-----------------------Deposit Titanium (metal Contact)-----------------------#
deposit material = {Titanium} thickness = 70<nm>
struct tdr = screenshot_25

#-----------------------remove excess Titanium-----------------------#
etch material = {Titanium} type = isotropic thickness = 75<nm>
struct tdr = screenshot_26








