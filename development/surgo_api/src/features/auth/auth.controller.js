// handles request/response/next functions utlising auth.service

// imports
import * as authService from "./auth.service.js";

// service functions with additional functionality

// controller for signing up first time
export async function signupController(req, res, next) {
  try {
    const { email, password } = req.body;
    if (!email || !password) {
      return res.status(400).json({ error: "Email and password required" });
    }
    const data = await authService.signup(email.trim(), password);
    res.status(201).json({ data });
  } catch (err) {
    // pass to centralized error handler
    next(err);
  }
}

// controller for logging in a user
export async function loginController(req, res, next) {
  try {
    const { email, password } = req.body;
    if (!email || !password) {
      return res.status(400).json({ error: "Email and password required" });
    }
    const data = await authService.login(email.trim(), password);
    res.status(200).json({ access_token: data.session.access_token });
  } catch (err) {
    // pass to centralized error handler
    next(err);
  }
}

// controller for deleting a user
export async function deleteAccountController(req, res, next) {
  try {
    // authMiddleware has already stepped in at this point, JWT is decoded
    // check if its req.user.sub or req.user.id
    const userId = req.user.id;
    const result = await authService.deleteUser(userId);
    res.status(200).json(result);
  } catch (error) {
    next(error);
  }
}
