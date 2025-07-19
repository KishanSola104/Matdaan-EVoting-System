const http = require("http");
const fs = require("fs");
const path = require("path");
const url = require("url");

// COMMENT these lines for now
// const adminRoutes = require("./routes/adminRoutes");
// const voterRoutes = require("./routes/voterRoutes");

const PORT = 3000;
const publicDir = path.join(__dirname, "../public");

const server = http.createServer((req, res) => {
  const parsedUrl = url.parse(req.url);
  let pathname = parsedUrl.pathname;

  // Serve index.html on root
  if (pathname === "/") {
    pathname = "/index.html";
  }

  // GET file extension and resolve full path
  const ext = path.extname(pathname);
  const filePath = path.join(publicDir, pathname);

  // Read and serve the file
  fs.readFile(filePath, (err, data) => {
    if (err) {
      res.writeHead(404);
      res.end("404 Page Not Found");
    } else {
      res.writeHead(200, { "Content-Type": getContentType(ext) });
      res.end(data);
    }
  });
});

function getContentType(ext) {
  switch (ext) {
    case ".html": return "text/html";
    case ".css": return "text/css";
    case ".js": return "application/javascript";
    case ".png": return "image/png";
    case ".jpg":
    case ".jpeg": return "image/jpeg";
    case ".svg": return "image/svg+xml";
    default: return "text/plain";
  }
}

server.listen(PORT, () => {
  console.log(`✅ Server is running at http://localhost:${PORT}`);
});
