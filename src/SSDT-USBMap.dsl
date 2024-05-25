/*
    
    This is combined ACPI Patch _UPC to XUPC
    
    {
        Scope (XXXX)
        {
            Method (_UPC, 0, Serialized)  // I am not sure,  Method (_UPC) was set as "Serialized" in DSDT, I just copied it.
            {
                If (_OSI ("Darwin")) // If OS is macOS
                {
                    Return (GUPC             // The GUPC method:
                    (0xFF,                   //  0xFF = enable, Zero is disabled    
                                  0x03))     //  0xFF = Internal, 0x00 = USB 2.0, 0x03 = USB 3.0 
                }
                Else
                {
                    Return (\_SB.PCI0.XHC.HUBN.XXXX.XUPC ()) // if not macOS, return to the original method in DSDT 
                                                             // I think other OS are not reliant on ACPI in enumerating ports,
                                                             // I just added the OSI check because I feel like it.
                }
        }
    

*/


DefinitionBlock ("", "SSDT", 2, "ACER", "USBMap", 0x00001000)
{

    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.EH01, DeviceObj)
    External (_SB_.PCI0.EH01.HUBN, DeviceObj)
    External (_SB_.PCI0.EH01.HUBN.PR01, DeviceObj)
    External (_SB_.PCI0.EH01.HUBN.PR01.PR11, DeviceObj)
    External (_SB_.PCI0.EH01.HUBN.PR01.PR11.XUPC, MethodObj)     
    External (_SB_.PCI0.EH01.HUBN.PR01.PR12, DeviceObj)
    External (_SB_.PCI0.EH01.HUBN.PR01.PR12.XUPC, MethodObj)     
    External (_SB_.PCI0.EH01.HUBN.PR01.PR13, DeviceObj)
    External (_SB_.PCI0.EH01.HUBN.PR01.PR13.XUPC, MethodObj)     
    External (_SB_.PCI0.EH01.HUBN.PR01.PR14, DeviceObj)
    External (_SB_.PCI0.EH01.HUBN.PR01.PR14.XUPC, MethodObj)     
    External (_SB_.PCI0.EH01.HUBN.PR01.PR15, DeviceObj)
    External (_SB_.PCI0.EH01.HUBN.PR01.PR15.XUPC, MethodObj)     
    External (_SB_.PCI0.EH01.HUBN.PR01.PR16, DeviceObj)
    External (_SB_.PCI0.EH01.HUBN.PR01.PR16.XUPC, MethodObj)     
    External (_SB_.PCI0.EH01.HUBN.PR01.PR17, DeviceObj)
    External (_SB_.PCI0.EH01.HUBN.PR01.PR17.XUPC, MethodObj)     
    External (_SB_.PCI0.EH01.HUBN.PR01.PR18, DeviceObj)
    External (_SB_.PCI0.EH01.HUBN.PR01.PR18.WCAM, DeviceObj)
    External (_SB_.PCI0.EH01.HUBN.PR01.PR18.WCAM.XUPC, MethodObj)     
    External (_SB_.PCI0.EH01.HUBN.PR01.PR18.XUPC, MethodObj)     
    External (_SB_.PCI0.EH01.HUBN.PR01.XUPC, MethodObj)     
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
                Scope (EH01)
                {
                    Scope (HUBN)
                    {
                        Scope (PR01)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                If (_OSI ("Darwin"))
                                {
                                    Return (GUPC (0xFF, 0xFF))
                                }
                                Else
                                {
                                    Return (\_SB.PCI0.EH01.HUBN.PR01.XUPC ())
                                }
                            }

                            Scope (PR11)
                            {
                                Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                                {
                                    If (_OSI ("Darwin"))
                                    {
                                        Return (GUPC (Zero, Zero))
                                    }
                                    Else
                                    {
                                        Return (\_SB.PCI0.EH01.HUBN.PR01.PR11.XUPC ())
                                    }
                                }
                            }

                            Scope (PR12)
                            {
                                Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                                {
                                    If (_OSI ("Darwin"))
                                    {
                                        Return (GUPC (0xFF, Zero))
                                    }
                                    Else
                                    {
                                        Return (\_SB.PCI0.EH01.HUBN.PR01.PR12.XUPC ())
                                    }
                                }
                            }

                            Scope (PR13)
                            {
                                Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                                {
                                    If (_OSI ("Darwin"))
                                    {
                                        Return (GUPC (0xFF, Zero))
                                    }
                                    Else
                                    {
                                        Return (\_SB.PCI0.EH01.HUBN.PR01.PR13.XUPC ())
                                    }
                                }
                            }

                            Scope (PR14)
                            {
                                Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                                {
                                    If (_OSI ("Darwin"))
                                    {
                                        Return (GUPC (Zero, Zero))
                                    }
                                    Else
                                    {
                                        Return (\_SB.PCI0.EH01.HUBN.PR01.PR14.XUPC ())
                                    }
                                }
                            }

                            Scope (PR15)
                            {
                                Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                                {
                                    If (_OSI ("Darwin"))
                                    {
                                        Return (GUPC (0xFF, 0xFF))
                                    }
                                    Else
                                    {
                                        Return (\_SB.PCI0.EH01.HUBN.PR01.PR15.XUPC ())
                                    }
                                }
                            }

                            Scope (PR16)
                            {
                                Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                                {
                                    If (_OSI ("Darwin"))
                                    {
                                        Return (GUPC (Zero, Zero))
                                    }
                                    Else
                                    {
                                        Return (\_SB.PCI0.EH01.HUBN.PR01.PR16.XUPC ())
                                    }
                                }
                            }

                            Scope (PR17)
                            {
                                Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                                {
                                    If (_OSI ("Darwin"))
                                    {
                                        Return (GUPC (Zero, Zero))
                                    }
                                    Else
                                    {
                                        Return (\_SB.PCI0.EH01.HUBN.PR01.PR17.XUPC ())
                                    }
                                }
                            }

                            Scope (PR18)
                            {
                                Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                                {
                                    If (_OSI ("Darwin"))
                                    {
                                        Return (GUPC (0xFF, 0xFF))
                                    }
                                    Else
                                    {
                                        Return (\_SB.PCI0.EH01.HUBN.PR01.PR18.XUPC ())
                                    }
                                }

                                Scope (WCAM)
                                {
                                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                                    {
                                        If (_OSI ("Darwin"))
                                        {
                                            Return (GUPC (0xFF, Zero))
                                        }
                                        Else
                                        {
                                            Return (\_SB.PCI0.EH01.HUBN.PR01.PR18.WCAM.XUPC ())
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                Scope (XHC)
                {
                    Scope (RHUB)
                    {
                        Scope (HS01)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                If (_OSI ("Darwin"))
                                {
                                    Return (GUPC (0xFF, Zero))
                                }
                                Else
                                {
                                    Return (\_SB.PCI0.XHC.RHUB.HS01.XUPC ())
                                }
                            }
                        }

                        Scope (HS02)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                If (_OSI ("Darwin"))
                                {
                                    Return (GUPC (0xFF, Zero))
                                }
                                Else
                                {
                                    Return (\_SB.PCI0.XHC.RHUB.HS02.XUPC ())
                                }
                            }
                        }

                        Scope (HS03)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                If (_OSI ("Darwin"))
                                {
                                    Return (GUPC (0xFF, Zero))
                                }
                                Else
                                {
                                    Return (\_SB.PCI0.XHC.RHUB.HS03.XUPC ())
                                }
                            }
                        }

                        Scope (HS04)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                If (_OSI ("Darwin"))
                                {
                                    Return (GUPC (Zero, Zero))
                                }
                                Else
                                {
                                    Return (\_SB.PCI0.XHC.RHUB.HS04.XUPC ())
                                }
                            }
                        }

                        Scope (HS05)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                If (_OSI ("Darwin"))
                                {
                                    Return (GUPC (0xFF, 0xFF))
                                }
                                Else
                                {
                                    Return (\_SB.PCI0.XHC.RHUB.HS05.XUPC ())
                                }
                            }
                        }

                        Scope (HS06)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                If (_OSI ("Darwin"))
                                {
                                    Return (GUPC (Zero, Zero))
                                }
                                Else
                                {
                                    Return (\_SB.PCI0.XHC.RHUB.HS06.XUPC ())
                                }
                            }
                        }

                        Scope (HS07)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                If (_OSI ("Darwin"))
                                {
                                    Return (GUPC (Zero, Zero))
                                }
                                Else
                                {
                                    Return (\_SB.PCI0.XHC.RHUB.HS07.XUPC ())
                                }
                            }
                        }

                        Scope (HS08)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                If (_OSI ("Darwin"))
                                {
                                    Return (GUPC (0xFF, 0xFF))
                                }
                                Else
                                {
                                    Return (\_SB.PCI0.XHC.RHUB.HS08.XUPC ())
                                }
                            }
                        }

                        Scope (HS09)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                If (_OSI ("Darwin"))
                                {
                                    Return (GUPC (Zero, Zero))
                                }
                                Else
                                {
                                    Return (\_SB.PCI0.XHC.RHUB.HS09.XUPC ())
                                }
                            }
                        }

                        Scope (HS10)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                If (_OSI ("Darwin"))
                                {
                                    Return (GUPC (Zero, Zero))
                                }
                                Else
                                {
                                    Return (\_SB.PCI0.XHC.RHUB.HS10.XUPC ())
                                }
                            }
                        }

                        Scope (HS11)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                If (_OSI ("Darwin"))
                                {
                                    Return (GUPC (Zero, Zero))
                                }
                                Else
                                {
                                    Return (\_SB.PCI0.XHC.RHUB.HS11.XUPC ())
                                }
                            }
                        }

                        Scope (HS12)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                If (_OSI ("Darwin"))
                                {
                                    Return (GUPC (Zero, Zero))
                                }
                                Else
                                {
                                    Return (\_SB.PCI0.XHC.RHUB.HS12.XUPC ())
                                }
                            }
                        }

                        Scope (HS13)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                If (_OSI ("Darwin"))
                                {
                                    Return (GUPC (Zero, Zero))
                                }
                                Else
                                {
                                    Return (\_SB.PCI0.XHC.RHUB.HS13.XUPC ())
                                }
                            }
                        }

                        Scope (HS14)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                If (_OSI ("Darwin"))
                                {
                                    Return (GUPC (Zero, Zero))
                                }
                                Else
                                {
                                    Return (\_SB.PCI0.XHC.RHUB.HS14.XUPC ())
                                }
                            }
                        }

                        Scope (HS15)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                If (_OSI ("Darwin"))
                                {
                                    Return (GUPC (Zero, Zero))
                                }
                                Else
                                {
                                    Return (\_SB.PCI0.XHC.RHUB.HS15.XUPC ())
                                }
                            }
                        }

                        Scope (SSP1)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                If (_OSI ("Darwin"))
                                {
                                    Return (GUPC (0xFF, 0x03))
                                }
                                Else
                                {
                                    Return (\_SB.PCI0.XHC.RHUB.SSP1.XUPC ())
                                }
                            }
                        }

                        Scope (SSP2)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                If (_OSI ("Darwin"))
                                {
                                    Return (GUPC (Zero, Zero))
                                }
                                Else
                                {
                                    Return (\_SB.PCI0.XHC.RHUB.SSP2.XUPC ())
                                }
                            }
                        }

                        Scope (SSP3)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                If (_OSI ("Darwin"))
                                {
                                    Return (GUPC (Zero, Zero))
                                }
                                Else
                                {
                                    Return (\_SB.PCI0.XHC.RHUB.SSP3.XUPC ())
                                }
                            }
                        }

                        Scope (SSP4)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                If (_OSI ("Darwin"))
                                {
                                    Return (GUPC (Zero, Zero))
                                }
                                Else
                                {
                                    Return (\_SB.PCI0.XHC.RHUB.SSP4.XUPC ())
                                }
                            }
                        }

                        Scope (SSP5)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                If (_OSI ("Darwin"))
                                {
                                    Return (GUPC (Zero, Zero))
                                }
                                Else
                                {
                                    Return (\_SB.PCI0.XHC.RHUB.SSP5.XUPC ())
                                }
                            }
                        }

                        Scope (SSP6)
                        {
                            Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                            {
                                If (_OSI ("Darwin"))
                                {
                                    Return (GUPC (Zero, Zero))
                                }
                                Else
                                {
                                    Return (\_SB.PCI0.XHC.RHUB.SSP6.XUPC ())
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

