const express = require("express");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const User = require("./User");

const router = express.Router();

// Signup Route
router.post("/register", async (req, res) => {
    try {
        const { name, email, password } = req.body;

        console.log("🔍 [Register] Request Body:", { name, email }); // Log request body (excluding password for security)


        // Check if user already exists
        let user = await User.findOne({ email });
        if (user) {
            console.log(`❌ [Register] User already exists: ${email}`);
            return res.status(400).json({ message: "User already exists" });
        }

        // Hash the password
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);
        console.log("✅ [Register] Password hashed successfully");

        // Create new user
        user = new User({ name, email, password: hashedPassword});
        await user.save();
        console.log(`✅ [Register] User created successfully: ${email}`);

        // Generate JWT Token
        const token = jwt.sign({ id: user._id}, process.env.JWT_SECRET, { expiresIn: "7d" });
        console.log(`✅ [Register] JWT Token generated for user: ${email}`);

        res.status(201).json({ token, user: { id: user._id, name, email } });
    } catch (error) {
        console.error("❌ [Register] Server Error:", error.message); // Log the error
        res.status(500).json({ message: "Server Error" });
    }
});

// Login Route
router.post("/login", async (req, res) => {
    try {
        const { email, password } = req.body;

        console.log("🔍 [Login] Request Body:", { email }); // Log request body (excluding password for security)

        // Check if user exists
        const user = await User.findOne({ email });
        if (!user) {
            console.log(`❌ [Login] User not found: ${email}`);
            return res.status(400).json({ message: "Invalid Credentials" });
        }

        // Compare password
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            console.log(`❌ [Login] Password mismatch for user: ${email}`);
            return res.status(400).json({ message: "Invalid Credentials" });
        }

        // Generate JWT Token
        const token = jwt.sign({ id: user._id,}, process.env.JWT_SECRET, { expiresIn: "16d" });
        console.log(`✅ [Login] JWT Token generated for user: ${email}`);

        res.json({ token, user: { id: user._id, name: user.name, email: user.email } });
    } catch (error) {
        console.error("❌ [Login] Server Error:", error.message); // Log the error
        res.status(500).json({ message: "Server Error" });
    }
});

module.exports = router;