window.initAdminElections = function () {
  console.log("Elections JS Is Loaded");

  // Get The State Select Dropdown
  const states=document.getElementById("state");
  console.log(states);
  addPlaceholder(states,"Select State");

  // Array for All States and Unioun Territories
  const indianStatesAndUTs = [
  // States
  "Andhra Pradesh",
  "Arunachal Pradesh",
  "Assam",
  "Bihar",
  "Chhattisgarh",
  "Goa",
  "Gujarat",
  "Haryana",
  "Himachal Pradesh",
  "Jharkhand",
  "Karnataka",
  "Kerala",
  "Madhya Pradesh",
  "Maharashtra",
  "Manipur",
  "Meghalaya",
  "Mizoram",
  "Nagaland",
  "Odisha",
  "Punjab",
  "Rajasthan",
  "Sikkim",
  "Tamil Nadu",
  "Telangana",
  "Tripura",
  "Uttar Pradesh",
  "Uttarakhand",
  "West Bengal",
  
  // Union Territories
  "Andaman and Nicobar Islands",
  "Chandigarh",
  "Dadra and Nagar Haveli and Daman and Diu",
  "Delhi",
  "Jammu and Kashmir",
  "Ladakh",
  "Lakshadweep",
  "Puducherry"
];

indianStatesAndUTs.forEach(st => {
  const state = document.createElement("option");
  state.value=st;
  state.textContent=st;
  states.appendChild(state);
});

indianStatesAndUTs.sort();

  // Election Date Year, Month, Day
  const electionMonthSelect = document.getElementById("electionMonth");
  const electionYearSelect = document.getElementById("electionYear");
  const electionDaySelect = document.getElementById("electionDay");

  // Result Date Year, Month, Day
  const resultYearSelect = document.getElementById("resultYear");
  const resultMonthSelect = document.getElementById("resultMonth");
  const resultDaySelect = document.getElementById("resultDay");

  const months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  // Add placeholder to a select
  function addPlaceholder(select, text) {
    const option = document.createElement("option");
    option.value = "";
    option.textContent = text;
    select.appendChild(option);
  }

  // Add placeholders
  addPlaceholder(electionMonthSelect, "Month");
  addPlaceholder(resultMonthSelect, "Month");
  addPlaceholder(electionYearSelect, "Year");
  addPlaceholder(resultYearSelect, "Year");
  addPlaceholder(electionDaySelect, "Day");
  addPlaceholder(resultDaySelect, "Day");

  // Populate months
  months.forEach((monthName, index) => {
    const electionMonthOption = document.createElement("option");
    electionMonthOption.value = index + 1;
    electionMonthOption.textContent = monthName;
    electionMonthSelect.appendChild(electionMonthOption);

    const resultMonthOption = document.createElement("option");
    resultMonthOption.value = index + 1;
    resultMonthOption.textContent = monthName;
    resultMonthSelect.appendChild(resultMonthOption);
  });

  // Populate years
  for (let year = 2025; year <= 2035; year++) {
    const electionYearOption = document.createElement("option");
    electionYearOption.value = year;
    electionYearOption.textContent = year;
    electionYearSelect.appendChild(electionYearOption);

    const resultYearOption = document.createElement("option");
    resultYearOption.value = year;
    resultYearOption.textContent = year;
    resultYearSelect.appendChild(resultYearOption);
  }

  // Check leap year
  const isLeapYear = (year) => {
    return (year % 4 === 0 && year % 100 !== 0) || year % 400 === 0;
  };

  // Days in month
  function getDaysInMonth(year, month) {
    if ([1, 3, 5, 7, 8, 10, 12].includes(month)) return 31;
    if ([4, 6, 9, 11].includes(month)) return 30;
    if (month === 2) return isLeapYear(year) ? 29 : 28;
    return 0;
  }

  // Update days for a given select
  function updateDayDropdown(yearSelect, monthSelect, daySelect) {
    const yearSelected = parseInt(yearSelect.value);
    const monthSelected = parseInt(monthSelect.value);

    daySelect.innerHTML = "";
    addPlaceholder(daySelect, "Day");

    if (!yearSelected || !monthSelected) return;

    const daysInMonth = getDaysInMonth(yearSelected, monthSelected);

    for (let day = 1; day <= daysInMonth; day++) {
      const option = document.createElement("option");
      option.value = day;
      option.textContent = day;
      daySelect.appendChild(option);
    }
  }

  // Bind change events  ELECTION
  electionYearSelect.addEventListener("change", () => {
    updateDayDropdown(electionYearSelect, electionMonthSelect, electionDaySelect);
  });

  electionMonthSelect.addEventListener("change", () => {
    updateDayDropdown(electionYearSelect, electionMonthSelect, electionDaySelect);
  });

  // Bind change events  RESULT
  resultYearSelect.addEventListener("change", () => {
    updateDayDropdown(resultYearSelect, resultMonthSelect, resultDaySelect);
  });

  resultMonthSelect.addEventListener("change", () => {
    updateDayDropdown(resultYearSelect, resultMonthSelect, resultDaySelect);
  });
};
