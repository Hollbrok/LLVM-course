label0
  ALLOCATE x1
  ALLOCATE x2  
  BITCAST x3 x1                                        
  LIFETIME_START x3
  BITCAST x4 x2                                        
  LIFETIME_START x4  
  PTRTOINT x5 x1
  PTRTOINT x6 x2
  RAND x7 1000 5000
  TRUNC x7 x7
  XOR x8 x8 x8
  SGT_BR x7 label10 label18
label10                                              
  RAND x9 0 119
  RAND x10 0 119
  GEP_DEFAULT x11 x1 x10 x9
  STORE x11 1 
  GEP_DEFAULT x12 x2 x10 x9
  STORE x12 0
  INC_EQ x0 x8 x7
  BR_COND x0 label18 label10
label18                                               
  BR label19
label19                                             
  INTTOPTR x13 x5  
  INTTOPTR x14 x6  
  GEP x15 x13 
  XOR x16 x16 x16
  BR label25
label25                                             
  TRUNC x17 x16 
  XOR x18 x18 x18
  BR label31
label28                                              
  INC_EQ x31 x16 120
  XOR x27 x27 x27
  BR_COND x31 label46 label25
label31                                              
  TRUNC x19 x18  
  CNT_ALIVE x20 x15 x17 x19 
  GEP_LOAD x21 x13 x16 x18 
  CMP_EQ x22 x21 1 
  AND_EQ x23 x20
  EQ_SELECT x24 x20 x22 x23
  ZEXT x25 x24 
  GEP_STORE x25 x14 x16 x18
  INC x18
  EQ_BR x18 label28 label31
label46                                             
  TRUNC x28 x27
  XOR x30 x30 x30
  BR label52
label49                                               
  INC x27
  EQ_BR x27 label59 label46
label52                                               
  GEP_LOAD x26 x14 x27 x30
  TRUNC x29 x30
  DRAW x28 x29 x26
  INC x30
  EQ_BR x30 label49 label52
label59                                               
  DISPLAY  
  SWAP x5 x6  
  BR label19
exit
  EXIT
