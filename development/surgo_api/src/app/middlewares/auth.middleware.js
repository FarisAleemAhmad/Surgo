// imports
import CustomError from "../../utils/CustomError.js";
import { supabase } from "../supabase.js";

export async function authMiddleware(req, res, next) {
  try {
    // get the header from the request
    const authHeader = req.headers.authorization || req.headers.Authorization;

    // if no authorization header
    if (!authHeader) {
      throw new CustomError(401, "Authorization header missing");
    }

    const parts = authHeader.split(" ");
    // if header not formatted / doesn't have bearer
    if (parts.length !== 2 || parts[0] !== "Bearer") {
      throw new CustomError(401, "Invalid authorization header format");
    }

    // extract token from the parts
    const token = parts[1];

    // use supabase to get user against the token
    const { data, error } = await supabase.auth.getUser(token);

    if (error) {
      // supabase returned error for invalid token
      throw new CustomError(401, error.message || "Invalid token");
    }

    const user = data?.user;
    if (!user) {
      throw new CustomError(401, "Invalid token/User not found");
    }

    // attach token and user to downstream handlers
    req.user = user;
    req.accessToken = token;
    return next();
  } catch (error) {
    // let central error handler format the response
    return next(error);
  }
}
