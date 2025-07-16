// Matdaan/backend/controllers/adminController.js

const stateDistricts = {
  "Gujarat": ["Ahmedabad", "Surat", "Rajkot", "Vadodara"],
  "Rajasthan": ["Jaipur", "Jodhpur", "Udaipur", "Kota"],
  "Maharashtra": ["Mumbai", "Pune", "Nagpur", "Nashik"]
  // Add more...
};

function getDistricts(req, res, query) {
  const state = query.state;

  if (!state) {
    res.writeHead(400, { "Content-Type": "application/json" });
    res.end(JSON.stringify({ error: "State parameter is required" }));
    return;
  }

  const districts = stateDistricts[state];

  if (!districts) {
    res.writeHead(404, { "Content-Type": "application/json" });
    res.end(JSON.stringify({ error: "State not found" }));
    return;
  }

  res.writeHead(200, { "Content-Type": "application/json" });
  res.end(JSON.stringify({ districts }));
}

module.exports = {
  getDistricts,
  // export other functions you have here...
};
