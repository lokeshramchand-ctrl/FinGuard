const Transcations = require("./Transaction");
const router = express.Router();


router.post("/add", async (req, res) => {
try {
    const { description , amount } = req.body;

    // ✅ Validate input
    if (!description || !amount ) {
      return res.status(400).json({ message: "All fields are required" });
    }

    // Check if farmer exists
    const User = await User.findById(farmerId);
    if (!User) return res.status(404).json({ message: "User not found" });

    // Create new produce item
    const transcation = new Produce({ description , amount});
    await transcation.save();

    // Link produce to farmer
    farmer.produce.push(produce._id);
    await farmer.save();

    res.status(201).json({ message: "Transcation added successfully", transcation });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
