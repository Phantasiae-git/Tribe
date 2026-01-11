import express from "express";
import authRoutes from "./api/routes/auth_routes.ts";
import userRoutes from "./api/routes/user_routes.ts";

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use("/api/auth", authRoutes);
app.use("/api/users", userRoutes);

export default app;