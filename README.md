# Hostel Management System (HMS) 

The **Hostel Management System (HMS)** is an all-in-one, web-based solution designed to streamline and digitize hostel operations. HMS enhances the student living experience and reduces administrative overhead through a modern, scalable platform that supports a wide range of functionalities tailored for hostel life.

---
## Demo


---

##  Why We Built This (The Fun, Honest Truth)
-  Lost & Found Chaos
Lose something in the hostel? You either make 10 calls, send 20 WhatsApp photos, or it’s gone forever. We fixed that. Snap it, upload it, and everyone can see and claim it instantly.

-  Washing Machine Guesswork
Ever paced to the laundry room every 10 minutes just to find someone else’s clothes inside? Or worse—left your own and had them mysteriously disappear? Now you just book a slot and relax. No more laundry roulette.

-  Complaints in the Void
You write your issue in a dusty complaint notebook and… it vanishes into the abyss. Our platform logs every complaint, tracks its status, and ensures it's seen and solved.

-  Room Cleaning Confusion
Want your room cleaned? Too bad—there’s no system, and you’ll never know when it's your turn. We added a slot-based room cleaning scheduler. Book, confirm, and breathe easy.

- 🛏 Roommate Roulette
Getting a roommate whose vibe doesn’t match yours? Say hello to sleepless nights and awkward conversations. We introduced a Score-Based Roommate Matching System—so you’re more likely to be paired with someone who actually respects your sleep schedule.

-  Sick Day Struggles
You’re unwell. But you still need to walk to the mess, stand in line, and carry your food back. Why?! With HMS, you just submit a Food Request, and your needs are logged and managed. Rest like you deserve to.

-  Never-Ending Questions
“What’s the laundry policy?” “Who’s the warden?” “What’s the WiFi password?” Enter the AI-powered Hostel Chatbot—available 24/7, powered by real-time web scraping and intelligent search. Ask away, and skip the endless group chats.

---
From broken processes to brilliance—we turned problems into features. HMS isn't just software. It's a student-life upgrade.

- Because we believe managing hostel life shouldn’t feel harder than clearing your midterms. 

---

##  Key Features

###  1. Complaint Management

Students can easily raise complaints regarding maintenance, infrastructure, or general issues within the hostel.

* Status-tracked entries (New, In Progress, Resolved)
* Validation for complete input
* Admin portal for reviewing and resolving issues

###  2. Lost and Found

Students and wardens can:

* Report lost or found items
* Upload images and detailed descriptions
* Browse and claim listed items
* Warden dashboard to **edit**, **resolve**, and **delete** entries

###  3. Room Cleaning Schedule

A digital room-cleaning calendar lets students:

* Book cleaning slots with real-time availability
* Reschedule or cancel if needed
* Receive instant notifications upon booking
* Cleaning staff can update task status

###  4. Washing Machine Booking

* Reserve slots based on real-time availability
* One booking per student per day
* Specify clothing type (e.g., wool, cotton)
* Track machine usage for maintenance

###  5. Mahindra University QA Bot

An AI chatbot that answers queries about:

* Hostel facilities
* Academic programs
* Admissions, events, and rules

Built using **Streamlit + OpenAI (RAG)**:

* Crawler keeps the dataset up-to-date
* Embedding + FAISS for efficient retrieval
* Context-aware responses via GPT-3.5

###  6. Score-Based Roommate Matching

Students fill a lifestyle preference survey:

* Sleep schedules, noise tolerance, etc.
* Matching algorithm ranks compatibility scores
* Suggestions based on best match

###  7. Food Requests for Sick Students

When unwell, students can:

* Request food delivery
* Submit room and illness details
* Avoid duplicates with auto-check
* Admins mark requests as completed

---

##  Tech Stack

| Layer    | Tech                       |
| -------- | -------------------------- |
| Frontend | Flutter (Web via Chrome)   |
| Backend  | Spring Boot (RESTful APIs) |
| Database | MySQL                      |

---

##  Setup Instructions

###  Frontend (Flutter Web)

# Run the frontend
- flutter run -d chrome

###  Backend (Spring Boot)

bash
# Clone the repository
git clone [<repository-url>](https://github.com/monisha-max/SE-HostelManagement/)

# Navigate into the project folder
cd SE-HostelManagement-backend

# Clean and build the project
mvn clean
mvn install

# Run the backend
mvn spring-boot:run

Ensure MySQL is running and accessible. Update your `application.properties` to match your MySQL credentials and database schema.

---

##  Team





---

HMS isn't just a hostel management system—it's a leap toward smart, student-first living. With automation, AI, and empathy at its core, HMS transforms everyday hostel life into a seamless, empowering experience
