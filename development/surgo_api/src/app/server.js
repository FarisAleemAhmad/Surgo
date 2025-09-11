// basic imports
import express from "express";
import cors from "cors";
// modularizing imports
import { config } from "./config.js";
import { registerRoutes } from "./routes.js";
import { errorHandler } from "./middlewares/errorHandler.js";

// starting the express server
const app = express();


// enabling cors before json and routes
app.use(
  cors({
    origin: "*", // allow for all dev
    methods: ["GET", "POST", "DELETE"],
    allowedHeaders: ["Content-Type", "Authorization"],
  })
);

// basic middlewares
app.use(express.json());

// mounting all feature routes
registerRoutes(app);

// central error handler after the routes
app.use(errorHandler);

// start and expose the server
app.listen(config.port, () => {
  console.log(`Surgo API is running on port ${config.port}`);
});
