using System;
using System.Diagnostics;
using System.Runtime.InteropServices;

namespace NssmService
{
    class Program
    {
        private static string _serviceName = "NssmService";

        [DllImport("User32.dll")]
        public static extern int GetMessage(out IntPtr lpMsg, IntPtr hWndm, uint wMsgFilterMin, uint wMsgFilterMax);

        static void Main(string[] args)
        {
            var sLog = "Application";
            int ret = 0;

            if (!EventLog.SourceExists(_serviceName))
                EventLog.CreateEventSource(_serviceName, sLog);

            // allocate memory for MSG structure
            MSG msg = new MSG();
            IntPtr msgPtr = Marshal.AllocHGlobal(Marshal.SizeOf(msg));

            EventLog.WriteEntry(_serviceName, $"Welcome from {_serviceName}!");

            // wait for message: if return value is 0 it's WM_QUIT message
            while ((ret = GetMessage(out msgPtr, IntPtr.Zero, 0, 0)) != 0) { }

            // free allocated memory
            Marshal.FreeHGlobal(msgPtr);

            EventLog.WriteEntry(_serviceName, $"{_serviceName} says good bye.");
        }
    }

    public struct MSG
    {
        public IntPtr hwnd;
        public uint message;
        public long wParam;
        public long lParam;
        public uint time;
        public POINT pt;
    }

    public struct POINT
    {
        public long x;
        public long y;
    }
}
