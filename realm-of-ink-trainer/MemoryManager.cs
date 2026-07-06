using System;
using System.Diagnostics;
using System.Runtime.InteropServices;

namespace RealmOfInkTrainer
{
    public class MemoryManager : IDisposable
    {
        private IntPtr processHandle;
        private int processId;

        [DllImport("kernel32.dll")]
        private static extern IntPtr OpenProcess(uint dwDesiredAccess, bool bInheritHandle, int dwProcessId);

        [DllImport("kernel32.dll")]
        private static extern bool ReadProcessMemory(IntPtr hProcess, IntPtr lpBaseAddress, byte[] lpBuffer, int dwSize, out int lpNumberOfBytesRead);

        [DllImport("kernel32.dll")]
        private static extern bool WriteProcessMemory(IntPtr hProcess, IntPtr lpBaseAddress, byte[] lpBuffer, int dwSize, out int lpNumberOfBytesWritten);

        [DllImport("kernel32.dll")]
        private static extern bool CloseHandle(IntPtr hObject);

        private const uint PROCESS_ALL_ACCESS = 0x1F0FFF;

        public MemoryManager(string processName)
        {
            var processes = Process.GetProcessesByName(processName);
            if (processes.Length == 0)
                throw new InvalidOperationException($"Process '{processName}' not found.");

            processId = processes[0].Id;
            processHandle = OpenProcess(PROCESS_ALL_ACCESS, false, processId);
            if (processHandle == IntPtr.Zero)
                throw new InvalidOperationException("Failed to open process.");
        }

        public int ReadInt(IntPtr address)
        {
            byte[] buffer = new byte[4];
            ReadProcessMemory(processHandle, address, buffer, 4, out _);
            return BitConverter.ToInt32(buffer, 0);
        }

        public void WriteInt(IntPtr address, int value)
        {
            byte[] buffer = BitConverter.GetBytes(value);
            WriteProcessMemory(processHandle, address, buffer, 4, out _);
        }

        public void Dispose()
        {
            if (processHandle != IntPtr.Zero)
            {
                CloseHandle(processHandle);
                processHandle = IntPtr.Zero;
            }
        }
    }
}