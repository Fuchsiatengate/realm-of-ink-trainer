import struct
import ctypes
from ctypes import wintypes

class MemoryReader:
    def __init__(self, process_name="RealmOfInk.exe"):
        self.process_name = process_name
        self.process_handle = None
        self._open_process()

    def _open_process(self):
        kernel32 = ctypes.WinDLL("kernel32", use_last_error=True)
        PROCESS_VM_READ = 0x0010
        self.process_handle = kernel32.OpenProcess(
            PROCESS_VM_READ, False, self._get_pid()
        )
        if not self.process_handle:
            raise RuntimeError("Could not open process. Run as admin?")

    def _get_pid(self):
        import psutil
        for proc in psutil.process_iter(["pid", "name"]):
            if proc.info["name"] == self.process_name:
                return proc.info["pid"]
        raise ProcessLookupError(f"Process {self.process_name} not running.")

    def read_int(self, address):
        buffer = ctypes.c_uint32()
        bytes_read = ctypes.c_size_t()
        kernel32 = ctypes.WinDLL("kernel32", use_last_error=True)
        kernel32.ReadProcessMemory(
            self.process_handle,
            ctypes.c_void_p(address),
            ctypes.byref(buffer),
            ctypes.sizeof(buffer),
            ctypes.byref(bytes_read),
        )
        return buffer.value

    def write_int(self, address, value):
        buffer = ctypes.c_uint32(value)
        bytes_written = ctypes.c_size_t()
        kernel32 = ctypes.WinDLL("kernel32", use_last_error=True)
        kernel32.WriteProcessMemory(
            self.process_handle,
            ctypes.c_void_p(address),
            ctypes.byref(buffer),
            ctypes.sizeof(buffer),
            ctypes.byref(bytes_written),
        )

    def close(self):
        if self.process_handle:
            ctypes.WinDLL("kernel32").CloseHandle(self.process_handle)