import { Router } from "express";
import {
  getUser,
  getUsers,
  updateUser,
} from "../controllers/user_controller.ts";

const router = Router();

router.get("/", getUsers);
router.get("/:id", getUser);
router.put("/:id", updateUser);

export default router;