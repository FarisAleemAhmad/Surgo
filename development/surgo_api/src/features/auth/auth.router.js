// define auth endpoints

// imports
import { Router } from "express";
import { authMiddleware } from "../../app/middlewares/auth.middleware.js";
import {
  signupController,
  loginController,
  deleteAccountController,
} from "./auth.controller.js";

const router = Router();

// auth routes
router.post("/signup", signupController);
router.post("/login", loginController);
router.delete("/delete", authMiddleware, deleteAccountController);

// exports
export default router;
