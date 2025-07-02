window.initAdminDashboardMain = function() {
  console.log("AdminDashboardMain overlay logic initialized!");

  const dummyData = {
    "registered-voters": {
      title: "Registered Voters",
      text: "Total registered voters: 1200. These include all users who have signed up on the platform."
    },
    "eligible-voters": {
      title: "Eligible Voters",
      text: "950 voters are eligible to vote after verification of documents and eligibility criteria."
    },
    "voters-logged-in": {
      title: "Voters Logged In",
      text: "Currently, 350 voters have logged into the system and are browsing election details."
    },
    "voters-voted": {
      title: "Voters Voted",
      text: "So far, 200 voters have cast their votes in ongoing elections."
    },
    "current-elections": {
      title: "Current Elections",
      text: "There are 2 elections currently running. Click further to see details about candidates and progress."
    },
    "past-elections": {
      title: "Past Elections",
      text: "12 elections have been completed on the Matdaan platform, with securely stored results."
    },
    "upcoming-elections": {
      title: "Upcoming Elections",
      text: "5 elections are scheduled in the next 5 years, covering various constituencies."
    }
  };

  const cards = document.querySelectorAll('.card');
  cards.forEach(card => {
    card.addEventListener('click', () => {
      const key = card.getAttribute('data-card');
      const data = dummyData[key];
      if (data) {
        document.getElementById('overlay-title').textContent = data.title;
        document.getElementById('overlay-text').textContent = data.text;
        document.getElementById('detail-overlay').classList.add('active');
      }
    });
  });

  const closeBtn = document.getElementById("close-overlay");
  if (closeBtn) {
    closeBtn.addEventListener("click", () => {
      document.getElementById("detail-overlay").classList.remove("active");
    });
  }
};
