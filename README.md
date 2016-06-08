# dmi_oem_strings #

This module simply adds a new set of facts, based off the oem strings output of
dmidecode (type 11). They are flattened facts from a hash currently, because for
compatibility with razor policies, one is limited to top level facts, not structured.

By including this module in your environment, it will automatically sync to all
systems. Currently confined to Enterprise Linux hosts, it is intended to be used
with a Razor server to assist in node tagging, and specifically synced to the
Razor microkernel agent with the razorext module.

The fact structure is simple, and returns each string as a top level fact:
dmi_oem_string_1
dmi_oem_string_2
...
These are consistent and based on the output of the following command:
`/usr/sbin/dmidecode --type 11`

## Example Use Case ##

By using these facts, combined with Razor and the Razor UCS hooks, one can set the
an intended Puppet Role for a node in the UCS Manager and Director interfaces, via
the Service Profile field name (dmi_oem_string_2's value)

More Information:
Razor Link
Razor EXT
