import express from "express";
import authRoutes from "./api/routes/auth_routes.ts";
import userRoutes from "./api/routes/user_routes.ts";
import matchmakingRoutes from "./api/routes/matchmaking_routes.ts";

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use("/api/auth", authRoutes);
app.use("/api/users", userRoutes);
app.use("/api/matchmaking", matchmakingRoutes);

export default app;