using System;

namespace RealmOfInkTrainer
{
    public class Trainer
    {
        private MemoryManager memory;
        private IntPtr goldAddress = new IntPtr(0x00A1B2C0); // Example static address
        private IntPtr healthAddress = new IntPtr(0x00A1B2C4);

        public Trainer(string processName)
        {
            memory = new MemoryManager(processName);
        }

        public int GetGold()
        {
            return memory.ReadInt(goldAddress);
        }

        public void SetGold(int value)
        {
            memory.WriteInt(goldAddress, value);
        }

        public int GetHealth()
        {
            return memory.ReadInt(healthAddress);
        }

        public void SetHealth(int value)
        {
            memory.WriteInt(healthAddress, value);
        }

        public void Run()
        {
            Console.WriteLine("Realm of Ink Trainer");
            Console.WriteLine("Commands: gold <value>, health <value>, exit");
            string? input;
            while ((input = Console.ReadLine()) != "exit")
            {
                if (string.IsNullOrWhiteSpace(input)) continue;
                var parts = input.Split(' ');
                if (parts.Length == 2 && int.TryParse(parts[1], out int val))
                {
                    switch (parts[0].ToLower())
                    {
                        case "gold":
                            SetGold(val);
                            Console.WriteLine($"Gold set to {val}");
                            break;
                        case "health":
                            SetHealth(val);
                            Console.WriteLine($"Health set to {val}");
                            break;
                        default:
                            Console.WriteLine("Unknown command.");
                            break;
                    }
                }
                else
                {
                    Console.WriteLine("Usage: <gold|health> <value>");
                }
            }
        }
    }
}