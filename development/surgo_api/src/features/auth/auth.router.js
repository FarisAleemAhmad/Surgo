// define auth endpoints

// imports
import { Router } from "express";
import { authMiddleware } from "../../app/middlewares/auth.middleware.js";
import {
  signupController,
  loginController,
  forgotPasswordController,
  deleteAccountController,
} from "./auth.controller.js";

const router = Router();

// auth routes
router.post("/signup", signupController);
router.post("/login", loginController);
router.post("/forgot-password", forgotPasswordController);
router.delete("/delete", authMiddleware, deleteAccountController);

// exports
export default router;
