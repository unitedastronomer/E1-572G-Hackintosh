/*
    
    This is combined ACPI Patch _UPC to XUPC
    
    {
        Scope (XXXX)
        {
            Method (_UPC, 0, Serialized)  // Method (_UPC) was set as "Serialized" in DSDT, I just copied it.
            {

                    Return (GUPC             // The GUPC method:
                    (0xFF,                   //  0xFF = enable, Zero is disabled    
                                  0x03))     //  0xFF = Internal, 0x00 = USB 2.0, 0x03 = USB 3.0 
             }
        }
    

*/


DefinitionBlock ("", "SSDT", 2, "ACER", "USBMap", 0x00001000)
{

    External (_SB_.PCI0, DeviceObj)    
    External (_SB_.PCI0.XHC_, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS01, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS01.XUPC, MethodObj)     
    External (_SB_.PCI0.XHC_.RHUB.HS02, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS02.XUPC, MethodObj)     
    External (_SB_.PCI0.XHC_.RHUB.HS03, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS03.XUPC, MethodObj)     
    External (_SB_.PCI0.XHC_.RHUB.HS04, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS04.XUPC, MethodObj)     
    External (_SB_.PCI0.XHC_.RHUB.HS05, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS05.XUPC, MethodObj)     
    External (_SB_.PCI0.XHC_.RHUB.HS06, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS06.XUPC, MethodObj)     
    External (_SB_.PCI0.XHC_.RHUB.HS07, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS07.XUPC, MethodObj)     
    External (_SB_.PCI0.XHC_.RHUB.HS08, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS08.XUPC, MethodObj)     
    External (_SB_.PCI0.XHC_.RHUB.HS09, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS09.XUPC, MethodObj)     
    External (_SB_.PCI0.XHC_.RHUB.HS10, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS10.XUPC, MethodObj)     
    External (_SB_.PCI0.XHC_.RHUB.HS11, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS11.XUPC, MethodObj)     
    External (_SB_.PCI0.XHC_.RHUB.HS12, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS12.XUPC, MethodObj)     
    External (_SB_.PCI0.XHC_.RHUB.HS13, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS13.XUPC, MethodObj)     
    External (_SB_.PCI0.XHC_.RHUB.HS14, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS14.XUPC, MethodObj)     
    External (_SB_.PCI0.XHC_.RHUB.HS15, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS15.XUPC, MethodObj)     
    External (_SB_.PCI0.XHC_.RHUB.SSP1, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SSP1.XUPC, MethodObj)     
    External (_SB_.PCI0.XHC_.RHUB.SSP2, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SSP2.XUPC, MethodObj)     
    External (_SB_.PCI0.XHC_.RHUB.SSP3, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SSP3.XUPC, MethodObj)     
    External (_SB_.PCI0.XHC_.RHUB.SSP4, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SSP4.XUPC, MethodObj)     
    External (_SB_.PCI0.XHC_.RHUB.SSP5, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SSP5.XUPC, MethodObj)     
    External (_SB_.PCI0.XHC_.RHUB.SSP6, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SSP6.XUPC, MethodObj)     


    Scope (\)
    {
        Method (GUPC, 2, Serialized)
        {
            Name (PCKG, Package (0x04)
            {
                0xFF, 
                0x03, 
                Zero, 
                Zero
            })
            PCKG [Zero] = Arg0
            PCKG [One] = Arg1
            Return (PCKG) /* \GUPC.PCKG */
        }

        Scope (_SB)
        {
            Scope (PCI0)
            {
                                Scope (XHC)
                {
                    Scope (RHUB)
                    {
                        Scope (HS01)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                Return (GUPC (0xFF, Zero))
                            }
                        }

                        Scope (HS02)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                Return (GUPC (0xFF, Zero))
                            }
                        }

                        Scope (HS03)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                Return (GUPC (0xFF, Zero))
                            }
                        }

                        Scope (HS04)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                Return (GUPC (Zero, Zero))
                            }
                        }

                        Scope (HS05)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                Return (GUPC (0xFF, 0xFF))
                            }
                        }

                        Scope (HS06)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                Return (GUPC (Zero, Zero))
                            }
                        }

                        Scope (HS07)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                Return (GUPC (Zero, Zero))
                            }
                        }

                        Scope (HS08)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                Return (GUPC (0xFF, 0xFF))
                            }
                        }

                        Scope (HS09)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                Return (GUPC (Zero, Zero))
                            }
                        }

                        Scope (HS10)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                Return (GUPC (Zero, Zero))
                            }
                        }

                        Scope (HS11)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                Return (GUPC (Zero, Zero))
                            }
                        }

                        Scope (HS12)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                Return (GUPC (Zero, Zero))
                            }
                        }

                        Scope (HS13)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                Return (GUPC (Zero, Zero))
                            }
                        }

                        Scope (HS14)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                Return (GUPC (Zero, Zero))
                            }
                        }

                        Scope (HS15)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                Return (GUPC (Zero, Zero))
                            }
                        }

                        Scope (SSP1)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                Return (GUPC (0xFF, 0x03))
                            }
                        }

                        Scope (SSP2)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                Return (GUPC (Zero, Zero))
                            }
                        }

                        Scope (SSP3)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                Return (GUPC (Zero, Zero))
                            }
                        }

                        Scope (SSP4)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                Return (GUPC (Zero, Zero))
                            }
                        }

                        Scope (SSP5)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                Return (GUPC (Zero, Zero))
                            }
                        }

                        Scope (SSP6)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                Return (GUPC (Zero, Zero))
                            }
                        }
                    }
                }
                
            }
        }
    }
}

