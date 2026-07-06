using System;

namespace RealmOfInkTrainer
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                var trainer = new Trainer("RealmOfInk");
                trainer.Run();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error: {ex.Message}");
            }
        }
    }
}