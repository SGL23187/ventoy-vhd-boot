using System;
using System.Runtime.InteropServices;

Console.WriteLine(VHDPath.GetVHDPath());

public class VHDPath
{
    [DllImport("kernel32.dll", SetLastError = true)]
    static extern UInt32
    GetFirmwareEnvironmentVariableA(string lpName, string lpGuid, IntPtr pBuffer, UInt32 nSize);
    const int ERROR_INVALID_FUNCTION = 1;

    public static string GetVHDPath()
    {
        byte[] buffer = new byte[512];

        // Try to call the GetFirmwareEnvironmentVariable API. This is invalid on legacy BIOS.
        UInt32 size = GetFirmwareEnvironmentVariableA("VentoyOsParam", " { 0x77772020, 0x2e77, 0x6576, { 0x6e, 0x74, 0x6f, 0x79, 0x2e, 0x6e, 0x65, 0x74 }}", Marshal.UnsafeAddrOfPinnedArrayElement(buffer, 0), 512);

        Console.WriteLine("Error: " + Marshal.GetLastWin32Error());

        if (Marshal.GetLastWin32Error() == ERROR_INVALID_FUNCTION)
        {
            Console.WriteLine("ERROR_INVALID_FUNCTION");
            // Legacy BIOS
            // Get the physical memory range 0x80000~0xA0000
            // IntPtr ptr = Marshal.AllocHGlobal(0x20000);
            // Marshal.Copy(ptr, buffer, 0, 0x20000);
            // Marshal.FreeHGlobal(ptr);
        }
        else
        {
            Console.WriteLine("size: " + size);
            int offset = 45;
            int length = 384;
            return System.Text.Encoding.UTF8.GetString(buffer, offset, length).TrimEnd('\0');
        }
        return "not done";
    }
}


