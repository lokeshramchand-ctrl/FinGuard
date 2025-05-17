const express = require("express");
const http = require("http");
const socketIO = require("socket.io"); // ✅ Fixed import
const cors = require("cors");
const dotenv = require("dotenv");
const connectDB = require("./Auth/db");
const authRoutes = require("./Auth/authRoutes");

dotenv.config();
const app = express();
const server = http.createServer(app);
const io = socketIO(server, { cors: { origin: "*" } });
const { exec } = require("child_process");
connectDB();

const connectedUsers = {}; // Stores online users

// Middleware
app.use(express.json());
app.use(cors());
app.use("/api/auth", authRoutes); // Ensure this file exists

// Handle WebSocket Connections
io.on("connection", (socket) => {
  console.log("User connected:", socket.id);

  // Register a user with their ID
  socket.on("registerUser", ({ userId }) => {
    connectedUsers[userId] = { socketId: socket.id };
    console.log(`✅ User Registered: ${userId} → ${socket.id}`);
  });

  // Handle messages
  socket.on("sendMessage", (message) => {
    try {
      if (!message || typeof message !== "string") {
        throw new Error("Invalid message");
      }
      console.log("Received message:", message);
      io.emit("message", message);
    } catch (error) {
      console.error("Error sending message:", error.message);
    }
  });



  // Handle disconnection
  socket.on("disconnect", () => {
    console.log("User disconnected:", socket.id);

    // Remove user from connectedUsers
    Object.keys(connectedUsers).forEach((userId) => {
      if (connectedUsers[userId].socketId === socket.id) {
        delete connectedUsers[userId];
      }
    });
  });
  io.emit("message", {
    userId: data.userId,
    text: data.text,
  });
});
app.post("/predict", (req, res) => {
  const { description } = req.body;
  const input = JSON.stringify({ description });

  exec(`python Auth/predict_api.py '${input}'`, (err, stdout, stderr) => {
    if (err) {
      console.error(stderr);
      return res.status(500).send("Error predicting category");
    }

    return res.json({ category: stdout.trim() });
  });
});


// Start Server
server.listen(3000, () => {
  console.log("Server is running on port 3000 🚀");
});
