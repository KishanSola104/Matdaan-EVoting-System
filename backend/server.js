const http = require("http");
const fs = require("fs");
const path = require("path");
const url = require("url");

// Define your port
const PORT = 3000;

// MIME types for various file extensions
const mimeTypes = {
  ".html": "text/html",
  ".css": "text/css",
  ".js": "text/javascript",
  ".json": "application/json",
  ".png": "image/png",
  ".jpg": "image/jpeg",
  ".ico": "image/x-icon",
  ".svg": "image/svg+xml"
};

// Create HTTP server
const server = http.createServer((req, res) => {
  let parsedUrl = url.parse(req.url);
  let pathname = `public${parsedUrl.pathname}`;

  // Default to index.html if root is requested
  if (pathname === "public/") {
    pathname += "index.html";
  }

  // Get the extension
  const ext = path.extname(pathname);

  // Read and serve file
  fs.readFile(pathname, (err, data) => {
    if (err) {
      // File not found
      res.writeHead(404, { "Content-Type": "text/html" });
      res.end("<h1>404 Not Found</h1>");
    } else {
      // Serve with correct content-type
      res.writeHead(200, { "Content-Type": mimeTypes[ext] || "text/plain" });
      res.end(data);
    }
  });
});

// Start server
server.listen(PORT, () => {
  console.log(`🚀 Server running at http://localhost:${PORT}`);
});
