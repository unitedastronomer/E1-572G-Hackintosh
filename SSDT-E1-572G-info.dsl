DefinitionBlock ("", "SSDT", 2, "ACER", "E1-572G", 0x00001000)
{
    External (_PR_.CPU0, ProcessorObj)
    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.EHC1, DeviceObj)
    External (_SB_.PCI0.GFX0, DeviceObj)
    External (_SB_.PCI0.LPCB, DeviceObj)
    External (_SB_.PCI0.LPCB.EC0_, DeviceObj)
    External (_SB_.PCI0.LPCB.EC0_.XQ11, MethodObj)    
    External (_SB_.PCI0.LPCB.EC0_.XQ12, MethodObj)    
    External (_SB_.PCI0.LPCB.HPET, DeviceObj)
    External (_SB_.PCI0.LPCB.HPET.XCRS, MethodObj)  
    External (_SB_.PCI0.LPCB.HPET.XSTA, MethodObj)    
    External (_SB_.PCI0.LPCB.KBC0, DeviceObj)
    External (_SB_.PCI0.LPCB.LID0, DeviceObj)
    External (_SB_.PCI0.RP04, DeviceObj)
    External (_SB_.PCI0.RP05.PEGP._OFF, MethodObj)    
    External (_SB_.PCI0.SBUS, DeviceObj)
    External (_SB_.PCI0.SBUS.BUS0, DeviceObj)
    External (_SB_.PCI0.XHC_, DeviceObj)
    External (_SB_.PCI0.XHC_.PMEE, FieldUnitObj)
    External (_SB_.PCI0.XHC_.RHUB, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS01, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS02, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS03, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS04, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS05, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS06, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS07, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS08, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS09, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS10, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS11, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS12, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS13, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS14, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS15, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SSP1, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SSP2, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SSP3, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SSP4, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SSP5, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SSP6, DeviceObj)
    External (RMCF.BKLT, IntObj)
    External (RMCF.FBTP, IntObj)
    External (RMCF.GRAN, IntObj)
    External (RMCF.LEVW, IntObj)
    External (RMCF.LMAX, IntObj)
    External (XPRW, MethodObj)   
    External (ZPTS, MethodObj)    

    Scope (\)
    {
        Scope (\_PR)
        {
            Scope (CPU0) 
            {
                If (_OSI ("Darwin"))
                {
                    Method (_DSM, 4, NotSerialized)   // SSDT-PLUG.aml
                    {
                        If (!Arg2)
                        {
                            Return (Buffer (One)
                            {
                                 0x03                                             
                            })
                        }

                        Return (Package (0x02)
                        {
                            "plugin-type", 
                            One
                        })
                    }
                }
            }
        }

        Scope (_SB)
        {
            Scope (PCI0)
            {
                Method (GUPC, 2, Serialized) // Reference Method for _UPC
// Make sure this Method is accessible if for all USB Ports In DSDT. In this case my ports are under  _SB.PCI0.XHC, I just placed the method with its parent _SB.PCI0.
                {
                    Name (PCKG, Package (0x04)
                    {
                        0xFF, // 0xFF = Port exists, Zero = Port doesn't exist
                        0x03, // 0xFF = Internal, 0x00 = USB 2.0, 0x03 = USB 3.0
                        Zero, 
                        Zero
                    })
                    PCKG [Zero] = Arg0 // The first input // ex. 0xFF = Port exists
                    PCKG [One] = Arg1  // The second input  // ex. 0xFF = Internal    
                    Return (PCKG)      // Return (first, second)
                                       // So if GUPC Method is called by a _UPC, it returns this PCKG.
                }

                Scope (EHC1) // SSDT-USB-Reset.dsl, it is apparently needed to rename EHC1 to EH01 in macOS
                {
                    Method (_STA, 0, NotSerialized) 
                    {
                        If (_OSI ("Darwin")) 
                        {
                            Return (Zero) // If macOS, disable EHC1. 
                        }
                        Else
                        {
                            Return (0x0F) // If not macOS, EHC1 is active.
                        }
                    }
                }

                Device (EH01)
                {
                    Name (_ADR, 0x001D0000)  // Since EHC1 is disabled for macOS, we route the address of EHC1 to EH01
                    Method (_STA, 0, NotSerialized) 
                    {
                        If (_OSI ("Darwin"))
                        {
                            Return (0x0F) // If macOS, enable EH01
                        }
                        Else
                        {
                            Return (Zero) // If not macOS, EHC1 is disabled.
                        }
                    }

                    Device (HUBN)
                    {
                        Name (_ADR, Zero)  // Since EHC1 is disabled for macOS, we route each EHC1 port/device's addresses to EH01
                        Device (PR01)
                        {
                            Name (_ADR, One)  
                            Method (_UPC, 0, Serialized) // USB Port Capabilities
                            {
                                Return (GUPC (0xFF, 0xFF)) // Enable, Internal

// _UPC needs the PCKG for garhering information in defining an active (or absent) port, and its type. If _UPC is called -> it calls GUPC, it finally return the PCKG with its custom Arg0 and Arg1.

// Such as:
// Return (GUPC (0xFF, Zero))

      
// If port is just the same, Arg0 which is 0xFF = Enabled, Arg1 which is 0x03 = Internal, then you can just call the method directly

// Such as: Return (GUPC ())
                            }                           

                            Device (PR12)
                            {
                                Name (_ADR, 0x02)  
                                Method (_UPC, 0, Serialized)   
                                {
                                    Return (GUPC (0xFF, Zero)) // Enable, USB 2.0
                                }
                            }

                            Device (PR13) 
                            {
                                Name (_ADR, 0x03)    
                                Method (_UPC, 0, Serialized)   
                                {
                                    Return (GUPC (0xFF, Zero)) // Enable, USB 2.0
                                }
                            }

                            Device (PR15) 
                            {
                                Name (_ADR, 0x04)    
                                Method (_UPC, 0, Serialized)   
                                {
                                    Return (GUPC (0xFF, 0xFF)) // Enable, Internal
                                }
                            }

                            Device (PR18) 
                            {
                                Name (_ADR, 0x04)    
                                Method (_UPC, 0, Serialized)   
                                {
                                    Return (GUPC (0xFF, 0xFF)) // Enable, Internal
                                }
                            }
                        }
                    }
                }

                Scope (XHC) // "Scope" under DSDT
                {
                    Scope (RHUB)
                    {
                        Scope (HS01) 
                        {
                            Method (_UPC, 0, Serialized)   // All XHC _UPC are renamed to XUPC
                            {
                                Return (GUPC (0xFF, Zero)) //  Enable, USB 2.0
                            }
                        }

                        Scope (HS02)
                        {
                            Method (_UPC, 0, Serialized) // All set as "Serializable" as they were in the DSDT
                            {
                                Return (GUPC (0xFF, Zero)) //  Enable, USB 2.0
                            }
                        }

                        Scope (HS03)
                        {
                            Method (_UPC, 0, Serialized)   
                            {
                                Return (GUPC (0xFF, Zero)) // Enable, USB 2.0
                            }
                        }

                        Scope (HS04)
                        {
                            Method (_UPC, 0, Serialized)   
                            {
                                Return (GUPC (Zero, Zero)) // Disable, Disable
                            }
                        }

                        Scope (HS05)
                        {
                            Method (_UPC, 0, Serialized)   
                            {
                                Return (GUPC (0xFF, 0xFF)) // Enable, Internal
                            }
                        }

                        Scope (HS06)
                        {
                            Method (_UPC, 0, Serialized)   
                            {
                                Return (GUPC (Zero, Zero)) // Disable, Disable
                            }
                        }

                        Scope (HS07)
                        {
                            Method (_UPC, 0, Serialized)   
                            {
                                Return (GUPC (Zero, Zero)) // Disable, Disable
                            }
                        }

                        Scope (HS08)
                        {
                            Method (_UPC, 0, Serialized)   
                            {
                                Return (GUPC (0xFF, 0xFF)) // Enable, Internal
                            }
                        }

                        Scope (HS09)
                        {
                            Method (_UPC, 0, Serialized)   
                            {
                                Return (GUPC (Zero, Zero)) // Disable, Disable
                            }
                        }

                        Scope (HS10)
                        {
                            Method (_UPC, 0, Serialized)   
                            {
                                Return (GUPC (Zero, Zero)) // Disable, Disable
                            }
                        }

                        Scope (HS11)
                        {
                            Method (_UPC, 0, Serialized)   
                            {
                                Return (GUPC (Zero, Zero)) // Disable, Disable
                            }
                        }

                        Scope (HS12)
                        {
                            Method (_UPC, 0, Serialized)   
                            {
                                Return (GUPC (Zero, Zero)) // Disable, Disable
                            }
                        }

                        Scope (HS13)
                        {
                            Method (_UPC, 0, Serialized)   
                            {
                                Return (GUPC (Zero, Zero)) // Disable, Disable
                            }
                        }

                        Scope (HS14)
                        {
                            Method (_UPC, 0, Serialized)   
                            {
                                Return (GUPC (Zero, Zero)) // Disable, Disable
                            }
                        }

                        Scope (HS15)
                        {
                            Method (_UPC, 0, Serialized)   
                            {
                                Return (GUPC (Zero, Zero)) // Disable, Disable
                            }
                        }

                        Scope (SSP1)
                        {
                            Method (_UPC, 0, Serialized)   
                            {
                                Return (GUPC (0xFF, 0x03)) // Disable, Disable
                            }
                        }

                        Scope (SSP2)
                        {
                            Method (_UPC, 0, Serialized)   
                            {
                                Return (GUPC (Zero, Zero)) // Disable, Disable
                            }
                        }

                        Scope (SSP3)
                        {
                            Method (_UPC, 0, Serialized)   
                            {
                                Return (GUPC (Zero, Zero)) // Disable, Disable
                            }
                        }

                        Scope (SSP4)
                        {
                            Method (_UPC, 0, Serialized)   
                            {
                                Return (GUPC (Zero, Zero)) // Disable, Disable
                            }
                        }

                        Scope (SSP5)
                        {
                            Method (_UPC, 0, Serialized)   
                            {
                                Return (GUPC (Zero, Zero)) // Disable, Disable
                            }
                        }

                        Scope (SSP6)
                        {
                            Method (_UPC, 0, Serialized)   
                            {
                                Return (GUPC (Zero, Zero)) // Disable, Disable
                            }
                        }
                    }
                }

                Scope (GFX0) // All under GFX0 is SSDT-PNLF.aml
                {
                    OperationRegion (RMP3, PCI_Config, Zero, 0x14)
                    Device (PNLF)
                    {
                        Name (_HID, EisaId ("APP0002"))  // _HID: Hardware ID
                        Name (_CID, "backlight")  // _CID: Compatible ID
                        Name (_UID, Zero)  // _UID: Unique ID
                        Name (_STA, 0x0B)  // _STA: Status
                        Field (^RMP3, AnyAcc, NoLock, Preserve)
                        {
                            Offset (0x02), 
                            GDID,   16, 
                            Offset (0x10), 
                            BAR1,   32
                        }

                        OperationRegion (RMB1, SystemMemory, (BAR1 & 0xFFFFFFFFFFFFFFF0), 0x000E1184)
                        Field (RMB1, AnyAcc, Lock, Preserve)
                        {
                            Offset (0x48250), 
                            LEV2,   32, 
                            LEVL,   32, 
                            Offset (0x70040), 
                            P0BL,   32, 
                            Offset (0xC2000), 
                            GRAN,   32, 
                            Offset (0xC8250), 
                            LEVW,   32, 
                            LEVX,   32, 
                            LEVD,   32, 
                            Offset (0xE1180), 
                            PCHL,   32
                        }

                        Method (INI1, 1, NotSerialized)
                        {
                            If ((Zero == (0x02 & Arg0)))
                            {
                                Local5 = 0xC0000000
                                If (CondRefOf (\RMCF.LEVW))
                                {
                                    If ((Ones != \RMCF.LEVW))
                                    {
                                        Local5 = \RMCF.LEVW /* External reference */
                                    }
                                }

                                ^LEVW = Local5
                            }

                            If ((0x04 & Arg0))
                            {
                                If (CondRefOf (\RMCF.GRAN))
                                {
                                    ^GRAN = \RMCF.GRAN /* External reference */
                                }
                                Else
                                {
                                    ^GRAN = Zero
                                }
                            }
                        }

                        Method (_INI, 0, NotSerialized)  // _INI: Initialize
                        {
                            Local4 = One
                            If (CondRefOf (\RMCF.BKLT))
                            {
                                Local4 = \RMCF.BKLT /* External reference */
                            }

                            If (!(One & Local4))
                            {
                                Return (Zero)
                            }

                            Local0 = ^GDID /* \_SB_.PCI0.GFX0.PNLF.GDID */
                            Local2 = Ones
                            If (CondRefOf (\RMCF.LMAX))
                            {
                                Local2 = \RMCF.LMAX /* External reference */
                            }

                            Local3 = Zero
                            If (CondRefOf (\RMCF.FBTP))
                            {
                                Local3 = \RMCF.FBTP /* External reference */
                            }

                            If (((One == Local3) || (Ones != Match (Package (0x10)
                                                {
                                                    0x010B, 
                                                    0x0102, 
                                                    0x0106, 
                                                    0x1106, 
                                                    0x1601, 
                                                    0x0116, 
                                                    0x0126, 
                                                    0x0112, 
                                                    0x0122, 
                                                    0x0152, 
                                                    0x0156, 
                                                    0x0162, 
                                                    0x0166, 
                                                    0x016A, 
                                                    0x46, 
                                                    0x42
                                                }, MEQ, Local0, MTR, Zero, Zero))))
                            {
                                If ((Ones == Local2))
                                {
                                    Local2 = 0x0710
                                }

                                Local1 = (^LEVX >> 0x10)
                                If (!Local1)
                                {
                                    Local1 = Local2
                                }

                                If ((!(0x08 & Local4) && (Local2 != Local1)))
                                {
                                    Local0 = ((^LEVL * Local2) / Local1)
                                    Local3 = (Local2 << 0x10)
                                    If ((Local2 > Local1))
                                    {
                                        ^LEVX = Local3
                                        ^LEVL = Local0
                                    }
                                    Else
                                    {
                                        ^LEVL = Local0
                                        ^LEVX = Local3
                                    }
                                }
                            }
                            ElseIf (((0x03 == Local3) || (Ones != Match (Package (0x19)
                                                {
                                                    0x3E9B, 
                                                    0x3EA5, 
                                                    0x3E92, 
                                                    0x3E91, 
                                                    0x3EA0, 
                                                    0x3EA6, 
                                                    0x3E98, 
                                                    0x9BC8, 
                                                    0x9BC5, 
                                                    0x9BC4, 
                                                    0xFF05, 
                                                    0x8A70, 
                                                    0x8A71, 
                                                    0x8A51, 
                                                    0x8A5C, 
                                                    0x8A5D, 
                                                    0x8A52, 
                                                    0x8A53, 
                                                    0x8A56, 
                                                    0x8A5A, 
                                                    0x8A5B, 
                                                    0x9B41, 
                                                    0x9B21, 
                                                    0x9BCA, 
                                                    0x9BA4
                                                }, MEQ, Local0, MTR, Zero, Zero))))
                            {
                                If ((Ones == Local2))
                                {
                                    Local2 = 0xFFFF
                                }
                            }
                            Else
                            {
                                If ((Ones == Local2))
                                {
                                    If ((Ones != Match (Package (0x16)
                                                    {
                                                        0x0D26, 
                                                        0x0A26, 
                                                        0x0D22, 
                                                        0x0412, 
                                                        0x0416, 
                                                        0x0A16, 
                                                        0x0A1E, 
                                                        0x0A1E, 
                                                        0x0A2E, 
                                                        0x041E, 
                                                        0x041A, 
                                                        0x0BD1, 
                                                        0x0BD2, 
                                                        0x0BD3, 
                                                        0x1606, 
                                                        0x160E, 
                                                        0x1616, 
                                                        0x161E, 
                                                        0x1626, 
                                                        0x1622, 
                                                        0x1612, 
                                                        0x162B
                                                    }, MEQ, Local0, MTR, Zero, Zero)))
                                    {
                                        Local2 = 0x0AD9
                                    }
                                    Else
                                    {
                                        Local2 = 0x056C
                                    }
                                }

                                INI1 (Local4)
                                Local1 = (^LEVX >> 0x10)
                                If (!Local1)
                                {
                                    Local1 = Local2
                                }

                                If ((!(0x08 & Local4) && (Local2 != Local1)))
                                {
                                    Local0 = ((((^LEVX & 0xFFFF) * Local2) / Local1) | 
                                        (Local2 << 0x10))
                                    ^LEVX = Local0
                                }
                            }

                            If ((Local2 == 0x0710))
                            {
                                _UID = 0x0E
                            }
                            ElseIf ((Local2 == 0x0AD9))
                            {
                                _UID = 0x0F
                            }
                            ElseIf ((Local2 == 0x056C))
                            {
                                _UID = 0x10
                            }
                            ElseIf ((Local2 == 0x07A1))
                            {
                                _UID = 0x11
                            }
                            ElseIf ((Local2 == 0x1499))
                            {
                                _UID = 0x12
                            }
                            ElseIf ((Local2 == 0xFFFF))
                            {
                                _UID = 0x13
                            }
                            Else
                            {
                                _UID = 0x63
                            }
                        }
                    }
                }

                Scope (RP04) // Assigning a name to WiFi device in ACPI. Opencore does not overwrite device properties if device is not named in ACPI.
                {
                    Device (ARPT)
                    {
                        Name (_ADR, Zero)    
                    }
                }

                Scope (LPCB)
                {
                    Device (EC) // SSDT-EC
                    {
                        Name (_HID, "ACID0001")  // _HID: Hardware ID
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            If (_OSI ("Darwin"))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }
                    }

                    Scope (EC0) // Keyboard Brightness
                    {
                        Method (_Q11, 0, NotSerialized)  
                        {
                            If (_OSI ("Darwin"))
                            {
                                Notify (KBC0, 0x0365) // Return F14 key (Brightness down in macs)
                            }
                            Else
                            {
                                \_SB.PCI0.LPCB.EC0.XQ11 () // Return to original method in DSDT
                            }
                        }

                        Method (_Q12, 0, NotSerialized)  
                        {
                            If (_OSI ("Darwin"))
                            {
                                Notify (KBC0, 0x0366) // Return F15 key (Brightness up in macs)
                            }
                            Else
                            {
                                \_SB.PCI0.LPCB.EC0.XQ12 ()
                            }
                        }
                    }

                    Scope (HPET) // SSDT-HPET.aml, this resolves sound device not being detected
                    {
                        Name (BUFX, ResourceTemplate ()
                        {
                            IRQNoFlags ()
                                {0,8,11}
                            Memory32Fixed (ReadWrite,
                                0xFED00000,         
                                0x00000400,         
                                )
                        })
                        Method (_CRS, 0, Serialized)  
                        {
                            If ((_OSI ("Darwin") || !CondRefOf (\_SB.PCI0.LPCB.HPET.XCRS)))
                            {
                                Return (BUFX) 
                            }

                            Return (\_SB.PCI0.LPCB.HPET.XCRS ())
                        }

                        Method (_STA, 0, NotSerialized)  
                        {
                            If ((_OSI ("Darwin") || !CondRefOf (\_SB.PCI0.LPCB.HPET.XSTA)))
                            {
                                Return (0x0F)
                            }

                            Return (\_SB.PCI0.LPCB.HPET.XSTA ())
                        }
                    }

                    Device (RMD1) // Disable dGPU
                    {
                        Name (_HID, "RMD10000")  
                        Method (_STA, 0, NotSerialized) 
                        {
                            If (_OSI ("Darwin"))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }

                        Method (_INI, 0, NotSerialized)  
                        {
                            If (_OSI ("Darwin"))
                            {
                                If (CondRefOf (\_SB.PCI0.RP05.PEGP._OFF))
                                {
                                    \_SB.PCI0.RP05.PEGP._OFF ()
                                }
                            }
                            Else
                            {
                            }
                        }
                    }

                    Scope (KBC0) // Keyboard Remapping, paired with VoodooPS2
                    {
                        Name (RMCF, Package (0x02)
                        {
                            "Keyboard", 
                            Package (0x02)
                            {
                                "Custom PS2 Map", 
                                Package (0x03)
                                {
                                    Package (0x00){}, 
                                    "e045=0",   // Fn + F12 = Disabled, acted as F14 under macOS
                                    "46=0"      // Pause Break = Disabled, acted as F15 under macOS
                                }
                            }
                        })
                    }

                    Device (ALS0) // Fake Ambient Sensor, needed so macOS saves last brightness level after reboot.
                    {
                        Name (_HID, "ACPI0008" 
                        Name (_CID, "smc-als")  
                        Name (_ALI, 0x012C)  
                        Name (_ALR, Package (0x01) 
                        {
                            Package (0x02)
                            {
                                0x64, 
                                0x012C
                            }
                        })
                        Method (_STA, 0, NotSerialized)  
                        {
                            If (_OSI ("Darwin"))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }
                    }
                }

                Scope (SBUS) // Apparently fixes SMBUS support, this will help load some SMBUS related kext.
                {
                    Device (BUS0)
                    {
                        Name (_CID, "smbus") 
                        Name (_ADR, Zero)    
                        Device (DVL0)
                        {
                            Name (_ADR, 0x57)    
                            Name (_CID, "diagsvault") 
                            Method (_DSM, 4, NotSerialized) 
                            {
                                If (!Arg2)
                                {
                                    Return (Buffer (One)
                                    {
                                         0x57                                             
                                    })
                                }

                                Return (Package (0x02)
                                {
                                    "address", 
                                    0x57
                                })
                            }
                        }

                        Method (_STA, 0, NotSerialized)  
                        {
                            If (_OSI ("Darwin"))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }
                    }
                }

                Device (MCHC)
                {
                    Name (_ADR, Zero)    
                    Method (_STA, 0, NotSerialized)  
                    {
                        If (_OSI ("Darwin"))
                        {
                            Return (0x0F)
                        }

                        Return (Zero)
                    }
                }
            }
        }

        Method (_PTS, 1, NotSerialized)  // FixShutdown-USB-SSDT.dsl, apparently fixes USB Shutdown
        {
            ZPTS (Arg0)
            If ((0x05 == Arg0))
            {
                \_SB.PCI0.XHC.PMEE = Zero
            }
        }

        Method (GPRW, 2, NotSerialized) // SSDT-GPRW, resolves the issue where laptop does not wake on sleep.
        {
            If (_OSI ("Darwin"))
            {
                If ((0x6D == Arg0))
                {
                    Return (Package (0x02)
                    {
                        0x6D, 
                        Zero
                    })
                }

                If ((0x0D == Arg0))
                {
                    Return (Package (0x02)
                    {
                        0x0D, 
                        Zero
                    })
                }
            }

            Return (XPRW (Arg0, Arg1))
        }

        OperationRegion (RCRG, SystemMemory, 0xFED1F418, One)
        Field (RCRG, DWordAcc, Lock, Preserve)
        {
                ,   13, 
            EH2D,   1, 
                ,   1, 
            EH1D,   1
        }

        Method (_INI, 0, NotSerialized) 
        {
            If (_OSI ("Darwin"))
            {
                EH2D = One     // Disable EHC2, just in case.
            }
        }
    }
}

