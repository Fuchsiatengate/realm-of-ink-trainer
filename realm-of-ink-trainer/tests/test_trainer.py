import unittest
from unittest.mock import patch, MagicMock
from src.trainer import Trainer

class TestTrainer(unittest.TestCase):
    @patch("src.trainer.MemoryReader")
    def test_activate_runs(self, mock_mem):
        mock_instance = MagicMock()
        mock_mem.return_value = mock_instance
        trainer = Trainer()
        # Override running to avoid infinite loop
        trainer.running = False
        # Just test initialization
        self.assertIsNotNone(trainer.mem)

    @patch("src.trainer.MemoryReader")
    def test_set_infinite_ink(self, mock_mem):
        mock_instance = MagicMock()
        mock_instance.read_int.return_value = 500
        mock_mem.return_value = mock_instance
        trainer = Trainer()
        trainer._set_infinite_ink()
        mock_instance.write_int.assert_called_with(0x00A3F1C0, 9999)

    def test_deactivate(self):
        trainer = Trainer()
        trainer.mem = MagicMock()
        trainer.deactivate()
        self.assertFalse(trainer.running)
        trainer.mem.close.assert_called_once()

if __name__ == "__main__":
    unittest.main()