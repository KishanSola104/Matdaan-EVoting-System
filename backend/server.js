const http = require("http");
const url = require("url");
const fs = require("fs");
const path = require("path");

const handleAdminRoutes = require("./routes/adminRoutes");

// Global error handlers
process.on("uncaughtException", (err) => {
  console.error("💥 Uncaught Exception:", err);
});
process.on("unhandledRejection", (reason) => {
  console.error("💥 Unhandled Rejection:", reason);
});

// Define public directory
const publicDir = path.join(__dirname, "../public");

const extToContentType = {
  ".html": "text/html",
  ".css": "text/css",
  ".js": "application/javascript",
  ".json": "application/json",
  ".png": "image/png",
  ".jpg": "image/jpeg",
  ".jpeg": "image/jpeg",
  ".gif": "image/gif",
  ".svg": "image/svg+xml",
};

const server = http.createServer((req, res) => {
  try {
    const parsedUrl = url.parse(req.url, true);
    let pathname = parsedUrl.pathname;

    console.log("👉 Incoming request:", req.method, pathname);

    // Handle API routes first
    if (handleAdminRoutes(req, res, parsedUrl)) {
      return;
    }

    // Default to index.html if root path
    if (pathname === "/") {
      pathname = "/index.html";
    }

    // Normalize path to avoid issues with slashes
    let decodedPath;
    try {
      decodedPath = decodeURIComponent(pathname);
    } catch (err) {
      res.writeHead(400, { "Content-Type": "text/plain" });
      res.end("Bad request");
      return;
    }

    const filePath = path.join(publicDir, decodedPath);

    // Security check: ensure no path traversal outside public
    if (!filePath.startsWith(publicDir)) {
      res.writeHead(403, { "Content-Type": "text/plain" });
      res.end("Forbidden");
      return;
    }

    // Check if the file exists
    fs.stat(filePath, (err, stats) => {
      if (err || !stats.isFile()) {
        res.writeHead(404, { "Content-Type": "application/json" });
        res.end(JSON.stringify({ error: "Route not found" }));
        return;
      }

      const ext = path.extname(filePath).toLowerCase();
      const contentType = extToContentType[ext] || "application/octet-stream";

      fs.readFile(filePath, (err, content) => {
        if (err) {
          console.error("Error reading file:", err);
          res.writeHead(500, { "Content-Type": "text/plain" });
          res.end("Server error");
          return;
        }
        res.writeHead(200, { "Content-Type": contentType });
        res.end(content);
      });
    });

  } catch (err) {
    console.error("Unhandled error:", err);
    res.writeHead(500, { "Content-Type": "text/plain" });
    res.end("Internal server error");
  }
});

// Listen on localhost only for local dev
server.listen(3000, "127.0.0.1", () => {
  console.log("✅ Server is running at http://127.0.0.1:3000/");
});
