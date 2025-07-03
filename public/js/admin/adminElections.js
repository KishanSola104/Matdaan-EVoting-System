window.initAdminElections = function () {
  console.log("Elections JS Is Loaded");

  const electionMonthSelect = document.getElementById("electionMonth");
  const electionYearSelect = document.getElementById("electionYear");
  const electionDaySelect = document.getElementById("electionDay");
  console.log(electionMonthSelect);

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

  const placeHolderMonth = document.createElement("option");
  placeHolderMonth.value = "";
  placeHolderMonth.textContent = "Select Month";
  electionMonthSelect.appendChild(placeHolderMonth);

  const placeHolderYear = document.createElement("option");
  placeHolderYear.value = "";
  placeHolderYear.textContent = "Select Year";
  electionYearSelect.appendChild(placeHolderYear);

  const placeHolderDay=document.createElement("option");
  placeHolderDay.value="";
  placeHolderDay.textContent="Select Day";
  electionDaySelect.appendChild(placeHolderDay);

  // Populate months
  months.forEach((monthName, index) => {
    const option = document.createElement("option");
    option.value = index + 1;
    option.textContent = monthName;
    electionMonthSelect.appendChild(option);
  });

  // Populate years
  for (let year = 2025; year <= 2035; year++) {
    const option = document.createElement("option");
    option.value = year;
    option.textContent = year;
    electionYearSelect.appendChild(option);
  }

  // Function to check whether a year is leap year
  const isLeapYear = (year) => {
    return (year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0);
  };

  // Listener for month change
  electionMonthSelect.addEventListener("change", () => {
    const selectedMonth = parseInt(electionMonthSelect.value);
    updateDayDropdown();
    console.log("Selected Month", selectedMonth);
  });

  // Listener for year change
  electionYearSelect.addEventListener("change", () => {
    const selectedYear = parseInt(electionYearSelect.value);
    updateDayDropdown();
    console.log("Selected Year", selectedYear);
  });

  // Update day dropdown
  function updateDayDropdown() {
    const yearSelected = parseInt(electionYearSelect.value);
    const monthSelected = parseInt(electionMonthSelect.value);

    // clear previous days
    electionDaySelect.innerHTML = "";

    const placeHolderDay = document.createElement("option");
    placeHolderDay.value = "";
    placeHolderDay.textContent = "Select Day";
    electionDaySelect.appendChild(placeHolderDay);

    if (!yearSelected || !monthSelected) {
      return;
    }

    const daysInMonth = getDaysInMonth(yearSelected, monthSelected);

    for (let day = 1; day <= daysInMonth; day++) {
      const option = document.createElement("option");
      option.value = day;
      option.textContent = day;
      electionDaySelect.appendChild(option);
    }
  }

  // Determine days in month
  function getDaysInMonth(year, month) {
    if ([1, 3, 5, 7, 8, 10, 12].includes(month)) return 31;
    else if ([4, 6, 9, 11].includes(month)) return 30;
    else if (month === 2) {
      return isLeapYear(year) ? 29 : 28;
    } else return 0;
  }
};
