// main hub for all routes to be combined

// imports
import authRouter from "../features/auth/auth.router.js";
import { authMiddleware } from "./middlewares/auth.middleware.js";

// mounting the different feature routes
export const registerRoutes = (app) => {
  // homepage
  app.get("/", (req, res) => {
    res.send("Surgo is alive");
  });

  // PUBLIC authentication pages
  app.use("/api/auth", authRouter);

  // PROTECTED - quick check user endpoint
  app.get("/api/me", authMiddleware, (req, res) => {
    // return user claims
    res.status(200).json({ success: true, user: req.user });
  });
};
