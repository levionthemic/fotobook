# Fotobook

**Fotobook** is a photo-sharing web application where users can sign up, upload and share photos and albums, follow other users, and interact socially. It supports multiple user roles (Admin, Member, Guest) and provides an intuitive and dynamic user interface.

---

## Demo
- Log in: https://www.loom.com/share/02644496d0954288aed27ec71964badd?sid=5865d0b7-e7b9-4dc6-8f07-22b9291ff4b3
- Sign up: https://www.loom.com/share/264f1cef12bb404abad1144eb73e38a8?sid=31cbeaa8-dce2-41fb-966a-2046a03baea0
- Feed/discover page: https://www.loom.com/share/096c67d538b74f05bf8be50edea6991c?sid=8cadef82-5ffa-4e03-b4e6-5ddace43fbc5
- Photo CRUD: https://www.loom.com/share/9e93e401748d45c08fd021d6cbd02a95?sid=8af327f8-9cb5-4e01-ae61-97ce40a83965
- Album CRUD: https://www.loom.com/share/3b8d3705bb9540639a10944565164c06?sid=e8c985d5-2269-41d9-8601-77904f81502e
- Edit Profile: https://www.loom.com/share/093ba6148ed1429dbbe15cba310fb674?sid=2891b919-5d06-46f9-b212-66607f6d88e3
- Follow: https://www.loom.com/share/27f00dc94b184b2aba58e9f11a7feda4?sid=47ede388-fa5e-4daf-b48f-510d3da629eb
- Admin Photos: https://www.loom.com/share/07cdc3dacb014e01bc1a7178f8f034f0?sid=17cafb90-6082-472c-bf93-3a9acbb290d9
- Admin Albums: https://www.loom.com/share/651a09a991974b5d822fdf99ec303214?sid=84e95cef-5661-404d-927e-f31e6dc020b0
- Admin Users: https://www.loom.com/share/8fc666915a6d46c19050afc68e48e9fd?sid=8d5b8e84-6a07-446e-a200-d32276402356

---

## 🚀 Features

### ✅ Authentication
- Sign up / Log in / Log out
- Email confirmation and password reset
- Google/Facebook OAuth (optional)

### 📷 Photo Sharing
- Upload photos and group them into albums
- View photos in grid or single layout
- Like, comment, and share photos
- Tag friends in photos (optional)

### 📁 Album Management
- Create, update, delete albums
- Add or remove photos from albums
- Set visibility (public/private)

### 🢑 User Interaction
- Follow / unfollow other users
- View followers and following list
- Discover new users and photos
- Like/dislike posts

### 🔐 Authorization
- Role-based access control:
    - Admin: Manage users, reports, and platform settings
    - Member: Full user functionality
    - Guest: Browse only public content

### 🛡️ Admin Panel
- View user statistics and activity logs
- Moderate reported photos/users/comments
- System configuration options

### 📱 Responsive UI
- Clean and modern interface built with Tailwind CSS and ShadCN UI
- Fully responsive on desktop and mobile

---

## 🏗️ Tech Stack

| Layer        | Technology           |
|--------------|----------------------|
| Framework      | Ruby on Rails |
| Database     | PostgreSQL           |
| Authentication | Devise / OmniAuth    |
| File Storage | Cloundinary |

---

## 🛠️ Setup Instructions

1. **Clone the repository**
```bash
git clone https://github.com/your-username/fotobook.git
cd fotobook
```

2. **Install dependencies**
```bash
bundle install         
```

3. **Set up database**
```bash
rails db:setup
```

4. **Run the server**
```bash
rails server
```

5. **Access the app**  
   Visit `http://localhost:3000`

Sample account:
- User: email - "user1@fotobook.com", pass - "password"
- Admin: email - "admin@fotobook.com", password - "password"

---

