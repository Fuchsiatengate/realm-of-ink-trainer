import sys
from src import Trainer

def main():
    try:
        trainer = Trainer()
        trainer.activate()
    except KeyboardInterrupt:
        print("\n[Main] Exiting...")
        trainer.deactivate()
        sys.exit(0)
    except Exception as e:
        print(f"[Main] Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()