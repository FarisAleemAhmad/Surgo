export function errorHandler(err, req, res, next) {
  console.error(err);
  const status = err?.status || 500;
  const message = err?.message || "internal server error";
  res.status(status).json({ error: message });
}
