import { Router } from "express";
import {
  submitForm,
} from "../controllers/form_controller.ts";

const router = Router();

router.post("/submitForm", submitForm);

export default router;