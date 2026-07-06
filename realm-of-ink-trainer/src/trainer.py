import keyboard
import pyautogui
import time
from .memory_reader import MemoryReader

class Trainer:
    def __init__(self):
        self.mem = MemoryReader()
        self.ink_address = 0x00A3F1C0  # Example static address
        self.running = False

    def activate(self):
        self.running = True
        print("[Trainer] Activated. Press F1 for infinite ink, F2 to quit.")
        while self.running:
            if keyboard.is_pressed("F1"):
                self._set_infinite_ink()
                time.sleep(0.3)
            if keyboard.is_pressed("F2"):
                self.deactivate()
                break
            time.sleep(0.05)

    def _set_infinite_ink(self):
        try:
            current = self.mem.read_int(self.ink_address)
            self.mem.write_int(self.ink_address, 9999)
            print(f"[Trainer] Ink set to 9999 (was {current})")
        except Exception as e:
            print(f"[Trainer] Error: {e}")

    def deactivate(self):
        self.running = False
        self.mem.close()
        print("[Trainer] Deactivated.")