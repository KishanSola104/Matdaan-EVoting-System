# 🗳️ Matdaan – A Secure & Scalable E-Voting System

> 🇮🇳 Empowering Digital Democracy using  Node.js + MySQL + HTML/CSS

Matdaan  is a web-based electronic voting system built from the ground up using **Node.js** , **MySQL**, and **vanilla HTML/CSS/JS**. The system is designed to offer a clean, secure, and scalable platform for online elections — accessible to both administrators and voters with role-specific dashboards.

This project is the evolved version of my original college project, now re-engineered with a modern web stack to make it web-hostable and more developer-friendly.

---

## 🚀 Tech Stack

| Layer         | Technology             |
|---------------|------------------------|
| Backend       | Node.js (No Express) |
| Database      | MySQL                  |
| Frontend      | HTML, CSS, JavaScript  |
| Version Control | Git + GitHub         |
| Hosting (Planned) | Render / Railway / Vercel (Backend), GitHub Pages (Static) |

---

## 🧩 Project Structure

Matdaan/
├── backend/
│ ├── db/ # MySQL connection setup
│ ├── controllers/ # Business logic
│ ├── routes/ # Manual routing (Node)
│ ├── utils/ # Helper functions (validation, etc.)
│ └── server.js # Pure Node.js HTTP server
│
├── public/
│ ├── css/ # Stylesheets
│ ├── js/ # Frontend scripts
│ ├── admin/ # Admin HTML pages
│ ├── voter/ # Voter HTML pages
│ └── index.html # Entry page (login/user-type selection)
│
└── README.md


---

## 🔐 Core Features

### 👑 Admin Panel
- Two-step secure login (Access Code + Personal Credentials)
- Manage elections: create, update, delete
- Manage candidates: add, edit, remove
- View and verify voters
- Live voting results and winner declaration

### 🧑‍💼 Voter Panel
- Register using Voter ID / Aadhar
- One-person, one-vote system
- Cast vote in active elections
- View results in real-time or post-election

---

## 🔁 Project Philosophy

This project isn’t about copying code. It's a line-by-line, concept-by-concept rebuild focused on **learning**, **control**, and **clarity**.  
We’re intentionally avoiding frameworks like Express or React to master the **core workings of HTTP, routing, and file serving** in Node.js.

> 🔥 Built for learning. Designed for scalability. Made with passion.

---

## 📌 Future Improvements

- Session-based authentication (using cookies or JWT)
- Admin analytics dashboard
- Voter email verification
- Hosting & deployment
- Mobile-responsive UI
- PDF result export

---

## 🧑‍💻 Developed By

**Kishan Solanki**  
Aspiring Software Developer focused on full-stack development, real-world problem-solving, and continuous learning.

---

## 📬 Feedback & Suggestions

Have ideas to improve the system or make it more secure?  
Feel free to open an issue or send me an email:  
📧 kishan104.solanki@gmail.com

---

## 📜 License

This project is open for learning and personal use. Please credit the author if you reuse or extend it in any public project.

