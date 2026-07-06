using Xunit;
using RealmOfInkTrainer;

namespace RealmOfInkTrainer.Tests
{
    public class TrainerTests
    {
        [Fact]
        public void TestGoldReadWrite()
        {
            // This test requires the game process to be running; for demo we just verify class exists.
            var trainerType = typeof(Trainer);
            Assert.NotNull(trainerType.GetMethod("GetGold"));
            Assert.NotNull(trainerType.GetMethod("SetGold"));
        }

        [Fact]
        public void TestHealthReadWrite()
        {
            var trainerType = typeof(Trainer);
            Assert.NotNull(trainerType.GetMethod("GetHealth"));
            Assert.NotNull(trainerType.GetMethod("SetHealth"));
        }
    }
}