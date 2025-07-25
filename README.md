# Fotobook

**Fotobook** is a photo-sharing web application where users can sign up, upload and share photos and albums, follow other users, and interact socially. It supports multiple user roles (Admin, Member, Guest) and provides an intuitive and dynamic user interface.

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

