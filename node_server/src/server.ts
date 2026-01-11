import dotenv from "dotenv";
import mongoose from "mongoose";
import app from "./app.ts";

dotenv.config();

const DB_USER = process.env.DB_USER;
const DB_KEY = process.env.DB_KEY;
const DB_NAME = process.env.DB_NAME;
const PORT = process.env.PORT;

async function startServer() {
  try {
    await mongoose.connect(
      `mongodb+srv://${DB_USER}:${DB_KEY}@cluster0.fxphavu.mongodb.net/${DB_NAME}`
    );

    console.log("Connected to MongoDB");

    app.listen(PORT, () => {
      console.log(`Server running on port ${PORT}`);
    });
  } catch (error) {
    console.error("Failed to start server:", error);
  }
}

startServer();
