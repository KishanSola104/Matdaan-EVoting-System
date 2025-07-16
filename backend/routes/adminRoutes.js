// Matdaan/backend/routes/adminRoutes.js

const adminController = require("../controllers/adminController");

function handleAdminRoutes(req, res, parsedUrl) {
  const pathname = parsedUrl.pathname;

  if (pathname === "/api/districts" && req.method === "GET") {
    adminController.getDistricts(req, res, parsedUrl.query);
    return true;
  }

  // handle other admin routes...

  return false;
}

module.exports = handleAdminRoutes;
