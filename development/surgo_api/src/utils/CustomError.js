export default class CustomError extends Error {
  constructor(status = 500, message = "Internal Server Error") {
    super(message);
    this.status = status;
    Object.setPrototypeOf(this, new.target.prototype);
    Error.captureStackTrace(this);
  }
}
